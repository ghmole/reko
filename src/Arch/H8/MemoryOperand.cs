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
using Reko.Core.Machine;
using Reko.Core.Types;
using System;
using System.Collections.Generic;
using System.Drawing;
using System.Text;

namespace Reko.Arch.H8
{
    public class MemoryOperand : MachineOperand
    {
        private MemoryOperand(PrimitiveType dt) : base(dt)
        {
        }

        public RegisterStorage? Base { get; set; }

        public int Offset { get; set; }
        public bool PreDecrement { get; set; }
        public bool PostIncrement { get; set; }
        public PrimitiveType? AddressWidth { get; set; }
        public bool Deferred { get; set; }

        public static MemoryOperand Abs(PrimitiveType dt, uint uAddr, PrimitiveType addrSize)
        {
            return new MemoryOperand(dt)
            {
                Offset = (int) uAddr,
                AddressWidth = addrSize,
            };
        }


        public static MemoryOperand BaseOffset(PrimitiveType dt, short offset, PrimitiveType addrSize, RegisterStorage baseReg)
        {
            return new MemoryOperand(dt)
            {
                Base = baseReg,
                Offset = offset,
                AddressWidth = addrSize,
            };
        }

        public static MemoryOperand Pre(PrimitiveType dt, RegisterStorage reg)
        {
            return new MemoryOperand(dt)
            {
                Base = reg,
                PreDecrement = true,
            };
        }
        public static MemoryOperand Post(PrimitiveType dt, RegisterStorage reg)
        {
            return new MemoryOperand(dt)
            {
                Base = reg,
                PostIncrement = true,
            };
        }

        public override void Write(MachineInstructionWriter writer, MachineInstructionWriterOptions options)
        {
            writer.WriteChar('@');
            if (this.Deferred)
                writer.WriteChar('@');
            if (Base != null)
            {
                if (this.PreDecrement)
                {
                    writer.WriteChar('-');
                    writer.WriteString(Base.Name);
                }
                else if (this.PostIncrement)
                {
                    writer.WriteString(Base.Name);
                    writer.WriteChar('+');
                }
                else if (Offset != 0)
                {
                    writer.WriteChar('(');
                    writer.WriteFormat("{0}:{1},", Offset, AddressWidth!.BitSize);
                    writer.WriteString(Base.Name);
                    writer.WriteChar(')');
                }
                else
                {
                    writer.WriteString(Base.Name);
                }
            }
            else
            {
                //$REFACTOR: does it make sense to move absolute addresses to their own class?
                writer.WriteAddress($"0x{(uint) Offset:X}:{AddressWidth!.BitSize}", Address.Ptr32((uint)Offset));
            }
        }

    }
}
