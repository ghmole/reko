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

using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Reko.Arch.Mips
{
    public enum Mnemonic
    {
        illegal,

        add,
        addi,
        addiu,
        addu,
        add_d,
        add_s,
        and,
        andi,
        bc1f,
        bc1t,
        beq,
        beql,
        bgez,
        bgezal,
        bgezall,
        bgezl,
        bgtz,
        bgtzl,
        blez,
        blezl,
        bltz,
        bltzal,
        bltzall,
        bltzl,
        bne,
        bnel,
        @break,
        c_eq_d,
        c_eq_s,
        c_le_d,
        c_le_s,
        c_lt_d,
        c_lt_s,
        cfc1,
        ctc1,
        cvt_d_l,
        cvt_s_d,
        cvt_s_l,
        cvt_w_d,
        dadd,
        daddi,
        daddiu,
        daddu,
        ddiv,
        ddivu,
        div,
        divu,
        div_d,
        div_s,
        dmfc0,
        dmfc1,
        dmtc0,
        dmtc1,
        dmult,
        dmultu,
        dsll,
        dsll32,
        dsllv,
        dsra,
        dsra32,
        dsrav,
        dsrl,
        dsrl32,
        dsrlv,
        dsub,
        dsubu,
        eret,
        j,
        jal,
        jalr,
        jr,
        lb,
        lbu,
        ld,
        ldc1,
        ldl,
        ldr,
        lh,
        lhu,
        ll,
        lld,
        lui,
        lw,
        lwc1,
        lwl,
        lwr,
        lwu,
        mfc0,
        mfc1,
        mfhi,
        mflo,
        mtc0,
        mtc1,
        mthi,
        mtlo,
        movf,
        movn,
        movt,
        movz,
        mov_d,
        mov_s,
        mul,
        mult,
        multu,
        mul_d,
        mul_s,
        neg_d,
        neg_s,
        nop,
        nor,
        or,
        ori,
        pref,
        prefx,
        rdhwr,
        sb,
        sc,
        scd,
        sd,
        sdc1,
        sdl,
        sdr,
        seb,
        seh,
        sh,
        sll,
        sllv,
        slt,
        slti,
        sltiu,
        sltu,
        sra,
        srav,
        srl,
        srlv,
        sub,
        subu,
        sub_d,
        sub_s,
        sw,
        swc1,
        swl,
        swr,
        sync,
        syscall,

        trunc_l_d,
        teq,
        tlt,
        tltu,
        teqi,
        tge,
        tgei,
        tgeiu,
        tgeu,
        tlbp,
        tlbr,
        tlbwi,
        tlbwr,
        tltiu,
        tlti,
        tne,
        tnei,
        wait,
        wsbh,

        xor,
        xori,

        // Micro MIPS mnemonics.
        andi32,
        and16,
        aui,
        bc16,
        bnezc16,
        break16,
        jalrc16,
        jrc16,
        jrcaddiusp,
        lbu16,
        lbu32,
        ldc132,
        lwm16,
        movep,
        not16,
        or16,
        sb32,
        sdbbp16,
        sh16,
        sw16,
        swm16,
        xor16,
        xori32,
        ori32,
        bc,
        sd32,
        ld32,
        sw32,
        sdc132,
        addiur1sp,

        // Nano mnemonics
        addiupc,
        aluipc,
        balc,
        bnec,
        bnezc,
        bbeqzc,
        bbnezc,
        beqc,
        beqic,
        beqzc,
        bgec,
        bgeic,
        bgeiuc,
        bgeuc,
        bltc,
        bltic,
        bltiuc,
        bltuc,
        bneiuc,
        clo,
        clz,
        ext,
        ins,
        jalrc,
        jrc,
        lbux,
        lhe,
        li,
        lsa,
        lwe,
        lwm,
        lwx,
        lwxs,
        modu,
        move,
        move_balc,
        not,
        restore,
        restore_jrc,
        save,
        shxs,
        sigrie,
        swxs,
        swm,
        swx,
        ualwm,
        uaswm,
        lwpc,
        cache,
        madd_s,
        madd_d,
        msub_s,
        msub_d,
        madd_ps,
        msub_ps,
        madd,
        maddu,
        msub,
        msubu,
        nmadd_s,
        nmadd_d,
        nmadd_ps,
        nmsub_s,
        nmsub_d,
        nmsub_ps,
        lwc2,
        sdc2,
        ldc2,
        swc2,
        alnv_ps,
        sdbbp,
        swxc1,
        sdxc1,
        ldxc1,
        lwxc1,
        luxc1,
        suxc1,
    }
}
