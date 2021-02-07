#region License
/* 
 * Copyright (C) 1999-2021 John Källén.
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
using Reko.Core.Operators;
using Reko.Core.Services;
using Reko.Core.Types;
using System;
using System.Collections.Generic;
using System.Linq;

namespace Reko.Typing
{
	/// <summary>
	/// Rewrites a constant based on its type.
	/// </summary>
	public class TypedConstantRewriter : IDataTypeVisitor<Expression>
	{
        private readonly Program program;
        private readonly IPlatform platform;
		private readonly Identifier globals;
        private readonly Dictionary<ushort, Identifier> mpSelectorToSegId;
        private readonly DecompilerEventListener eventListener;
        private Constant? c;
        private Expression? basePtr;
		private PrimitiveType? pOrig;
		private bool dereferenced;

        public TypedConstantRewriter(Program program, DecompilerEventListener eventListener)
		{
            this.eventListener = eventListener;
            this.program = program;
            this.platform = program.Platform;
            this.globals = program.Globals;
            if (program.SegmentMap != null)
            {
                this.mpSelectorToSegId = program.SegmentMap.Segments.Values
                    .Where(s => s.Identifier != null && s.Address.Selector.HasValue)
                    .ToDictionary(s => s.Address.Selector!.Value, s => s.Identifier)!;
            }
            else
            {
                this.mpSelectorToSegId = new Dictionary<ushort, Identifier>();
            }
        }

        /// <summary>
        /// Rewrites a machine word constant depending on its data type.
        /// </summary>
        /// <param name="c"></param>
        /// <param name="dereferenced"></param>
        /// <returns></returns>
        public Expression Rewrite(Constant c, Expression? basePtr, bool dereferenced)
        {
            this.c = c;
            this.basePtr = basePtr;
            DataType dtInferred = c.DataType;
            if (dtInferred == null)
            {
                eventListener.Warn(
                    $"The equivalence class {c.TypeVariable!.Name} has a null data type");
                dtInferred = c.TypeVariable.DataType;
            }
            else
            {
                this.pOrig = (c.DataType as PrimitiveType)!;
                if (c.TypeVariable != null)
                {
                    dtInferred = c.TypeVariable.DataType;
                    this.pOrig = (c.TypeVariable.OriginalDataType as PrimitiveType)!;
                }
            }
            var dt = dtInferred.ResolveAs<DataType>()!;
            this.dereferenced = dereferenced;
            return dt.Accept(this);
        }

        public Expression Rewrite(Address addr, Expression? basePtr, bool dereferenced)
        {
            if (addr.Selector.HasValue)
            {
                if (!mpSelectorToSegId.TryGetValue(addr.Selector.Value, out Identifier segId))
                {
                    eventListener.Warn(
                        "Selector {0:X4} has no known segment.",
                        addr.Selector.Value);
                    return addr;
                }
                var ptrSeg = segId.TypeVariable!.DataType.ResolveAs<Pointer>();
                if (ptrSeg == null)
                {
                    //$TODO: what should the warning be?
                    //$BUG: create a fake field for now.
                    var field = new StructureField((int)addr.Offset, new UnknownType());
                    Expression x = new FieldAccess(new UnknownType(), new Dereference(segId.DataType, segId), field);
                    if (!dereferenced)
                    {
                        x = new UnaryExpression(Operator.AddrOf, addr.DataType, x);
                    }
                    return x;
                }
                var baseType = ptrSeg.Pointee.ResolveAs<StructureType>()!;
                var dt = addr.TypeVariable!.DataType.ResolveAs<Pointer>()!;
                this.c = Constant.Create(
                    PrimitiveType.CreateWord(addr.DataType.BitSize - ptrSeg.BitSize),
                    addr.Offset);

                var f = EnsureFieldAtOffset(baseType, dt.Pointee, c.ToInt32());
                Expression ex = new FieldAccess(f.DataType, new Dereference(ptrSeg, segId), f);
                if (dereferenced || dt.Pointee is ArrayType)
                {
                    return ex;
                }
                else
                {
                    var un = new UnaryExpression(Operator.AddrOf, dt, ex);
                    return un;
                }
            }
            else
            {
                this.c = addr.ToConstant();
                this.c.TypeVariable = addr.TypeVariable;
                var dtInferred = addr.TypeVariable!.DataType.ResolveAs<DataType>()!;
                this.pOrig = addr.TypeVariable.OriginalDataType as PrimitiveType;
                this.dereferenced = dereferenced;
                return dtInferred.Accept(this);
            }
        }

		private StructureType? GlobalVars
		{
            get
            {
                if (globals != null && globals.TypeVariable != null)
                {
                    if (globals.TypeVariable.DataType is Pointer pGlob)
                    {
                        return pGlob.Pointee.ResolveAs<StructureType>();
                    }
                    if (globals.DataType is Pointer pGlob2)
                    {
                        return pGlob2.Pointee as StructureType;
                    }
                }
                return null;
            }
		}

        //$REVIEW: special cased code; we need to handle segments appropriately and remove this function.
        private bool IsSegmentPointer(Pointer ptr)
        {
            if (!(ptr.Pointee is EquivalenceClass eq))
                return false;
            if (eq.DataType is StructureType str)
                return str.IsSegment;
            else
                return false;
        }
        
        public Expression VisitArray(ArrayType at)
		{
			throw new ArgumentException("Constants cannot have array values yet.");
		}

        public Expression VisitClass(ClassType ct)
        {
            throw new NotImplementedException();
        }

        public Expression VisitCode(CodeType c)
        {
            throw new NotImplementedException();
        }

        public Expression VisitEnum(EnumType e)
        {
            var item = e.Members.FirstOrDefault(de => de.Value == c!.ToInt64());
            if (item.Key != null)
                return new Identifier(item.Key, e, RegisterStorage.None);
            return new Cast(e, c!);
        }

        public Expression VisitEquivalenceClass(EquivalenceClass eq)
		{
			throw new NotImplementedException();
		}

		public Expression VisitFunctionType(FunctionType ft)
		{
			throw new NotImplementedException();
		}

		public Expression VisitMemberPointer(MemberPointer memptr)
		{
			// The constant is a member pointer.

			Pointer p = (Pointer) memptr.BasePointer;
			EquivalenceClass eq = (EquivalenceClass) p.Pointee;
			StructureType baseType = (StructureType) eq.DataType;
			Expression baseExpr = this.basePtr != null
				? new Dereference(this.basePtr.DataType, this.basePtr)
                : (Expression) new ScopeResolution(baseType);

            var dt = memptr.Pointee.ResolveAs<DataType>()!;
            var f = EnsureFieldAtOffset(baseType, dt, c!.ToInt32());
            Expression ex = new FieldAccess(memptr.Pointee, baseExpr, f);
			if (dereferenced)
			{
				ex.DataType = memptr.Pointee;
			}
			else
			{
                if (f.DataType is ArrayType array)
                {
                    ex.DataType = new MemberPointer(p, array.ElementType, platform.PointerType.BitSize);
                }
                else
                {
                    ex = new UnaryExpression(Operator.AddrOf, memptr, ex);
                }
            }
            return ex;
		}

		public Expression VisitPointer(Pointer ptr)
		{
			Expression e = c!;
            if (IsSegmentPointer(ptr))
            {
                if (mpSelectorToSegId.TryGetValue(c!.ToUInt16(), out Identifier segID))
                    return segID;
                return e;
            } 
            else if (GlobalVars != null)
            {
                // Null pointer.
                if (c!.IsZero)
                {
                    var np = Address.Create(ptr, 0);
                    np.TypeVariable = c.TypeVariable;
                    np.DataType = c.DataType;
                    return np;
                }

                var addr = program.Platform.MakeAddressFromConstant(c, false);
                // An invalid pointer -- often used as sentinels in code.
                if (!program.SegmentMap.IsValidAddress(addr))
                {
                    //$TODO: probably should use a reinterpret_cast here.
                    e = new Cast(ptr, c)
                    {
                        TypeVariable = c.TypeVariable
                    };
                    if (dereferenced)
                    {
                        e = new Dereference(ptr.Pointee, e);
                    }
                    return e;
                }
                
                var dt = ptr.Pointee.ResolveAs<DataType>()!;
                var charType = MaybeCharType(dt);
                if (charType != null && IsPtrToReadonlySection(c))
                {
                    PromoteToCString(c, charType);
                    return ReadNullTerminatedString(c, charType);
                }
                e = RewriteGlobalFieldAccess(dt, c.ToInt32());
            }
			return e;
		}

        /// <summary>
        /// Drill into dt to see if it could be the beginning of a character string.
        /// </summary>
        private PrimitiveType? MaybeCharType(DataType dt)
        {
            var pr = dt as PrimitiveType;
            if (pr == null)
            {
                if (!(dt is ArrayType at))
                    return null;
                pr = at.ElementType as PrimitiveType;
                if (pr == null)
                    return null;
            }
            if (pr.Domain != Domain.Character)
                return null;
            return pr;
        }

        public Expression VisitReference(ReferenceTo refTo)
        {
            throw new NotImplementedException();
        }

        private bool IsPtrToReadonlySection(Constant c)
        {
            Address addr = platform.MakeAddressFromConstant(c, false);
            if (addr == null!)
                return false;
            if (!program.SegmentMap.TryFindSegment(addr, out ImageSegment seg))
                return false;
            return (seg.Access & AccessMode.ReadWrite) == AccessMode.Read;
        }

        private Expression ReadNullTerminatedString(Constant c, DataType dt)
        {
            var rdr = program.CreateImageReader(program.Architecture, platform.MakeAddressFromConstant(c, false));
            return rdr.ReadCString(dt, program.TextEncoding);
        }

        DataType PromoteToCString(Constant c, DataType charType)
        {
            // Note that it's OK if there is no global field corresponding to a string constant.
            // It means that the string will be emitted "inline" in the code and not
            // as a separate global character array.
            var dt = StringType.NullTerminated(charType);
            var field = GlobalVars!.Fields.AtOffset(c.ToInt32());
            if (field != null)
            {
                field.DataType = dt;
            }
            return dt;
        }

        private bool IsInsideField(int offset, StructureField field)
        {
            if (offset < field.Offset)
                return false;
            if (offset == field.Offset)
                return true;
            if (offset < field.Offset + field.DataType.Size)
                return true;
            var str = field.DataType.ResolveAs<StructureType>();
            if (str != null && offset < field.Offset + str.GetInferredSize())
                return true;
            return false;
        }

        private Expression RewriteGlobalFieldAccess(
            DataType dt,
            int offset)
        {
            var f = GlobalVars!.Fields.LowerBound(offset);
            if (f == null || !IsInsideField(offset, f))
            {
                f = new StructureField(offset, dt);
                GlobalVars.Fields.Add(f);
            }
            if (dereferenced || f.Offset != offset)
            {
                var ceb = new ComplexExpressionBuilder(
                    program, null, globals, null, offset);
                return ceb.BuildComplex(dereferenced);
            }
            //$REVIEW: We can't use ComplexExpresionBuilder to rewrite pointers to
            // global variable. It's too aggressive now
            // (e.g. &globals->var.ptr00.ptr00 instead of &globals->var)
            var name = program.NamingPolicy.GlobalName(f);
            var globalVar = Identifier.Global(name, f.DataType);
            return CreateAddrOf(globalVar, dt);
        }

        private Expression CreateAddrOf(Expression e, DataType dt)
        {
            if (dereferenced)
            {
                e.DataType = dt;
                return e;
            }
            if (e.DataType is ArrayType array) // C language rules 'promote' arrays to pointers.
            {
                e.DataType = program.TypeFactory.CreatePointer(
                    array.ElementType,
                    platform.PointerType.BitSize);
                return e;
            }
            var ptr = new Pointer(e.DataType, platform.PointerType.BitSize);
            return new UnaryExpression(Operator.AddrOf, ptr, e);
        }

        private StructureField EnsureFieldAtOffset(StructureType str, DataType dt, int offset)
        {
            StructureField? f = str.Fields.AtOffset(offset);
            if (f == null)
            {
                //$TODO: overlaps and conflicts.
                //$TODO: strings.
                f = new StructureField(offset, dt);
                str.Fields.Add(f);
            }
            return f;
#if TODO
            var f = GlobalVars.Fields.LowerBound(c.ToInt32());
            //StructureField f = str.Fields.AtOffset(offset);
            if (f != null)
            {
                Unifier u = new Unifier();
                if (u.AreCompatible(f.DataType, dt))
                {
                    return f;
                }

                // Check for special case when an array ends at the offset.
                f = GlobalVars.Fields.LowerBound(c.ToInt32() - 1);
                var array = f.DataType.ResolveAs<ArrayType>();
                if (array != null && u.AreCompatible(array.ElementType, dt))
                {
                    return f;
                }
            }
            //$TODO: overlaps and conflicts.
            //$TODO: strings.
            f = new StructureField(offset, dt);
            str.Fields.Add(f);
            return f;
#endif
        }

		public Expression VisitPrimitive(PrimitiveType pt)
		{
			if (pt.Domain == Domain.Real && (pOrig!.Domain & Domain.Integer) != 0)
			{
				return(Constant.RealFromBitpattern(pt, c!.ToInt64()));
			}
			else
			{
                return c!;
			}
		}

        public Expression VisitString(StringType str)
        {
            throw new NotImplementedException();
        }

		public Expression VisitStructure(StructureType str)
		{
            c!.TypeVariable!.DataType = str;
            return c;
		}

		public Expression VisitUnion(UnionType ut)
		{
			// A constant can't have a union value, so we coerce it to the appropriate type.
			UnionAlternative? a = ut.FindAlternative(pOrig!);
            if (a == null)
            {
                // This is encountered when the original type is a [[word]] but
                // the alternatives are, say, [[int32]] and [[uint32]]. In this case
                // we pick an arbitrary type and go with it.
                //$REVIEW: should emit a warning.
                a = ut.Alternatives.Values[0];
            }
			c!.TypeVariable!.DataType = a.DataType;
            return c;
		}

        public Expression VisitTypeReference(TypeReference typeref)
        {
            return typeref.Referent.Accept(this);
        }

		public Expression VisitTypeVariable(TypeVariable tv)
		{
			throw new NotImplementedException();
		}

        public Expression VisitUnknownType(UnknownType ut)
		{
			throw new NotImplementedException();
		}

        public Expression VisitVoidType(VoidType vt)
        {
            throw new NotImplementedException();
        }
	}
}
