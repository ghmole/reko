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

using Reko.Core.Rtl;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Collections;
using Reko.Core;
using Reko.Core.Expressions;
using Reko.Core.Machine;
using Reko.Core.Types;
using System.Diagnostics;
using Reko.Core.Lib;
using Reko.Core.Services;
using Reko.Core.Memory;

namespace Reko.Arch.Avr
{
    public class Avr8Rewriter : IEnumerable<RtlInstructionCluster>
    {
        private readonly Avr8Architecture arch;
        private readonly IStorageBinder binder;
        private readonly IRewriterHost host;
        private readonly LookaheadEnumerator<AvrInstruction> dasm;
        private readonly EndianImageReader rdr;
        private readonly ProcessorState state;
        private AvrInstruction instr;
        private RtlEmitter m;
        private InstrClass iclass;
        private List<RtlInstruction> rtlInstructions;
        private List<RtlInstructionCluster> clusters;

        public Avr8Rewriter(Avr8Architecture arch, EndianImageReader rdr, ProcessorState state, IStorageBinder binder, IRewriterHost host)
        {
            this.arch = arch;
            this.rdr = rdr;
            this.dasm = new LookaheadEnumerator<AvrInstruction>(new Avr8Disassembler(arch, rdr).GetEnumerator());
            this.state = state;
            this.binder = binder;
            this.host = host;
        }

        public IEnumerator<RtlInstructionCluster> GetEnumerator()
        {
            while (dasm.MoveNext())
            {
                this.clusters = new List<RtlInstructionCluster>();
                Rewrite(dasm.Current);
                foreach (var cluster in clusters)
                {
                    yield return cluster;
                }
            }
        }

