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

using System;
using System.Collections.Generic;
using Reko.Core;
using Reko.Core.Machine;

namespace Reko.Arch.Z80
{
    public class Z80InstructionComparer : InstructionComparer
    {
        public Z80InstructionComparer(Normalize norm) : base(norm)
        {
        }

        public override bool CompareOperands(MachineInstruction x, MachineInstruction y)
        {
            var a = (Z80Instruction)x;
            var b = (Z80Instruction)y;
            return CompareOp(a.Operands[0], b.Operands[0]) &&
                CompareOp(a.Operands[1], b.Operands[1]);
        }

        private bool CompareOp(MachineOperand opA, MachineOperand opB)
        {
            if (opA == null && opB == null)
                return true;
            if (opA == null || opB == null)
                return false;
            if (opA.GetType() != opB.GetType())
                return false;
            if (opA is RegisterOperand regOpA)
            {
                if (NormalizeRegisters)
                    return true;
                var regOpB = (RegisterOperand) opB;
                return regOpA.Register == regOpB.Register;
            }
            if (opA is ImmediateOperand immOpA)
            {
                if (NormalizeConstants)
                    return true;
                var immOpB = (ImmediateOperand) opB;
                return CompareValues(immOpA.Value, immOpB.Value);
            }
            if (opA is AddressOperand addrOpA)
            {
                if (NormalizeConstants)
                    return true;
                var addrOpB = (AddressOperand) opB;
                return addrOpA.Address.ToLinear() == addrOpB.Address.ToLinear();
            }
            if (opA is ConditionOperand condOpA)
            {
                return condOpA.Code == ((ConditionOperand) opB).Code;
            }
            if (opA is MemoryOperand memOpA)
            {
                var memOpB = (MemoryOperand) opB;
                if (NormalizeRegisters && !CompareRegisters(memOpA.Base, memOpB.Base))
                    return false;
                if (NormalizeConstants && !CompareValues(memOpA.Offset, memOpB.Offset))
                    return false;
                return true;
            }
            throw new NotImplementedException();
        }

        public override int GetOperandsHash(MachineInstruction i)
        {
            var instr = (Z80Instruction)i;

            return
                HashOp(instr.Operands[0]) ^
                HashOp(instr.Operands[1]) * 17;
        }

        private int HashOp(MachineOperand op)
        {
            if (op == null)
                return 0;
            int h = op.GetType().GetHashCode();
            if (op is RegisterOperand regOp)
            {
                if (NormalizeRegisters)
                    return h;
                else
                    return h * 29 ^ regOp.Register.GetHashCode();
            }
            if (op is ImmediateOperand immOp)
            {
                if (NormalizeConstants)
                    return h;
                else
                    return h * 13 ^ GetConstantHash(immOp.Value);
            }
            if (op is AddressOperand addrOp)
            {
                if (NormalizeConstants)
                    return h;
                else
                    return h * 29 ^ addrOp.Address.GetHashCode();
            }
            if (op is ConditionOperand condOp)
            {
                return h * 19 ^ condOp.Code.GetHashCode();
            }
            if (op is MemoryOperand memOp)
            {
                if (!NormalizeRegisters && memOp.Base != null)
                    h = h * 23 ^ memOp.Base.GetHashCode();
                if (!NormalizeConstants && memOp.Offset != null)
                    h = h * 17 ^ GetConstantHash(memOp.Offset);
                return h;
            }
            throw new NotImplementedException(string.Format("{0} ({1})", op, op.GetType().Name));
        }
    }
}