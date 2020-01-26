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

namespace Reko.Arch.X86
{
    public enum Mnemonic : ushort
    {
        illegal,

        @in,
        @int,
        @lock,
        @out,
        aaa,
        aad,
        aam,
        aas,
        adc,
        add,
        addpd,
        addps,
        addsd,
        addss,
        addsubpd,
        addsubps,
        aesimc,
        and,
        andnpd,
        andnps,
        andpd,
        andps,
        arpl,
        blendvpd,
        blendvps,
        bound,
        bsf,
        bsr,
        bswap,
        bt,
        btc,
        btr,
        bts,
        call,
        cbw,
        clac,
        clc,
        cld,
        cldemote,
        clflush,
        cli,
        clts,
        cmc,
        cmova,
        cmovbe,
        cmovc,
        cmovg,
        cmovge,
        cmovl,
        cmovle,
        cmovnc,
        cmovno,
        cmovns,
        cmovnz,
        cmovo,
        cmovpe,
        cmovpo,
        cmovs,
        cmovz,
        cmp,
        cmppd,
        cmpps,
        cmps,
        cmpsb,
        cmpsd,
        cmpss,
        cmpxchg,
        cmpxchg16b,
        cmpxchg8b,
        comisd,
        comiss,
        cpuid,
        cvtdq2ps,
        cvtdq2pd,
        cvtpd2dq,
        cvtpd2ps,
        cvtpd2si,
        cvtph2ps,
        cvtpi2pd,
        cvtpi2ps,
        cvtps2dq,
        cvtps2pd,
        cvtps2pi,
        cvtsd2si,
        cvtsd2ss,
        cvtsi2sd,
        cvtsi2ss,
        cvtss2sd,
        cvtss2si,
        cvttpd2dq,
        cvttpd2pi,
        cvttpd2si,
        cvttps2dq,
        cvttps2pi,
        cvttsd2si,
        cvttss2si,
        cwd,
        daa,
        das,
        dec,
        div,
        divpd,
        divps,
        divsd,
        divss,
        emms,
        enter,
        f2xm1,
        fabs,
        fadd,
        faddp,
        fbld,
        fbstp,
        fchs,
        fclex,
        fcmovb,
        fcmovbe,
        fcmove,
        fcmovnb,
        fcmovnbe,
        fcmovne,
        fcmovnu,
        fcmovu,
        fcom,
        fcomi,
        fcomip,
        fcomp,
        fcompp,
        fcos,
        fdecstp,
        fdiv,
        fdivp,
        fdivr,
        fdivrp,
        femms,
        ffree,
        ffreep,
        fiadd,
        ficom,
        ficomp,
        fidiv,
        fidivr,
        fild,
        fildcw,
        fildenv,
        fimul,
        fincstp,
        fist,
        fistcw,
        fistenv,
        fistp,
        fisttp,
        fisub,
        fisubr,
        fld,
        fld1,
        fldcw,
        fldenv,
        fldl2e,
        fldl2t,
        fldlg2,
        fldln2,
        fldpi,
        fldz,
        fmul,
        fmulp,
        fndisi,
        fneni,
        fninit,
        fnop,
        fnsetpm,
        fpatan,
        fprem,
        fprem1,
        fptan,
        frndint,
        frstor,
        frstpm,
        fsave,
        fscale,
        fsin,
        fsincos,
        fsqrt,
        fst,
        fstcw,
        fstenv,
        fstp,
        fstsw,
        fsub,
        fsubp,
        fsubr,
        fsubrp,
        ftst,
        fucom,
        fucomi,
        fucomip,
        fucomp,
        fucompp,
        fxam,
        fxch,
        fxrstor,
        fxsave,
        fxtract,
        fyl2x,
        fyl2xp1,
        getsec,
        hlt,
        idiv,
        imul,
        inc,
        ins,
        insb,
        into,
        invd,
        invept,
        invlpg,
        invpcid,
        invvpid,
        iret,
        ja,
        jbe,
        jc,
        jcxz,
        jg,
        jge,
        jl,
        jle,
        jmp,
        jmpe,
        jnc,
        jno,
        jns,
        jnz,
        jo,
        jpe,
        jpo,
        js,
        jz,
        lahf,
        lar,
        ldmxcsr,
        lds,
        lea,
        leave,
        les,
        lfence,
        lfs,
        lgdt,
        lgs,
        lidt,
        lldt,
        lmsw,
        lods,
        lodsb,
        loop,
        loope,
        loopne,
        lsl,
        lss,
        ltr,
        lzcnt,
        maskmovq,
        maxpd,
        maxps,
        maxsd,
        maxss,
        mfence,
        minpd,
        minps,
        minsd,
        minss,
        monitor,
        monitorx,
        mov,
        movapd,
        movaps,
        movd,
        movddup,
        movdqa,
        movdqu,
        movhpd,
        movhps,
        movlhps,
        movlpd,
        movlps,
        movmskpd,
        movmskps,
        movnti,
        movntpd,
        movntps,
        movntq,
        movq,
        movs,
        movsb,
        movsd,
        movshdup,
        movsldup,
        movss,
        movsx,
        movupd,
        movups,
        movzx,
        mul,
        mulpd,
        mulps,
        mulsd,
        mulss,
        mwait,
        mwaitx,
        neg,
        nop,
        not,
        or,
        orpd,
        orps,
        outs,
        outsb,
        packssdw,
        packuswb,
        paddb,
        paddd,
        paddq,
        paddsb,
        paddsw,
        paddusb,
        paddusw,
        paddw,
        palignr,
        packsswb,
        pand,
        pandn,
        pause,
        pavgb,
        pavgw,
        pblendvdb,
        pcmpeqb,
        pcmpeqd,
        pcmpeqw,
        pcmpgtb,
        pcmpgtd,
        pcmpgtw,
        pcmpistri,
        pextrw,
        phsubsw,
        pinsrw,
        pmaddwd,
        pmaxsw,
        pmaxub,
        pminsw,
        pminub,
        pmovmskb,
        pmulhuw,
        pmulhw,
        pmullw,
        pmuludq,
        pop,
        popa,
        popcnt,
        popf,
        por,
        prefetchnta,
        prefetcht0,
        prefetcht1,
        prefetcht2,
        prefetchw,
        psadbw,
        pshufd,
        pshufhw,
        pshuflw,
        pshufb,
        pshufw,
        pslld,
        psllq,
        psllw,
        psrad,
        psraw,
        psrld,
        psrlq,
        psrlw,
        psubb,
        psubd,
        psubq,
        psubsb,
        psubsw,
        psubusb,
        psubusw,
        psubw,
        punpckhbw,
        punpckhdq,
        punpckhwd,
        punpcklbw,
        punpckldq,
        punpcklwd,
        push,
        pusha,
        pushf,
        pxor,
        rcl,
        rcpps,
        rcpss,
        rcr,
        rdmsr,
        rdpkru,
        rdpmc,
        rdrand,
        rdseed,
        rdtsc,
        rdtscp,
        ret,
        retf,
        rol,
        ror,
        rsm,
        rsqrtps,
        rsqrtss,
        sahf,
        sar,
        sbb,
        scas,
        scasb,
        seta,
        setbe,
        setc,
        setg,
        setge,
        setl,
        setle,
        setnc,
        setno,
        setns,
        setnz,
        seto,
        setpe,
        setpo,
        sets,
        setz,
        sfence,
        sgdt,
        sha1msg2,
        shl,
        shld,
        shr,
        shrd,
        sidt,
        sldt,
        smsw,
        sqrtpd,
        sqrtps,
        sqrtsd,
        sqrtss,
        stac,
        stc,
        std,
        sti,
        stmxcsr,
        stos,
        stosb,
        str,
        sub,
        subpd,
        subps,
        subsd,
        subss,
        swapgs,
        syscall,
        sysenter,
        sysexit,
        sysret,
        test,
        tzcnt,
        ucomisd,
        ucomiss,
        ud0,
        ud1,
        ud2,
        unpckhpd,
        unpckhps,
        unpcklpd,
        unpcklps,
        vaddpd,
        vaddsd,
        vaddsubpd,
        vaddsubps,
        vblendvpdv,
        vblendvpsv,
        vcvtdq2pd,
        vcvtpd2dq,
        vcvtsi2sd,
        vcvtsi2ss,
        vcvttpd2dq,
        verr,
        verw,
        vextrw,
        vhaddpd,
        vhaddps,
        vhsubpd,
        vhsubps,
        vlddqu,
        vmaskmovdqu,
        vmcall,
        vmclear,
        vmfunc,
        vmlaunch,
        vmovapd,
        vmovaps,
        vmovlpd,
        vmovlps,
        vmovntq,
        vmovsd,
        vmovss,
        vmptrld,
        vmptrst,
        vmread,
        vmresume,
        vmwrite,
        vmxoff,
        vmxon,
        vpackssdw,
        vpacksswb,
        vpaddb,
        vpaddd,
        vpaddq,
        vpaddsb,
        vpaddsw,
        vpaddusb,
        vpaddusw,
        vpaddw,
        vpand,
        vpandn,
        vpavgb,
        vpavgw,
        vpermq,
        vphsubsw,
        vpinsrw,
        vpmaddwd,
        vpmaxsw,
        vpmaxub,
        vpminsw,
        vpminub,
        vpmovmskb,
        vpmovsxbw,
        vpmulhuw,
        vpmulhw,
        vpmullw,
        vpmuludq,
        vpor,
        vpsadbw,
        vpslld,
        vpslldq,
        vpsllq,
        vpsllw,
        vpsrad,
        vpsraw,
        vpsrld,
        vpsrldq,
        vpsrlq,
        vpsrlw,
        vpsubb,
        vpsubd,
        vpsubq,
        vpsubsb,
        vpsubsw,
        vpsubusb,
        vpsubusw,
        vpsubw,
        vpunpckhbw,
        vpunpckhdq,
        vpunpckhqdq,
        vpunpckhwd,
        vpunpcklqdq,
        vpxor,
        vpshufb,
        vshufpd,
        vshufps,
        vunpckhpd,
        vunpckhps,
        vxorpd,
        vxorps,
        wait,
        wbinvd,
        wrmsr,
        wrpkru,
        xadd,
        xchg,
        xend,
        xgetbv,
        xlat,
        xor,
        xorpd,
        xorps,
        xrstor,
        xsave,
        xsave64,
        xsaveopt,
        xsetbv,
        xtest,


