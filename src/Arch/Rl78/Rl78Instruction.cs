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
using Reko.Core.Machine;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Reko.Arch.Rl78
{
    public class Rl78Instruction : MachineInstruction
    {
        public Mnemonic Mnemonic { get; set; }

        public override int MnemonicAsInteger => (int) Mnemonic;

        public override string MnemonicAsString => Mnemonic.ToString();


        public RegisterStorage Prefix { get; internal set; }

        protected override void DoRender(MachineInstructionRenderer renderer, MachineInstructionRendererOptions options)
        {
            renderer.WriteMnemonic(Mnemonic.ToString());
            RenderOperands(renderer, options);
        }

        protected override void RenderOperand(MachineOperand op, MachineInstructionRenderer renderer, MachineInstructionRendererOptions options)
        {
            switch (op)
            {
            case RegisterOperand reg:
                renderer.WriteString(reg.Register.Name);
                return;
            case ImmediateOperand imm:
                renderer.WriteChar('#');
                var sImm = imm.Value.ToUInt32().ToString("X");
                renderer.WriteString(sImm);
                return;
            case MemoryOperand mem:
                if (Prefix != null)
                {
                    renderer.WriteFormat("{0}:", Prefix.Name);
                }
                renderer.WriteChar('[');
                if (mem.Base != null)
                {
                    renderer.WriteString(mem.Base.Name);
                    if (mem.Index != null)
                    {
                        renderer.WriteFormat("+{0}", mem.Index.Name);
                    }
                    else if (mem.Offset != 0)
                    {
                        if (mem.Offset >= 0xA0)
                            renderer.WriteFormat("+0{0:X2}h", mem.Offset);
                        else
                            renderer.WriteFormat("+{0:X2}h", mem.Offset);
                    }
                }
                else
                {
                    if (mem.Offset >= 0xA000)
                        renderer.WriteFormat("0{0:X4}h", mem.Offset);
                    else
                        renderer.WriteFormat("{0:X4}h", mem.Offset);
                    if (mem.Index != null)
                    {
                        renderer.WriteFormat("+{0}", mem.Index.Name);
                    }
                }
                renderer.WriteChar(']');
                return;
            case BitOperand bit:
                this.RenderOperand(bit.Operand, renderer, options);
                renderer.WriteFormat(".{0}", bit.BitPosition);
                return;
            case AddressOperand aop:
                renderer.WriteAddress(aop.Address.ToString(), aop.Address);
                return;
            case RegisterBankOperand rbop:
                renderer.WriteFormat("rb{0}", rbop.Bank);
                return;
            case FlagGroupOperand grf:
                renderer.WriteString(grf.FlagGroup.Name);
                return;
            }
            throw new NotImplementedException($"Rl78Instruction - RenderOperand {op.GetType().Name}.");
        }
    }
}