        public void Rewrite(AvrInstruction instr)
        {
            this.instr = instr;
            this.rtlInstructions = new List<RtlInstruction>();
            this.iclass = instr.InstructionClass;
            this.m = new RtlEmitter(rtlInstructions);
            switch (instr.Mnemonic)
            {
            case Mnemonic.adc: RewriteAdcSbc(m.IAdd); break;
            case Mnemonic.add: RewriteBinOp(m.IAdd, CmpFlags); break;
            case Mnemonic.adiw: RewriteAddSubIW(m.IAdd); break;
            case Mnemonic.and: RewriteBinOp(m.And, arch.SNZ, arch.V); break;
            case Mnemonic.andi: RewriteBinOp(m.And, arch.SNZ, arch.V); break;
            case Mnemonic.asr: RewriteAsr(); break;
            case Mnemonic.brcc: RewriteBranch(ConditionCode.UGE, arch.C); break;
            case Mnemonic.brcs: RewriteBranch(ConditionCode.ULT, arch.C); break;
            case Mnemonic.breq: RewriteBranch(ConditionCode.EQ, arch.Z); break;
            case Mnemonic.brge: RewriteBranch(ConditionCode.GE, arch.VN); break;
            case Mnemonic.brid: RewriteBranch(arch.I, false); break;
            case Mnemonic.brne: RewriteBranch(ConditionCode.NE, arch.Z); break;
            case Mnemonic.brpl: RewriteBranch(ConditionCode.GE, arch.N); break;
            case Mnemonic.call: RewriteCall(); break;
            case Mnemonic.cli: RewriteCli(); break;
            case Mnemonic.com: RewriteUnary(m.Comp, arch.SNZ, arch.V, arch.C); break;
            case Mnemonic.cp: RewriteCp(); break;
            case Mnemonic.cpi: RewriteCp(); break;
            case Mnemonic.cpc: RewriteCpc(); break;
            case Mnemonic.cpse: SkipIf(m.Eq); break;
            case Mnemonic.dec: RewriteIncDec(m.ISub); break;
            case Mnemonic.des: RewriteDes(); break;
            case Mnemonic.eor: RewriteBinOp(m.Xor, LogicalFlags, arch.V); break;
            case Mnemonic.icall: RewriteIcall(); break;
            case Mnemonic.@in: RewriteIn(); break;
            case Mnemonic.inc: RewriteIncDec(m.IAdd); break;
            case Mnemonic.ijmp: RewriteIjmp(); break;
            case Mnemonic.jmp: RewriteJmp(); break;
            case Mnemonic.ld: RewriteLd(); break;
            case Mnemonic.ldd: RewriteLd(); break;
            case Mnemonic.ldi: RewriteLdi(); break;
            case Mnemonic.lds: RewriteLds(); break;
            case Mnemonic.lpm: RewriteLpm(); break;
            case Mnemonic.lsr: RewriteLsr(); break;
            case Mnemonic.mov: RewriteMov(); break;
            case Mnemonic.movw: RewriteMovw(); break;
            case Mnemonic.muls: RewriteMuls(); break;
            case Mnemonic.neg: RewriteUnary(m.Neg, CmpFlags); break;
            case Mnemonic.@out: RewriteOut(); break;
            case Mnemonic.or: RewriteBinOp(m.Or, arch.SNZV); break;
            case Mnemonic.ori: RewriteBinOp(m.Or, arch.SNZV); break;
            case Mnemonic.pop: RewritePop(); break;
            case Mnemonic.push: RewritePush(); break;
            case Mnemonic.rcall: RewriteCall(); break;
            case Mnemonic.ror: RewriteRor(); break;
            case Mnemonic.ret: RewriteRet(); break;
            case Mnemonic.reti: RewriteRet(); break;  //$TODO: more to indicate interrupt return?
            case Mnemonic.rjmp: RewriteJmp(); break;
            case Mnemonic.sbc: RewriteAdcSbc(m.ISub); break;
            case Mnemonic.sbci: RewriteAdcSbc(m.ISub); break;
            case Mnemonic.sbis: RewriteSbis(); return; // We've already added ourself to clusters.
            case Mnemonic.sbiw: RewriteAddSubIW(m.ISub); break;
            case Mnemonic.sbrc: SkipIf(Sbrc); break;
            case Mnemonic.sbrs: SkipIf(Sbrs); break;
            case Mnemonic.sec: RewriteSetBit(arch.C, true); break;
            case Mnemonic.sei: RewriteSei(); break;
            case Mnemonic.st: RewriteSt(); break;
            case Mnemonic.std: RewriteSt(); break;
            case Mnemonic.sts: RewriteSts(); break;
            case Mnemonic.sub: RewriteBinOp(m.ISub, CmpFlags); break;
            case Mnemonic.subi: RewriteBinOp(m.ISub, CmpFlags); break;
            case Mnemonic.swap: RewriteSwap(); break;
            default:
                host.Error(instr.Address, string.Format("AVR8 instruction '{0}' is not supported yet.", instr.Mnemonic));
                EmitUnitTest();
                m.Invalid();
                break;
            }
            clusters.Add(m.MakeCluster(instr.Address, instr.Length, iclass));
        }

        IEnumerator IEnumerable.GetEnumerator()
        {
            return GetEnumerator();
        }

        private void EmitUnitTest()
        {
            var testGenSvc = arch.Services.RequireService<ITestGenerationService>();
            testGenSvc?.ReportMissingRewriter("Avr8_rw", instr, instr.Mnemonic.ToString(), rdr, "");
        }

        private void EmitFlags(Expression e, FlagGroupStorage mod)
        {
            var grf = binder.EnsureFlagGroup(mod);
            m.Assign(grf, m.Cond(e));
        }

        private FlagGroupStorage CmpFlags => arch.HSVNZC;
        private FlagGroupStorage ArithFlags => arch.SVNZC;
        private FlagGroupStorage LogicalFlags => arch.SNZC;
        private FlagGroupStorage IncDecFlags => arch.SVNZ;

        private Identifier RegisterPair(MachineOperand operand)
        {
            var regN = ((RegisterOperand)operand).Register;
            var regN1 = arch.GetRegister(regN.Number + 1);
            var regPair = binder.EnsureSequence(PrimitiveType.Word16, regN1, regN);
            return regPair;
        }

