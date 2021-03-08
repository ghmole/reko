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
using Reko.Core.Types;
using System;
using System.Collections.Generic;

namespace Reko.Arch.RiscV
{
    using Decoder = Reko.Core.Machine.Decoder<RiscVDisassembler, Mnemonic, RiscVInstruction>;
    using MaskDecoder = Reko.Core.Machine.MaskDecoder<RiscVDisassembler, Mnemonic, RiscVInstruction>;

    public partial class RiscVDisassembler
    {
        public class InstructionSet
        {
            private static readonly Decoder invalid = Instr(Mnemonic.invalid, InstrClass.Invalid);

            private Func<Mnemonic, Mutator<RiscVDisassembler>[], Decoder> floatSupport;
            private Dictionary<string, object> options;

            public static InstructionSet Create(Dictionary<string, object> options)
            {
                var isa = new InstructionSet(options);
                return isa;
            }

            private InstructionSet(Dictionary<string, object> options)
            {
                this.options = options;
                if (options.ContainsKey("FloatAbi"))
                    floatSupport = Instr;
                else
                    floatSupport = MakeInvalid;
            }

            private static Decoder MakeInvalid(Mnemonic mnemonic, params Mutator<RiscVDisassembler>[] mutators)
            {
                return invalid;
            }

            private static Decoder Instr(Mnemonic mnemonic, params Mutator<RiscVDisassembler>[] mutators)
            {
                return new InstrDecoder<RiscVDisassembler, Mnemonic, RiscVInstruction>(InstrClass.Linear, mnemonic, mutators);
            }

            private Decoder FpInstr(Mnemonic mnemonic, params Mutator<RiscVDisassembler>[] mutators)
            {
                return floatSupport(mnemonic, mutators);
            }

            private static Decoder Instr(Mnemonic mnemonic, InstrClass iclass, params Mutator<RiscVDisassembler>[] mutators)
            {
                return new InstrDecoder<RiscVDisassembler, Mnemonic, RiscVInstruction>(iclass, mnemonic, mutators);
            }

            // Conditional decoder

            private static WordSizeDecoder WordSize(
                Decoder? rv32 = null,
                Decoder? rv64 = null,
                Decoder? rv128 = null)
            {
                return new WordSizeDecoder(rv32 ?? invalid, rv64 ?? invalid, rv128 ?? invalid);
            }

            private static NyiDecoder Nyi(string message)
            {
                return new NyiDecoder(message);
            }

