#region License
/* 
 * Copyright (C) 1999-2019 John Källén.
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
using System.Linq;
using System.Text;
using System.Collections;
using Reko.Core;
using Reko.Core.Expressions;
using Reko.Core.Lib;
using Reko.Core.Types;

namespace Reko.Arch.RiscV
{
    using Decoder = Reko.Core.Machine.Decoder<RiscVDisassembler, Mnemonic, RiscVInstruction>;
    using MaskDecoder = Reko.Core.Machine.MaskDecoder<RiscVDisassembler, Mnemonic, RiscVInstruction>;

    public class RiscVDisassembler : DisassemblerBase<RiscVInstruction>
    {
        private static readonly Decoder[] decoders;
        private static readonly MaskDecoder w32decoders;
        private static readonly Decoder[] compressed0;
        private static readonly Decoder[] compressed1;
        private static readonly Decoder[] compressed2;
        private static readonly int[] compressedRegs;
        private static readonly Decoder invalid;

        private readonly RiscVArchitecture arch;
        private readonly EndianImageReader rdr;
        private Address addrInstr;
        private State state;

        public RiscVDisassembler(RiscVArchitecture arch, EndianImageReader rdr)
        {
            this.arch = arch;
            this.rdr = rdr;
            this.state = new State();
        }

        public override RiscVInstruction DisassembleInstruction()
        {
            this.addrInstr = rdr.Address;
            if (!rdr.TryReadLeUInt16(out ushort hInstr))
            {
                return null;
            }
            var instr = decoders[hInstr & 0x3].Decode(hInstr, this);
            instr.Address = addrInstr;
            instr.Length = (int) (rdr.Address - addrInstr);
            instr.InstructionClass |= hInstr == 0 ? InstrClass.Zero : 0;
            return instr;
        }

        private RiscVInstruction BuildInstruction(Mnemonic opcode, InstrClass iclass, List<MachineOperand> ops)
        { 
            var instr = new RiscVInstruction
            {
                Address = this.addrInstr,
                Mnemonic = opcode,
                InstructionClass = iclass,
                Operands = ops.ToArray(),
                Length = (int)(this.rdr.Address - addrInstr)
            };
            return instr;
        }

        //private RiscVInstruction DecodeWideOperands(Opcode opcode, InstrClass iclass, Mutator<RiscVDisassembler>[] fmt, uint wInstr)
        //{
        //    for (int i = 0; i < fmt.Length; ++i)
        //    {
        //        MachineOperand op;
        //        switch (fmt[i++])
        //        {
        //        default: throw new InvalidOperationException(string.Format("Unsupported operand code {0}", fmt[i - 1]));
        //        case ',': continue;
        //   return BuildInstruction(opcode, iclass, ops);
        // 
        private static bool r1(uint wInstr, RiscVDisassembler dasm)
        {
            var op = dasm.GetRegister(wInstr, 15);
            dasm.state.ops.Add(op);
            return true;
        }

        private static bool r2(uint wInstr, RiscVDisassembler dasm)
        {
            var op = dasm.GetRegister(wInstr, 20);
            dasm.state.ops.Add(op);
            return true;
        }

        private static bool d(uint wInstr, RiscVDisassembler dasm)
        {
            var op = dasm.GetRegister(wInstr, 7);
            dasm.state.ops.Add(op);
            return true;
        }

        private static bool i(uint wInstr, RiscVDisassembler dasm)
        {
            var op = dasm.GetImmediate(wInstr, 20, 's');
            dasm.state.ops.Add(op);
            return true;
        }

        private static bool B(uint wInstr, RiscVDisassembler dasm)
        { 
            var op = dasm.GetBranchTarget(wInstr);
            dasm.state.ops.Add(op);
            return true;
        }

        private static Mutator<RiscVDisassembler> Ff(int bitPos)
        {
            return (u, d) =>
            {
                var op = d.GetFpuRegister(u, bitPos);
                d.state.ops.Add(op);
                return true;
            };
        }
        private static readonly Mutator<RiscVDisassembler> F1 = Ff(15);
        private static readonly Mutator<RiscVDisassembler> F2 = Ff(20);
        private static readonly Mutator<RiscVDisassembler> F3 = Ff(27);
        private static readonly Mutator<RiscVDisassembler> Fd = Ff(7);

        private static bool J (uint u, RiscVDisassembler d)
        {
            var offset = Bitfield.ReadSignedFields(j_bitfields, u) << 1;
            d.state.ops.Add(AddressOperand.Create(d.addrInstr + offset));
            return true;
        }

        private static bool Iu(uint wInstr, RiscVDisassembler dasm)
        {
            uint u = wInstr >> 12;
            var op = ImmediateOperand.Word32(u);
            dasm.state.ops.Add(op);
            return true;
        }

        private static bool Ss(uint wInstr, RiscVDisassembler dasm)
        {
            var op = dasm.GetSImmediate(wInstr);
            dasm.state.ops.Add(op);
            return true;
        }

        // signed offset used in loads
        private static bool Ls(uint wInstr, RiscVDisassembler dasm)
        {
            var op = dasm.GetImmediate(wInstr, 20, 's');
            dasm.state.ops.Add(op);
            return true;
        }

        private static bool z(uint wInstr, RiscVDisassembler dasm)
        {
            var op = dasm.GetShiftAmount(wInstr, 5);
            dasm.state.ops.Add(op);
            return true;
        }

        private static bool Z(uint wInstr, RiscVDisassembler dasm)
        {
            var op = dasm.GetShiftAmount(wInstr, 6);
            dasm.state.ops.Add(op);
            return true;
        }

        private RegisterOperand GetRegister(uint wInstr, int bitPos)
        {
            var reg = arch.GetRegister((int)(wInstr >> bitPos) & 0x1F);
            return new RegisterOperand(reg);
        }

        private RegisterOperand GetFpuRegister(uint wInstr, int bitPos)
        {
            var reg = arch.GetRegister(32 + ((int)(wInstr >> bitPos) & 0x1F));
            return new RegisterOperand(reg);
        }

        private ImmediateOperand GetImmediate(uint wInstr, int bitPos, char sign)
        {
            if (sign == 's')
            {
                int s = ((int)wInstr) >> bitPos;
                return ImmediateOperand.Int32(s);
            }
            else
            {
                uint u = wInstr >> bitPos;
                return ImmediateOperand.Word32(u);
            }
        }

        private ImmediateOperand GetShiftAmount(uint wInstr, int length)
        {
            return ImmediateOperand.UInt32(extract32(wInstr, 20, length));
        }

        private static bool bit(uint wInstr, int bitNo)
        {
            return (wInstr & (1u << bitNo)) != 0;
        }

        private static uint extract32(uint wInstr, int start, int length)
        {
            uint n = (wInstr >> start) & (~0U >> (32 - length));
            return n;
        }

        private static ulong sextract64(ulong value, int start, int length)
        {
            long n = ((long)(value << (64 - length - start))) >> (64 - length);
            return (ulong)n;
        }

        private AddressOperand GetBranchTarget(uint wInstr)
        { 
            long offset = (long)
                  ((extract32(wInstr, 8, 4) << 1)
                | (extract32(wInstr, 25, 6) << 5)
                | (extract32(wInstr, 7, 1) << 11)
                | (sextract64(wInstr, 31, 1) << 12));
            return AddressOperand.Create(addrInstr + offset);
        }

        private AddressOperand GetJumpTarget(uint wInstr)
        {
            long offset = (long)
                  ((extract32(wInstr, 21, 10) << 1)
                | (extract32(wInstr, 20, 1) << 11)
                | (extract32(wInstr, 12, 8) << 12)
                | (sextract64(wInstr, 31, 1) << 20));
            return AddressOperand.Create(addrInstr + offset);
        }

        private ImmediateOperand GetSImmediate(uint wInstr)
        {
            var offset = (int)
                   (extract32(wInstr, 7, 5)
                 | (extract32(wInstr, 25, 7) << 5));
            return ImmediateOperand.Int32(offset);
        }

        private static HashSet<uint> seen = new HashSet<uint>();

        private new RiscVInstruction NotYetImplemented(uint instr, string message)
        {
            if (!seen.Contains(instr))
            {
                seen.Add(instr);
                base.EmitUnitTest("RiscV", instr.ToString("X8"), message, "RiscV_dasm", Address.Ptr32(0x00100000), w =>
                {
                    w.WriteLine("    AssertCode(\"@@@\", 0x{0:X8});", instr);
                });
            }
            return CreateInvalidInstruction();
        }

        public RiscVInstruction MakeInstruction()
        {
            var i = state.instr;
            i.Address = this.addrInstr;
            var ops = this.state.ops;
            i.Operands = ops.ToArray();
            state.instr = new RiscVInstruction();
            return i;
        }

        protected override RiscVInstruction CreateInvalidInstruction()
        {
            return new RiscVInstruction
            {
                Address = addrInstr,
                InstructionClass = InstrClass.Invalid,
                Mnemonic = Mnemonic.invalid,
                Operands = new MachineOperand[0]
            };
        }


        internal class State
        {
            public RiscVInstruction instr = new RiscVInstruction();
            public List<MachineOperand> ops = new List<MachineOperand>();
        }

        #region Decoders

        public class NyiDecoder : Decoder
        {
            private readonly string message; 

            public NyiDecoder(string message)
            {
                this.message = message;
            }

            public override RiscVInstruction Decode(uint hInstr, RiscVDisassembler dasm)
            {
                return dasm.NotYetImplemented(hInstr, message);
            }
        }

        public class CDecoder : Decoder
        {
            private readonly InstrClass iclass;
            private readonly Mnemonic opcode;
            private readonly Mutator<RiscVDisassembler>[] mutators;

            internal CDecoder(InstrClass iclass, Mnemonic opcode, params Mutator<RiscVDisassembler>[] mutators)
            {
                this.iclass = iclass;
                this.opcode = opcode;
                this.mutators = mutators;
            }

            public override RiscVInstruction Decode(uint wInstr, RiscVDisassembler dasm)
            {
                dasm.state.instr.InstructionClass = this.iclass;
                dasm.state.instr.Mnemonic = opcode;
                dasm.state.ops.Clear();
                foreach (var m in mutators)
                {
                    if (!m(wInstr, dasm))
                        return dasm.CreateInvalidInstruction();
                }
                return dasm.MakeInstruction();
            }
        }

        public class WInstrDecoderOld : Decoder
        {
            private readonly Mnemonic opcode;
            private readonly InstrClass iclass;
            private readonly Mutator<RiscVDisassembler> [] mutators;

            public WInstrDecoderOld(InstrClass iclass, Mnemonic opcode, params Mutator<RiscVDisassembler>[] mutators)
            {
                this.iclass = iclass;
                this.opcode = opcode;
                this.mutators = mutators;
            }

            public override RiscVInstruction Decode(uint wInstr, RiscVDisassembler dasm)
            {
                dasm.state.instr.InstructionClass = this.iclass;
                dasm.state.instr.Mnemonic = opcode;
                dasm.state.ops.Clear();
                foreach (var m in mutators)
                {
                    if (!m(wInstr, dasm))
                        return dasm.CreateInvalidInstruction();
                }
                return dasm.MakeInstruction();
            }
        }

        public class FpuDecoder : Decoder
        {
            private readonly Mutator<RiscVDisassembler>[] mutators;
            private readonly Mnemonic opcode;

            public FpuDecoder(Mnemonic opcode, params Mutator<RiscVDisassembler>[] mutators)
            {
                this.opcode = opcode;
                this.mutators = mutators;
            }

            public override RiscVInstruction Decode(uint wInstr, RiscVDisassembler dasm)
            {
                dasm.state.instr.InstructionClass = InstrClass.Linear;
                dasm.state.instr.Mnemonic = opcode;
                dasm.state.ops.Clear();
                foreach (var m in mutators)
                {
                    if (!m(wInstr, dasm))
                        return dasm.CreateInvalidInstruction();
                }
                return dasm.MakeInstruction();
            }
        }

        public class W32Decoder : Decoder
        {
            private readonly MaskDecoder<RiscVDisassembler, Mnemonic, RiscVInstruction> subDecoders;

            public W32Decoder(MaskDecoder subDecoders)
            {
                this.subDecoders = subDecoders;
            }

            public override RiscVInstruction Decode(uint hInstr, RiscVDisassembler dasm)
            {
                if (!dasm.rdr.TryReadUInt16(out ushort hiword))
                {
                    return dasm.CreateInvalidInstruction();
                }
                uint wInstr = (uint)hiword << 16;
                wInstr |= hInstr;
                return subDecoders.Decode(wInstr, dasm);
            }
        }

        public class ShiftDecoder : Decoder
        {
            private readonly Decoder[] decoders;

            public ShiftDecoder(params Decoder[] decoders)
            {
                this.decoders = decoders;
            }

            public override RiscVInstruction Decode(uint wInstr, RiscVDisassembler dasm)
            {
                var decoder = decoders[bit(wInstr, 30) ? 1 : 0];
                return decoder.Decode(wInstr, dasm);
            }
        }

        /// <summary>
        /// Handle instructions that are encoded differently depending on the word size
        /// of the CPU architecture.
        /// </summary>
        internal class WordSizeDecoder : Decoder
        {
            private readonly Decoder rv32;
            private readonly Decoder rv64;
            private readonly Decoder rv128;

            public WordSizeDecoder(
                Decoder rv32 = null,
                Decoder rv64 = null,
                Decoder rv128 = null)
            {
                this.rv32 = rv32 ?? invalid;
                this.rv64 = rv64 ?? invalid;
                this.rv128 = rv128 ?? invalid;
            }

            public override RiscVInstruction Decode(uint wInstr, RiscVDisassembler dasm)
            {
                switch (dasm.arch.WordWidth.Size)
                {
                case 4: return rv32.Decode(wInstr, dasm);
                case 8: return rv64.Decode(wInstr, dasm);
                case 16: return rv128.Decode(wInstr, dasm);
                }
                throw new NotSupportedException($"{dasm.arch.WordWidth.Size}-bit Risc-V instructions not supported.");
            }
        }

        #endregion

        private static WInstrDecoderOld Instr(Mnemonic opcode, params Mutator<RiscVDisassembler>[] mutators)
        {
            return new WInstrDecoderOld(InstrClass.Linear, opcode, mutators);
        }

        private static WInstrDecoderOld Instr(Mnemonic opcode, InstrClass iclass, params Mutator<RiscVDisassembler>[] mutators)
        {
            return new WInstrDecoderOld(iclass, opcode, mutators);
        }

        // Compact instruction decoder

        private static CDecoder CInstr(Mnemonic opcode, params Mutator<RiscVDisassembler>[] mutators)
        {
            return new CDecoder(InstrClass.Linear, opcode, mutators);
        }

        private static CDecoder CInstr(InstrClass iclass, Mnemonic opcode, params Mutator<RiscVDisassembler>[] mutator)
        {
            return new CDecoder(iclass, opcode, mutator);
        }

        // Conditional decoder

        private static WordSizeDecoder WordSize(
            Decoder rv32 = null,
            Decoder rv64 = null,
            Decoder rv128 = null)
        {
            return new WordSizeDecoder(rv32, rv64, rv128);
        }

        private static NyiDecoder Nyi(string message)
        {
            return new NyiDecoder(message);
        }

        #region Mutators

        // The Risc-V manual specifies 5 immediate formats

        // I-immediate
        private static readonly Bitfield iI = new Bitfield(20, 12);
        // S-immediate
        private static readonly Bitfield[] iS = Bf((25, 7), (7, 5));
        // B-immediate
        private static readonly Bitfield[] iB = Bf((31, 1), (7, 1), (25, 6), (8, 4));
        // U-immediate
        private static readonly Bitfield iU = new Bitfield(12, 20);
        // J-immediate
        private static readonly Bitfield[] iJ = Bf((31, 1), (12, 8), (20, 1), (21, 10));

        // Integer register
        private static Mutator<RiscVDisassembler> R(int bitPos)
        {
            var regMask = new Bitfield(bitPos, 5);
            return (u, d) =>
            {
                var iReg = (int) regMask.Read(u);
                var reg = new RegisterOperand(d.arch.GetRegister(iReg));
                d.state.ops.Add(reg);
                return true;
            };
        }

        // Registers specified at fixed positions.

        private static readonly Mutator<RiscVDisassembler> Rd = R(7);
        private static readonly Mutator<RiscVDisassembler> R1 = R(15);
        private static readonly Mutator<RiscVDisassembler> R2 = R(20);

        // Floating point register
        private static Mutator<RiscVDisassembler> F(int bitPos)
        {
            var regMask = new Bitfield(bitPos, 5);
            return (u, d) =>
            {
                var iReg = (int) regMask.Read(u);
                var reg = new RegisterOperand(d.arch.FpRegs[iReg]);
                d.state.ops.Add(reg);
                return true;
            };
        }
        //private static readonly Mutator<RiscVDisassembler> Fd = F(7);
        //private static readonly Mutator<RiscVDisassembler> F1 = F(15);
        //private static readonly Mutator<RiscVDisassembler> F2 = F(20);
        //private static readonly Mutator<RiscVDisassembler> F3 = F(27);

        // Compressed format register (r')
        private static Mutator<RiscVDisassembler> Rc(int bitPos)
        {
            var regMask = new Bitfield(bitPos, 3);
            return (u, d) =>
            {
                var iReg = compressedRegs[regMask.Read(u)];
                var reg = new RegisterOperand(d.arch.GetRegister(iReg));
                d.state.ops.Add(reg);
                return true;
            };
        }

        // Compressed format floating point register (fr')
        private static Mutator<RiscVDisassembler> Fc(int bitPos)
        {
            var regMask = new Bitfield(bitPos, 3);
            return (u, d) =>
            {
                var iReg = compressedRegs[regMask.Read(u)];
                var reg = new RegisterOperand(d.arch.FpRegs[iReg]);
                d.state.ops.Add(reg);
                return true;
            };
        }


        private static Mutator<RiscVDisassembler> ImmSigned(int bitPos, int length)
        {
            var field = new Bitfield(bitPos, length);
            return (u, d) =>
            {
                var imm = Constant.Create(d.arch.NaturalSignedInteger, field.ReadSigned(u));
                d.state.ops.Add(new ImmediateOperand(imm));
                return true;
            };
        }

        private static Mutator<RiscVDisassembler> ImmSigned(Bitfield[] fields)
        {
            return (u, d) =>
            {
                var n = Bitfield.ReadSignedFields(fields, u);
                var imm = Constant.Create(d.arch.NaturalSignedInteger, n);
                d.state.ops.Add(new ImmediateOperand(imm));
                return true;
            };
        }

        // Unsigned immediate
        private static Mutator<RiscVDisassembler> Imm(int bitPos1, int length1)
        {
            var mask = new Bitfield(bitPos1, length1);
            return (u, d) =>
            {
                var imm = Constant.Create(d.arch.WordWidth, mask.Read(u));
                d.state.ops.Add(new ImmediateOperand(imm));
                return true;
            };
        }

        private static Mutator<RiscVDisassembler> Imm(params (int pos, int len) [] fields)
        {
            var masks = fields
                .Select(field => new Bitfield(field.pos, field.len))
                .ToArray();
            return (u, d) =>
            {
                var uImm = Bitfield.ReadFields(masks, u);
                d.state.ops.Add(new ImmediateOperand(
                    Constant.Create(d.arch.WordWidth, uImm)));
                return true;
            };
        }

        // Immediate with a shift
        private static Mutator<RiscVDisassembler> ImmSh(int sh, params (int pos, int len)[] fields)
        {
            var masks = fields
                .Select(field => new Bitfield(field.pos, field.len))
                .ToArray();
            return (u, d) =>
            {
                var uImm = Bitfield.ReadFields(masks, u) << sh;
                d.state.ops.Add(new ImmediateOperand(
                    Constant.Create(d.arch.WordWidth, uImm)));
                return true;
            };
        }

        private static Mutator<RiscVDisassembler> ImmB(params (int pos, int len)[] fields)
        {
            var masks = fields
                .Select(field => new Bitfield(field.pos, field.len))
                .ToArray();
            return (u, d) =>
            {
                var uImm = Bitfield.ReadFields(masks, u);
                d.state.ops.Add(new ImmediateOperand(
                    Constant.Create(PrimitiveType.Byte, uImm)));
                return true;
            };
        }

        private static Mutator<RiscVDisassembler> ImmS(params (int pos, int len)[] fields)
        {
            var masks = fields
                .Select(field => new Bitfield(field.pos, field.len))
                .ToArray();
            return (u, d) =>
            {
                var sImm = Bitfield.ReadSignedFields(masks, u);
                d.state.ops.Add(new ImmediateOperand(
                    Constant.Create(d.arch.WordWidth, sImm)));
                return true;
            };
        }

        // Signed immediate with a shift
        private static Mutator<RiscVDisassembler> ImmShS(int sh, params (int pos, int len)[] fields)
        {
            var masks = fields
                .Select(field => new Bitfield(field.pos, field.len))
                .ToArray();
            return (u, d) =>
            {
                var uImm = Bitfield.ReadSignedFields(masks, u) << sh;
                d.state.ops.Add(new ImmediateOperand(
                    Constant.Create(d.arch.WordWidth, uImm)));
                return true;
            };
        }

        // Common immediate fields
        private static readonly Mutator<RiscVDisassembler> I20s = ImmS((20, 12));
        private static readonly Mutator<RiscVDisassembler> I12 = Imm(12, 20);

        // PC-relative displacement with shift.
        private static Mutator<RiscVDisassembler> PcRel(int sh, params (int pos, int len)[] fields)
        {
            var masks = fields
                .Select(field => new Bitfield(field.pos, field.len))
                .ToArray();
            return (u, d) =>
            {
                var sImm = Bitfield.ReadSignedFields(masks, u) << sh;
                var addr = d.addrInstr + sImm;
                d.state.ops.Add(AddressOperand.Create(addr));
                return true;
            };
        }

        // Memory operand format, where offset is not scaled
        private static Mutator<RiscVDisassembler> Mem(PrimitiveType dt, int regOffset, params (int pos, int len)[] fields)
        {
            var baseRegMask = new Bitfield(regOffset, 5);
            var masks = fields
                .Select(field => new Bitfield(field.pos, field.len))
                .ToArray();
            return (u, d) =>
            {
                var uOffset = (int) Bitfield.ReadFields(masks, u);
                var iBase = (int) baseRegMask.Read(u);

                d.state.ops.Add(new MemoryOperand(dt)
                {
                    Base = d.arch.GetRegister(iBase),
                    Offset = uOffset
                });
                return true;
            };
        }


        // Memory operand format, where offset is scaled by the register size
        private static Mutator<RiscVDisassembler> Mems(PrimitiveType dt, int regOffset, params (int pos, int len)[] fields)
        {
            var baseRegMask = new Bitfield(regOffset, 5);
            var masks = fields
                .Select(field => new Bitfield(field.pos, field.len))
                .ToArray();
            return (u, d) =>
            {
                var uOffset = (int) Bitfield.ReadFields(masks, u) * dt.Size;
                var iBase = (int)baseRegMask.Read(u);

                d.state.ops.Add(new MemoryOperand(dt)
                {
                    Base = d.arch.GetRegister(iBase),
                    Offset = uOffset
                });
                return true;
            };
        }

        // Memory operand format used for compressed instructions
        private static Mutator<RiscVDisassembler> Memc(PrimitiveType dt, int regOffset, params (int pos, int len)[] fields)
        {
            var baseRegMask = new Bitfield(regOffset, 3);
            var masks = fields
                .Select(field => new Bitfield(field.pos, field.len))
                .ToArray();
            return (u, d) =>
            {
                var uOffset = (int) Bitfield.ReadFields(masks, u) * dt.Size;
                var iBase = compressedRegs[baseRegMask.Read(u)];

                d.state.ops.Add(new MemoryOperand(dt)
                {
                    Base = d.arch.GetRegister(iBase),
                    Offset = uOffset
                });
                return true;
            };
        }

        private static readonly Bitfield[] j_bitfields = new[]
        {
            new Bitfield(31, 1),
            new Bitfield(12, 8),
            new Bitfield(20, 1),
            new Bitfield(21, 10)
        };

        #endregion

        static RiscVDisassembler()
        {
            invalid = Instr(Mnemonic.invalid, InstrClass.Invalid);

            var loads = new Decoder[]
            {
                Instr(Mnemonic.lb, d,r1,Ls),
                Instr(Mnemonic.lh, d,r1,Ls),
                Instr(Mnemonic.lw, d,r1,Ls),
                Instr(Mnemonic.ld, d,r1,Ls),

                Instr(Mnemonic.lbu, d,r1,Ls),
                Instr(Mnemonic.lhu, d,r1,Ls),
                Instr(Mnemonic.lwu, d,r1,Ls),    // 64
                Nyi(""),
            };

            var fploads = new Decoder[8]
            {
                invalid,
                invalid,
                CInstr(Mnemonic.flw, Fd,Mem(PrimitiveType.Real32, 15, (20, 12))),
                CInstr(Mnemonic.fld, Fd,Mem(PrimitiveType.Real64, 15, (20, 12))),

                invalid,
                invalid,
                invalid,
                invalid,
            };

            var stores = new Decoder[]
            {
                Instr(Mnemonic.sb, r2,r1,Ss),
                Instr(Mnemonic.sh, r2,r1,Ss),
                Instr(Mnemonic.sw, r2,r1,Ss),
                Instr(Mnemonic.sd, r2,r1,Ss),

                invalid,
                invalid,
                invalid,
                invalid,
            };

            var fpstores = new Decoder[8]
            {
                invalid,
                invalid,
                CInstr(Mnemonic.fsw, F2,Memc(PrimitiveType.Real32, 15, (25,7),(7,5))),
                CInstr(Mnemonic.fsd, F2,Memc(PrimitiveType.Real64, 15, (25,7),(7,5))),

                invalid,
                invalid,
                invalid,
                invalid,
            };

            var op = new Decoder[]
            {
                new ShiftDecoder(
                    Instr(Mnemonic.add, d,r1,r2),
                    Instr(Mnemonic.sub, d,r1,r2)),
                CInstr(Mnemonic.sll, Rd,R1,R2),
                CInstr(Mnemonic.slt, Rd,R1,R2),
                CInstr(Mnemonic.sltu, Rd,R1,R2),

                CInstr(Mnemonic.xor, Rd,R1,R2),
                new ShiftDecoder(
                    Instr(Mnemonic.srl, d,r1,r2),
                    Instr(Mnemonic.sra, d,r1,r2)),
                CInstr(Mnemonic.or, Rd,R1,R2),
                CInstr(Mnemonic.and, Rd,R1,R2),
            };

            var opimm = new Decoder[]
            {
                Instr(Mnemonic.addi, d,r1,i),
                new ShiftDecoder(
                    Instr(Mnemonic.slli, d,r1,z),
                    Instr(Mnemonic.invalid, InstrClass.Invalid)),
                Instr(Mnemonic.slti, d,r1,i),
                Instr(Mnemonic.sltiu, d,r1,i),

                Instr(Mnemonic.xori, d,r1,i),
                new ShiftDecoder(
                    Instr(Mnemonic.srli, d,r1,z),
                    Instr(Mnemonic.srai, d,r1,z)),
                Instr(Mnemonic.ori, d,r1,i),
                Instr(Mnemonic.andi, d,r1,i),
            };

            var opimm32 = new Decoder[]
            {
                CInstr(Mnemonic.addiw, Rd,R1,I20s),
                CInstr(Mnemonic.slliw, Rd,R1,Imm(20, 5)),
                Nyi(""),
                Nyi(""),
 
                Nyi(""),
                new ShiftDecoder(
                    Instr(Mnemonic.srliw, d,r1,Z),
                    Instr(Mnemonic.sraiw, d,r1,Z)),
                Nyi(""),
                Nyi(""),
            };

            var op32 = new Decoder[]
            {
                new ShiftDecoder(
                    Instr(Mnemonic.addw, d,r1,r2),
                    Instr(Mnemonic.subw, d,r1,r2)),
                new ShiftDecoder(
                    Instr(Mnemonic.sllw, d,r1,r2),
                    Instr(Mnemonic.invalid, InstrClass.Invalid)),
                Nyi(""),
                Nyi(""),

                Nyi(""),
                new ShiftDecoder(
                    Instr(Mnemonic.srlw, d,r1,r2),
                    Instr(Mnemonic.sraw, d,r1,r2)),
                Nyi(""),
                Nyi(""),
            };

            var opfp = new(uint, Decoder)[]
            {
                ( 0x00, new FpuDecoder(Mnemonic.fadd_s, Fd,F1,F2) ),
                ( 0x01, new FpuDecoder(Mnemonic.fadd_d, Fd,F1,F2) ),
                ( 0x21, new FpuDecoder(Mnemonic.fcvt_d_s, Fd,F1) ),
                ( 0x50, Sparse(12, 3, invalid,
                        ( 2, Instr(Mnemonic.feq_s, d,F1,F2)))),
                ( 0x71, new FpuDecoder(Mnemonic.fmv_d_x, Fd,r1) ),
                ( 0x78, new FpuDecoder(Mnemonic.fmv_s_x, Fd,r1) )
            };

            var branches = new Decoder[]
            {
                Instr(Mnemonic.beq, InstrClass.ConditionalTransfer, r1,r2,B),
                Instr(Mnemonic.bne, InstrClass.ConditionalTransfer, r1,r2,B),
                Nyi(""),
                Nyi(""),

                Instr(Mnemonic.blt, InstrClass.ConditionalTransfer,  r1,r2,B),
                Instr(Mnemonic.bge, InstrClass.ConditionalTransfer,  r1,r2,B),
                Instr(Mnemonic.bltu, InstrClass.ConditionalTransfer, r1,r2,B),
                Instr(Mnemonic.bgeu, InstrClass.ConditionalTransfer, r1,r2,B),
            };

            var system = Sparse(20, 12, "system",
                Nyi("system"),
                (0, Instr(Mnemonic.ecall)),
                (1, Instr(Mnemonic.ebreak)));


            w32decoders = Mask(2, 5, "w32decoders", 
                // 00
                Mask(12, 3, "loads", loads),
                Mask(12, 3, "fploads", fploads),
                Nyi("custom-0"),
                Nyi("misc-mem"),

                Mask(12, 3, "opimm", opimm),
                Instr(Mnemonic.auipc, d,Iu),
                Mask(12, 3, "opimm32", opimm32),
                Nyi("48-bit instruction"),

                Mask(12, 3, "stores", stores),
                Mask(12, 3, "fpstores", fpstores),
                Nyi("custom-1"),
                Nyi("amo"),

                Mask(30, 1, "op",
                    Mask(12, 3, "alu",
                         CInstr(Mnemonic.add, Rd,R1,R2),
                         CInstr(Mnemonic.sll, Rd,R1,R2),
                         CInstr(Mnemonic.slt, Rd,R1,R2),
                         CInstr(Mnemonic.sltu, Rd,R1,R2),

                         CInstr(Mnemonic.xor, Rd,R1,R2),
                         CInstr(Mnemonic.srl, Rd,R1,R2),
                         CInstr(Mnemonic.or,  Rd,R1,R2),
                         CInstr(Mnemonic.and, Rd,R1,R2)),
                    new MaskDecoder(12, 3, "alu2",
                         CInstr(Mnemonic.sub, Rd,R1,R2),
                         Nyi("op - 20 - 0b001"),
                         Nyi("op - 20 - 0b010"),
                         Nyi("op - 20 - 0b011"),

                         Nyi("op - 20 - 0b100"),
                         CInstr(Mnemonic.sra, Rd,R1,R2),
                         Nyi("op - 20 - 0b110"),
                         Nyi("op - 20 - 0b111"))),
                Instr(Mnemonic.lui, d,Iu),
                Sparse(25, 7, "op32",
                    invalid, 
                    ( 1, new MaskDecoder(12, 3, "muldiv",
                        CInstr(Mnemonic.mulw, Rd,R1,R2),
                        invalid,
                        invalid,
                        invalid,
                        
                        CInstr(Mnemonic.divw, Rd,R1,R2),
                        CInstr(Mnemonic.divuw, Rd,R1,R2),
                        CInstr(Mnemonic.remw, Rd,R1,R2),
                        CInstr(Mnemonic.remuw, Rd,R1,R2))
                    ),
                    ( 0x20, new MaskDecoder(12, 3, "suww",
                        CInstr(Mnemonic.subw, Rd,R1,R2),
                        Nyi("20 - 001"),
                        Nyi("20 - 010"),
                        Nyi("20 - 011"),

                        Nyi("20 - 100"),
                        Nyi("20 - 101"),
                        Nyi("20 - 110"),
                        Nyi("20 - 111")))),
                Nyi("64-bit instruction"),

                // 10
                CInstr(Mnemonic.fmadd_s,  Fd,F1,F2,F3),
                CInstr(Mnemonic.fmsub_s , Fd,F1,F2,F3),
                CInstr(Mnemonic.fnmsub_s, Fd,F1,F2,F3),
                CInstr(Mnemonic.fnmadd_s, Fd,F1,F2,F3),

                Sparse(25, 7, invalid, opfp),
                Nyi("Reserved"),
                Nyi("custom-2"),
                Nyi("48-bit instruction"),

                new MaskDecoder(12, 3, "branches", branches),
                Instr(Mnemonic.jalr, InstrClass.Transfer, d,r1,i),
                Nyi("Reserved"),
                CInstr(InstrClass.Transfer|InstrClass.Call, Mnemonic.jal, Rd,J),

                system,
                Nyi("Reserved"),
                Nyi("custom-3"),
                Nyi(">= 80-bit instruction"));

            compressedRegs = new int[8]
            {
                8, 9, 10, 11, 12, 13, 14, 15
            };

            compressed0 = new Decoder[8]
            {
                Select((0, 16), u => u != 0, "zero",
                    CInstr(Mnemonic.c_addi4spn, Rc(2), Imm((7,4), (11,2), (5, 1),(6, 1), (0,2))),
                    CInstr(InstrClass.Invalid|InstrClass.Zero, Mnemonic.invalid)),
                WordSize(
                    rv32: CInstr(Mnemonic.c_fld, Fc(7), Memc(PrimitiveType.Real64, 2, (5,2), (10, 3))),
                    rv64: CInstr(Mnemonic.c_fld, Fc(7), Memc(PrimitiveType.Real64, 2, (5,2), (10, 3))),
                    rv128: Nyi("lq")),
                CInstr(Mnemonic.c_lw, Rc(7), Memc(PrimitiveType.Word32, 2, (5,1), (10,3), (6,1))),
                WordSize(
                    rv32: CInstr(Mnemonic.c_flw, Fc(7), Memc(PrimitiveType.Real32, 2, (5,1), (10,3), (6,1))),
                    rv64: CInstr(Mnemonic.c_ld, Rc(7), Memc(PrimitiveType.Word64, 2, (5,2), (10, 3))),
                    rv128: CInstr(Mnemonic.c_ld, Rc(7), Memc(PrimitiveType.Word64, 2, (5,2), (10, 3)))),

                Nyi("reserved"),
                WordSize(
                    rv32: CInstr(Mnemonic.c_fsd, Fc(7), Memc(PrimitiveType.Real64, 2, (5,2), (10, 3))),
                    rv64: CInstr(Mnemonic.c_fsd, Fc(7), Memc(PrimitiveType.Real64, 2, (5,2), (10, 3))),
                    rv128: Nyi("sq")),
                CInstr(Mnemonic.c_sw, Rc(7), Memc(PrimitiveType.Word32, 2, (5,1), (10,3), (6,1))),
                WordSize(
                    rv32: Nyi("fsw"),
                    rv64: CInstr(Mnemonic.c_sd, Rc(7), Memc(PrimitiveType.Real64, 2, (5,2), (10, 3))),
                    rv128: CInstr(Mnemonic.c_sd, Rc(7), Memc(PrimitiveType.Real64, 2, (5,2), (10, 3)))),
            };

            compressed1 = new Decoder[8]
            {
                CInstr(Mnemonic.c_addi, R(7), ImmS((12, 1), (2, 5))),
                WordSize(
                    rv32: Nyi("c.jal"),
                    rv64: CInstr(Mnemonic.c_addiw, R(7), ImmS((12, 1), (2, 5))),
                    rv128: CInstr(Mnemonic.c_addiw, R(7), ImmS((12, 1), (2, 5)))),
                CInstr(Mnemonic.c_li, R(7), ImmS((12,1), (2, 5))),
                Select((7, 5), u => u == 2,
                    CInstr(Mnemonic.c_addi16sp, ImmShS(4, (12,1), (3,2), (5,1), (2,1), (6, 1))),
                    CInstr(Mnemonic.c_lui, R(7), ImmShS(12, (12,1), (2, 5)))),

                new MaskDecoder(10, 2, "comp1",
                    CInstr(Mnemonic.c_srli, Rc(7), Imm((12,1), (2,5))),
                    CInstr(Mnemonic.c_srai, Rc(7), Imm((12,1), (2,5))),
                    CInstr(Mnemonic.c_andi, Rc(7), ImmS((12,1), (2,5))),
                    new MaskDecoder(12, 1, "comp1_1",
                        new MaskDecoder(5, 2, "comp1_1_1",
                            CInstr(Mnemonic.c_sub, Rc(7), Rc(2)),
                            CInstr(Mnemonic.c_xor, Rc(7), Rc(2)),
                            CInstr(Mnemonic.c_or, Rc(7), Rc(2)),
                            CInstr(Mnemonic.c_and, Rc(7), Rc(2))),
                        new MaskDecoder(5, 2, "comp1_1_2",
                            WordSize(
                                rv64: CInstr(Mnemonic.c_subw, Rc(7),Rc(2)),
                                rv128: CInstr(Mnemonic.c_subw, Rc(7),Rc(2))),
                            WordSize(
                                rv64: CInstr(Mnemonic.c_addw, Rc(7),Rc(2)),
                                rv128: CInstr(Mnemonic.c_addw, Rc(7),Rc(2))),
                            invalid,
                            invalid))),

// imm[11|4|9:8|10|6|7|3:1|5]
     //11 10  9  8 7 6   3 2
                CInstr(InstrClass.Transfer, Mnemonic.c_j, PcRel(1, (11,1), (8,1), (9,2), (6,1), (7,1), (2,1), (10,1), (3,2))),
                CInstr(InstrClass.ConditionalTransfer, Mnemonic.c_beqz, Rc(7), PcRel(1, (12,1), (5,2), (2,1), (10,2), (3, 2))),
                CInstr(InstrClass.ConditionalTransfer, Mnemonic.c_bnez, Rc(7), PcRel(1, (12,1), (5,2), (2,1), (10,2), (3, 2))),
            };

            compressed2 = new Decoder[8]
            {
                CInstr(Mnemonic.c_slli, R(7), ImmB((12, 1), (2, 5))),
                WordSize(
                    rv32: CInstr(Mnemonic.c_fldsp, F(2), ImmSh(3, (12,1),(7,3),(10,3))),
                    rv64: CInstr(Mnemonic.c_fldsp, F(2), ImmSh(3, (12,1),(7,3),(10,3)))),
                CInstr(Mnemonic.c_lwsp, R(2), ImmSh(2, (12,1),(7,3),(10,3))),
                CInstr(Mnemonic.c_ldsp, R(2), ImmSh(3, (12,1),(7,3),(10,3))),

                new MaskDecoder(12, 1,  "",
                    Select((2, 5), u => u == 0, "",
                        CInstr(InstrClass.Transfer, Mnemonic.c_jr, R(7)),
                        CInstr(Mnemonic.c_mv, R(7), R(2))),
                    Select((2, 5), u => u == 0,
                        Select((7, 5), u => u == 0,
                            Nyi("c.ebreak"),
                            CInstr(InstrClass.Transfer, Mnemonic.c_jalr, R(7))),
                        CInstr(Mnemonic.c_add, R(7), R(2)))),
                WordSize(
                    rv32: CInstr(Mnemonic.c_fsdsp, F(2), ImmSh(3, (7,3), (10,3))),
                    rv64: CInstr(Mnemonic.c_fsdsp, F(2), ImmSh(3, (7,3), (10,3))),
                    rv128:Nyi("sqsp")),
                CInstr(Mnemonic.c_swsp, R(2), ImmSh(2, (7,3),(10,3))),
                CInstr(Mnemonic.c_sdsp, R(2), ImmSh(3, (7,3),(10,3))),
            };

            decoders = new Decoder[4]
            {
                new MaskDecoder(13, 3, "compressed0", compressed0),
                new MaskDecoder(13, 3, "compressed1", compressed1),
                new MaskDecoder(13, 3, "compressed2", compressed2),
                new W32Decoder(w32decoders)
            };
        }
    }
}
