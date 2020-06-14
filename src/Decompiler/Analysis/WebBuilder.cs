#region License
/* 
 * Copyright (C) 1999-2020 John Källén.
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2, or (at your option)
 * any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program; see the file COPYING.  If not, write to
 * the Free Software Foundation, 675 Mass Ave, Cambridge, MA 02139, USA.
 */
#endregion

using Reko.Core;
using Reko.Core.Code;
using Reko.Core.Expressions;
using Reko.Core.Lib;
using Reko.Core.Services;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;

namespace Reko.Analysis
{
	/// <summary>
	/// Builds webs out of the unions of phi functions. Each
	/// web will correspond to a local variable in the finished 
	/// decompilation. 
    /// </summary>
    /// <remarks>
    /// After this pass, the code is no longer in SSA
    /// form, so all analyses should be done prior to applying this stage.
    /// </remarks>
	public class WebBuilder
	{
        private readonly Program program;
		private readonly SsaState ssa;
		private readonly SsaIdentifierCollection ssaIds;
        private readonly DecompilerEventListener listener;
		private readonly BlockDominatorGraph doms;
		private readonly Dictionary<Identifier,LinearInductionVariable> ivs;
		private readonly Dictionary<Identifier, Web> webOf;
		private readonly List<Web> webs;

        public WebBuilder(Program program, SsaState ssa, Dictionary<Identifier,LinearInductionVariable> ivs,DecompilerEventListener listener)
        {
            this.program = program;
            this.ssa = ssa;
            this.ssaIds = ssa.Identifiers;
            this.ivs = ivs;
            this.listener = listener;
            this.doms = ssa.Procedure.CreateBlockDominatorGraph();
            this.webs = new List<Web>();
            this.webOf = new Dictionary<Identifier, Web>();
        }

        private void BuildWebOf()
		{
			foreach (SsaIdentifier sid in ssaIds)
			{
				Web w = new Web();
				w.Add(sid);
				webOf[sid.Identifier] = w;
				webs.Add(w);
			}
		}

		public void InsertDeclarations()
		{
			var deci = new DeclarationInserter(ssaIds, doms);
			foreach (Web web in this.webs)
			{
                bool isLive = web.Uses.Count > 0;
                bool isOnlyUsedByPhis = web.Uses.All(u => u.Instruction is PhiAssignment);
                bool isMemoryId = web.Identifier is MemoryIdentifier;
                if (isLive && !isOnlyUsedByPhis && !isMemoryId)
                {
                    deci.InsertDeclaration(web);
                }
                else
                {
                    var isDefinedByOutArg = OutDefinitionFinder.Find(web.Members);
                    if (isDefinedByOutArg)
                    {
                        deci.InsertDeclaration(web);
                    }
                }
			}
		}

		public void Transform()
		{
            try
            {
                new LiveCopyInserter(ssa).Transform();
                BuildWebOf();

                foreach (SsaIdentifier id in ssaIds)
                {
                    if (id.DefStatement != null && !(id.Identifier is MemoryIdentifier))
                        VisitStatement(id.DefStatement);
                }

                InsertDeclarations();

                WebReplacer replacer = new WebReplacer(this);
                foreach (Block bl in ssa.Procedure.ControlGraph.Blocks)
                {
                    for (int i = bl.Statements.Count - 1; i >= 0; --i)
                    {
                        Statement stm = bl.Statements[i];
                        stm.Instruction = stm.Instruction.Accept(replacer);
                        if (stm.Instruction == null)
                        {
                            bl.Statements.RemoveAt(i);
                        }
                    }
                }

                foreach (Web w in webs)
                {
                    if (w.InductionVariable  != null)
                    {
                        ivs.Add(w.Identifier!, w.InductionVariable );
                    }
                }
            }
            catch (Exception ex)
            {
                listener.Error(
                    listener.CreateProcedureNavigator(program, ssa.Procedure),
                    ex,
                    "An error occurred while renaming variables.");
            }
		}

		private void Merge(Web a, Web b)
		{
			Web c = new Web();
			foreach (SsaIdentifier sid in a.Members)
			{
				c.Add(sid);
				webOf[sid.Identifier] = c;
				foreach (Statement u in a.Uses)
					if (!c.Uses.Contains(u))
						c.Uses.Add(u);
			}
			foreach (SsaIdentifier sid in b.Members)
			{
				c.Add(sid);
				webOf[sid.Identifier] = c;
				foreach (Statement u in b.Uses)
					if (!c.Uses.Contains(u))
						c.Uses.Add(u);
			}
			webs.Remove(a);
			webs.Remove(b);
			webs.Add(c);
		}

		public void VisitPhiAssignment(PhiAssignment p)
		{
			Identifier idDst = p.Dst;
			PhiFunction phi = p.Src;
			foreach (var de in phi.Arguments)
			{
                if (de.Value is Identifier id && id != idDst)
                    Merge(webOf[idDst], webOf[id]);
            }
		}

		public void VisitStatement(Statement stm)
		{
            if (stm.Instruction is PhiAssignment phi)
                VisitPhiAssignment(phi);
        }

		public Web WebOf(Identifier id)
		{
			return webOf[id];
		}

		public void Write(TextWriter writer)
		{
			foreach (SsaIdentifier sid in ssaIds)
			{
				WebOf(sid.Identifier).Write(writer);
			}
		}

		private class WebReplacer : InstructionTransformer
		{
			private readonly WebBuilder bld;

			public WebReplacer(WebBuilder bld)
			{
				this.bld = bld;
			}

			public override Expression VisitIdentifier(Identifier id)
			{
                if (id.Storage is OutArgumentStorage)
                    return id;
				return bld.webOf[id].Identifier!;
			}

			public override Instruction TransformAssignment(Assignment a)
			{
				a.Dst = (Identifier) a.Dst.Accept(this);
				a.Src = a.Src.Accept(this);
                Identifier idDst = a.Dst;
                if (a.Src is Identifier idSrc && idSrc == idDst)
                    return null!;
                else
                    return a;
            }
		}

        public class OutDefinitionFinder : InstructionVisitorBase
        {
            private readonly Identifier id;
            private bool usedAsOutArgument;

            public static bool Find(IEnumerable<SsaIdentifier> sids)
            {
                foreach (var sid in sids)
                {
                    if (sid.DefStatement != null)
                    {
                        var odf = new OutDefinitionFinder(sid.Identifier);
                        sid.DefStatement.Instruction.Accept(odf);
                        if (odf.usedAsOutArgument)
                            return true;
                    }
                }
                return false;
            }

            public OutDefinitionFinder(Identifier id)
            {
                this.id = id;
            }

            public override void VisitOutArgument(OutArgument outArg)
            {
                usedAsOutArgument |= (outArg.Expression is Identifier id && this.id == id);
            }
        }
	}
}
