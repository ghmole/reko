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

namespace Reko.Arch.Xtensa
{
    public enum Mnemonic
    {
        reserved = -2,
        invalid = -1,

        abs,
        abs_s,
        add,
        add_n,
        add_s,
        addi,
        addi_n,
        addmi,
        addx2,
        addx4,
        addx8,
        all4,
        all8,
        and,
        andb,
        andbc,
        any4,
        any8,
        ball,
        bany,
        bbc,
        bbci,
        bbs,
        bbsi,
        beq,
        beqi,
        beqz,
        beqz_n,
        bf,
        bge,
        bgei,
        bgeu,
        bgeui,
        bgez,
        blt,
        blti,
        bltu,
        bltui,
        bltz,
        bnall,
        bne,
        bnei,
        bnez,
        bnez_n,
        bnone,
        @break,
        break_n,
        bt,
        call0,
        call12,
        call4,
        call8,
        callx0,
        callx12,
        callx4,
        callx8,
        ceil_s,
        clamps,
        cust0,
        cust1,
        dhi,
        dhu,
        dhwb,
        dhwbi,
        dii,
        diu,
        diwb,
        diwbi,
        dpfl,
        dpfr,
        dpfro,
        dpfw,
        dpfwo,
        dsync,
        entry,
        esync,
        excw,
        extui,
        extw,
        float_s,
        floor_s,
        idtlb,
        ihi,
        ihu,
        iii,
        iitlb,
        iiu,
        ill,
        ipf,
        ipfl,
        isync,
        j,
        jx,
        l16si,
        l16ui,
        l32ai,
        l32e,
        l32i,
        l32i_n,
        l32r,
        l8ui,
        lddec,
        ldinc,
        ldpte,
        loop,
        loopgtz,
        loopnez,
        lsi,
        lsiu,
        lsx,
        lsxu,
        madd_s,
        max,
        maxu,
        memw,
        min,
        minu,
        mov_n,
        mov_s,
        moveqz,
        moveqz_s,
        movf,
        movf_s,
        movgez,
        movgez_s,
        movi,
        movi_n,
        movltz,
        movltz_s,
        movnez,
        movnez_s,
        movsp,
        movt,
        movt_s,
        msub_s,
        mul_aa_hh,
        mul_aa_hl,
        mul_aa_lh,
        mul_aa_ll,
        mul_ad_hh,
        mul_ad_hl,
        mul_ad_lh,
        mul_ad_ll,
        mul_da_hh,
        mul_da_hl,
        mul_da_lh,
        mul_da_ll,
        mul_dd_hh,
        mul_dd_hl,
        mul_dd_lh,
        mul_dd_ll,
        mul_s,
        mul16s,
        mul16u,
        mula_aa_hh,
        mula_aa_hl,
        mula_aa_lh,
        mula_aa_ll,
        mula_ad_hh,
        mula_ad_hl,
        mula_ad_lh,
        mula_ad_ll,
        mula_da_hh,
        mula_da_hh_lddec,
        mula_da_hh_ldinc,
        mula_da_hl,
        mula_da_hl_lddec,
        mula_da_hl_ldinc,
        mula_da_lh,
        mula_da_lh_lddec,
        mula_da_lh_ldinc,
        mula_da_ll,
        mula_da_ll_lddec,
        mula_da_ll_ldinc,
        mula_dd_hh,
        mula_dd_hh_lddec,
        mula_dd_hl,
        mula_dd_hl_lddec,
        mula_dd_lh,
        mula_dd_lh_lddec,
        mula_dd_ll,
        mula_dd_ll_lddec,
        mull,
        muls_aa_hh,
        muls_aa_hl,
        muls_aa_lh,
        muls_aa_ll,
        muls_ad_hh,
        muls_ad_hl,
        muls_ad_lh,
        muls_ad_ll,
        muls_da_hh,
        muls_da_hl,
        muls_da_lh,
        muls_da_ll,
        muls_dd_hh,
        muls_dd_hl,
        muls_dd_lh,
        muls_dd_ll,
        mulsh,
        muluh,
        neg,
        neg_s,
        nop,
        nop_n,
        nsa,
        nsau,
        oeq_s,
        ole_s,
        olt_s,
        or,
        orb,
        orbc,
        pdtlb,
        pitlb,
        quos,
        quou,
        rdtlb0,
        rdtlb1,
        rems,
        remu,
        rer,
        ret,
        ret_n,
        retw,
        retw_n,
        rfde,
        rfe,
        rfi,
        rfme,
        rfr,
        rfue,
        rfwo,
        rfwu,
        ritlb0,
        ritlb1,
        rotw,
        round_s,
        rsil,
        rsr,
        rsync,
        rur,
        s16i,
        s32c1i,
        s32e,
        s32i,
        s32i_n,
        s32ri,
        s8i,
        sext,
        sll,
        slli,
        sra,
        srai,
        src,
        srl,
        srli,
        ssa8b,
        ssa8l,
        ssai,
        ssi,
        ssl,
        ssr,
        ssx,
        ssxu,
        sub,
        sub_s,
        subx2,
        subx4,
        subx8,
        syscall,
        trunc_s,
        ueq_s,
        ufloat_s,
        ule_s,
        ult_s,
        umul_aa_hh,
        umul_aa_hl,
        umul_aa_lh,
        umul_aa_ll,
        un_s,
        utrunc_s,
        waiti,
        wdtlb,
        wer,
        wfr,
        witlb,
        wsr,
        wur,
        xor,
        xorb,
        xsr,
    }
}