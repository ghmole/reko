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
using Reko.Core.Rtl;
using Reko.Core.Types;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Reko.Arch.PowerPC
{
    partial class PowerPcRewriter
    {
        private void RewriteDcbf()
        {
            m.SideEffect(host.Intrinsic("__dcbf", false, VoidType.Instance,
                EffectiveAddress_r0(instr.Operands[0], instr.Operands[1])));
        }

        private void RewriteDcbi()
        {
            m.SideEffect(host.Intrinsic("__dcbi", false, VoidType.Instance,
                EffectiveAddress_r0(instr.Operands[0], instr.Operands[1])));
        }

        private void RewriteDcbt()
        {
            // This is just a hint to the cache; makes no sense to have it in
            // high-level language. Consider adding option to have cache
            // hint instructions decompiled into intrinsics
        }

        private void RewriteDcbst()
        {
            m.SideEffect(host.Intrinsic("__dcbst", false, VoidType.Instance,
                EffectiveAddress_r0(instr.Operands[0], instr.Operands[1])));
        }

        private void RewriteIcbi()
        {
            m.SideEffect(host.Intrinsic("__icbi", false, VoidType.Instance,
                EffectiveAddress_r0(instr.Operands[0], instr.Operands[1])));
        }

        private void RewriteIsync()
        {
            m.SideEffect(host.Intrinsic("__isync", false, VoidType.Instance));
        }

        private void RewriteMfmsr()
        {
            var dst = RewriteOperand(instr.Operands[0]);
            m.Assign(dst, host.Intrinsic("__read_msr", false, PrimitiveType.Word32));
        }

        private void RewriteMfspr()
        {
            var spr = RewriteOperand(instr.Operands[0]);
            var reg = RewriteOperand(instr.Operands[1]);
            if (spr is Identifier id)
            {
                m.Assign(reg, id);
            }
            else
            {
                m.Assign(
                    reg,
                    host.Intrinsic("__read_spr", false, PrimitiveType.Word32, spr));
            }
        }

        private void RewriteMtmsr(PrimitiveType dt)
        {
            var src = RewriteOperand(instr.Operands[0]);
            m.SideEffect(host.Intrinsic("__write_msr", false, VoidType.Instance, src));
        }

        private void RewriteMtspr()
        {
            var spr = RewriteOperand(instr.Operands[0]);
            var reg = RewriteOperand(instr.Operands[1]);
            if (spr is Identifier id)
            {
                m.Assign(id, reg);
            }
            else
            {
                m.SideEffect(host.Intrinsic("__write_spr", false, PrimitiveType.Word32, spr, reg));
            }
        }

        private void RewriteRfi()
        {
            var srr0 = binder.EnsureRegister(arch.SpRegisters[26]);
            var srr1 = binder.EnsureRegister(arch.SpRegisters[27]);
            m.SideEffect(host.Intrinsic("__write_msr", false, PrimitiveType.Word32, srr1));
            m.Goto(srr0);
        }

        private void RewriteTlbie()
        {
            var src = RewriteOperand(instr.Operands[0]);
            m.SideEffect(host.Intrinsic("__tlbie", false, VoidType.Instance, src));
        }

        private void RewriteTlbsync()
        {
            m.SideEffect(host.Intrinsic("__tlbie", false, VoidType.Instance));
        }
    }
}