        // Borland implemented an x87 emulator, and introduced these
        // pseudo-instructions.
        BOR_exp,
        BOR_ln,
        vtestpd,
        vtestps,
        vpermilpd,
        vpermilps,
        vpmulhrsw,
        pmulhrsw,
        vpsignd,
        psignd,
        vpsignw,
        psignw,
        vpsignb,
        psignb,
        vphaddw,
        phaddw,
        vphaddd,
        phaddd,
        phaddsw,
        vphaddsw,
        pmaddubsw,
        vpmaddubsw,
        phsubw,
        vphsubw,
        phsubd,
        vphsubd,
        vaesenc,
        vaesenclast,
        vaesdec,
        vaesdeclast,
        sha256msg2,
        sha256msg1,
        sha256mds2,
        sha1msg1,
        sha1nexte,
        vptest,
        vpermps,
        pblendvb,
        vcvtph2ps,
        vpmovsxbq,
        vpmovsxbd,
        vpmovsxwd,
        vpmovsxwq,
        vpmovsxdq,
        vfnmsub231ps,
        vfnmsub231ss,
        vfmadd213pd,
        vfmadd213ps,

        vbroadcastss,
        vbroadcastsd, 
        vbroadcastb,
        vbroadcastw,
        vbroadcastf128, 
        pabsb,
        vpabsb, 
        pabsw,
        vpabsw,
        pabsd,
        vpabsd,
        vpmuldq,
        vpcmpeqq,
        vpminsb,
        vpminsd,
        vpminuw,
        vpminud,
        vpmaxsb,
        vpmaxsd,
        vpmaxuw,
        vpmaxud,
        vpsllvq,
        vpsllvd,
        vpsravd,
        vpsrlvq,
        vpsrlvd,
        vphminposuw,
        vpmulld,
        vgatherdd,
        vgatherdq,
        vgatherqd,
        vgatherqq,
        vgatherdps,
        vgatherdpd,
        vgatherqps,
        vgatherqpd,
        vfmaddsub132ps,
        vfmaddsub132pd,
        vfmsubadd132ps,
        vfmsubadd132pd,
        vpmovzxbw,
        vpmovzxbd,
        vpmovzxbq,
        vpmovzxwd,
        vpmovzxwq,
        vpmovzxdq,
        vpermd,
        vpcmpgtq,
        vmovntdqa, 
        vpackusdw, 
        vmaskmovps,
        vmaskmovpd,

        vpermpd,
        vpblendd,
        vperm2f128,
        vpbroadcastd,
        vpbroadcastq,
        vpbroadcasti128,
    }
}