            public Decoder[] CreateRootDecoders()
            {

                var loads = new Decoder[]           // 0b00000
                {
                    Instr(Mnemonic.lb, d,r1,Ls),
                    Instr(Mnemonic.lh, d,r1,Ls),
                    Instr(Mnemonic.lw, d,r1,Ls),
                    Instr(Mnemonic.ld, d,r1,Ls),    // 64I

                    Instr(Mnemonic.lbu, d,r1,Ls),
                    Instr(Mnemonic.lhu, d,r1,Ls),
                    Instr(Mnemonic.lwu, d,r1,Ls),    // 64I
                    Nyi(""),
                };

                var fploads = new Decoder[8]        // 0b00001
                {
                    invalid,
                    invalid,
                    FpInstr(Mnemonic.flw, Fd,Mem(PrimitiveType.Real32, 15, (20, 12))),
                    FpInstr(Mnemonic.fld, Fd,Mem(PrimitiveType.Real64, 15, (20, 12))),

                    FpInstr(Mnemonic.flq, Fd,Mem(PrimitiveType.Real64, 15, (20, 12))),
                    invalid,
                    invalid,
                    invalid,
                };

                var stores = new Decoder[]          // 0b01000
                {
                    Instr(Mnemonic.sb, r2,r1,Ss),
                    Instr(Mnemonic.sh, r2,r1,Ss),
                    Instr(Mnemonic.sw, r2,r1,Ss),
                    Instr(Mnemonic.sd, r2,r1,Ss),   // I64

                    invalid,
                    invalid,
                    invalid,
                    invalid,
                };

                var fpstores = new Decoder[8]       // 0b01001
                {
                    invalid,
                    invalid,
                    FpInstr(Mnemonic.fsw, F2,Memc(PrimitiveType.Real32, 15, (25,7),(7,5))),
                    FpInstr(Mnemonic.fsd, F2,Memc(PrimitiveType.Real64, 15, (25,7),(7,5))),

                    invalid,
                    invalid,
                    invalid,
                    invalid,
                };

                var opimm = new Decoder[]           // 0b00100
                {
                    Instr(Mnemonic.addi, d,r1,i),
                    new ShiftDecoder(
                        Instr(Mnemonic.slli, d,r1,Z),
                        invalid),
                    Instr(Mnemonic.slti, d,r1,i),
                    Instr(Mnemonic.sltiu, d,r1,i),

                    Instr(Mnemonic.xori, d,r1,i),
                    new ShiftDecoder(
                        Instr(Mnemonic.srli, d,r1,Z),
                        Instr(Mnemonic.srai, d,r1,Z)),
                    Instr(Mnemonic.ori, d,r1,i),
                    Instr(Mnemonic.andi, d,r1,i),
                };

                var opimm32 = new Decoder[]         // 0b00110
                {
                    Instr(Mnemonic.addiw, Rd,R1,I20s),
                    Instr(Mnemonic.slliw, Rd,R1,Imm(20, 5)),
                    Nyi(""),
                    Nyi(""),

                    Nyi(""),
                    new ShiftDecoder(
                        Instr(Mnemonic.srliw, d,r1,Z),
                        Instr(Mnemonic.sraiw, d,r1,Z)),
                    Nyi(""),
                    Nyi(""),
                };

                var op = Mask(30, 1, "op",      // 0b01100
                    Mask(12, 3, "alu",
                        Instr(Mnemonic.add, Rd, R1, R2),
                        Instr(Mnemonic.sll, Rd, R1, R2),
                        Instr(Mnemonic.slt, Rd, R1, R2),
                        Instr(Mnemonic.sltu, Rd, R1, R2),

                        Instr(Mnemonic.xor, Rd, R1, R2),
                        Instr(Mnemonic.srl, Rd, R1, R2),
                        Instr(Mnemonic.or, Rd, R1, R2),
                        Instr(Mnemonic.and, Rd, R1, R2)),
                    Mask(12, 3, "alu2",
                        Instr(Mnemonic.sub, Rd, R1, R2),
                        Nyi("op - 20 - 0b001"),
                        Nyi("op - 20 - 0b010"),
                        Nyi("op - 20 - 0b011"),

                        Nyi("op - 20 - 0b100"),
                        Instr(Mnemonic.sra, Rd, R1, R2),
                        Nyi("op - 20 - 0b110"),
                        Nyi("op - 20 - 0b111")));

                var op32 = new Decoder[]            // 0b01110
                {
                    Sparse(25, 7, "  000", Nyi(""),
                        (0x00, Instr(Mnemonic.addw, d,r1,r2)),
                        (0x01, Instr(Mnemonic.mulw, d,r1,r2)),
                        (0x20, Instr(Mnemonic.subw, d,r1,r2))),
                    Sparse(25, 7, "  000", Nyi(""),
                        (0x00, Instr(Mnemonic.sllw, d,r1,r2))),
                    Nyi(""),
                    Nyi(""),

                    Sparse(25, 7, "  100", Nyi(""),
                        (0x01, Instr(Mnemonic.divw, d,r1,r2))),
                    Sparse(25, 7, "  101", Nyi(""),
                        (0x00, Instr(Mnemonic.srlw, d,r1,r2)),
                        (0x01, Instr(Mnemonic.divuw, d,r1,r2)),
                        (0x20, Instr(Mnemonic.sraw, d,r1,r2))),
                    Sparse(25, 7, "  110", Nyi(""),
                        (0x01, Instr(Mnemonic.remw, d,r1,r2))),
                    Sparse(25, 7, "  111", Nyi(""),
                        (0x01, Instr(Mnemonic.remuw, d,r1,r2))),
                };

                var opfp = new (uint, Decoder)[]     // 0b10100
                {
                    ( 0x00, FpInstr(Mnemonic.fadd_s, Fd,F1,F2) ),
                    ( 0x01, FpInstr(Mnemonic.fadd_d, Fd,F1,F2) ),
                    ( 0x03, FpInstr(Mnemonic.fadd_q, Fd,F1,F2) ),

                    ( 0x04, FpInstr(Mnemonic.fsub_s, Fd,F1,F2) ),
                    ( 0x05, FpInstr(Mnemonic.fsub_d, Fd,F1,F2) ),
                    ( 0x07, FpInstr(Mnemonic.fsub_q, Fd,F1,F2) ),

                    ( 0x08, FpInstr(Mnemonic.fmul_s, Fd,F1,F2) ),
                    ( 0x09, FpInstr(Mnemonic.fmul_d, Fd,F1,F2) ),
                    ( 0x0B, FpInstr(Mnemonic.fmul_q, Fd,F1,F2) ),

                    ( 0x0C, FpInstr(Mnemonic.fdiv_s, Fd,F1,F2) ),
                    ( 0x0D, FpInstr(Mnemonic.fdiv_d, Fd,F1,F2) ),
                    ( 0x0F, FpInstr(Mnemonic.fdiv_q, Fd,F1,F2) ),

                    ( 0x10, Sparse(12, 3, "fsgn.s", invalid,
                        (0x0, Select(R1EqR2,
                            FpInstr(Mnemonic.fmv_s, Fd,F1, F2),
                            FpInstr(Mnemonic.fsgnj_s, Fd,F1, F2))),
                        (0x1, Select(R1EqR2,
                            FpInstr(Mnemonic.fneg_s, Fd,F1, F2),
                            FpInstr(Mnemonic.fsgnjn_s, Fd,F1, F2))),
                        (0x2, Select(R1EqR2,
                            FpInstr(Mnemonic.fabs_s, Fd,F1, F2),
                            FpInstr(Mnemonic.fsgnjx_s, Fd,F1, F2))))),
                    ( 0x11, Sparse(12, 3, "fsgn.d", invalid,
                        (0x0, Select(R1EqR2,
                            FpInstr(Mnemonic.fmv_d, Fd,F1, F2),
                            FpInstr(Mnemonic.fsgnj_d, Fd,F1, F2))),
                        (0x1, Select(R1EqR2,
                            FpInstr(Mnemonic.fneg_d, Fd,F1, F2),
                            FpInstr(Mnemonic.fsgnjn_d, Fd,F1, F2))),
                        (0x2, Select(R1EqR2,
                            FpInstr(Mnemonic.fabs_d, Fd,F1, F2),
                            FpInstr(Mnemonic.fsgnjx_d, Fd,F1, F2))))),
                    ( 0x13, Sparse(12, 3, "fsgn.q", invalid,
                        (0x0, Select(R1EqR2,
                            FpInstr(Mnemonic.fmv_q, Fd,F1, F2),
                            FpInstr(Mnemonic.fsgnj_q, Fd,F1, F2))),
                        (0x1, Select(R1EqR2,
                            FpInstr(Mnemonic.fneg_q, Fd,F1, F2),
                            FpInstr(Mnemonic.fsgnjn_q, Fd,F1, F2))),
                        (0x2, Select(R1EqR2,
                            FpInstr(Mnemonic.fabs_q, Fd,F1, F2),
                            FpInstr(Mnemonic.fsgnjx_q, Fd,F1, F2))))),

                    ( 0x14, Sparse(12, 3, "fmin/fmax.s", invalid,
                        (0x0, FpInstr(Mnemonic.fmin_s, Fd,F1, F2)),
                        (0x1, FpInstr(Mnemonic.fmax_s, Fd,F1, F2)))),
                    ( 0x15, Sparse(12, 3, "fmin/fmax.d", invalid,
                        (0x0, FpInstr(Mnemonic.fmin_d, Fd,F1, F2)),
                        (0x1, FpInstr(Mnemonic.fmax_d, Fd,F1, F2)))),
                    ( 0x17, Sparse(12, 3, "fmin/fmax.q", invalid,
                        (0x0, FpInstr(Mnemonic.fmin_q, Fd,F1, F2)),
                        (0x1, FpInstr(Mnemonic.fmax_q, Fd,F1, F2)))),

                    ( 0x20, Sparse(20, 5, "fcvt.s", invalid,
                        (0x1, FpInstr(Mnemonic.fcvt_s_d, Fd,F1) ),
                        (0x3, FpInstr(Mnemonic.fcvt_s_q, Fd,F1) ))),
                    ( 0x21, Sparse(20, 5, "fcvt.d", invalid,
                        (0x0, FpInstr(Mnemonic.fcvt_d_s, Fd,F1) ),
                        (0x3, FpInstr(Mnemonic.fcvt_d_q, Fd,F1) ))),
                    ( 0x23, Sparse(20, 5, "fcvt", invalid,
                        (0x0, FpInstr(Mnemonic.fcvt_q_s, Fd,F1) ),
                        (0x1, FpInstr(Mnemonic.fcvt_q_d, Fd,F1) ))),

                    ( 0x2C, Select((20, 5), Ne0, invalid, FpInstr(Mnemonic.fsqrt_s, Fd,F1)) ),
                    ( 0x2D, Select((20, 5), Ne0, invalid, FpInstr(Mnemonic.fsqrt_d, Fd,F1)) ),
                    ( 0x2F, Select((20, 5), Ne0, invalid, FpInstr(Mnemonic.fsqrt_q, Fd,F1)) ),

                    ( 0x50, Sparse(12, 3, "fcmp.s", invalid,
                        ( 0, FpInstr(Mnemonic.fle_s, d,F1,F2)),
                        ( 1, FpInstr(Mnemonic.flt_s, d,F1,F2)),
                        ( 2, FpInstr(Mnemonic.feq_s, d,F1,F2)))),
                    ( 0x51, Sparse(12, 3, "fcmp.d", invalid,
                        ( 0, FpInstr(Mnemonic.fle_d, d,F1,F2)),
                        ( 1, FpInstr(Mnemonic.flt_d, d,F1,F2)),
                        ( 2, FpInstr(Mnemonic.feq_d, d,F1,F2)))),
                    ( 0x53, Sparse(12, 3, "fcmp.q", invalid,
                        ( 0, FpInstr(Mnemonic.fle_q, d,F1,F2)),
                        ( 1, FpInstr(Mnemonic.flt_q, d,F1,F2)),
                        ( 2, FpInstr(Mnemonic.feq_s, d,F1,F2)))),

                    ( 0x60, Sparse(20, 5, "fcvt.w.s", invalid,
                        ( 0, FpInstr(Mnemonic.fcvt_w_s, Rd,F1)),
                        ( 1, FpInstr(Mnemonic.fcvt_wu_s, Rd,F1)),
                        ( 2, FpInstr(Mnemonic.fcvt_l_s, Rd,F1)),
                        ( 3, FpInstr(Mnemonic.fcvt_lu_s, Rd,F1)))),
                    ( 0x61, Sparse(20, 5, "fcvt.w.d", invalid,
                        ( 0, FpInstr(Mnemonic.fcvt_w_d, Rd,F1)),
                        ( 1, FpInstr(Mnemonic.fcvt_wu_d, Rd,F1)),
                        ( 2, FpInstr(Mnemonic.fcvt_l_d, Rd,F1)),
                        ( 3, FpInstr(Mnemonic.fcvt_lu_d, Rd,F1)))),
                    ( 0x63, Sparse(20, 5, "fcvt_w_q", invalid,
                        ( 0, FpInstr(Mnemonic.fcvt_w_q, Rd,F1)),
                        ( 1, FpInstr(Mnemonic.fcvt_wu_q, Rd,F1)),
                        ( 2, FpInstr(Mnemonic.fcvt_l_q, Rd,F1)),
                        ( 3, FpInstr(Mnemonic.fcvt_lu_q, Rd,F1)))),

                    ( 0x68, Sparse(20, 5, "fcvt.to.s", invalid,
                        ( 0, FpInstr(Mnemonic.fcvt_s_w, Fd,R1)),
                        ( 1, FpInstr(Mnemonic.fcvt_s_wu, Fd,R1)),
                        ( 2, FpInstr(Mnemonic.fcvt_s_l, Fd,R1)),
                        ( 3, FpInstr(Mnemonic.fcvt_s_lu, Fd,R1)))),
                    ( 0x69, Sparse(20, 5, "fcvt.to.d", invalid,
                        ( 0, FpInstr(Mnemonic.fcvt_d_w, Fd,R1)),
                        ( 1, FpInstr(Mnemonic.fcvt_d_wu, Fd,R1)),
                        ( 2, FpInstr(Mnemonic.fcvt_d_l, Fd,R1)),
                        ( 3, FpInstr(Mnemonic.fcvt_d_lu, Fd,R1)))),
                    ( 0x6B, Sparse(20, 5, "fcvt.to.q", invalid,
                        ( 0, FpInstr(Mnemonic.fcvt_q_w, Fd,R1)),
                        ( 1, FpInstr(Mnemonic.fcvt_q_wu, Fd,R1)),
                        ( 2, FpInstr(Mnemonic.fcvt_q_l, Fd,R1)),
                        ( 3, FpInstr(Mnemonic.fcvt_q_lu, Fd,R1)))),

                    ( 0x70, FpInstr(Mnemonic.fmv_x_w, Rd,F1) ),
                    ( 0x71, FpInstr(Mnemonic.fmv_d_x, Fd,r1) ),
                    ( 0x73, Sparse(20, 5, "fclass.q", invalid,
                        ( 0, FpInstr(Mnemonic.fclass_q, Rd,F1)))),

                    ( 0x78, FpInstr(Mnemonic.fmv_w_x, Fd,r1) ),
                    ( 0x79, FpInstr(Mnemonic.fmv_d_x, Fd,r1) )
                };

                var branches = new Decoder[]            // 0b11000
                {
                    Instr(Mnemonic.beq, InstrClass.ConditionalTransfer, r1,r2,B),
                    Instr(Mnemonic.bne, InstrClass.ConditionalTransfer, r1,r2,B),
                    Nyi(""),
                    Nyi(""),

                    Instr(Mnemonic.blt,  InstrClass.ConditionalTransfer, r1,r2,B),
                    Instr(Mnemonic.bge,  InstrClass.ConditionalTransfer, r1,r2,B),
                    Instr(Mnemonic.bltu, InstrClass.ConditionalTransfer, r1,r2,B),
                    Instr(Mnemonic.bgeu, InstrClass.ConditionalTransfer, r1,r2,B),
                };

                var system = Mask(12, 3, "  system",
                    Sparse(20, 12, "system",   // 0b11100
                        Nyi("system 000"),
                        (0, Instr(Mnemonic.ecall, InstrClass.Transfer | InstrClass.Call)),
                        (1, Instr(Mnemonic.ebreak, InstrClass.Terminates)),
                        (0b0000000_00010, Instr(Mnemonic.uret, InstrClass.Transfer)),
                        (0b0001000_00010, Instr(Mnemonic.sret, InstrClass.Transfer)),
                        (0b0011000_00010, Instr(Mnemonic.mret, InstrClass.Transfer)),
                        (0b0001000_00101, Instr(Mnemonic.wfi, InstrClass.Linear))),

                    Instr(Mnemonic.csrrw, d, Csr20, r2),
                    Instr(Mnemonic.csrrs, d, Csr20, r2),
                    Instr(Mnemonic.csrrc, d, Csr20, r2),
                    invalid,
                    Instr(Mnemonic.csrrwi, d, Csr20, Imm(15, 5)),
                    Instr(Mnemonic.csrrsi, d, Csr20, Imm(15, 5)),
                    Instr(Mnemonic.csrrci, d, Csr20, Imm(15, 5))); ;


                var w32decoders = Mask(2, 5, "w32decoders",
                    // 00
                    Mask(12, 3, "loads", loads),
                    Mask(12, 3, "fploads", fploads),
                    Nyi("custom-0"),
                    Nyi("misc-mem"),

                    Mask(12, 3, "opimm", opimm),
                    Instr(Mnemonic.auipc, d, Iu),
                    Mask(12, 3, "opimm32", opimm32),
                    Nyi("48-bit instruction"),

                    Mask(12, 3, "stores", stores),
                    Mask(12, 3, "fpstores", fpstores),
                    Nyi("custom-1"),
                    Nyi("amo"),

                    op,
                    Instr(Mnemonic.lui, d, Iu),
                    Sparse(25, 7, "op-32",
                        invalid,
                        (1, new MaskDecoder(12, 3, "muldiv",
                            Instr(Mnemonic.mulw, Rd, R1, R2),
                            invalid,
                            invalid,
                            invalid,

                            Instr(Mnemonic.divw, Rd, R1, R2),
                            Instr(Mnemonic.divuw, Rd, R1, R2),
                            Instr(Mnemonic.remw, Rd, R1, R2),
                            Instr(Mnemonic.remuw, Rd, R1, R2))
                        ),
                        (0x20, new MaskDecoder(12, 3, "suww",
                            Instr(Mnemonic.subw, Rd, R1, R2),
                            Nyi("20 - 001"),
                            Nyi("20 - 010"),
                            Nyi("20 - 011"),

                            Nyi("20 - 100"),
                            Nyi("20 - 101"),
                            Nyi("20 - 110"),
                            Nyi("20 - 111")))),
                    Nyi("64-bit instruction"),

                    // 10
                    FpInstr(Mnemonic.fmadd_s, Fd, F1, F2, F3),
                    FpInstr(Mnemonic.fmsub_s, Fd, F1, F2, F3),
                    FpInstr(Mnemonic.fnmsub_s, Fd, F1, F2, F3),
                    FpInstr(Mnemonic.fnmadd_s, Fd, F1, F2, F3),

                    Sparse(25, 7, invalid, opfp),
                    Nyi("Reserved"),
                    Nyi("custom-2"),
                    Nyi("48-bit instruction"),

                    new MaskDecoder(12, 3, "branches", branches),
                    Instr(Mnemonic.jalr, InstrClass.Transfer, d, r1, i),
                    Nyi("Reserved"),
                    Instr(Mnemonic.jal, InstrClass.Transfer | InstrClass.Call, Rd, J),

                    system,
                    Nyi("Reserved"),
                    Nyi("custom-3"),
                    Nyi(">= 80-bit instruction"));

                

                var compressed0 = new Decoder[8]
                {
                    Select((0, 16), Ne0, "zero",
                        Instr(Mnemonic.c_addi4spn, Rc(2), Imm((7,4), (11,2), (5, 1),(6, 1), (0,2))),
                        Instr(Mnemonic.invalid, InstrClass.Invalid|InstrClass.Zero)),
                    WordSize(
                        rv32: FpInstr(Mnemonic.c_fld, Fc(2), Memc(PrimitiveType.Real64, 7, (5,2), (10, 3))),
                        rv64: FpInstr(Mnemonic.c_fld, Fc(2), Memc(PrimitiveType.Real64, 7, (5,2), (10, 3))),
                        rv128: Nyi("lq")),
                    Instr(Mnemonic.c_lw, Rc(2), Memc(PrimitiveType.Word32, 7, (5,1), (10,3), (6,1))),
                    WordSize(
                        rv32: FpInstr(Mnemonic.c_flw, Fc(2), Memc(PrimitiveType.Real32, 7, (5,1), (10,3), (6,1))),
                        rv64: Instr(Mnemonic.c_ld, Rc(2), Memc(PrimitiveType.Word64, 7, (5,2), (10, 3))),
                        rv128: Instr(Mnemonic.c_ld, Rc(2), Memc(PrimitiveType.Word64, 7, (5,2), (10, 3)))),

                    invalid, // Nyi("reserved"),
                    WordSize(
                        rv32: FpInstr(Mnemonic.c_fsd, Fc(2), Memc(PrimitiveType.Real64, 7, (5,2), (10, 3))),
                        rv64: FpInstr(Mnemonic.c_fsd, Fc(2), Memc(PrimitiveType.Real64, 7, (5,2), (10, 3))),
                        rv128: Nyi("sq")),
                    Instr(Mnemonic.c_sw, Rc(2), Memc(PrimitiveType.Word32, 7, (5,1), (10,3), (6,1))),
                    WordSize(
                        rv32: Instr(Mnemonic.c_fsw, Rc(2), Memc(PrimitiveType.Word32, 7, (5,1), (10,3), (6,1))),
                        rv64: Instr(Mnemonic.c_sd, Rc(2), Memc(PrimitiveType.Real64, 7, (5,2), (10, 3))),
                        rv128: Instr(Mnemonic.c_sd, Rc(2), Memc(PrimitiveType.Real64, 7, (5,2), (10, 3)))),
                };

                var bf_12_1_2_5 = Bf((12, 1), (2, 5));

                var compressed1 = new Decoder[8]
                {
                    Select((7,5), Eq0, "  c.addi",
                        Select(u => u == 0x0001,
                            Instr(Mnemonic.c_nop, InstrClass.Linear|InstrClass.Padding),
                            invalid),
                        Instr(Mnemonic.c_addi, R(7), ImmS(bf_12_1_2_5))),
                    WordSize(
                        rv32: Instr(Mnemonic.c_jal, InstrClass.Transfer|InstrClass.Call, Jc),
                        rv64: Instr(Mnemonic.c_addiw, R_nz(7), ImmS((12, 1), (2, 5))),
                        rv128: Instr(Mnemonic.c_addiw, R(7), ImmS((12, 1), (2, 5)))),
                    Instr(Mnemonic.c_li, R(7), ImmS((12,1), (2, 5))),
                    Select((7, 5), u => u == 2,
                        Instr(Mnemonic.c_addi16sp, ImmShS(4, (12,1), (3,2), (5,1), (2,1), (6, 1))),
                        Instr(Mnemonic.c_lui, R(7), ImmShS(12, (12,1), (2, 5)))),

                    new MaskDecoder(10, 2, "comp1",
                        Instr(Mnemonic.c_srli, Rc(7), Imm((12,1), (2,5))),
                        Instr(Mnemonic.c_srai, Rc(7), Imm((12,1), (2,5))),
                        Instr(Mnemonic.c_andi, Rc(7), ImmS((12,1), (2,5))),
                        new MaskDecoder(12, 1, "comp1_1",
                            new MaskDecoder(5, 2, "comp1_1_1",
                                Instr(Mnemonic.c_sub, Rc(7), Rc(2)),
                                Instr(Mnemonic.c_xor, Rc(7), Rc(2)),
                                Instr(Mnemonic.c_or, Rc(7), Rc(2)),
                                Instr(Mnemonic.c_and, Rc(7), Rc(2))),
                            new MaskDecoder(5, 2, "comp1_1_2",
                                WordSize(
                                    rv64: Instr(Mnemonic.c_subw, Rc(7),Rc(2)),
                                    rv128: Instr(Mnemonic.c_subw, Rc(7),Rc(2))),
                                WordSize(
                                    rv64: Instr(Mnemonic.c_addw, Rc(7),Rc(2)),
                                    rv128: Instr(Mnemonic.c_addw, Rc(7),Rc(2))),
                                invalid,
                                invalid))),

                    Instr(Mnemonic.c_j, InstrClass.Transfer, Jc),
                    Instr(Mnemonic.c_beqz, InstrClass.ConditionalTransfer, Rc(7), PcRel(1, (12,1), (5,2), (2,1), (10,2), (3, 2))),
                    Instr(Mnemonic.c_bnez, InstrClass.ConditionalTransfer, Rc(7), PcRel(1, (12,1), (5,2), (2,1), (10,2), (3, 2))),
                    };

                    var compressed2 = new Decoder[8]
                    {
                    Instr(Mnemonic.c_slli, R_nz(7), ImmB((12, 1), (2, 5))),
                    WordSize(
                        rv32: FpInstr(Mnemonic.c_fldsp, F(2), ImmSh(3, (12,1),(7,3),(10,3))),
                        rv64: FpInstr(Mnemonic.c_fldsp, F(2), ImmSh(3, (12,1),(7,3),(10,3))),
                        rv128: Instr(Mnemonic.c_lqsp, R_nz(7), ImmSh(4, (2, 4),(12, 1),(6,1)))),
                    Instr(Mnemonic.c_lwsp, R_nz(7), ImmSh(2, (12,1),(2,2),(4,3))),
                    Instr(Mnemonic.c_ldsp, R_nz(7), ImmSh(3, (12,1),(2,3),(5,2))),

                    new MaskDecoder(12, 1,  "",
                        Select((2, 5), u => u == 0, "",
                            Instr(Mnemonic.c_jr, InstrClass.Transfer, R(7)),
                            Instr(Mnemonic.c_mv, R(7), R(2))),
                        Select((2, 5), Eq0,
                            Select((7, 5), Eq0,
                                Instr(Mnemonic.c_ebreak, InstrClass.Terminates),
                                Instr(Mnemonic.c_jalr, InstrClass.Transfer, R(7))),
                            Instr(Mnemonic.c_add, R(7), R(2)))),
                    WordSize(
                        rv32: FpInstr(Mnemonic.c_fsdsp, F(2), ImmSh(3, (7,3), (10,3))),
                        rv64: FpInstr(Mnemonic.c_fsdsp, F(2), ImmSh(3, (7,3), (10,3))),
                        rv128:Nyi("sqsp")),
                    Instr(Mnemonic.c_swsp, R(2), ImmSh(2, (7,2),(9,4))),
                    Instr(Mnemonic.c_sdsp, R(2), ImmSh(3, (7,3),(10,3))),
                };

                return new Decoder[4]
                {
                    new MaskDecoder(13, 3, "compressed0", compressed0),
                    new MaskDecoder(13, 3, "compressed1", compressed1),
                    new MaskDecoder(13, 3, "compressed2", compressed2),
                    new W32Decoder(w32decoders)
                };
            }

        }
    }
}
