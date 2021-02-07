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

using Reko.Core.Machine;
using System;
using System.Collections.Generic;
using System.Text;

namespace Reko.Arch.Arc
{
    public class ArcInstruction : MachineInstruction
    {
        public Mnemonic Mnemonic;
        public ArcCondition Condition;
        public AddressWritebackMode Writeback;
        public bool SignExtend;
        public bool DirectWrite;
        public bool Delay;
        public bool SetFlags;

        public override int MnemonicAsInteger => (int) Mnemonic;

        public override string MnemonicAsString => Mnemonic.ToString();

        protected override void DoRender(MachineInstructionRenderer renderer, MachineInstructionRendererOptions options)
        {
            RenderMnemonic(renderer);
            RenderOperands(renderer, options);
        }

        private void RenderMnemonic(MachineInstructionRenderer renderer)
        {
            var sb = new StringBuilder();
            sb.Append(Mnemonic.ToString());
            if (Condition != 0)
            {
                sb.AppendFormat(".{0}", Condition.ToString().ToLowerInvariant());
            }
            if (Delay)
            {
                sb.Append(".d");
            }
            if (SignExtend)
            {
                sb.AppendFormat(".x");
            }
            if (SetFlags)
            {
                sb.Append(".f");
            }
            if (Writeback != AddressWritebackMode.None)
            {
                sb.AppendFormat(".{0}", Writeback);
            }
            if (DirectWrite)
            {
                sb.Append(".di");
            }
            renderer.WriteMnemonic(sb.ToString());
        }
    }
}
