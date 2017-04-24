﻿#region License
/* 
 * Copyright (C) 1999-2017 John Källén.
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
using Reko.Core.NativeInterface;
using Reko.Core.Types;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.InteropServices;
using System.Text;
using System.Threading.Tasks;

namespace Reko.Arch.Arm
{
    [ComVisible(true)]
    [ClassInterface(ClassInterfaceType.None)]
    public class ArmNativeRewriterHost : MarshalByRefObject, INativeRewriterHost
    {
        private Frame frame;
        private IRewriterHost host;
        private RtlNativeEmitter m;

        public ArmNativeRewriterHost(Frame frame, IRewriterHost host, RtlNativeEmitter m)
        {
            this.frame = frame;
            this.host = host;
            this.m = m;
        }

        public virtual RegisterStorage GetRegister(int reg)
        {
            return A32Registers.RegisterByCapstoneIDNew[(capstone_arm_reg)reg];
        }

        public HExpr CreateTemporary(BaseType size)
        {
            var id = frame.CreateTemporary(Interop.DataTypes[size]);
            return m.MapToHandle(id);
        }

        public HExpr EnsureFlagGroup(int baseReg, int bitmask, string name, BaseType size)
        {
            var reg = A32Registers.RegisterByCapstoneIDNew[(capstone_arm_reg)baseReg];
            var id = frame.EnsureFlagGroup((FlagRegister)reg, (uint)bitmask, name, Interop.DataTypes[size]);
            return m.MapToHandle(id);
        }

        public HExpr EnsureRegister(int reg)
        {
            var r = GetRegister(reg);
            var id = frame.EnsureRegister(r);
            return m.MapToHandle(id);
        }

        public HExpr EnsureSequence(int regHi, int regLo, BaseType size)
        {
            var hi = A32Registers.RegisterByCapstoneIDNew[(capstone_arm_reg)regHi];
            var lo = A32Registers.RegisterByCapstoneIDNew[(capstone_arm_reg)regLo];
            var id = frame.EnsureSequence(hi, lo, Interop.DataTypes[size]);
            return m.MapToHandle(id);
        }

        public void Error(ulong uAddress, string error)
        {
            host.Error(m.CreateAddress(uAddress), error);
        }

        public HExpr EnsurePseudoProcedure(string name, BaseType dt, int arity)
        {
            var exp = host.EnsurePseudoProcedure(name, Interop.DataTypes[dt], arity);
            var pc = new ProcedureConstant(PrimitiveType.Pointer32, exp);
            return m.MapToHandle(pc);
        }
    }
}