        private void RewriteIO(int iRegOp, int iPortOp, bool read)
        {
            var reg = RewriteOp(iRegOp);
            var port = ((ImmediateOperand)instr.Operands[iPortOp]).Value.ToByte();
            if (port == 0x3F)
            {
                var psreg = binder.EnsureRegister(arch.sreg);
                if (read)
                {
                    m.Assign(reg, psreg);
                }
                else
                {
                    m.Assign(psreg, reg);
                }
            }
            else if (read)
            {
                m.Assign(reg, host.Intrinsic("__in", false, PrimitiveType.Byte, Constant.Byte(port)));
            }
            else
            {
                m.SideEffect(host.Intrinsic("__out", false, VoidType.Instance, Constant.Byte(port), reg));
            }
        }

        private void RewriteBinOp(
             Func<Expression, Expression, Expression> fn,
             FlagGroupStorage mod,
             FlagGroupStorage clr = null)
        {
            var dst = RewriteOp(0);
            var src = RewriteOp(1);
            m.Assign(dst, fn(dst, src));
            EmitFlags(dst, mod);
            if (clr != null)
            {
                m.Assign(binder.EnsureFlagGroup(clr), 0);
            }
        }

        private void RewriteUnary(
             Func<Expression, Expression> fn,
             FlagGroupStorage mod,
             FlagGroupStorage clr = null,
             FlagGroupStorage set = null)
        {
            var reg = RewriteOp(0);
            m.Assign(reg, fn(reg));
            EmitFlags(reg, mod);
            if (clr != null)
            {
                m.Assign(binder.EnsureFlagGroup(clr), 0);
            }
            if (set != null)
            {
                m.Assign(binder.EnsureFlagGroup(set), 1);
            }
        }

        private Expression RewriteOp(int iOp)
        {
            var op = instr.Operands[iOp];
            switch (op)
            {
            case RegisterOperand rop:
                return binder.EnsureRegister(rop.Register);
            case ImmediateOperand iop:
                return iop.Value;
            case AddressOperand aop:
                return aop.Address;
            }
            throw new NotImplementedException(string.Format("Rewriting {0}s not implemented yet.", op.GetType().Name));
        }

        private void RewriteMem(int iOp, Expression src, Action<Expression, Expression> write, Expression seg)
        {
            var op = instr.Operands[iOp];
            var mop = (MemoryOperand)op;
            var baseReg = binder.EnsureRegister(mop.Base);
            Expression ea = baseReg;
            if (mop.PreDecrement)
            {
                m.Assign(baseReg, m.ISubS(baseReg, 1));
            } else if (mop.Displacement != 0)
            {
                ea = m.IAddS(ea, mop.Displacement);
            }
            Expression val;
            if (seg != null)
            {
                val = m.SegMem(mop.Width, seg, ea);
            }
            else
            {
                val = m.Mem(mop.Width, ea);
            }
            write(val, src);
            if (mop.PostIncrement)
            {
                m.Assign(baseReg, m.IAddS(baseReg, 1));
            }
        }

        public void RewriteAdcSbc(Func<Expression, Expression, Expression> opr)
        {
            // We do not take the trouble of widening the CF to the word size
            // to simplify code analysis in later stages. 
            var c = binder.EnsureFlagGroup(arch.C);
            var dst = RewriteOp(0);
            var src = RewriteOp(1);
            m.Assign(
                dst,
                opr(
                    opr(dst, src),
                    c));
            EmitFlags(dst, CmpFlags);
        }

        private void RewriteAddSubIW(Func<Expression,Expression,Expression> fn)
        {
            var operand = instr.Operands[0];
            var regPair = RegisterPair(operand);
            var imm = ((ImmediateOperand)instr.Operands[1]).Value;
            m.Assign(regPair, fn(regPair, Constant.Word16(imm.ToUInt16())));
            EmitFlags(regPair, ArithFlags);
        }

        private void RewriteAsr()
        {
            var reg = RewriteOp(0);
            m.Assign(reg, m.Sar(reg, 1));
            EmitFlags(reg, ArithFlags);
        }

