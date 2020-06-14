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
using Reko.Core.Expressions;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;

namespace Reko.Analysis
{
	public class Web
	{
		public Web()
		{
			this.Members = new HashSet<SsaIdentifier>();
			this.Definitions = new HashSet<Statement>();
			this.Uses = new HashSet<Statement>();
            this.DefExprs = new List<Expression>();
		}

        public Identifier? Identifier { get; private set; }
        public HashSet<SsaIdentifier> Members { get; private set; }
        public HashSet<Statement> Uses { get; private set; }
        public HashSet<Statement> Definitions { get; private set; }
        public List<Expression> DefExprs { get; private set; }

        public void Add(SsaIdentifier sid)
		{
            if (Members.Contains(sid))		// should be a set!
                return;

			Members.Add(sid);
			if (this.Identifier == null)
			{
				this.Identifier = sid.Identifier;
			}
			else
			{
				if (string.Compare(sid.Identifier.Name, this.Identifier.Name) < 0)
				{
					this.Identifier = sid.Identifier;
				}

				if (InductionVariable == null)
				{
					InductionVariable = sid.InductionVariable;
				}
				else if (sid.InductionVariable == null)
				{
					sid.InductionVariable = InductionVariable ;
				}
				else 
				{
					InductionVariable  = LinearInductionVariable.Merge(sid.InductionVariable, InductionVariable );
					if (InductionVariable  == null)
					{
						// Warning(string.Format("{0} and {1} are conflicting induction variables: {2} {3}", 
					}
					sid.InductionVariable = InductionVariable ;
				}
			}
			Definitions.Add(sid.DefStatement!);
            DefExprs.Add(sid.DefExpression!);
			foreach (Statement u in sid.Uses)
				Uses.Add(u);
		}
        
		public LinearInductionVariable? InductionVariable { get; private set; }

		public void Write(TextWriter writer)
		{
			writer.Write("{0}: {{ ", Identifier!.Name);
			foreach (SsaIdentifier m in Members.OrderBy(mm => mm.Identifier.Name))
			{
				writer.Write("{0} ", m.Identifier.Name);
			}
			writer.WriteLine("}");
		}
	}
}
