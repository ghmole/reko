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

using Reko.Core.Machine;
using Reko.Core.Types;
using System.Text;

namespace Reko.Arch.H8
{
    public class H8Instruction : MachineInstruction
    {
        public Mnemonic Mnemonic { get; set; }
        public override int MnemonicAsInteger => (int) Mnemonic;

        public override string MnemonicAsString => Mnemonic.ToString();

        public PrimitiveType? Size { get; set; }

        public override void Render(MachineInstructionWriter writer, MachineInstructionWriterOptions options)
        {
            RenderMnemonic(writer);
            RenderOperands(writer, options);
        }

        private void RenderMnemonic(MachineInstructionWriter writer)
        {
            var sb = new StringBuilder(MnemonicAsString);
            string suffix = "";
            if (Size != null)
            {
                switch (Size.Size)
                {
                case 1: suffix = ".b"; break;
                case 2: suffix = ".w"; break;
                case 4: suffix = ".l"; break;
                default: break;
                }
            }
            sb.Append(suffix);
            writer.WriteMnemonic(sb.ToString());
        }

        protected override void RenderOperand(MachineOperand operand, MachineInstructionWriter writer, MachineInstructionWriterOptions options)
        {
            if (operand is ImmediateOperand imm)
            {
                writer.WriteString("#0x");
                imm.Write(writer, options);
            }
            else
            {
                base.RenderOperand(operand, writer, options);
            }
        }
    }
}