        private void RewriteBranch(ConditionCode cc, FlagGroupStorage flags)
        {
            var grf = binder.EnsureFlagGroup(flags);
            var target = (Address)RewriteOp(0);
            m.Branch(m.Test(cc, grf), target, InstrClass.ConditionalTransfer);
        }

        private void RewriteBranch(FlagGroupStorage grf, bool set)
        {
            iclass = InstrClass.ConditionalTransfer;
            Expression test = binder.EnsureFlagGroup(grf);
            if (!set)
                test = m.Not(test);
            var target = (Address)RewriteOp(0);
            m.Branch(test, target, InstrClass.ConditionalTransfer);
        }

        private void RewriteMov()
        {
            var dst = RewriteOp(0);
            var src = RewriteOp(1);
            m.Assign(dst, src);
        }

        private void RewriteMovw()
        {
            var pairDst = RegisterPair(instr.Operands[0]);
            var pairSrc = RegisterPair(instr.Operands[1]);
            m.Assign(pairDst, pairSrc);
        }

        private void RewriteCall()
        {
            iclass = InstrClass.Transfer | InstrClass.Call;
            m.Call(RewriteOp(0), 2);    //$TODO: 3-byte mode in architecture.
        }

        private void RewriteCli()
        {
            m.SideEffect(host.Intrinsic("__cli", false, VoidType.Instance));
        }

        private void RewriteCp()
        {
            var left = RewriteOp(0);
            var right = RewriteOp(1);
            var flags = binder.EnsureFlagGroup(CmpFlags);
            m.Assign(flags, m.ISub(left, right));
        }

        private void RewriteCpc()
        {
            var left = RewriteOp(0);
            var right = RewriteOp(1);
            var c = binder.EnsureFlagGroup(arch.C);
            var flags = binder.EnsureFlagGroup(CmpFlags);
            m.Assign(flags, m.ISub(m.ISub(left, right), c));
        }

        private void SkipIf(Func<Expression, Expression,Expression> cond)
        {
            iclass = InstrClass.ConditionalTransfer;
            //$BUG: may boom if there is no next instruction.
            var nextInstr = dasm.Peek(1);
            var left = RewriteOp(0);
            var right = RewriteOp(1);
            m.Branch(cond(left,right), nextInstr.Address + nextInstr.Length, iclass);

        }

        private Expression Sbrc(Expression a, Expression b)
        {
            var imm = ((Constant)b).ToInt32();
            return m.Eq0(m.And(a, m.Byte((byte)(1 << imm))));
        }

        private Expression Sbrs(Expression a, Expression b)
        {
            var imm = ((Constant)b).ToInt32();
            return m.Ne0(m.And(a, m.Byte((byte)(1 << imm))));
        }

        private void RewriteDes()
        {
            var h = binder.EnsureFlagGroup(arch.H);
            m.SideEffect(host.Intrinsic("__des", false, VoidType.Instance, RewriteOp(0), h));
        }

        private void RewriteIcall()
        {
            iclass = InstrClass.Transfer | InstrClass.Call;
            var z = binder.EnsureRegister(Avr8Architecture.z);
            m.Call(z, 2);
        }

        private void RewriteIn()
        {
            RewriteIO(0, 1, true);
        }

        private void RewriteIjmp()
        {
            iclass = InstrClass.Transfer;
            var z = binder.EnsureRegister(Avr8Architecture.z);
            m.Goto(z);
        }

        private void RewriteIncDec(Func<Expression, Expression, Expression> fn)
        {
            var reg = RewriteOp(0);
            m.Assign(reg, fn(reg, Constant.SByte(1)));
            EmitFlags(reg, IncDecFlags);
        }

        private void RewriteLd()
        {
            var dst = RewriteOp(0);
            RewriteMem(1, dst, (d, s) => m.Assign(s, d), null);
        }

        private void RewriteLdi()
        {
            m.Assign(RewriteOp(0), RewriteOp(1));
        }

        private void RewriteLds()
        {
            m.Assign(RewriteOp(0), m.Mem8(RewriteOp(1)));
        }

        private void RewriteLpm()
        {
            var codeSel = binder.EnsureRegister(arch.code);
            if (instr.Operands.Length == 0)
            {
                var z = binder.EnsureRegister(Avr8Architecture.z);
                var r0 = binder.EnsureRegister(arch.GetRegister(0));
                m.Assign(r0, m.SegMem8(codeSel, z));
            }
            else
            {
                var dst = RewriteOp(0);
                RewriteMem(1, dst, (d, s) => m.Assign(s, d), codeSel);
            }
        }

        private void RewriteLsr()
        {
            var reg = RewriteOp(0);
            m.Assign(reg, m.Shr(reg, 1));
            EmitFlags(reg, arch.SVZC);
            m.Assign(binder.EnsureFlagGroup(arch.N), 0);
        }

        private void RewriteJmp()
        {
            iclass = InstrClass.Transfer;
            var op = RewriteOp(0);
            if (op is Constant c)
            {
                op = arch.MakeAddressFromConstant(c, true);
            }
            m.Goto(op);
        }

        private void RewriteMuls()
        {
            var r1_r0 = binder.EnsureSequence(PrimitiveType.Word16, arch.ByteRegs[1], arch.ByteRegs[0]);
            var op0 = RewriteOp(0);
            var op1 = RewriteOp(1);
            var c = binder.EnsureFlagGroup(arch.C);
            var z = binder.EnsureFlagGroup(arch.Z);
            var smul = m.SMul(op0, op1);
            smul.DataType = PrimitiveType.Int16;
            m.Assign(r1_r0, smul);
            m.Assign(c, m.Lt0(r1_r0));
            m.Assign(z, m.Eq0(r1_r0));
        }

        private void RewriteOut()
        {
            RewriteIO(1, 0, false);
        }

        private void RewritePop()
        {
            var sp = binder.EnsureRegister(arch.StackRegister);
            m.Assign(RewriteOp(0), m.Mem8(sp));
            m.Assign(sp, m.IAddS(sp, 1));
        }

        private void RewritePush()
        {
            var sp = binder.EnsureRegister(arch.StackRegister);
            m.Assign(sp, m.ISubS(sp, 1));
            m.Assign(m.Mem8(sp), RewriteOp(0));
        }

        private void RewriteRet()
        {
            iclass = InstrClass.Transfer;
            m.Return(2, 0);
        }

        private void RewriteRor()
        {
            var c = binder.EnsureFlagGroup(arch.C);
            var reg = RewriteOp(0);
            m.Assign(reg, host.Intrinsic(IntrinsicProcedure.RorC, true, PrimitiveType.Byte, reg, m.Int32(1), c));
            EmitFlags(reg, CmpFlags);
        }

        private void RewriteSbis()
        {
            var io = host.Intrinsic("__in", false, PrimitiveType.Byte, RewriteOp(0));
            var bis = host.Intrinsic("__bit_set", true, PrimitiveType.Bool, io, RewriteOp(1));
            if (!dasm.MoveNext())
            {
                m.Invalid();
                return;
            }
            var addrSkip = dasm.Current.Address + dasm.Current.Length;
            var branch = m.BranchInMiddleOfInstruction(bis, addrSkip, InstrClass.ConditionalTransfer);
            clusters.Add(m.MakeCluster(this.instr.Address, this.instr.Length, InstrClass.ConditionalTransfer));
            Rewrite(dasm.Current);
        }

        private void RewriteSei()
        {
            m.SideEffect(host.Intrinsic("__sei", false, VoidType.Instance));
        }

        private void RewriteSetBit(FlagGroupStorage grf, bool value)
        {
            m.Assign(binder.EnsureFlagGroup(grf), Constant.Bool(value));
        }

        private void RewriteSt()
        {
            var src = RewriteOp(1);
            RewriteMem(0, src, (d, s) => m.Assign(d, s), null);
        }

        private void RewriteSts()
        {
            m.Assign(m.Mem8(RewriteOp(0)), RewriteOp(1));
        }

        private void RewriteSwap()
        {
            var reg = RewriteOp(0);
            m.Assign(reg, host.Intrinsic("__swap", true, PrimitiveType.Byte, reg));
        }

    }
}
