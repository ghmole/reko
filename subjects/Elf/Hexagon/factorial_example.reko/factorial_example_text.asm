;;; Segment .text (00005000)

;; .EventVectors: 00005000
.EventVectors proc
	{ jump	00000970 }
00005004             32 DD FF 59 36 DD FF 59 3A DD FF 59     2..Y6..Y:..Y
00005010 58 DD FF 59 36 DD FF 59 D4 DD FF 59 32 DD FF 59 X..Y6..Y...Y2..Y
00005020 48 DE FF 59 06 DF FF 59 2C DD FF 59 2A DD FF 59 H..Y...Y,..Y*..Y
00005030 28 DD FF 59 26 DD FF 59 24 DD FF 59 22 DD FF 59 (..Y&..Y$..Y"..Y
00005040 FE DE FF 59 FC DE FF 59 FA DE FF 59 F8 DE FF 59 ...Y...Y...Y...Y
00005050 F6 DE FF 59 F4 DE FF 59 F2 DE FF 59 F0 DE FF 59 ...Y...Y...Y...Y
00005060 EE DE FF 59 EC DE FF 59 EA DE FF 59 E8 DE FF 59 ...Y...Y...Y...Y
00005070 E6 DE FF 59 E4 DE FF 59 E2 DE FF 59 E0 DE FF 59 ...Y...Y...Y...Y
00005080 DE DE FF 59 DC DE FF 59 DA DE FF 59 D8 DE FF 59 ...Y...Y...Y...Y
00005090 D6 DE FF 59 D4 DE FF 59 D2 DE FF 59 D0 DE FF 59 ...Y...Y...Y...Y
000050A0 CE DE FF 59 CC DE FF 59 CA DE FF 59 C8 DE FF 59 ...Y...Y...Y...Y
000050B0 C6 DE FF 59 C4 DE FF 59 C2 DE FF 59 C0 DE FF 59 ...Y...Y...Y...Y

;; strict_aliasing_workaround: 000050C0
strict_aliasing_workaround proc
	{ allocframe(+00000010) }
	{ memw(r30-12) = r0 }
	{ r0 = memw(r30-12) }
	{ memw(r30-4) = r0 }
	{ r0 = memw(r30-4) }
	{ deallocframe }
	{ jumpr	r31 }

;; fact: 000050DC
;;   Called from:
;;     00005108 (in fact)
;;     000051AC (in main)
fact proc
	{ allocframe(+00000008) }
	{ memw(r30-4) = r0 }
	{ r0 = memw(r30-4) }
	{ p0 = cmp.gt(r0,00000001) }
	{ r0 = mux(p0,00000001,00000000) }
	{ p0 = tstbit(r0,00000000) }
	{ if (p0) jump:nt	00005100 }

l000050F8:
	{ r0 = 00000001 }
	{ jump	00005118 }

l00005100:
	{ r0 = memw(r30-4) }
	{ r0 = add(r0,FFFFFFFF) }
	{ call	000050DC }
	{ r1 = r0 }
	{ r0 = memw(r30-4) }
	{ r0 = mpyi(r1,r0) }

l00005118:
	{ deallocframe }
	{ jumpr	r31 }

;; main: 00005120
;;   Called from:
;;     000055F4 (in __libc_start_main)
main proc
	{ allocframe(+00000018) }
	{ memw(r30-12) = r0 }
	{ memw(r30-16) = r1 }
	{ r0 = memw(r30-12) }
	{ p0 = cmp.eq(r0,00000002) }
	{ r0 = mux(p0,00000001,00000000) }
	{ p0 = tstbit(r0,00000000) }
	{ if (!p0) jump:nt	00005180 }

l00005140:
	{ r0 = memw(r30-16) }
	{ r0 = add(r0,00000004) }
	{ r0 = memw(r0) }
	{ call	000051DC }
	{ memw(r30-4) = r0 }
	{ r0 = memw(r30-4) }
	{ memw(r29) = r0 }
	{ r0 = 0000D000 }
	{ call	00005310 }
	{ r0 = memw(r30-4) }
	{ p0 = cmp.gt(r0,FFFFFFFF) }
	{ r0 = mux(p0,00000001,00000000) }
	{ p0 = tstbit(r0,00000000) }
	{ if (!p0) jump:nt	00005194 }

l0000517C:
	{ jump	000051A8 }

l00005180:
	{ r0 = 0000D013 }
	{ call	00005310 }
	{ r0 = FFFFFFFF }
	{ jump	000051D4 }

l00005194:
	{ r0 = 0000D02F }
	{ call	00005310 }
	{ r0 = FFFFFFFF }
	{ jump	000051D4 }

l000051A8:
	{ r0 = memw(r30-4) }
	{ call	000050DC }
	{ memw(r30-8) = r0 }
	{ r0 = memw(r30-4) }
	{ memw(r29) = r0 }
	{ r0 = memw(r30-8) }
	{ memw(r29+4) = r0 }
	{ r0 = 0000D050 }
	{ call	00005310 }
	{ r0 = 00000000 }

l000051D4:
	{ deallocframe }
	{ jumpr	r31 }

;; atoi: 000051DC
;;   Called from:
;;     0000514C (in main)
atoi proc
	{ allocframe(+00000008) }
	{ memw(r30-4) = r0 }
	{ r0 = memw(r30-4) }
	{ r1 = 00000000 }
	{ r2 = 0000000A }
	{ call	00006894 }
	{ deallocframe }
	{ jumpr	r31 }
000051FC                                     00 C0 00 7F             ....

;; thread_create: 00005200
thread_create proc
	{ r6.h = 0000; r5.h = 0000; r7 = asl(r2,00000002); r4.h = 0000 }
	{ r8 = 00000001; r6.l = 6C50; r5.l = 6BF0; r4.l = 6B90 }
	{ r6 = add(r6,r7); r4 = add(r4,r7); r8 &= asl(r8,r2); r5 = add(r7,r5) }
	{ memw(r4) = r0 }
	{ memw(r5) = r1 }
	{ memw(r6) = r3 }
	{ start(r8) }
	{ jumpr	r31 }

;; thread_stop: 00005240
;;   Called from:
;;     0000AEE4 (in _exit)
thread_stop proc
	{ r1 = 00000001; r0 = htid }
	{ r1 &= lsl(r1,r0) }
	{ stop(r1) }
	{ r28.h = 0000 }
	{ r28.l = 1DC0 }
	{ jumpr	r28 }
0000525C                                     00 C0 00 7F             ....

;; thread_join: 00005260
thread_join proc
	{ r3 = 00000001; r1 = htid }
	{ r1 &= asl(r3,r1) }
	{ r1 = sub(FFFFFFFF,r1) }
	{ r0 = and(r0,r1) }
	{ r0 = combine(r0.l,r0.l) }
	{ r2 = modectl }
	{ r2 = and(r0,r2) }
	{ if (p0.new) jumpr	r31; p0 = cmp.eq(r2,00000000) }
00005284             04 C0 40 54 F8 FF FF 59 00 C0 00 7F     ..@T...Y....

;; thread_get_tnum: 00005290
thread_get_tnum proc
	{ jumpr	r31; r0 = htid }
00005298                         00 40 00 7F 00 C0 00 7F         .@......

;; thread_stack_size: 000052A0
thread_stack_size proc
	{ r2.h = 0000 }
	{ r3 = asl(r0,00000002); r2.l = 6CB0 }
	{ r4 = add(r2,r3) }
	{ memw(r4) = r1 }
	{ jumpr	r31 }
000052B8                         00 C0 00 7F 00 C0 00 7F         ........

;; __sys_get_cmdline: 000052C0
__sys_get_cmdline proc
	{ allocframe(+00000010); r3 = memw(gp+224); r2 = 00000000 }
	{ memd(r29+8) = r17:r16; if (p0.new) jump:nt	00005300; p0 = cmp.eq(r3,00000000) }

l000052D8:
	{ memw(r29) = r0; r16 = add(r29,00000000) }
	{ r2 = setbit(r16,00000004) }
	{ memw(r2) = r1; call	00005610 }
	{ r0 = add(r29,00000000); r1 = 00000008; call	00005610 }
	{ r0 = 00000015 }
	{ r1 = r16 }
	{ trap0(00000000) }
	{ r2 = r0 }

l00005300:
	{ dealloc_return; r17:r16 = memd(r29+8); r0 = r2 }
00005308                         00 C0 00 7F 00 C0 00 7F         ........

;; printf: 00005310
;;   Called from:
;;     00005164 (in main)
;;     00005188 (in main)
;;     0000519C (in main)
;;     000051CC (in main)
printf proc
	{ allocframe(00000010); memd(r29+496) = r17:r16; r16 = r0 }
	{ r0 = 0000E498; r1 = add(r29,00000018) }
	{ call	00006958 }
	{ r3 = memd(r29+4); r1 = 00000018; r2 = r16 }
	{ r0 = 00005360; call	00005770 }
	{ r16 = r0; r0 = 00000018; nop; call	00006A10 }
	{ dealloc_return; r17:r16 = memd(r29+8); nop; r0 = r16 }

;; prout: 00005360
prout proc
	{ allocframe(00000008); memd(r29+496) = r17:r16; r17:r16 = combine(r0,r2); r4 = r1 }
	{ call	000070C0 }
	{ r3 = r17 }
	{ r17:r16 = memd(r29); r0 = -00000001; if (p0.new) r0 = add(r17,00000000); p0 = cmp.eq(r0,r16) }
	{ dealloc_return }
00005388                         00 C0 00 7F 00 C0 00 7F         ........

;; memset: 00005390
memset proc
	{ r6 = r0; r7 = vsplatb(r1); if (r2=00000000) jump:nt	00005490 }

l0000539C:
	{ if (p0.new) jump:t	000053C0; p0 = cmp.gtu(r2,-00000001); r5:r4 = combine(r7,r7) }

l000053A4:
	{ nop; r3 = r0; loop0(000053B0,r2) }
	{ memb(r3++#1) = r1; nop }
	{ jumpr	r31 }
000053BC                                     0A 43 C0 11             .C..

l000053C0:
	{ p1 = cmp.eq(r2,00000001) }
	{ memb(r0) = r1; r6 = r0; if (p1) jump:nt	00005494; r2 = add(r2,FFFFFFFF) }

l000053D0:
	{ if (!p0.new) jump:nt	000053E8; p0 = tstbit(r6,00000001) }

l000053D8:
	{ memuh(r6++#2) = r7; if (p0.new) jump:nt	00005494; p0 = cmp.eq(r2,00000004); r2 = add(r2,FFFFFFFE) }

l000053E4:
	{ if (!p0.new) jump:nt	000053FC; p0 = tstbit(r6,00000002) }

l000053E8:
	{ if (!p0.new) jump:nt	000053FC }

l000053EC:
	{ memw(r6++#4) = r7; if (p0.new) jump:nt	00005494; p0 = cmp.eq(r2,00000008); r2 = add(r2,FFFFFFFC) }

l000053F8:
	{ if (!p0.new) jump:nt	00005454; p0 = cmp.gtu(r2,0000007F) }

l000053FC:
	{ if (!p0.new) jump:nt	00005454 }

l00005400:
	{ r3 = and(r6,0000001F) }
	{ if (r3=00000000) jump:nt	00005430 }

l00005408:
	{ memd(r6++#8) = r5:r4; r2 = add(r2,FFFFFFF8) }
	{ r3 = and(r6,0000001F) }
	{ if (r3=00000000) jump:nt	00005430 }

l00005418:
	{ memd(r6++#8) = r5:r4; r2 = add(r2,FFFFFFF8) }
	{ r3 = and(r6,0000001F) }
	{ if (r3=00000000) jump:nt	00005430 }

l00005428:
	{ memd(r6++#8) = r5:r4; r2 = add(r2,FFFFFFF8) }

l00005430:
	{ r3 = lsr(r2,00000005); if (r1!=00000000) jump:nt	00005494 }

l00005438:
	{ r3 = r6; r8 = r3; loop0(00005444,r3) }
	{ dczeroa(r6); r2 = add(r2,FFFFFFE0); r6 = add(r6,00000020) }

l00005450:
	{ r8 = lsr(r2,00000003); if (!p0.new) jump:t	00005468; p0 = cmp.gtu(r2,-00000001) }

l00005454:
	{ r8 = lsr(r2,00000003) }

l00005458:
	{ nop; loop0(00005460,r8) }
	{ memd(r6++#8) = r5:r4; r2 = add(r2,FFFFFFF8) }

l00005468:
	{ if (!p0.new) jump:nt	0000547C; p0 = tstbit(r2,00000002) }

l00005470:
	{ memw(r6++#4) = r7; r2 = add(r2,FFFFFFFC) }
	{ if (!p0.new) jump:nt	0000548C; p0 = tstbit(r2,00000001) }

l0000547C:
	{ if (!p0.new) jump:nt	0000548C }

l00005480:
	{ memuh(r6++#2) = r7; r2 = add(r2,FFFFFFFE) }
	{ p0 = cmp.eq(r2,00000001) }

l0000548C:
	{ if (p0) memb(r6) = r1 }

l00005490:
	{ jumpr	r31 }

l00005494:
	{ loop0(00005498,r3) }
	{ dczeroa(r6) }
	{ memd(r6+8) = r5:r4; memd(r6++#16) = r5:r4; r2 = add(r2,FFFFFFE0) }
	{ memd(r6+8) = r5:r4; memd(r6++#16) = r5:r4 }
	{ jump	00005450 }
000054B4             00 C0 00 7F 00 C0 00 7F 00 C0 00 7F     ............

;; __libc_start_main: 000054C0
__libc_start_main proc
	{ allocframe(00000008); memd(r29+496) = r17:r16; r16 = r3; p0 = cmp.gt(r1,FFFFFFFF) }
	{ if (!p0) jump:nt	000055FC }

l000054D0:
	{ if (!p0.new) jump:t	00005500; p0 = cmp.gt(r1,00000000) }

l000054D4:
	{ if (p0.new) jump:t	00005500; p0 = cmp.eq(r0,00000000) }

l000054D8:
	{ r3 = memb(r0) }
	{ p0 = cmp.eq(r3,00000020); if (!p0.new) jump:nt	00005500 }

l000054E8:
	{ r1 = add(r1,FFFFFFFF); r3 = add(r0,00000001) }
	{ r0 = r3; if (!p0.new) jump:t	000054D8; p0 = cmp.eq(r0,-00000001) }

l000054FC:
	{ jump	00005504 }

l00005500:
	{ r3 = r0 }

l00005504:
	{ r17 = 00000000; r0 = 00000000; if (!p0.new) jump:nt	000055C8; p0 = cmp.gt(r1,00000000) }

l0000550C:
	{ r5:r4 = combine(00000000,00000001); r17 = 00000000; r6 = 00000000 }
	{ if (p0.new) jump:nt	000055C8; p0 = cmp.eq(r4,00000000) }

l00005518:
	{ p0 = cmp.gt(r17,00000063); if (p0.new) jump:nt	000055C8 }

l00005520:
	{ r7 = memb(r4) }
	{ if (p0.new) jump:t	0000554C; p0 = cmp.eq(r7,00000000) }

l0000552C:
	{ if (p0.new) jump:t	0000554C; p0 = cmp.eq(r7,00000012) }

l00005530:
	{ jump	000055BC }
00005534             08 58 20 5C 40 C4 07 75 11 33 43 31     .X \@..u.3C1
00005540 20 C4 03 17 3C 58 20 5C 00 C4 07 75              ...<X \...u   

l0000554C:
	{ if (!p0.new) jump:t	00005570; p0 = cmp.eq(r6,00000000) }

l00005550:
	{ memb(r4) = 00000000; p0 = cmp.eq(r7,00000000); p1 = cmp.eq(r4,r3); r6 = 00000000 }
	{ if (p0) r5 = 00000001; if (!p1) jump:nt	000055A0 }

l00005564:
	{ p0 = !cmp.eq(r7,00000000); if (!p0.new) jump:t	000055A0 }

l0000556C:
	{ jump	000055BC }

l00005570:
	{ if (p0.new) jump:nt	000055C8; p0 = cmp.eq(r7,00000000) }

l00005574:
	{ r3 = add(r4,00000001); jump	000055BC; r6 = 00000000 }
0000557C                                     11 33 44 31             .3D1
00005580 06 C0 24 91 0C 58 00 5C 40 C4 06 75 F8 E0 76 10 ..$..X.\@..u..v.
00005590 3A 40 00 58 41 43 00 00 E0 C4 00 78 40 32 16 68 :@.XAC.....x@2.h

l000055A0:
	{ r7 = memb(r3) }
	{ memw(r17<<#2+0000E700) = r3; r17 = add(r17,00000001) }
	{ if (!p0.new) jump:nt	000055C8; p0 = cmp.eq(r5,00000000) }

l000055B8:
	{ r3 = r4; r5 = 00000000 }

l000055BC:
	{ r1 = add(r1,FFFFFFFF); r4 = add(r4,00000001) }

l000055C8:
	{ memw(r17<<#2+0000E700) = r0; if (p0.new) jump:t	000055D8; p0 = cmp.eq(r2,00000000) }

l000055D4:
	{ callr	r2 }

l000055D8:
	{ if (!p0.new) r0 = add(r16,00000000); if (p0.new) jump:t	000055E4; p0 = cmp.eq(r8,00000000) }

l000055E0:
	{ call	00006F20 }

l000055E4:
	{  }
	{ r2 = 0000E440 }
	{ call	00005120 }
	{ call	00006F70 }

l000055FC:
	{ dealloc_return; r17:r16 = memd(r29); r0 = 00000001 }
00005604             BE CE 00 5A B4 4C 00 5A 00 C0 00 78     ...Z.L.Z...x

;; hexagon_cache_cleaninv: 00005610
;;   Called from:
;;     000052E0 (in __sys_get_cmdline)
;;     000052E8 (in __sys_get_cmdline)
;;     0000AFD4 (in __sys_close)
;;     0000B050 (in __sys_remove)
;;     0000B058 (in __sys_remove)
;;     0000B2C4 (in __sys_write)
;;     0000B2CC (in __sys_write)
hexagon_cache_cleaninv proc
	{ r2 = and(r0,0000001F) }
	{ r2 += add(r1,0000001F) }
	{ r1 = lsr(r2,00000005) }
	{ r4 = r0; r3 = 00000000; r1 = asl(r1,00000005) }
	{ r3 -= lsr(r2,00000005) }
	{ r2 = sub(00000000,r3) }
	{ loop0(00005634,r2) }
	{ r2 = add(r4,00000020) }
	{ dccleaninva(r4) }
	{ nop; r4 = r2 }
	{ r0 = add(r0,r1) }
	{ r0 = add(r0,FFFFFFE0) }
	{ r1 = memb(r0) }
	{ dccleaninva(r0) }
	{ jumpr	r31 }

;; hexagon_cache_inva: 00005658
hexagon_cache_inva proc
	{ r2 = and(r0,0000001F) }
	{ r2 += add(r1,0000001F) }
	{ r1 = lsr(r2,00000005) }
	{ r1 = 00000000 }
	{ r1 -= lsr(r2,00000005) }
	{ r1 = sub(00000000,r1) }
	{ loop0(00005678,r1) }
	{ r1 = add(r0,00000020) }
	{ dcinva(r0) }
	{ nop; r0 = r1 }
	{ jumpr	r31 }
0000568C                                     00 C0 00 7F             ....

;; __registerx: 00005690
__registerx proc
	{ allocframe(00000010); memd(r29+496) = r17:r16; r17:r16 = combine(r1,r0) }
	{ memd(r29) = r19:r18; p0 = cmp.eq(r16,00000000); r19:r18 = combine(r4,r3) }
	{ if (p0) jump:nt	000056D0 }

l000056A4:
	{ if (cmp.eq(r0.new,00000000)) jump:nt	000056D4; r0 = memw(r16) }

l000056B0:
	{ r1:r0 = combine(00000018,00000001) }
	{ if (p0.new) memw(r0+12) = r18; if (p0.new) jump:nt	000056D8; p0 = cmp.eq(r0,00000000) }

l000056BC:
	{ memw(r0+20) = 00000000; memw(r0+8) = r17 }
	{ memw(r0+16) = r19; memw(r0+4) = r16 }
	{ r1 = memw(gp+116) }
	{ memw(gp) = r0 }

l000056D0:
	{ r19:r18 = memd(r29); r17:r16 = memd(r29+8) }

l000056D4:
	{ dealloc_return }

l000056D8:
	{ nop; call	00006E30 }

;; __register_frame_info_bases: 000056E0
;;   Called from:
;;     000056D8 (in __registerx)
__register_frame_info_bases proc
	{ allocframe(00000010); memd(r29+496) = r17:r16; r17:r16 = combine(r2,r0) }
	{ memd(r29) = r19:r18; p0 = cmp.eq(r16,00000000); r18 = r3 }
	{ if (p0) jump:nt	00005720 }

l000056F4:
	{ if (cmp.eq(r0.new,00000000)) jump:nt	00005724; r0 = memw(r16) }

l00005700:
	{ r1:r0 = combine(00000018,00000001) }
	{ if (p0.new) memw(r0+12) = r17; if (p0.new) jump:nt	00005728; p0 = cmp.eq(r0,00000000) }

l0000570C:
	{ memw(r0+20) = 00000000; memw(r0+8) = 00000000 }
	{ memw(r0+16) = r18; memw(r0+4) = r16 }
	{ r1 = memw(gp+116) }
	{ memw(gp) = r0 }

l00005720:
	{ r19:r18 = memd(r29); r17:r16 = memd(r29+8) }

l00005724:
	{ dealloc_return }

l00005728:
	{ nop; call	00006E30 }

;; __deregister_frame_info_bases: 00005730
;;   Called from:
;;     00005728 (in __register_frame_info_bases)
__deregister_frame_info_bases proc
	{ allocframe(+00000000); if (p0.new) jump:nt	0000576C; p0 = cmp.eq(r0,00000000) }

l00005738:
	{ r1 = memw(r0) }
	{ r1 = 00010074 }
	{ r2 = r1 }
	{ r1 = memw(r2) }
	{ r3 = memw(r1+4) }
	{ r3 = memw(r1); r0 = r1; call	00006FF0 }

l0000576C:
	{ dealloc_return; r0 = 00000000 }

;; _Printf: 00005770
;;   Called from:
;;     00005338 (in printf)
_Printf proc
	{ allocframe(+000000C8); call	0000A2C0 }
	{ r5:r4 = combine(00000000,00000000); r1 = r3; r0 = add(r29,00000054); r19:r18 = combine(r1,r0) }
	{  }
	{ memd(r29+88) = r5:r4; r21 = add(r29,00000060) }
	{ r24 = 000003E8; r23 = 000003E7; r22 = add(r29,00000050); call	00006BF0 }
	{ memw(r21+12) = r19; memw(r21+8) = r18; r25 = 0000D088 }
	{ memw(r21+52) = FFFFFF80; jump	000057B8 }
000057B4             31 C0 11 B0                             1...       

l000057B8:
	{ r1 = r17; r0 = add(r29,00000050); r2 = r16; r3 = add(r29,00000058) }
	{ memw(r22) = 00000000; call	00008F3C }
	{ if (cmp.gt(r18.new,00000000)) jump:t	000057E0; r18 = r0 }

l000057D8:
	{ r18 = !cmp.eq(r0,00000000) }
	{ r0 = memw(r29+80) }

l000057E0:
	{ if (!p0.new) r1 = 00000000; if (p0.new) r1 = FFFFFFFF; p0 = cmp.eq(r0,00000025) }
	{ r19 = add(r1,r18) }
	{ r3 = memw(r21+8); r0 = memw(r21+12); r2 = r19; r1 = r17 }
	{ callr	r3; r20 = FFFFFFFF }
	{ memw(r21+12) = r0; if (p0.new) jump:nt	00005ABC; p0 = cmp.eq(r16,00000000) }

l00005810:
	{ r0 = memw(r21+52) }
	{ memb(r21+13) = r0.new; r0 = add(r0,r19) }
	{ p0 = cmp.eq(r0,00000025); r17 = add(r17,r18); if (!p0.new) jump:nt	00005AA4 }

l0000582C:
	{ memw(r21+44) = 00000000; r19:r18 = combine(00000000,00000000) }

l00005830:
	{ r20 = memb(r18); call	00007998 }
	{ r0 = memb(r13+r20<<#1) }
	{ if (cmp.eq(r0.new,00000000)) jump:nt	00005860; r0 = and(r0,00000020) }

l00005848:
	{ r19 = memb(r18++#1) }
	{ r19 += add(r0,FFFFFFD0) }
	{ memw(r21+44) = r19; p0 = cmp.gt(r24,r19); if (p0.new) jump:t	00005830 }

l0000585C:
	{ r0 = memb(r18) }

l00005860:
	{ p0 = cmp.eq(r0,00000024); if (!p0.new) jump:t	0000587C }

l00005868:
	{ r0 = r19; r18 = r18 }
	{ if (!p0.new) memw(r21+44) = 00000000; if (!p0.new) r18 = add(r17,00000000); p0 = cmp.gtu(r23,r0); jump	00005880 }

l0000587C:
	{ memw(r21+44) = 00000000; r18 = r17 }

l00005880:
	{ memuh(r21+60) = 0000; memw(r21+36) = FFFFFF80; r2 = 00000005 }
	{ memw(r21+20) = 00000000; memw(r21+40) = 00000000; r0 = 0000D088 }
	{ memw(r21+28) = 00000000; memw(r21+24) = 00000000 }
	{ memw(r21+32) = 00000000 }
	{ r1 = memb(r18); call	00007350 }
	{ if (p0.new) jump:t	000058E4; p0 = cmp.eq(r0,00000000) }

l000058AC:
	{ r18 = add(r18,00000001); jump	000058BC; r1 = 00000000 }

l000058B4:
	{ r1 = memuh(r21+60); r18 = add(r18,00000001) }

l000058BC:
	{ r2 = 00000005; r0 = sub(r0,r25) }
	{ r0 = memw(r0<<#2+0000D098) }
	{ memb(r21+30) = r0.new; r0 = or(r1,r0) }
	{ r1 = memb(r18); r0 = 00000008 }
	{ if (!p0.new) jump:t	000058B4; p0 = cmp.eq(r16,00000001) }

l000058E4:
	{ r0 = memb(r18) }
	{ if (!p0.new) memw(r21+56) = 00000000; p0 = cmp.eq(r0,0000002A); if (!p0.new) jump:t	00005928 }

l000058F4:
	{ r0 = memw(r29+84) }
	{ r1 = add(r0,00000004) }
	{ r0 = memw(r0) }
	{ memw(r21+56) = r0; if (!p0.new) r1 = memh(r21+60); if (p0.new) jump:t	00005920; p0 = tstbit(r0,00000000) }

l00005910:
	{ r0 = sub(00000000,r0); r1 = setbit(r1,00000004) }
	{ memw(r21+56) = r0; memuh(r21+60) = r1 }

l00005920:
	{ r18 = add(r18,00000001); jump	00005964 }

l00005928:
	{ r17 = memb(r18); call	00007998 }
	{ jump	0000593C }
00005934             32 50 00 5A                             2P.Z       

l00005938:
	{ r17 = memb(r18+1); r18 = r18 }

l0000593C:
	{ r0 = memb(r13+r17<<#1) }
	{ if (cmp.eq(r0.new,00000000)) jump:t	00005968; r0 = and(r0,00000020) }

l0000594C:
	{ if (cmp.eq(r0.new,r16)) jump:t	00005938 }

l00005954:
	{ r1 = memb(r18) }
	{ jump	00005938; r1 += add(r0,FFFFFFD0) }

l00005964:
	{ r0 = memb(r18) }

l00005968:
	{ if (!p0.new) memw(r21+48) = FFFFFFFF; p0 = cmp.eq(r0,0000002E); if (!p0.new) jump:t	0000599C }

l00005974:
	{ r0 = memb(r18+1) }
	{ if (!p0.new) memw(r21+48) = 00000000; p0 = cmp.eq(r0,0000002A); if (!p0.new) jump:t	000059A0 }

l00005984:
	{ r0 = memd(r29+84); r18 = add(r18,00000002) }
	{ r1 = add(r0,00000004) }
	{ memb(r21+12) = r0.new; r0 = memw(r0); jump	000059E4 }

l0000599C:
	{ jump	000059E4 }

l000059A0:
	{ r17 = memb(r18+1); call	00007998 }
	{ r0 = memb(r13+r17<<#1); r18 = add(r18,00000001); jump	000059C0 }
000059B4             F2 4F 00 5A                             .O.Z       

l000059B8:
	{ r17 = memb(r18+1); r18 = r18 }
	{ r0 = memb(r13+r17<<#1) }

l000059C0:
	{ if (cmp.eq(r0.new,00000000)) jump:t	000059E8; r0 = and(r0,00000020) }

l000059CC:
	{ if (cmp.eq(r0.new,r16)) jump:t	000059B8 }

l000059D4:
	{ r1 = memb(r18) }
	{ jump	000059B8; r1 += add(r0,FFFFFFD0) }

l000059E4:
	{ r1 = memb(r18); r0 = 00000030; call	000078D0 }

l000059E8:
	{ r1 = memb(r18); r0 = 00000030 }
	{ if (p0.new) memb(r21-2) = 00; if (!p0.new) r17 = add(r18,00000000); if (!p0.new) jump:t	00005A00; p0 = cmp.eq(r0,00000000) }

l000059FC:
	{ jump	00005A50; r9 = r10 }

l00005A00:
	{ memb(r21+62) = r0.new; r0 = memb(r17++#1) }
	{ if (p0.new) r0 = memb(r17); p0 = cmp.eq(r0,0000006C) }
	{ p0 = cmp.eq(r0,0000006C); if (p0.new) r17 = add(r18,00000002); if (!p0.new) jump:t	00005A50 }

l00005A20:
	{ memb(r21-2) = 71; nop; nop; jump	00005A50 }
00005A30 10 58 20 5C 00 4D 00 75 00 C0 31 43 0A 58 20 5C .X \.M.u..1C.X \
00005A40 51 60 12 74 00 CD 00 75 00 40 00 7F 62 DF 15 3C Q`.t...u.@..b..<

l00005A50:
	{ if (!cmp.gt(r0.new,00000000)) jump:t	00005A84; r0 = memw(r21+44) }

l00005A5C:
	{ r0 = add(r29,00000004) }
	{ r1 = memw(r29+84); call	00006BF0 }
	{ r2 = memb(r17); r0 = add(r29,00000060); r3 = add(r29,00000008); r1 = add(r29,00000004) }
	{ nop; jump	00005A8C }
00005A80 81 4A 1D B0                                     .J..           

l00005A84:
	{ r2 = memb(r17); r3 = add(r29,00000008); r0 = add(r29,00000060) }

l00005A8C:
	{ call	00005AD0 }
	{ if (!p0.new) jump:nt	00005AB8; p0 = cmp.eq(r0,00000000) }

l00005A94:
	{ r0 = add(r29,00000060); r1 = add(r29,00000008); call	00006320 }
	{  }
	{ jump	00005AB8 }

l00005AA4:
	{ if (p0.new) r0 = add(r29,00000060); if (!p0.new) jump:t	000057B8; p0 = cmp.eq(r0,00000001) }

l00005AAC:
	{ r20 = memw(r0+52) }
	{ jump	00005B40; r0 = r12 }

l00005AB8:
	{ r20 = FFFFFFFF }

l00005ABC:
	{ jump	00005B1C; r0 = r12 }
00005AC4             00 C0 00 7F 00 C0 00 7F 00 C0 00 7F     ............

;; _Putfld: 00005AD0
;;   Called from:
;;     00005A8C (in _Printf)
_Putfld proc
	{ allocframe(00000010); memd(r29+496) = r17:r16; r16 = r0; p0 = cmp.gtu(r2,00000040) }
	{ if (p0) jump:nt	00005B00 }

l00005AE0:
	{ if (p0.new) r0 = memw(r16+20); p0 = cmp.eq(r2,00000025); if (!p0.new) jump:t	00005C48 }

l00005AEC:
	{ r0 = add(r3,r0); r1 = add(r0,00000001) }
	{ memb(r0) = 25; jump	00005CFC }

l00005B00:
	{ p0 = cmp.gtu(r2,00000052); if (p0.new) jump:t	00005B60 }

l00005B08:
	{ if (cmp.gtu(r0.new,0000000D)) jump:t	00005C4C; r0 = add(r2,FFFFFFBF) }

l00005B14:
	{ if (cmp.eq(r0.new,00000001)) jump:nt	00005C4C; r0 = and(r0,00000071) }

;; fn00005B1C: 00005B1C
;;   Called from:
;;     00005ABC (in _Printf)
;;     00005AF8 (in _Putfld)
;;     00005B08 (in _Putfld)
;;     00005C48 (in _Putfld)
fn00005B1C proc
	{ if (!tstbit(r0.new,-00000001)) jump:nt	00005C7C; r0 = memw(r16+44) }

l00005B20:
	{ if (!tstbit(r0.new,-00000001)) jump:nt	00005C7C }

;; fn00005B24: 00005B24
;;   Called from:
;;     00005B4C (in fn00005B40)
;;     00005B4C (in fn00005B40)
;;     00005B54 (in fn00005B54)
;;     00005CFC (in fn00005B1C)
;;     00005ED4 (in _Putfld)
fn00005B24 proc
	{ r0 = memw(r1) }

;; fn00005B28: 00005B28
;;   Called from:
;;     00005B1C (in fn00005B1C)
;;     00005B24 (in fn00005B24)
fn00005B28 proc
	{ r0 = add(r0,00000007) }
	{ r0 = and(r0,FFFFFFF8) }
	{ memb(r1) = r4.new; r4 = add(r0,00000008) }
	{ r5:r4 = memd(r0) }

;; fn00005B40: 00005B40
;;   Called from:
;;     00005AB0 (in _Printf)
;;     00005B3C (in fn00005B28)
fn00005B40 proc
	{ memd(r16) = r5:r4; p0 = cmp.gt(r6,00000000); r0 = add(r6,FFFFFFFF) }
	{ memw(r16+44) = r0; if (p0) jump:nt	00005B24 }

;; fn00005B54: 00005B54
;;   Called from:
;;     00005B4C (in fn00005B40)
;;     00005B4C (in fn00005B40)
;;     00005C7C (in fn00005C7C)
;;     00005C7C (in fn00005C7C)
fn00005B54 proc
	{ r1:r0 = combine(r5,r4) }
	{ jump	00005C80; r1:r0 = lsr(r1:r0,00000030) }

l00005B60:
	{ p0 = cmp.gtu(r2,00000057); if (p0.new) r0 = add(r2,FFFFFFA8); if (p0.new) jump:t	00005B8C }

l00005B6C:
	{ p0 = cmp.eq(r2,00000053); if (p0.new) r2 = add(r16,0000002C); if (!p0.new) jump:t	00005C48 }

l00005B78:
	{ memb(r16-2) = 6C; r3 = memw(r16+44); r0 = 00000000 }
	{  }
	{ jump	00005EC4 }

l00005B8C:
	{ p0 = cmp.gtu(r0,00000020); if (p0.new) jump:t	00005C48 }

l00005B94:
	{ r4 = memw(gp+120) }
	{ r0 = memw(r14+r0<<#2) }
	{ jumpr	r0 }
00005BA0 60 41 90 91 42 C0 C2 26 C0 C7 30 91 0A 58 20 5C `A..B..&..0..X \
00005BB0 20 4E 00 75 00 C0 81 43 1A 40 00 58 E0 C0 00 B0  N.u...C.@.X....
00005BC0 10 58 20 5C 80 4D 00 75 00 40 81 43 04 C0 81 47 .X \.M.u.@.C...G
00005BD0 84 40 00 B0 00 D2 A1 A1 1A 40 00 58 00 C0 80 91 .@.......@.X....
00005BE0 10 58 20 5C E0 60 04 74 40 CD 00 75 00 FF 20 76 .X \.`.t@..u.. v
00005BF0 04 41 00 B0 00 D2 A1 A1 0C 40 00 58 04 C0 C0 91 .A.......@.X....
00005C00 80 40 04 B0 00 D2 A1 A1 00 C0 84 91 04 E0 20 73 .@............ s
00005C10 60 41 90 91 00 C4 D0 A1 C8 60 B0 10 E4 7F E0 BF `A.......`......
00005C20 0B D2 B0 A1 C0 C7 30 91 C0 58 00 5C E0 CC 80 75 ......0..X.\...u
00005C30 74 78 20 5C 40 4C 00 75 00 C0 D0 43 C4 C2 C0 49 tx \@L.u...C...I
00005C40 00 44 E0 D3 6A C1 00 58                         .D..j..X       

l00005C48:
	{ r0 = memw(r16+20); p0 = cmp.eq(r2,00000000) }

l00005C4C:
	{ r0 = add(r3,r0); r1 = add(r0,00000001) }
	{ memb(r0) = 25; if (p0) jump:nt	00005CFC }

l00005C60:
	{ r0 = memw(r16+20) }
	{ r0 = add(r3,r0); r1 = add(r0,00000001) }
	{ memb(r0) = r2; jump	00005CFC }
00005C78                         60 C0 50 91                     `.P.   

;; fn00005C7C: 00005C7C
;;   Called from:
;;     00005B1C (in fn00005B1C)
;;     00005B24 (in fn00005B24)
fn00005C7C proc
	{ if (!tstbit(r0.new,-00000001)) jump:nt	00005CB4; r0 = sxth(r0) }

l00005C80:
	{ if (!tstbit(r0.new,-00000001)) jump:nt	00005CB4 }

l00005C88:
	{ if (cmp.eq(r0.new,00000000)) jump:nt	00005CD4; r0 = and(r1,00000002); p0 = tstbit(r1,00000000) }

l00005C98:
	{ r1 = memw(r16+20) }
	{ memb(r16+5) = r4.new; r1 = add(r3,r1); r4 = add(r1,00000001) }
	{ memb(r1) = 2B }
	{ r1 = memw(r16+20); r0 = add(r16,00000014) }

l00005CB4:
	{ r1 = memw(r16+20) }

l00005CB8:
	{ memb(r16+5) = r4.new; r1 = add(r3,r1); r4 = add(r1,00000001) }
	{ memb(r1) = 2D }
	{ if (p0) r1 = memw(r16+20); r0 = add(r16,00000014); if (!p0) jump:nt	00005CE8 }

l00005CD4:
	{ if (p0) r1 = memw(r16+20) }

l00005CD8:
	{ memb(r16+5) = r4.new; r1 = add(r3,r1); r4 = add(r1,00000001) }

l00005CE8:
	{ r4 = memw(r0); r1:r0 = combine(r2,r16) }
	{ memb(r16+4) = r2.new; r2 = add(r3,r4); call	00007AD0 }

l00005CFC:
	{ r1 = 00000000 }

l00005D00:
	{ dealloc_return; r17:r16 = memd(r29+8); r0 = r1 }
00005D08                         60 41 90 91 42 C0 C2 26         `A..B..&
00005D10 C0 C7 30 91 0A 58 20 5C 20 4E 00 75 00 C0 81 43 ..0..X \ N.u...C
00005D20 1A 40 00 58 E0 C0 00 B0 10 58 20 5C 80 4D 00 75 .@.X.....X \.M.u
00005D30 00 40 81 43 04 C0 81 47 84 40 00 B0 00 D2 A1 A1 .@.C...G.@......
00005D40 1A 40 00 58 00 C0 80 91 10 58 20 5C E0 60 04 74 .@.X.....X \.`.t
00005D50 40 CD 00 75 00 FF 20 76 04 41 00 B0 00 D2 A1 A1 @..u.. v.A......
00005D60 0C 40 00 58 04 C0 C0 91 80 40 04 B0 00 D2 A1 A1 .@.X.....@......
00005D70 00 C0 84 91 04 C0 40 84 60 41 90 91 00 C4 D0 A1 ......@.`A......
00005D80 C8 60 B0 10 E4 7F E0 BF 0B D2 B0 A1 C0 C7 30 91 .`............0.
00005D90 A6 58 00 5C E0 CC 80 75 56 78 20 5C 50 41 00 58 .X.\...uVx \PA.X
00005DA0 40 4C 00 75 00 C0 10 43 08 48 00 5C 40 CF 00 75 @L.u...C.H.\@..u
00005DB0 A8 58 20 5C 80 CE 00 75 84 01 80 00 AC C0 01 16 .X \...u........
00005DC0 C2 47 30 91 60 C1 90 91 DC 58 20 5C 02 60 00 7E .G0.`....X \.`.~
00005DD0 80 CD 02 75 10 C1 C0 11 00 C0 81 91 82 40 00 B0 ...u.........@..
00005DE0 00 D2 A1 A1 02 00 83 0B F8 60 B3 10 E0 7F E3 BF .........`......
00005DF0 0B D2 B0 A1 01 40 1D B0 00 40 70 70 02 28 03 6C .....@...@pp.(.l
00005E00 03 42 C3 8C 7F E6 50 3C 60 40 00 58 00 C0 43 3C .B....P<`@.X..C<
00005E10 C0 C7 30 91 D4 58 00 5C E0 CC 80 75 7C 78 20 5C ..0..X.\...u|x \
00005E20 40 CC 00 75 00 C0 81 91 82 40 00 B0 00 D2 A1 A1 @..u.....@......
00005E30 00 00 82 0B F8 60 B2 10 E3 7F E2 BF 0B D3 B0 A1 .....`..........
00005E40 5E 7F FF 59 A1 41 90 91 00 C3 A0 A1 04 40 00 7C ^..Y.A.......@.|
00005E50 60 41 90 91 16 C0 C2 26 00 C0 81 91 82 40 00 B0 `A.....&.....@..
00005E60 00 D2 A1 A1 00 00 82 0B F8 60 B2 10 E4 7F E2 BF .........`......
00005E70 0B D2 B0 A1 04 E0 20 73 00 6F 30 73 A2 40 90 91 ...... s.o0s.@..
00005E80 00 C4 D0 A1 AC 41 00 58 02 C2 03 F3 C2 47 30 91 .....A.X.....G0.
00005E90 60 C1 90 91 BC 58 20 5C 82 65 10 74 80 CD 02 75 `....X \.e.t...u
00005EA0 12 41 C0 11 00 C0 00 78 00 C0 81 91 83 40 00 B0 .A.....x.....@..
00005EB0 00 D3 A1 A1 00 00 23 00 F8 60 B3 10 E4 7F E3 BF ......#..`......
00005EC0 00 D2 A2 A1                                     ....           

l00005EC4:
	{ r1:r0 = combine(r0,r16) }
	{ call	00006200 }
	{ p0 = cmp.gt(r0,FFFFFFFF); r1 = FFFFFFFF }
	{ if (p0) r1 = 00000000; jump	00005D00 }
00005EDC                                     AE 48 00 5C             .H.\
00005EE0 00 4D 00 75 00 C0 50 43 08 58 00 5C 80 CE 00 75 .M.u..PC.X.\...u
00005EF0 AA 58 20 5C 40 CF 00 75 A0 40 00 58 00 C0 90 91 .X \@..u.@.X....
00005F00 0C 58 20 5C 00 4D 00 75 00 C0 D0 43 E4 C2 C0 49 .X \.M.u...C...I
00005F10 00 C4 E0 D3 00 C0 D0 A1 04 40 00 7C 80 C7 30 91 .........@.|..0.
00005F20 00 41 00 76 24 C0 02 24 00 C0 D0 91 00 44 80 D2 .A.v$..$.....D..
00005F30 1E C8 00 5C 00 C5 C2 8C 18 48 20 5C 00 4F 00 75 ...\.....H \.O.u
00005F40 A1 C0 90 43 00 41 03 F3 21 40 01 B0 05 D3 B0 A1 ...C.A..!@......
00005F50 30 C0 00 3C A0 C0 90 91 21 40 00 B0 00 40 03 F3 0..<....!@...@..
00005F60 05 D5 B0 A1 00 C2 00 A1 A0 C0 90 91 00 40 03 F3 .............@..
00005F70 04 D2 B0 A1 CE 50 00 5A 00 D0 02 F5 C0 FE FF 59 .....P.Z.......Y
00005F80 12 41 C0 11 00 C0 00 78 00 C0 81 91 82 40 00 B0 .A.....x.....@..
00005F90 00 D2 A1 A1 00 00 82 0B F8 60 B2 10 E4 7F E2 BF .........`......
00005FA0 0B D2 B0 A1 A1 C0 90 91 22 40 01 B0 01 41 03 F3 ........"@...A..
00005FB0 05 D4 B0 A1 A4 7E FF 59 00 C0 01 A1 64 58 00 5C .....~.Y....dX.\
00005FC0 20 CF 80 75 80 58 00 5C 60 CE 80 75 90 58 00 5C  ..u.X.\`..u.X.\
00005FD0 00 CE 80 75 B4 48 00 5C 00 CD 00 75 C4 58 00 5C ...u.H.\...u.X.\
00005FE0 40 CD 00 75 98 58 20 5C 80 CD 00 75 00 C0 81 91 @..u.X \...u....
00005FF0 82 40 00 B0 00 D2 A1 A1 00 00 82 0B F8 60 B2 10 .@...........`..
00006000 E3 7F E2 BF 0B D3 B0 A1 94 C0 00 58 C2 41 C0 11 ...........X.A..
00006010 80 C0 90 47 00 C0 81 91 82 40 00 B0 00 D2 A1 A1 ...G.....@......
00006020 00 00 82 0B 00 40 42 75 80 04 23 73 F4 60 DF 5C .....@Bu..#s.`.\
00006030 0B C3 90 A1 AE C0 00 58 00 C0 40 84 06 40 00 58 .......X..@..@.X
00006040 00 C0 D0 A1 00 C0 D0 91 E4 FF 7F 7C 40 44 80 D2 ...........|@D..
00006050 30 48 20 5C 80 62 90 74 C1 C3 70 43 00 40 01 85 0H \.b.t..pC.@..
00006060 40 40 01 76 AC C0 02 24 80 42 10 B0 A1 C0 90 91 @@.v...$.B......
00006070 24 40 01 B0 01 41 03 F3 05 D4 B0 A1 AA 40 00 58 $@...A.......@.X
00006080 2B C0 01 3C 48 58 20 5C 40 CF 00 75 00 C0 81 91 +..<HX \@..u....
00006090 82 40 00 B0 00 D2 A1 A1 00 00 82 0B F8 60 B2 10 .@...........`..
000060A0 E3 7F E2 BF 0B D3 B0 A1 44 C0 00 58 A1 C0 90 91 ........D..X....
000060B0 24 40 01 B0 01 41 03 F3 05 D4 B0 A1 8A 40 00 58 $@...A.......@.X
000060C0 2D C0 01 3C 28 58 20 5C 80 CE 00 75 00 C0 81 91 -..<(X \...u....
000060D0 82 40 00 B0 00 D2 A1 A1 00 00 82 0B F8 60 B2 10 .@...........`..
000060E0 E3 7F E2 BF 0B D3 B0 A1 24 C0 00 58 14 58 20 5C ........$..X.X \
000060F0 20 CE 00 75 00 C0 81 91 82 40 00 B0 00 D2 A1 A1  ..u.....@......
00006100 00 00 82 0B F8 60 B2 10 E3 7F E2 BF 0B D3 B0 A1 .....`..........
00006110 38 C0 00 58 00 C0 81 91 82 40 00 B0 00 D2 A1 A1 8..X.....@......
00006120 00 00 82 0B F8 60 B2 10 E3 7F E2 BF 0B D3 B0 A1 .....`..........
00006130 E6 7D FF 59 A1 41 90 91 00 D3 A0 A1 00 C0 81 91 .}.Y.A..........
00006140 82 40 00 B0 00 D2 A1 A1 00 00 82 0B F8 60 B2 10 .@...........`..
00006150 E3 7F E2 BF 0B D3 B0 A1 D2 7D FF 59 A1 41 90 91 .........}.Y.A..
00006160 00 CB A0 A1 00 C0 81 91 82 40 00 B0 00 D2 A1 A1 .........@......
00006170 00 00 82 0B F8 60 B2 10 E3 7F E2 BF 0B D3 B0 A1 .....`..........
00006180 A1 C1 90 91 02 C0 41 84 BA 7D FF 59 00 C2 C0 A1 ......A..}.Y....
00006190 01 40 00 78 82 41 90 91 2C C0 C2 26 DA C8 00 5A .@.x.A..,..&...Z
000061A0 2A 40 00 10 81 C0 90 47 AA 7D FF 59 00 40 21 F3 *@.....G.}.Y.@!.
000061B0 07 D2 B0 A1 0E 40 20 5C 80 42 10 B0 A1 C0 90 41 .....@ \.B.....A
000061C0 24 40 01 B0 01 41 03 F3 05 D4 B0 A1 20 C0 01 3C $@...A...... ..<
000061D0 00 50 02 F5 04 C0 80 91 02 C4 03 F3 9A 4F 00 5A .P...........O.Z
000061E0 04 C2 90 A1 8C FD FF 59 7C CA 00 5A 88 7D FF 59 .......Y|..Z.}.Y
000061F0 07 C0 90 A1 84 7D FF 59 80 41 90 91 07 D2 B0 A1 .....}.Y.A......

;; _Putstr: 00006200
;;   Called from:
;;     00005EC8 (in _Putfld)
_Putstr proc
	{ allocframe(+00000070); call	0000A278 }
	{ r23:r22 = combine(00000000,00000000); r18 = r1; r17 = r0 }
	{ r19 = memw(r17+24); r20 = memw(r17+16); call	000066B0 }
	{ memd(r29) = r23:r22; r19 = add(r19,r0); r22 = 00000040; r16 = add(r29,00000010) }
	{ r1 = memb(r17+60) }
	{ r1 = and(r1,00000004) }
	{ r1 = 00000041 }
	{ r22 = r19; r0 = r19; r21 = FFFFFFFF; call	00007220 }
	{ if (cmp.eq(r16.new,00000000)) jump:nt	00006314; r16 = r0 }

l00006250:
	{ r0 = 7FFFFFFF }
	{ r23 = mux(p0,r20,r0) }
	{ r21 = -00000001; r19 = 00000000 }
	{ r1 = memw(r18); r0 = add(r29,00000008); r2 = add(r29,00000000); call	00006DF0 }
	{ if (!tstbit(r20.new,-00000001)) jump:nt	00006304; r20 = r0 }

l0000627C:
	{ if (!cmp.eq(r0.new,00000000)) jump:t	0000628C }

l00006284:
	{ if (!tstbit(r20.new,-00000001)) jump:nt	00006304 }

l0000628C:
	{ if (!p0.new) r0 = memw(r17+20) }
	{ r1 = add(r0,r20) }
	{ memw(r17+56) = 00000000; r1:r0 = combine(r16,r17); call	00006320 }
	{ r19 = r0 }
	{ memw(r17+20) = 00000000; r0 = 00000000 }
	{ r0 = add(r0,r16); r1 = add(r29,00000008); r2 = r20; call	000073E0 }
	{ r0 = memw(r17+20) }
	{ memb(r17+5) = r0.new; r0 = add(r0,r20) }
	{ if (cmp.eq(r0.new,00000000)) jump:nt	000062E4; r0 = memw(r18) }

l000062D8:
	{  }
	{ r21 = r19; if (!p0.new) jump:t	00006300; p0 = cmp.eq(r11,00000000) }

l000062E4:
	{ r1:r0 = combine(r16,r17); call	00006320 }
	{ r21 = r0 }
	{ if (p0.new) memw(r17+20) = 00000000; if (p0.new) memw(r17+56) = 00000000; if (p0.new) r21 = 00000000; p0 = cmp.eq(r21,00000000) }

l00006300:
	{ if (cmp.eq(r0.new,r16)) jump:nt	00006314; r0 = add(r29,00000010) }

l00006304:
	{ if (cmp.eq(r0.new,r16)) jump:nt	00006314 }

l0000630C:
	{ r0 = r16 }
	{ jump	000063D0; r0 = r13 }

l00006314:
	{ jump	000063D4; r0 = r13 }
00006318                         F4 CD 3B 17 00 C0 00 7F         ..;.....

;; _Puttxt: 00006320
;;   Called from:
;;     00005A94 (in _Printf)
;;     00006298 (in _Putstr)
;;     000062E4 (in _Putstr)
_Puttxt proc
	{ allocframe(+00000020); call	0000A278 }
	{ r17:r16 = combine(r1,r0) }
	{ r2 = memw(r16+20); r3 = memw(r16+24) }
	{ r4 = memw(r16+28); r0 = memw(r16+24); r3 = sub(r3,r2) }
	{ r0 = memw(r16+4); r3 = memw(r16); r5 = sub(r3,r0) }
	{ r5 = memuh(r16+60); r4 = sub(r5,r4) }
	{ r3 = memw(r16+40); r4 = sub(r4,r3) }
	{ r0 = sub(r4,r0) }
	{ r5 = and(r5,00000004); r20 = sub(r0,r3) }
	{ if (!p0.new) jump:t	000063A4; p0 = cmp.gt(r12,00000000) }

l00006364:
	{ r22 = r20; r21 = 00000020 }
	{ r19 = minu(r22,r21) }

l0000636C:
	{  }
	{ r3 = memw(r16+8); r0 = memw(r16+12); r1 = 0000D140 }
	{ r18 = -00000001; r2 = r19; callr	r3 }
	{ memw(r16+12) = r0; if (p0.new) jump:nt	0000654C; p0 = cmp.eq(r0,00000001) }

l0000638C:
	{ r0 = memw(r16+52) }
	{ memb(r16+13) = r0.new; r0 = add(r0,r19) }
	{ if (cmp.gt(r22.new,00000001)) jump:t	0000636C }

l000063A4:
	{ if (!p0.new) jump:nt	000063CC; p0 = cmp.gt(r2,00000000) }

l000063A8:
	{ r3 = memw(r16+8); r0 = memw(r16+12); r18 = FFFFFFFF; r1 = r17 }
	{ callr	r3 }
	{ memw(r16+12) = r0; if (p0.new) jump:nt	0000654C; p0 = cmp.eq(r0,00000001) }

l000063C0:
	{ r1 = memw(r16+20); r0 = memw(r16+20) }
	{ memb(r16+13) = r0.new; r0 = add(r0,r1) }

l000063CC:
	{ r19 = memw(r16+24); r21 = 00000020 }

;; fn000063D0: 000063D0
;;   Called from:
;;     00006310 (in _Putstr)
;;     000063CC (in _Puttxt)
fn000063D0 proc
	{ r19 = memw(r16+24) }

;; fn000063D4: 000063D4
;;   Called from:
;;     00006314 (in _Putstr)
fn000063D4 proc
	{  }

;; fn000063D8: 000063D8
;;   Called from:
;;     00006380 (in _Puttxt)
;;     000063BC (in _Puttxt)
;;     000063CC (in _Puttxt)
;;     000063D4 (in fn000063D4)
;;     000063D4 (in fn000063D4)
;;     000063D4 (in fn000063D4)
fn000063D8 proc
	{ r17 = minu(r19,r21) }
	{ r3 = memw(r16+8); r0 = memw(r16+12); r1 = 0000D168 }
	{ r18 = -00000001; r2 = r17; callr	r3 }
	{ memw(r16+12) = r0; if (p0.new) jump:nt	0000654C; p0 = cmp.eq(r0,00000001) }

l000063FC:
	{ r0 = memw(r16+52) }
	{ memb(r16+13) = r0.new; r0 = add(r0,r17) }
	{  }
	{ if (!cmp.gt(r2.new,00000000)) jump:nt	00006440; r2 = memw(r16+28) }

l0000641C:
	{ r1 = memw(r16+16); r0 = memw(r16+12) }
	{ r3 = memw(r16+8) }
	{ callr	r3 }
	{ memw(r16+12) = r0; if (p0.new) jump:nt	0000654C; p0 = cmp.eq(r0,00000001) }

l00006430:
	{ r1 = memw(r16+28); r0 = memw(r16+20) }
	{ memb(r16+13) = r0.new; r0 = add(r0,r1) }

l00006440:
	{ r19 = memw(r16+32) }
	{ r17 = minu(r19,r21) }
	{ r3 = memw(r16+8); r0 = memw(r16+12); r1 = 0000D168 }
	{ r18 = -00000001; r2 = r17; callr	r3 }
	{ memw(r16+12) = r0; if (p0.new) jump:nt	0000654C; p0 = cmp.eq(r0,00000000) }

l0000646C:
	{ r0 = memw(r16+52) }
	{ memb(r16+13) = r0.new; r0 = add(r0,r17) }
	{  }
	{ if (!cmp.gt(r2.new,00000000)) jump:nt	000064B4; r2 = memw(r16+36) }

l0000648C:
	{ r3 = memw(r16+28); r1 = memw(r16+16) }
	{ r3 = memw(r16+8); r0 = memw(r16+12); r1 = add(r1,r3) }
	{ callr	r3 }
	{ memw(r16+12) = r0; if (p0.new) jump:nt	0000654C; p0 = cmp.eq(r0,00000000) }

l000064A4:
	{ r1 = memw(r16+4); r0 = memw(r16+20) }
	{ memb(r16+13) = r0.new; r0 = add(r0,r1) }

l000064B4:
	{ r19 = memw(r16+40); nop }
	{ r17 = minu(r19,r21) }
	{ r3 = memw(r16+8); r0 = memw(r16+12); r1 = 0000D168 }
	{ r18 = -00000001; r2 = r17; callr	r3 }
	{ memw(r16+12) = r0; if (p0.new) jump:nt	0000654C; p0 = cmp.eq(r0,00000000) }

l000064E4:
	{ r0 = memw(r16+52) }
	{ memb(r16+13) = r0.new; r0 = add(r0,r17) }
	{  }
	{ r0 = memb(r16+60); p0 = cmp.gt(r20,00000000) }
	{ if (cmp.eq(r0.new,00000000)) jump:t	0000654C; r0 = and(r0,00000004) }

l0000650C:
	{ if (p0) r19 = 00000020 }
	{ r17 = minu(r20,r19) }

l00006514:
	{  }
	{ r3 = memw(r16+8); r0 = memw(r16+12); r1 = 0000D140 }
	{ r18 = -00000001; r2 = r17; callr	r3 }
	{ memw(r16+12) = r0; if (p0.new) jump:nt	0000654C; p0 = cmp.eq(r0,00000000) }

l00006534:
	{ r0 = memw(r16+52) }
	{ memb(r16+13) = r0.new; r0 = add(r0,r17) }
	{ if (cmp.gt(r20.new,00000001)) jump:t	00006514 }

l0000654C:
	{ jump	0000661C; r0 = r10 }
00006554             00 C0 00 7F 00 C0 00 7F 00 C0 00 7F     ............

;; _Tls_get__Mbcurmax: 00006560
;;   Called from:
;;     000066B0 (in _Getmbcurmax)
_Tls_get__Mbcurmax proc
	{ allocframe(00000010); memd(r29+496) = r17:r16; r1 = 00000001 }
	{ memd(r29) = r19:r18; r16 = 00000014 }
	{ r18 = 00010018 }

l00006578:
	{ r0 = memw_locked(r16) }
	{ p0 = cmp.gt(r0,00000000) }
	{ if (p0) jump:nt	0000658C }

l00006584:
	{ memw_locked(r16,p0) = r1 }
	{ if (!p0) jump:nt	00006578 }

l0000658C:
	{ if (p0.new) r17 = 00000002; if (!p0.new) jump:t	000065B0; p0 = cmp.eq(r0,00000000) }

l00006594:
	{ r1 = 00006FF0; r0 = 00010018 }
	{ call	0000B150 }
	{ memw(r16) = r17; nop }

l000065B0:
	{ if (!cmp.gt(r0.new,00000002)) jump:t	000065B4; r0 = memw(r16) }

l000065B4:
	{ if (!cmp.gt(r0.new,00000002)) jump:t	000065B4 }

l000065BC:
	{ r0 = memw(r18) }
	{ if (!cmp.eq(r16.new,00000000)) jump:t	00006600; r16 = r0; r1:r0 = combine(00000001,00000001) }

l000065D0:
	{  }
	{ if (p0.new) jump:nt	000065F8; p0 = cmp.eq(r9,00000000) }

l000065D8:
	{ r0 = memw(r18); r1 = r17; call	0000B224 }
	{ if (!p0.new) r0 = add(r17,00000000); if (p0.new) r16 = add(r17,00000000); if (p0.new) jump:nt	000065F4; p0 = cmp.eq(r0,00000000) }

l000065EC:
	{ call	00006FF0 }
	{ jump	000065F8 }

l000065F4:
	{ memb(r17) = 06 }

l000065F8:
	{ r19:r18 = memd(r29); r17:r16 = memd(r29+8); r0 = r16 }

l00006600:
	{ dealloc_return }

;; _Tls_get__Mbstate: 00006604
;;   Called from:
;;     000066BC (in _Getpmbstate)
;;     00006DF8 (in _Wctomb)
;;     00008F40 (in _Mbtowc)
_Tls_get__Mbstate proc
	{ allocframe(00000010); memd(r29+496) = r17:r16; r1 = 00000001 }
	{ r17 = 00010020; r16 = 0001001C }

;; fn0000661C: 0000661C
;;   Called from:
;;     0000654C (in fn000063D8)
;;     0000660C (in _Tls_get__Mbstate)
fn0000661C proc
	{ memd(r29) = r19:r18 }

;; fn00006620: 00006620
;;   Called from:
;;     0000661C (in fn0000661C)
;;     0000661C (in fn0000661C)
fn00006620 proc
	{ r0 = memw_locked(r16) }
	{ p0 = cmp.gt(r0,00000000) }
	{ if (p0) jump:nt	00006634 }

l0000662C:
	{ memw_locked(r16,p0) = r1 }
	{ if (!p0) jump:nt	00006620 }

l00006634:
	{ if (p0.new) r18 = 00000002; if (!p0.new) jump:t	00006654; p0 = cmp.eq(r0,00000000) }

l0000663C:
	{ r1 = 00006FF0; r0 = 00010020 }
	{ call	0000B150 }
	{ memw(r16) = r18 }

l00006654:
	{ if (!cmp.gt(r0.new,00000002)) jump:t	00006658; r0 = memw(r16) }

l00006658:
	{ if (!cmp.gt(r0.new,00000002)) jump:t	00006658 }

l00006660:
	{ r0 = memw(r17) }
	{ if (!cmp.eq(r16.new,00000000)) jump:t	000066AC; r16 = r0; r1:r0 = combine(00000040,00000001) }

l00006674:
	{ if (cmp.eq(r16.new,00000000)) jump:nt	000066A8; r16 = r0 }

l00006680:
	{ r0 = memw(r17); r1 = r16 }
	{ if (p0.new) jump:nt	00006694; p0 = cmp.eq(r0,00000000) }

l00006688:
	{ r0 = r16; r16 = 00000000; call	00006FF0 }
	{ jump	000066A4 }

l00006694:
	{ call	0000A380 }
	{ r2 = 00000040 }

l000066A4:
	{ r19:r18 = memd(r29); r17:r16 = memd(r29+8); r0 = r16 }

l000066A8:
	{ r19:r18 = memd(r29); r17:r16 = memd(r29+8) }

l000066AC:
	{ dealloc_return }

;; _Getmbcurmax: 000066B0
;;   Called from:
;;     00006210 (in _Putstr)
_Getmbcurmax proc
	{ allocframe(+00000000); call	00006560 }
	{ dealloc_return; r0 = memb(r0) }

;; _Getpmbstate: 000066BC
_Getpmbstate proc
	{ jump	00006604 }

;; _Stoulx: 000066C0
;;   Called from:
;;     00006894 (in _Stoul)
_Stoulx proc
	{ allocframe(00000040); p0 = cmp.eq(r3,00000000); call	0000A270 }
	{ memw(r29+8) = r3; r16 = r1; r19:r18 = combine(r2,r0); r4 = p0 }
	{ memw(r29+4) = r4; if (!p0) memw(r3) = 00000000; r22 = add(r18,FFFFFFFF) }
	{ r17 = memb(r22+1); call	00007998 }

l000066E4:
	{ r17 = memb(r22+1) }
	{ r0 = memuh(r13+r17<<#1); r22 = add(r22,00000001) }
	{ if (!cmp.eq(r0.new,00000001)) jump:t	000066E4; r0 = and(r0,00000144) }

l000066FC:
	{ r0 = memb(r1++#1) }
	{ p0 = cmp.eq(r0,0000002B); if (!p0.new) r21 = 0000002B; if (!p0.new) jump:t	00006714 }

l0000670C:
	{ r22 = r1; jump	00006720; r13 = r0 }

l00006714:
	{ if (p0.new) r22 = add(r1,00000000); p0 = cmp.eq(r0,0000002D) }
	{ if (p0) r21 = add(r0,00000000) }

l00006720:
	{ if (!p0.new) jump:t	00006730; p0 = tstbit(r11,00000000) }

l00006724:
	{ if (p0.new) jump:t	00006730; p0 = cmp.eq(r11,00000002) }

l00006728:
	{ p0 = cmp.gt(r19,00000024); if (!p0.new) jump:t	00006740 }

l00006730:
	{ r0 = 00000000; if (p0.new) jump:nt	00006890; p0 = cmp.eq(r8,00000001) }

l00006738:
	{ memw(r16) = r18; jump	0000A350 }

l00006740:
	{ if (!p0.new) jump:nt	00006768; p0 = cmp.gt(r11,00000000) }

l00006744:
	{ if (!p0.new) jump:t	00006788; p0 = cmp.eq(r11,00000000) }

l00006748:
	{ r0 = memb(r22); r19 = 00000010 }
	{ if (p0.new) r0 = memb(r22+1); p0 = cmp.eq(r0,00000030); if (!p0.new) jump:t	00006788 }

l00006758:
	{ r0 = setbit(r0,0000000A) }
	{ if (p0.new) r22 = add(r22,00000002); jump	0000678C; p0 = cmpb.eq(r0,78) }

l00006768:
	{ r0 = memb(r22); r19 = 0000000A }
	{ p0 = cmp.eq(r0,00000030); if (!p0.new) jump:t	00006788 }

l00006774:
	{ r0 = memb(r22+1); r19 = 00000008 }
	{ r0 = setbit(r0,0000000A) }
	{ if (p0.new) r19 = 00000010; if (p0.new) r22 = add(r22,00000002); p0 = cmpb.eq(r0,78) }

l00006788:
	{ r25 = r22; jump	00006794 }

l0000678C:
	{ r25 = r22 }

l00006790:
	{ r25 = add(r25,00000001) }

l00006794:
	{ r17 = memb(r25) }
	{ p0 = cmp.eq(r17,00000030); if (p0.new) jump:t	00006790 }

l000067A0:
	{ call	00006BD8 }
	{  }
	{ r2 = r19 }
	{ r1 = memh(r29+r17<<#1); r27:r26 = combine(0000D1D0,00000000); call	00007350 }
	{ if (cmp.eq(r20.new,00000000)) jump:nt	00006818; nop; r20 = r0; r24 = r25 }

l000067D4:
	{ r17 = memb(r24+1) }
	{  }
	{ r2 = r19; r3 = sub(r20,r27) }
	{ r1 = memh(r29+r17<<#1); r23 = and(r3,000000FF); r17 = r26; r24 = add(r24,00000001) }
	{ r26 = add(r23,mpyi(r26,r19)); call	00007350 }
	{ if (!cmp.eq(r20.new,00000001)) jump:t	000067D4; r20 = r0 }

l0000680C:
	{ r24 = r25; r23 = r26 }
	{ p0 = cmp.eq(r22,r24); if (!p0.new) r0 = sub(r24,r25); if (p0.new) jump:nt	00006880 }

l00006818:
	{ p0 = cmp.eq(r22,r24); if (!p0.new) r0 = sub(r24,r25) }

l00006820:
	{ r1 = memb(r19+0000D1F8) }
	{ if (!tstbit(r0.new,-00000001)) jump:nt	0000686C; r0 = sub(r0,r1) }

l00006834:
	{ if (!p0.new) r1 = add(r19,00000000) }
	{ if (cmp.gtu(r0.new,r26)) jump:t	0000684C; r0 = sub(r26,r23) }

l00006844:
	{ if (p0.new) jump:t	00006868; p0 = cmp.eq(r0,-00000001) }

l00006848:
	{ call	00006F10 }

l0000684C:
	{ memw(r0) = 00000022; r0 = memw(r29+4); r21 = 0000002B; r26 = FFFFFFFF }
	{ if (!p0.new) r0 = memw(r29+8); p0 = r0 }
	{ if (!p0) memw(r0) = 00000001 }

l00006868:
	{ p1 = cmp.eq(r16,00000000); r0 = sub(00000000,r26); p0 = cmp.eq(r21,0000002D) }

l0000686C:
	{ p1 = cmp.eq(r16,00000000); r0 = sub(00000000,r26) }

l00006874:
	{ if (!p0) r0 = add(r26,00000000); jump	00006890 }

l00006880:
	{ r0 = 00000000; if (p0.new) jump:nt	00006890; p0 = cmp.eq(r8,00000000) }

l00006888:
	{ memw(r16) = r18; jump	0000A350 }

l00006890:
	{ jump	0000A350 }

;; _Stoul: 00006894
;;   Called from:
;;     000051F0 (in atoi)
_Stoul proc
	{ jump	000066C0; r3 = 00000000 }
00006898                         00 C0 00 7F 00 C0 00 7F         ........

;; _Clearlocks: 000068A0
_Clearlocks proc
	{ allocframe(00000008); memd(r29+496) = r17:r16; nop; r0 = 00000000 }
	{ memb(gp+4) = r0; r17:r16 = combine(0000E8D4,00000020) }
	{ nop }

l000068C0:
	{ r0 = r16; r16 = add(r16,00000004); r17 = add(r17,FFFFFFFF); call	0000AF70 }
	{ if (!p0.new) jump:t	000068C0; p0 = cmp.eq(r25,00000001) }

l000068D0:
	{ r17:r16 = combine(0000E904,00000030); r0 = 00000000 }
	{ memb(gp+4) = r0 }

l000068E4:
	{ r0 = r16; r16 = add(r16,00000004); r17 = add(r17,FFFFFFFF); call	0000AF70 }
	{ if (!p0.new) jump:t	000068E4; p0 = cmp.eq(r25,00000001) }

l000068F4:
	{ dealloc_return; r17:r16 = memd(r29); nop; nop }

;; _Initlocks: 00006900
_Initlocks proc
	{ allocframe(00000008); memd(r29+496) = r17:r16; nop; r17:r16 = combine(0000E8D4,00000020) }

l00006910:
	{ r0 = r16; r16 = add(r16,00000004); r17 = add(r17,FFFFFFFF); call	0000AF60 }
	{ if (!p0.new) jump:t	00006910; p0 = cmp.eq(r25,00000001) }

l00006920:
	{ r17:r16 = combine(0000E904,00000030); r0 = 00000001 }
	{ memb(gp+4) = r0 }

l00006934:
	{ r0 = r16; r16 = add(r16,00000004); r17 = add(r17,FFFFFFFF); call	0000AF60 }
	{ if (!p0.new) jump:t	00006934; p0 = cmp.eq(r25,00000001) }

l00006944:
	{ r17:r16 = memd(r29); r0 = 00000001 }

;; _Lockfilelock: 00006958
;;   Called from:
;;     00005328 (in printf)
;;     00006944 (in _Initlocks)
;;     000070E0 (in fwrite)
;;     00007388 (in puts)
;;     00009214 (in fflush)
;;     000092E8 (in fputc)
;;     00009368 (in fputs)
_Lockfilelock proc
	{ allocframe(+00000018); call	0000A2C8 }
	{ r1 = 00000001; r20 = 0000002C; r16 = r0 }
	{ r19 = 00010024; r18 = 0000E8E0 }

l0000697C:
	{ r0 = memw_locked(r20) }
	{ p0 = cmp.gt(r0,00000000) }
	{ if (p0) jump:nt	00006990 }

l00006988:
	{ memw_locked(r20,p0) = r1 }
	{ if (!p0) jump:nt	0000697C }

l00006990:
	{ if (!p0.new) jump:t	000069E4; p0 = cmp.eq(r0,00000000) }

l00006994:
	{ r21 = 00000014; r17 = 00000020; nop }

l000069A0:
	{ r0 = r17; r17 = add(r17,00000004); r21 = add(r21,FFFFFFFF); call	0000AF60 }
	{ if (!p0.new) jump:t	000069A0; p0 = cmp.eq(r29,00000001) }

l000069B0:
	{ r21 = 00000004; r0 = 00000001; r17 = 0000E930 }
	{ memb(r19) = r0 }

l000069C0:
	{ r0 = r17; r17 = add(r17,00000004); r21 = add(r21,FFFFFFFF); call	0000AF60 }
	{ if (!p0.new) jump:t	000069C0; p0 = cmp.eq(r29,00000001) }

l000069D0:
	{ memb(gp+132) = r1.new; r1 = 00000002; r0 = 00000001 }

l000069E4:
	{ if (!cmp.gt(r0.new,00000002)) jump:t	000069E8; r0 = memw(r20) }

l000069E8:
	{ if (!cmp.gt(r0.new,00000002)) jump:t	000069E8 }

l000069F0:
	{ r1 = memb(r19); r0 = memb(r16+2) }
	{ p0 = r1 }
	{ r1 = mux(p0,00000014,00000000); r0 = addasl(r18,r0,00000002) }
	{ call	0000AEF0 }
	{ nop; jump	0000A360 }

;; _Unlockfilelock: 00006A10
;;   Called from:
;;     00005344 (in printf)
;;     000071F0 (in fwrite)
;;     000073CC (in puts)
;;     000092B4 (in fflush)
;;     00009354 (in fputc)
;;     00009454 (in fputs)
_Unlockfilelock proc
	{ allocframe(+00000000); if (p0.new) jump:nt	00006A40; p0 = cmp.eq(r0,00000000) }

l00006A18:
	{ r0 = memb(r0+2); r1 = memb(gp+36) }
	{ p0 = r1 }
	{ r1 = mux(p0,00000014,00000000) }
	{ r1 = 0000E8E0 }
	{ call	0000AF34; r0 = addasl(r1,r0,00000002) }

l00006A40:
	{ dealloc_return }

;; _Locksyslock: 00006A44
;;   Called from:
;;     00006F2C (in atexit)
;;     00007230 (in fn0000722C)
;;     00007230 (in fn0000722C)
;;     000078A0 (in signal)
;;     000090EC (in _Closreg)
;;     00009164 (in fclose)
;;     0000926C (in fflush)
_Locksyslock proc
	{ allocframe(+00000018); call	0000A2C8 }
	{ r1 = 00000001; r20 = 0000002C; r16 = r0 }
	{ r19 = 00010028; r18 = 0000E930 }

l00006A68:
	{ r0 = memw_locked(r20) }
	{ p0 = cmp.gt(r0,00000000) }
	{ if (p0) jump:nt	00006A7C }

l00006A74:
	{ memw_locked(r20,p0) = r1 }
	{ if (!p0) jump:nt	00006A68 }

l00006A7C:
	{ if (!p0.new) jump:t	00006AD4; p0 = cmp.eq(r0,00000000) }

l00006A80:
	{ r21 = 00000014; r17 = 00000020; nop; nop }

l00006A90:
	{ r0 = r17; r17 = add(r17,00000004); r21 = add(r21,FFFFFFFF); call	0000AF60 }
	{ if (!p0.new) jump:t	00006A90; p0 = cmp.eq(r29,00000001) }

l00006AA0:
	{ r21 = 00000004; r0 = 00000001; r17 = 0000E930 }
	{ memb(gp+4) = r0 }

l00006AB4:
	{ r0 = r17; r17 = add(r17,00000004); r21 = add(r21,FFFFFFFF); call	0000AF60 }
	{ if (!p0.new) jump:t	00006AB4; p0 = cmp.eq(r29,00000001) }

l00006AC4:
	{ memb(r19) = r0.new; r1 = 00000002; r0 = 00000001 }

l00006AD4:
	{ if (!cmp.gt(r0.new,00000002)) jump:t	00006AD8; r0 = memw(r20) }

l00006AD8:
	{ if (!cmp.gt(r0.new,00000002)) jump:t	00006AD8 }

l00006AE0:
	{ p0 = r0 }
	{ if (!cmp.gt(r16,r0.new)) jump:t	00006AF8; r0 = mux(p0,00000004,00000000) }

l00006AF0:
	{ call	0000AEF4 }
	{ jump	0000A360 }

;; _Unlocksyslock: 00006AF8
;;   Called from:
;;     00006AE4 (in _Locksyslock)
;;     00006F60 (in atexit)
;;     00007094 (in fn000070A0)
;;     00007340 (in fn00007240)
;;     000078B0 (in signal)
;;     000090FC (in _Closreg)
;;     000091C4 (in fclose)
;;     000091E0 (in fclose)
_Unlocksyslock proc
	{ allocframe(+00000000) }
	{ r1 = memb(gp+40) }
	{ p0 = r1 }
	{ r1 = mux(p0,00000004,00000000) }
	{ r1 = 0000E930 }
	{ call	0000AF34; r0 = addasl(r1,r0,00000002) }
	{ dealloc_return }
00006B24             00 C0 00 7F 00 C0 00 7F 00 C0 00 7F     ............

;; _Tls_get__Tolotab: 00006B30
;;   Called from:
;;     00006BD8 (in _Getptolower)
_Tls_get__Tolotab proc
	{ allocframe(00000010); memd(r29+496) = r17:r16; r1 = 00000001 }
	{ r17 = 00010034; r16 = 00010030 }
	{ memd(r29) = r19:r18 }

l00006B4C:
	{ r0 = memw_locked(r16) }
	{ p0 = cmp.gt(r0,00000000) }
	{ if (p0) jump:nt	00006B60 }

l00006B58:
	{ memw_locked(r16,p0) = r1 }
	{ if (!p0) jump:nt	00006B4C }

l00006B60:
	{ if (p0.new) r18 = 00000002; if (!p0.new) jump:t	00006B80; p0 = cmp.eq(r0,00000000) }

l00006B68:
	{ r1 = 00006FF0; r0 = 00010034 }
	{ call	0000B150 }
	{ memw(r16) = r18 }

l00006B80:
	{ if (!cmp.gt(r0.new,00000002)) jump:t	00006B84; r0 = memw(r16) }

l00006B84:
	{ if (!cmp.gt(r0.new,00000002)) jump:t	00006B84 }

l00006B8C:
	{ r0 = memw(r17) }
	{ if (!cmp.eq(r16.new,00000000)) jump:t	00006BD4; r16 = r0; r1:r0 = combine(00000004,00000001) }

l00006BA0:
	{ if (cmp.eq(r16.new,00000000)) jump:nt	00006BD0; r16 = r0 }

l00006BAC:
	{ r0 = memw(r17); r1 = r16 }
	{ if (p0.new) jump:nt	00006BC0; p0 = cmp.eq(r0,00000000) }

l00006BB4:
	{ r0 = r16; r16 = 00000000; call	00006FF0 }
	{ jump	00006BCC }

l00006BC0:
	{ memb(r16) = r0.new; r0 = 0000D222 }

l00006BCC:
	{ r19:r18 = memd(r29); r17:r16 = memd(r29+8); r0 = r16 }

l00006BD0:
	{ r19:r18 = memd(r29); r17:r16 = memd(r29+8) }

l00006BD4:
	{ dealloc_return }

;; _Getptolower: 00006BD8
;;   Called from:
;;     000067A0 (in _Stoulx)
_Getptolower proc
	{ allocframe(+00000000); call	00006B30 }
	{ dealloc_return; r0 = memw(r0) }
00006BE4             00 C0 00 7F 00 C0 00 7F 00 C0 00 7F     ............

;; _Vacopy: 00006BF0
;;   Called from:
;;     00005790 (in _Printf)
;;     00005A64 (in _Printf)
_Vacopy proc
	{ allocframe(00000008); r3 = r1; r2 = 00000004 }
	{ memw(r29+4) = r3; r1 = add(r29,00000004); call	000073E0 }
	{ dealloc_return }
00006C04             00 C0 00 7F 00 C0 00 7F 00 C0 00 7F     ............

;; _Wctombx: 00006C10
;;   Called from:
;;     00006E1C (in _Wctomb)
_Wctombx proc
	{ allocframe(+00000020); call	0000A278 }
	{ r20 = r4; r18 = r2; r17:r16 = combine(r1,r0) }
	{ r5 = memw(r3); p0 = cmp.eq(r16,00000000) }
	{ nop; if (p0) jump:nt	00006D24 }

l00006C34:
	{ r0 = memuh(r18+6); r21 = 00000000; nop; r19 = 00000000 }
	{ if (!p0.new) r0 = zxtb(r0); if (p0.new) jump:nt	00006D14; p0 = cmpb.gtu(r0,0F) }

l00006C4C:
	{ if (cmp.eq(r22.new,00000000)) jump:nt	00006D14; r22 = memw(r6+r0<<#2) }

l00006C58:
	{ if (p0.new) r21 = add(r21,00000001); if (!p0.new) jump:nt	00006D10; p0 = cmp.gt(r0,-00000001) }

l00006C60:
	{ p0 = cmp.gt(r21,00000FEF); if (!p0.new) r0 = zxtb(r17); if (p0.new) jump:nt	00006D10 }

l00006C70:
	{ r1 = memuh(r4+r0<<#1) }
	{ r2 = and(r1,000000FF); r3 = r17; r0 = and(r1,00008000) }
	{ p0 = cmp.eq(r0,00000000); r4 = and(r1,00001000); r3 = or(r2,and(r3,FFFFFF00)) }
	{ if (p0) r3 = add(r17,00000000); r5 = and(r1,00002000); p1 = cmp.eq(r4,00000000) }
	{ p0 = cmp.eq(r5,00000000); if (p1) r17 = add(r3,00000000); r4 = asl(r3,00000008); r0 = extractu(r1,00000004,0000000C) }
	{ r4 |= lsr(r3,00000018) }
	{ if (!p1) r17 = add(r4,00000000); if (p0) jump:nt	00006CE0 }

l00006CC0:
	{ p0 = cmp.eq(r2,00000000); r19 = r19; r21 = 00000000; r2 = add(r16,r19) }
	{ if (!p0) r3 = add(r1,00000000); if (p0) r3 = add(r17,00000000) }
	{ memb(r2) = r3; if (p0.new) jump:nt	00006CF0; p0 = cmpb.eq(r3,00) }

l00006CE0:
	{ r1 = and(r1,00004000) }
	{ memuh(r18+6) = r0; jump	00006D3C; r0 = r11 }

l00006CF0:
	{ memuh(r18+6) = r0; jump	00006D40; r0 = r11 }
00006CF8                         24 C0 08 10 00 50 00 78         $....P.x
00006D00 2A F1 42 21 00 C0 70 70 6C 40 00 58 08 D1 00 AB *.B!..ppl@.X....

l00006D10:
	{ r19 = FFFFFFFF; call	00006F10 }

l00006D14:
	{ r19 = FFFFFFFF }

l00006D18:
	{ memw(r0) = 00000058; jump	00006DB8; r0 = r11 }

l00006D24:
	{ memw(r18) = 00000000; memw(r18+4) = 00000000 }
	{ r0 = memw(r3) }
	{ r0 = memuh(r0) }
	{ r19 = and(r0,00000F00) }
	{ jump	00006D58; r0 = r11 }

l00006D3C:
	{ jump	00006D5C; r0 = r11 }

l00006D40:
	{ memw(r18+4) = 00000000; memw(r18) = 00000000; r19 = 00000000 }
	{ jump	00006E28; r0 = r11 }
00006D50 20 4B 11 8C 0A E0 42 24                          K....B$       

l00006D58:
	{  }

l00006D5C:
	{ jump	00006DAC; r1 = add(000000C2,asl(r1,0000000C)) }
00006D64             20 50 11 8C 0A E0 42 24 40 E0 11 73      P....B$@..s
00006D70 12 4C E1 DE 1C C0 00 58 20 55 11 8C 0A E0 42 24 .L.....X U....B$
00006D80 60 E0 11 73 12 72 E1 DE 12 C0 00 58 20 5A 11 8C `..s.r.....X Z..
00006D90 0A E0 42 24 80 E0 11 73 92 78 E1 DE 08 C0 00 58 ..B$...s.x.....X
00006DA0 A0 E0 11 73 D2 FE E1 DE 03 40 40 76             ...s.....@@v   

l00006DAC:
	{ memb(r16) = r1; r4 = -00000001; r1 = FFFFFFFA }
	{ r2 = add(r16,00000001); r1 += mpyi(r0,00000006); r3 = max(r3,r4) }

l00006DB8:
	{ r2 = add(r16,00000001); r1 += mpyi(r0,00000006) }
	{ r3 += add(r0,00000002); loop0(00006DC8,r0) }
	{ r1 = add(r1,FFFFFFFA); r0 &= asr(r17,r1) }
	{ r0 = and(r0,0000003F) }
	{ memb(r2++#1) = r0.new; r0 = setbit(r0,0000000E) }
	{ r19 = sub(r0,r16) }
	{ nop; jump	00006E54; r0 = r11 }

;; _Wctomb: 00006DF0
;;   Called from:
;;     00006264 (in _Putstr)
_Wctomb proc
	{ allocframe(00000010); memd(r29+496) = r17:r16; r17:r16 = combine(r2,r0) }
	{ memd(r29) = r19:r18; r18 = r1; call	00006604 }
	{ r19 = r0; r4 = 00000000; p0 = cmp.eq(r16,00000000) }
	{ if (p0) jump:nt	00006E1C }

l00006E14:
	{ call	00008F70 }
	{ r4 = r0 }

l00006E1C:
	{ r19:r18 = memd(r29); r17:r16 = memd(r29+8); r1:r0 = combine(r18,r16); r3:r2 = combine(r19,r17) }

l00006E28:
	{ deallocframe; jump	00006C10 }

;; abort: 00006E30
;;   Called from:
;;     000056D8 (in __registerx)
;;     00005728 (in __register_frame_info_bases)
;;     000095C4 (in _Atexit)
abort proc
	{ allocframe(00000000); r0 = 00000006; call	00007760 }
	{ r0 = 00000001; call	00006F70 }

;; calloc: 00006E40
;;   Called from:
;;     00006E38 (in abort)
calloc proc
	{ allocframe(00000008); memd(r29+496) = r17:r16; r17 = mpyi(r1,r0) }
	{ r0 = r17; call	00007220 }
	{ if (cmp.eq(r16.new,00000000)) jump:nt	00006E64; r16 = r0 }

;; fn00006E54: 00006E54
;;   Called from:
;;     00006DE4 (in _Wctombx)
fn00006E54 proc
	{ if (cmp.eq(r16.new,00000000)) jump:nt	00006E64 }

l00006E5C:
	{ r1:r0 = combine(00000000,00000000); r2 = r17 }
	{ dealloc_return; r17:r16 = memd(r29); r0 = r16 }

l00006E64:
	{ dealloc_return; r17:r16 = memd(r29) }
00006E68                         00 C0 00 7F 00 C0 00 7F         ........

;; _Tls_get__Errno: 00006E70
;;   Called from:
;;     00006F10 (in _Geterrno)
_Tls_get__Errno proc
	{ allocframe(00000010); memd(r29+496) = r17:r16; r1 = 00000001 }
	{ r17 = 0001003C; r16 = 00010038 }
	{ memd(r29) = r19:r18 }

l00006E8C:
	{ r0 = memw_locked(r16) }
	{ p0 = cmp.gt(r0,00000000) }
	{ if (p0) jump:nt	00006EA0 }

l00006E98:
	{ memw_locked(r16,p0) = r1 }
	{ if (!p0) jump:nt	00006E8C }

l00006EA0:
	{ if (p0.new) r18 = 00000002; if (!p0.new) jump:t	00006EC0; p0 = cmp.eq(r0,00000000) }

l00006EA8:
	{ r1 = 00006FF0; r0 = 0001003C }
	{ call	0000B150 }
	{ memw(r16) = r18 }

l00006EC0:
	{ if (!cmp.gt(r0.new,00000002)) jump:t	00006EC4; r0 = memw(r16) }

l00006EC4:
	{ if (!cmp.gt(r0.new,00000002)) jump:t	00006EC4 }

l00006ECC:
	{ r0 = memw(r17) }
	{ if (!cmp.eq(r16.new,00000000)) jump:t	00006F0C; r16 = r0; r1:r0 = combine(00000004,00000001) }

l00006EE0:
	{ if (cmp.eq(r16.new,00000000)) jump:nt	00006F08; r16 = r0 }

l00006EEC:
	{ r0 = memw(r17); r1 = r16 }
	{ if (p0.new) memw(r16) = 00000000; if (p0.new) jump:nt	00006F04; p0 = cmp.eq(r0,00000000) }

l00006EF8:
	{ r0 = r16; r16 = 00000000; call	00006FF0 }
	{ jump	00006F04 }

l00006F04:
	{ r19:r18 = memd(r29); r17:r16 = memd(r29+8); r0 = r16 }

l00006F08:
	{ r19:r18 = memd(r29); r17:r16 = memd(r29+8) }

l00006F0C:
	{ dealloc_return }

;; _Geterrno: 00006F10
;;   Called from:
;;     00006848 (in _Stoulx)
;;     00006D10 (in _Wctombx)
;;     000091E8 (in fclose)
;;     00009698 (in _Feraise)
;;     0000AFF8 (in __sys_close)
;;     0000B004 (in __sys_close)
;;     0000B078 (in __sys_remove)
;;     0000B084 (in __sys_remove)
;;     0000B10C (in __sys_sbrk)
;;     0000B2EC (in __sys_write)
;;     0000B2F8 (in __sys_write)
_Geterrno proc
	{ jump	00006E70 }
00006F14             00 C0 00 7F 00 C0 00 7F 00 C0 00 7F     ............

;; atexit: 00006F20
;;   Called from:
;;     000055E0 (in __libc_start_main)
atexit proc
	{ allocframe(00000008); memd(r29+496) = r17:r16; r0 = 00000001; r16 = r0 }
	{ call	00006A44 }
	{ r0 = memw(gp+12); r17 = FFFFFFFF }
	{ r1 = memw(gp+64) }
	{ call	00009020 }
	{ if (p0.new) jump:nt	00006F60; p0 = cmp.eq(r0,00000000) }

l00006F48:
	{ r0 = memw(gp+12) }
	{ r1 = memw(gp+8); r17 = 00000000; r0 = add(r0,FFFFFFFF) }
	{ memw(r30+r0<<#2) = r16; memw(gp) = r0 }

l00006F60:
	{ r0 = 00000001; call	00006AF8 }
	{ dealloc_return; r17:r16 = memd(r29); r0 = r17 }

;; exit: 00006F70
;;   Called from:
;;     000055F8 (in __libc_start_main)
;;     00006E38 (in abort)
;;     00007870 (in raise)
exit proc
	{ allocframe(00000008); memd(r29+496) = r17:r16; r16 = r0 }
	{ r2 = memw(gp+4) }
	{ r1 = memw(gp+12) }
	{ r0 = memw(gp+8); r2 = add(r1,00000001) }

l00006F88:
	{ r0 = memw(gp+8) }
	{ memw(gp+64) = r2; r0 = memw(r6+r1<<#2) }
	{ callr	r0 }
	{ r1 = memw(gp+12) }
	{ if (cmp.gtu(r0.new,r1)) jump:t	00006F88; r0 = memw(gp+4) }

l00006FA8:
	{ r1 = memw(gp+8); r0 = add(r0,FFFFFFFF) }
	{ memw(gp) = r0; r1 = memw(r22+r0<<#2) }

l00006FB4:
	{ memw(gp) = r0 }
	{ callr	r1 }
	{ if (!cmp.eq(r0.new,00000001)) jump:t	00006FB4; r0 = memw(gp+64); r17 = 0000E940 }

l00006FD0:
	{ if (cmp.eq(r0.new,r17)) jump:t	00006FDC }

l00006FD8:
	{  }

l00006FDC:
	{ memw(gp+544) = r17 }
	{ memw(gp+32) = r1; call	000079B0 }
	{ nop }
	{ nop }

;; free: 00006FF0
;;   Called from:
;;     0000575C (in __deregister_frame_info_bases)
;;     000065EC (in _Tls_get__Mbcurmax)
;;     00006688 (in fn00006620)
;;     00006BB4 (in _Tls_get__Tolotab)
;;     00006EF8 (in _Tls_get__Errno)
;;     00006FEC (in exit)
;;     00007974 (in _Tls_get__Ctype)
;;     00008FF4 (in _Tls_get__Wcstate)
;;     00009090 (in _Atrealloc)
;;     000091A8 (in fclose)
;;     00009758 (in _Fofree)
;;     00009CC4 (in _Tls_get__Locale)
free proc
	{ allocframe(00000008); memd(r29+496) = r17:r16 }

;; fn00006FF4: 00006FF4
;;   Called from:
;;     00006FF0 (in free)
;;     00007214 (in dkw_malloc_init)
fn00006FF4 proc
	{ if (cmp.eq(r16.new,00000000)) jump:nt	000070A0; r16 = r0 }

;; fn00007000: 00007000
;;   Called from:
;;     00006FF4 (in fn00006FF4)
;;     00006FF4 (in fn00006FF4)
fn00007000 proc
	{ r1 = 00000008 }
	{ if (!cmp.eq(r0.new,00000000)) jump:t	000070A0; r0 = and(r0,00000007) }

l00007014:
	{ r0 = 00000001 }
	{ r1 = memw(gp+72); r0 = add(r16,FFFFFFF8) }
	{ if (!p0.new) jump:t	00007060; p0 = cmp.gtu(r1,r0) }

l00007028:
	{ memw(gp) = r0; memw(r16-4) = r1 }

l00007030:
	{ if (cmp.eq(r2.new,00000000)) jump:nt	00007098; r2 = memw(r0+4) }

l0000703C:
	{ r3 = add(r0,r1); r2 = 00000000 }
	{ memw(gp+64) = r2 }
	{ r2 = memw(r0+4) }
	{ r2 = memw(r2+4); r3 = memw(r2) }
	{ memw(r0+4) = r2; r1 = add(r1,r3) }
	{ memw(r0) = r1; jump	00007094 }

l00007060:
	{ r2 = r1 }
	{ r1 = memw(r2+4) }
	{ if (p0.new) jump:nt	00007070; p0 = cmp.eq(r1,00000000) }

l0000706C:
	{ if (p1.new) jump:t	00007060; p1 = cmp.gtu(r0,r1) }

l00007070:
	{ r3 = memw(r2) }
	{ if (cmp.gtu(r4.new,r0)) jump:t	00007098; r4 = add(r2,r3) }

l00007080:
	{ if (p0) jump:nt	000070B8 }

l00007084:
	{ r3 = memw(r16-8); r4 = r16 }
	{ r4 += add(r3,FFFFFFF8) }

l00007094:
	{ r0 = 00000001; call	00006AF8 }

l00007098:
	{ r0 = 00000001 }

l0000709C:
	{ dealloc_return; r17:r16 = memd(r29) }

;; fn000070A0: 000070A0
;;   Called from:
;;     00006FF4 (in fn00006FF4)
;;     00006FF4 (in fn00006FF4)
;;     00007014 (in fn00007000)
;;     0000702C (in fn00007000)
;;     00007078 (in fn00007000)
;;     0000708C (in fn00007000)
fn000070A0 proc
	{ r1 = memw(r16-8); r0 = r2 }
	{ r1 = add(r1,r3); jump	00007030 }
000070B4             BE 7F FF 59                             ...Y       

l000070B8:
	{ memw(r2+4) = r0; memw(r16-4) = r1 }

;; fwrite: 000070C0
;;   Called from:
;;     0000536C (in prout)
;;     000070B8 (in memcpy)
fwrite proc
	{ allocframe(+00000038); call	0000A2C0 }
	{ r19 = r0; r0 = 00000000; r17:r16 = combine(r3,r1) }
	{ r21 = mpyi(r2,r16) }
	{ r0 = r2; if (p0.new) jump:nt	00007208; p0 = cmp.eq(r8,00000001) }

l000070E0:
	{ r23 = r21; r0 = r17; call	00006958 }

l000070E8:
	{ r0 = memw(r17+16); r18 = r23 }
	{ r1 = memw(r17+24) }
	{ r0 = r17; r22 = 00000000; call	000079C0 }
	{ if (!p0.new) jump:t	000071C8; p0 = tstbit(r0,00000000) }

l00007100:
	{ r0 = memb(r17+1); r2 = r18; r3 = r18; p0 = or(p0,!p0) }
	{ if (cmp.eq(r0.new,00000000)) jump:t	00007154; r0 = and(r0,00000004); p1 = or(p0,p0); p0 = or(p0,!p0) }

l00007120:
	{ call	00007354; r3 = p0 }
	{ r1 = memd(r29+8); r3 = r18; p0 = cmp.eq(r0,00000000) }
	{ if (p0) jump:nt	0000714C; p1 = r1 }

l0000713C:
	{ r3 = add(r0,sub(00000041,r19)); p0 = and(p0,p0) }
	{ p1 = or(p0,p0) }
	{ r2 = memw(r17+24); r0 = memw(r17+16); r1 = r19; r5 = p1 }

l0000714C:
	{ r2 = memw(r17+24); r0 = memw(r17+16); r1 = r19 }

l00007154:
	{ memw(r29+8) = r5; r4 = sub(r2,r0) }
	{ p0 = cmp.gtu(r3,r4); r20 = minu(r3,r4) }
	{ r23 = sub(r18,r20); r2 = r20; r3 = p0 }
	{ call	000073E0 }
	{ r0 = memw(r17+16) }
	{ memb(r17+4) = r22.new; r0 = memw(r29+4); r22 = add(r0,r20) }
	{ if (!p0.new) r0 = memw(r29+8); if (p0.new) jump:t	000071B8 }

l00007194:
	{ if (!p0.new) r24 = memw(r17+8); if (!p0.new) r0 = add(r17,00000000); if (p0.new) jump:t	000071B8; p0 = r0 }

l000071A4:
	{ call	00009200 }
	{ r22 = sub(r22,r24); if (!p0.new) r18 = add(r23,00000000); if (!p0.new) jump:nt	000071C8; p0 = cmp.eq(r0,00000000) }

l000071B4:
	{ r19 = add(r19,r20); r18 = 00000000; r22 = 00000000; p0 = cmp.eq(r18,r20) }

l000071B8:
	{ r19 = add(r19,r20); r18 = 00000000; r22 = 00000000 }

l000071C0:
	{ if (!p0) jump:nt	000070E8 }

l000071C4:
	{ jump	000071C8 }

l000071C8:
	{ r0 = memb(r17+1); p0 = cmp.eq(r22,00000000) }
	{ if (cmp.eq(r0.new,00000000)) jump:t	000071F4; r0 = and(r0,00000008) }

l000071D8:
	{ r20 = memw(r17+8); r19 = memw(r17+16); r0 = r17; call	00009200 }
	{ p0 = cmp.eq(r0,00000000); r22 = sub(r19,r20) }
	{ if (p0) r22 = 00000000 }
	{ r17 = sub(r21,r18); r0 = r17; call	00006A10 }

l000071F4:
	{ r17 = sub(r21,r18); r0 = r17 }

l000071FC:
	{ r1 = r16; r0 = sub(r17,r22); call	0000A540 }

l00007208:
	{ jump	0000A354 }
0000720C                                     00 C0 00 7F             ....

;; dkw_malloc_init: 00007210
dkw_malloc_init proc
	{ r1 = add(r1,sub(00000041,r0)) }
	{ jump	00006FF4; r1 = lsr(r1,00000003) }

;; malloc: 00007220
;;   Called from:
;;     00006238 (in _Putstr)
;;     00006E48 (in calloc)
malloc proc
	{ allocframe(00000008); memd(r29+496) = r17:r16; r0 = 00000001; r16 = r0 }

;; fn00007224: 00007224
;;   Called from:
;;     00009030 (in _Atrealloc)
fn00007224 proc
	{ allocframe(00000008); memd(r29+496) = r17:r16; r0 = 00000001 }

;; fn0000722C: 0000722C
;;   Called from:
;;     00007220 (in malloc)
;;     00007224 (in fn00007224)
fn0000722C proc
	{ r1 = add(r16,0000000F) }
	{ r17 = and(r1,FFFFFFF8); call	00006A44 }
	{ if (p0.new) r0 = 00000008; if (!p0.new) jump:t	000072F8; p0 = cmp.gtu(r9,r8) }

;; fn00007240: 00007240
;;   Called from:
;;     00007238 (in fn0000722C)
;;     00007238 (in fn0000722C)
fn00007240 proc
	{ jump	00007254; r17 = maxu(r0,r17) }
00007248                         D4 7E FF 5B 00 C0 00 7F         .~.[....
00007250 01 44 00 00                                     .D..           

l00007254:
	{ r4 = memw(gp+68); r2 = 00000008 }
	{ r5 = r4; if (!p0.new) jump:t	00007280; p0 = cmp.eq(r4,00000000) }

l00007264:
	{ r0 = r2 }
	{ r1 = memw(r0) }
	{ r2 = r1 }
	{ r3 = memw(r2++#4) }
	{ jump	000072E0 }

l00007280:
	{ r0 = r5 }
	{ r1 = memw(r0) }
	{ r5 = r1 }
	{ r3 = memw(r5++#4) }
	{ jump	000072E0 }
0000729C                                     04 C0 84 91             ....
000072A0 00 C0 62 70 01 40 80 91 0C C4 03 20 02 C0 61 70 ..bp.@..... ..ap
000072B0 23 40 82 9B F8 F1 33 22 14 C0 00 58 80 C0 80 49 #@....3"...X...I
000072C0 90 C0 D1 D5 F6 43 00 5A 00 C0 70 70 BE 40 70 10 .....C.Z..pp.@p.
000072D0 00 E1 80 74 20 41 10 8C F6 E9 78 14 0E C0 00 58 ...t A....x....X

l000072E0:
	{ if (p0.new) jump:nt	000072F8; p0 = cmp.eq(r0,00000000) }

l000072E4:
	{ if (!cmp.gtu(r17,r2.new)) jump:t	00007304; r2 = add(r3,FFFFFFF8) }

l000072F0:
	{ memb(r0) = r2.new; r2 = memw(r1+4) }

;; fn000072F8: 000072F8
;;   Called from:
;;     00007238 (in fn0000722C)
;;     00007238 (in fn0000722C)
;;     000072E0 (in fn00007240)
fn000072F8 proc
	{ r0 = 00000001; jump	00007340; r8 = 00000000 }

l000072FC:
	{ r0 = 00000001 }
00007300 02 51 01 F3                                     .Q..           

l00007304:
	{ memb(r0) = r2.new }
	{  }
	{ r2 = memw(r0); r3 = memw(r1) }
	{ memb(r2) = r0.new; r0 = sub(r3,r17) }
	{ r3 = 00000000; if (p0.new) jump:nt	00007334; p0 = cmp.eq(r2,00000000) }

l00007328:
	{ r0 = memw(r2+4) }
	{ if (!p0.new) r3 = add(r2,00000004); p0 = cmp.eq(r0,00000000) }

l00007334:
	{ memw(gp+96) = r3; r16 = add(r1,00000008); r0 = 00000001 }

l00007340:
	{ call	00006AF8 }
	{ dealloc_return; r17:r16 = memd(r29); r0 = r16 }
0000734C                                     00 C0 00 7F             ....

;; memchr: 00007350
;;   Called from:
;;     000058A0 (in _Printf)
;;     000067B0 (in _Stoulx)
;;     000067F8 (in _Stoulx)
memchr proc
	{ r3 = r0; r0 = 00000000; if (p0.new) jump:nt	00007374; p0 = cmp.eq(r2,00000000) }

;; fn00007354: 00007354
;;   Called from:
;;     00007120 (in fwrite)
fn00007354 proc
	{ r3 = r0; r0 = 00000000 }

;; fn00007358: 00007358
;;   Called from:
;;     00007350 (in memchr)
;;     00007354 (in fn00007354)
fn00007358 proc
	{ nop; r1 = and(r1,000000FF) }
	{ if (cmp.eq(r4.new,r1)) jump:nt	0000737C; r4 = memb(r3) }

l00007368:
	{ if (!cmp.eq(r2.new,00000001)) jump:t	00007368; r2 = add(r2,FFFFFFFF); r3 = add(r3,00000001) }

l0000736C:
	{ if (!cmp.eq(r2.new,00000001)) jump:t	00007368; r2 = add(r2,FFFFFFFF) }

l00007374:
	{ jumpr	r31 }

l00007378:
	{ jumpr	r31; r0 = r3 }

l0000737C:
	{ nop }

;; puts: 00007380
;;   Called from:
;;     0000737C (in memchr)
puts proc
	{ allocframe(00000010); memd(r29+496) = r17:r16; r16 = r0 }
	{ r0 = 0000E498; call	00006958 }
	{ call	00009360 }
	{ if (!p0.new) jump:t	000073C0; p0 = tstbit(r0,00000000); p1 = or(p1,!p1) }

l000073A8:
	{ r1:r0 = combine(0000E498,0000000A); call	000092E0 }
	{ p0 = cmp.gt(r0,FFFFFFFF) }
	{ p1 = not(p0) }
	{ r0 = 0000E498; r1 = p1 }

l000073C0:
	{ r0 = 0000E498 }

l000073CC:
	{ call	00006A10 }
	{ r17:r16 = memd(r29+8); r1 = memd(r29) }
	{ p0 = r1 }
	{ dealloc_return; r0 = mux(p0,FFFFFFFF,00000000) }

;; memcpy: 000073E0
;;   Called from:
;;     000062B0 (in _Putstr)
;;     00006BF8 (in _Vacopy)
;;     00007174 (in fwrite)
;;     00007B8C (in _Ldtob)
;;     00008270 (in _Litob)
;;     000088FC (in _LXp_movx)
;;     00008A40 (in fn00008A40)
;;     00008A78 (in fn00008A48)
;;     00008B10 (in _LXp_invx)
;;     00008B64 (in fn00008B64)
;;     00008B64 (in fn00008B64)
;;     00008CB4 (in fn00008CAC)
;;     00008CB4 (in fn00008CAC)
;;     00009880 (in _Genld)
;;     00009958 (in _Genld)
;;     000099A8 (in _Genld)
;;     00009A3C (in _Genld)
;;     0000A390 (in __hexagon_memcpy_likely_aligned_min32bytes_mult8bytes)
memcpy proc
	{ p1 = cmp.eq(r1,r0); p0 = cmp.gtu(r2,00000017); r14 = or(r1,r0); p2 = cmp.eq(r2,00000000) }

;; fn000073E4: 000073E4
;;   Called from:
;;     00009054 (in _Atrealloc)
;;     00009078 (in _Atrealloc)
;;     000093F0 (in fputs)
fn000073E4 proc
	{ p1 = cmp.eq(r1,r0); p0 = cmp.gtu(r2,00000017); r14 = or(r1,r0) }
	{ r14 = or(r14,r2); p3 = cmp.gtu(r2,0000005F); r9 = lsr(r2,00000003); p1 = or(p2,p1) }
	{ dcfetch(r1,00000000); if (p1) jumpr:nt	r31; p2 = bitsclr(r14,00000007) }
0000740C                                     02 42 63 6B             .Bck
00007410 4A 6A 00 5C 02 FF 42 74 36 60 20 5C FF 7F E8 71 Jj.\..Bt6` \...q
00007420 0F C0 40 76 FF 7F 68 72 A7 40 02 8C 05 44 01 B0 ..@v..hr.@...D..
00007430 03 C0 9D A0 B8 76 7F 71 4F 47 48 CC E9 40 01 76 .....v.qOGH..@.v
00007440 00 D0 DD A1 13 40 21 F3 00 40 3F 72 03 40 49 75 .....@!..@?r.@Iu
00007450 01 D2 DD A1 14 41 02 F3 07 49 02 F3 16 2A 2D 70 .....A...I...*-p
00007460 00 47 8F 85 EF 43 0F 76 05 44 05 B0 00 C0 05 94 .G...C.v.D......
00007470 04 42 2F F3 48 43 0F 8C F0 40 0F 76 01 FF 21 76 .B/.HC...@.v..!v
00007480 2F 43 0F 8C E3 43 04 76 11 4F 00 F3 F4 C0 14 76 /C...C.v.O.....v
00007490 03 40 54 75 75 C1 14 EF 15 C1 75 74 03 41 87 75 .@Tuu.....ut.A.u
000074A0 24 45 04 8C 05 44 05 B0 00 C0 05 94 01 40 0F 75 $E...D.......@.u
000074B0 2F 60 AF 74 05 44 05 B0 00 C0 05 94 01 40 04 75 /`.t.D.......@.u
000074C0 05 44 05 B0 0E 41 08 76 00 C0 05 94 05 44 05 B0 .D...A.v.....D..
000074D0 10 41 00 5C 22 40 04 75 00 C0 05 94 11 44 D1 74 .A.\"@.u.....D.t
000074E0 00 C0 D1 A0 F3 43 13 76 00 C0 D1 A0 26 40 00 5C .....C.v....&@.\
000074F0 02 40 49 85 4C 40 C1 9B 2A D8 C1 41 46 4A 0C C2 .@I.L@..*..AFJ..
00007500 00 43 08 85 09 D0 09 F3 46 4E 86 C3 00 44 08 85 .C......FN...D..
00007510 0E 42 08 76 08 E6 00 AB 46 4E 86 C3 00 45 08 85 .B.v....FN...E..
00007520 E2 40 89 75 08 E6 40 AB 4C 4A 0B FD 02 40 49 85 .@.u..@.LJ...@I.
00007530 2A 64 C1 9B 08 E6 80 AB 08 C0 AF 60 46 4A 0C C2 *d.........`FJ..
00007540 00 41 55 F2 0B E6 C0 AB 0C 8A 0B F5 2A E0 C1 9B .AU.........*...
00007550 03 40 84 75 E4 7F 64 74 03 E4 63 74 5E 40 04 12 .@.u..dt..ct^@..
00007560 0E 64 7F 7C 03 C3 93 75 30 C3 00 5C 18 40 04 60 .d.|...u0..\.@.`
00007570 20 40 84 75 08 C0 64 70 11 44 11 74 00 C0 05 94  @.u..dp.D.t....
00007580 03 48 04 F2 00 C0 D1 A0 A4 4E 04 D3 52 4A 0C C2 .H.......N..RJ..
00007590 2C 40 C1 9B 0F F2 C0 AB 46 4C 0A C2 2A 40 C1 9B ,@......FL..*@..
000075A0 08 C6 C0 AB 52 4A 0C C2 2C 40 C1 9B 08 D2 C0 AB ....RJ..,@......
000075B0 46 8C 0A C2 20 40 84 75 2A 40 C1 9B 08 C6 C0 AB F... @.u*@......
000075C0 2C 40 00 58 08 D2 C0 AB 18 40 04 60 20 40 84 75 ,@.X.....@.` @.u
000075D0 E8 FF E4 BF A4 4E 04 D3 11 44 11 74 00 C0 05 94 .....N...D.t....
000075E0 00 C0 D1 A0 46 4A 0C C2 2C 40 C1 9B 08 C6 C0 AB ....FJ..,@......
000075F0 46 4C 0A C2 2A 40 C1 9B 08 C6 C0 AB 46 4A 0C C2 FL..*@......FJ..
00007600 2C 40 C1 9B 08 C6 C0 AB 46 8C 0A C2 20 40 84 75 ,@......F... @.u
00007610 2A 40 C1 9B 08 C6 C0 AB 00 40 03 75 2F 43 03 8C *@.......@.u/C..
00007620 E4 C0 03 76 45 43 03 8C 00 40 5F 53 00 40 22 FB ...vEC...@_S.@".
00007630 03 C0 0F 75 00 42 03 85 12 43 00 5C 0E C4 05 76 ...u.B...C.\...v
00007640 08 C0 0F 60 46 4A 0C C2 03 41 55 F2 08 C6 C0 AB ...`FJ...AU.....
00007650 0C 8A 0B F5 2A E6 C1 9B 46 4E 86 C3 00 41 03 85 ....*...FN...A..
00007660 0E 42 05 76 08 E6 80 AB 46 4E 86 C3 00 40 03 85 .B.v....FN...@..
00007670 E2 7F 02 74 08 E6 40 AB 00 40 22 F3 00 40 9F 52 ...t..@..@"..@.R
00007680 00 C6 00 40 10 40 A2 60 E2 FF E2 BF 26 80 01 9B ...@.@.`....&...
00007690 0B E6 00 AB 00 40 22 F3 00 40 9F 52 00 C6 00 A1 .....@"..@.R....
000076A0 08 C0 A9 60 26 80 C1 9B 0B E6 C0 AB 00 40 22 F3 ...`&........@".
000076B0 00 40 9F 52 00 C6 C0 A1 54 C0 DD 91 04 1E 0D 3E .@.R....T......>
000076C0 1E C0 1E 90 00 C0 9F 52 00 C0 00 7F 00 C0 00 7F .......R........
000076D0 00 C0 00 7F 00 C0 00 7F 00 C0 00 7F 00 C0 00 7F ................

;; strlen: 000076E0
;;   Called from:
;;     000093B0 (in fputs)
;;     0000B034 (in __sys_remove)
;;     0000B048 (in __sys_remove)
strlen proc
	{ r4 = memb(r0); r2 = 00000000; if (!p1.new) jump:nt	00007734; p1 = bitsclr(r0,00000007) }

l000076EC:
	{ if (p0.new) jump:nt	00007728; p0 = cmp.eq(r4,00000000) }

l000076F0:
	{ if (!p0) r5:r4 = memd(r0+r2); nop; if (!p0) r2 = add(r2,00000008); r7:r6 = combine(00000000,00000000) }
	{ if (!p0.new) r5:r4 = memd(r0+r2); if (!p0.new) r2 = add(r2,00000008); if (!p0.new) jump:t	00007704; p0 = any8(vcmpb.eq(r5:r4,r7:r6)) }

l00007704:
	{ if (!p0.new) r5:r4 = memd(r0+r2); if (!p0.new) r2 = add(r2,00000008); if (!p0.new) jump:t	00007704 }

l00007710:
	{ p0 = vcmpb.eq(r5:r4,r7:r6) }
	{ r4 = p0 }
	{ r2 = add(r2,FFFFFFF8); r4 = ct0(r4) }
	{ jumpr	r31; r0 = add(r2,r4) }

l00007728:
	{ jumpr	r31; r0 = 00000000; nop }
00007730 01 42 00 F3                                     .B..           

l00007734:
	{ if (p1.new) jump:t	0000775C; p1 = cmp.eq(r4,00000000) }

l00007738:
	{ if (!p0.new) r4 = memb(r1+1); if (!p0.new) r2 = add(r2,00000001); if (!p0.new) jump:nt	00007734; p0 = bitsclr(r1,00000007) }

l00007748:
	{ r4 = memd(r12+r2); r2 = add(r2,00000008); jump	00007704; r7:r6 = combine(00000000,00000000) }
00007758                         C0 3F 20 50                     .? P   

l0000775C:
	{ nop }

;; raise: 00007760
;;   Called from:
;;     00006E30 (in abort)
;;     0000775C (in strlen)
raise proc
	{ allocframe(00000020); memd(r29+496) = r17:r16; r1 = 00000001 }
	{ memd(r29+16) = r19:r18; r16 = r0; r18 = FFFFFFFF; call	00007880 }
	{ r17 = r0 }
	{ if (!p0.new) jump:t	000077E4; p0 = cmp.eq(r9,00000000) }

l00007780:
	{ if (!cmp.gtu(r0.new,0000001A)) jump:nt	00007810; r1 = memw(gp+124); r0 = add(r16,FFFFFFFE) }

l00007790:
	{ r1:r0 = combine(66666642,00000027) }
	{ memb(r3+9) = 80; r2 = add(r3,00000008) }

l000077A0:
	{ r5 = add(r16,00000009); r4 = mpy(r16,r0) }
	{ p0 = cmp.gtu(r5,00000012); r3 = lsr(r4,0000001F) }
	{ r3 += asr(r4,r1) }
	{ r16 -= mpyi(r3,0000000A) }
	{ memb(r2++#-1) = r4.new; r16 = r3; r4 = add(r16,00000030); if (p0) jump:nt	000077A0 }

l000077CC:
	{ r1 = 0000E4E8; r0 = 00000003 }
	{ r17 = add(r2,00000001); call	00009360 }
	{ jump	00007850 }

l000077E4:
	{ r18 = 00000000; if (p0.new) jump:t	000077FC; p0 = cmp.eq(r9,00000002) }

l000077EC:
	{ r1:r0 = combine(00000000,00000000); r18 = 00000000; call	00007880 }
	{ callr	r17; r0 = r16 }

l000077FC:
	{ r19:r18 = memd(r29+16); r17:r16 = memd(r29+24); r0 = r18 }
	{ dealloc_return }
00007808                         51 43 00 00 91 43 00 78         QC...C.x

l00007810:
	{ r0 = memw(r30+r0<<#2) }
	{ jumpr	r0 }
00007818                         1C 40 00 58 52 43 00 00         .@.XRC..
00007820 71 C1 00 78 16 40 00 58 51 43 00 00 71 C6 00 78 q..x.@.XQC..q..x
00007830 10 40 00 58 51 43 00 00 51 C4 00 78 0A 40 00 58 .@.XQC..Q..x.@.X
00007840 52 43 00 00 11 C3 00 78 52 43 00 00 F1 C5 00 78 RC.....xRC.....x

l00007850:
	{ call	00009360 }
	{ r1 = 0000E4E8; r0 = 0000D4CC }
	{ call	00009360 }
	{ r0 = 00000001; call	00006F70 }
	{ nop }
	{ nop }

;; signal: 00007880
;;   Called from:
;;     00007768 (in raise)
;;     000077EC (in raise)
;;     0000787C (in raise)
signal proc
	{ allocframe(00000010); memd(r29+496) = r17:r16; r17:r16 = combine(r1,r0) }
	{ memd(r29) = r19:r18; r18 = -00000001; r0 = add(r16,FFFFFFFF) }
	{ p0 = cmp.gtu(r0,0000002A); if (p0.new) jump:t	000078BC }

l00007898:
	{ if (!p0.new) r0 = 00000001; if (p0.new) jump:t	000078BC; p0 = cmp.eq(r9,-00000001) }

l000078A0:
	{ call	00006A44 }
	{ r18 = memw(r16<<#2+0000EA80); r0 = 00000001 }
	{ memw(r16<<#2+0000EA80) = r17; call	00006AF8 }

l000078BC:
	{ r19:r18 = memd(r29); r17:r16 = memd(r29+8); r0 = r18 }
	{ dealloc_return }
000078C8                         00 C0 00 7F 00 C0 00 7F         ........

;; strchr: 000078D0
;;   Called from:
;;     000059E4 (in _Printf)
strchr proc
	{ r2 = and(r1,000000FF) }

l000078D4:
	{ r1 = memb(r0) }
	{ r1 = 00000000; r0 = add(r0,00000001); if (!p0.new) jump:t	000078D4; p0 = cmp.eq(r17,00000001) }

l000078E4:
	{ r0 = r1 }
	{ jumpr	r31 }
000078EC                                     00 C0 00 7F             ....

;; _Tls_get__Ctype: 000078F0
;;   Called from:
;;     00007998 (in _Getpctype)
_Tls_get__Ctype proc
	{ allocframe(00000010); memd(r29+496) = r17:r16; r1 = 00000001 }
	{ r17 = 00010050; r16 = 0001004C }
	{ memd(r29) = r19:r18 }

l0000790C:
	{ r0 = memw_locked(r16) }
	{ p0 = cmp.gt(r0,00000000) }
	{ if (p0) jump:nt	00007920 }

l00007918:
	{ memw_locked(r16,p0) = r1 }
	{ if (!p0) jump:nt	0000790C }

l00007920:
	{ if (p0.new) r18 = 00000002; if (!p0.new) jump:t	00007940; p0 = cmp.eq(r0,00000000) }

l00007928:
	{ r1 = 00006FF0; r0 = 00010050 }
	{ call	0000B150 }
	{ memw(r16) = r18 }

l00007940:
	{ if (!cmp.gt(r0.new,00000002)) jump:t	00007944; r0 = memw(r16) }

l00007944:
	{ if (!cmp.gt(r0.new,00000002)) jump:t	00007944 }

l0000794C:
	{ r0 = memw(r17) }
	{ if (!cmp.eq(r16.new,00000000)) jump:t	00007994; r16 = r0; r1:r0 = combine(00000004,00000001) }

l00007960:
	{ if (cmp.eq(r16.new,00000000)) jump:nt	00007990; r16 = r0 }

l0000796C:
	{ r0 = memw(r17); r1 = r16 }
	{ if (p0.new) jump:nt	00007980; p0 = cmp.eq(r0,00000000) }

l00007974:
	{ r0 = r16; r16 = 00000000; call	00006FF0 }
	{ jump	0000798C }

l00007980:
	{ memb(r16) = r0.new; r0 = 0000D4E2 }

l0000798C:
	{ r19:r18 = memd(r29); r17:r16 = memd(r29+8); r0 = r16 }

l00007990:
	{ r19:r18 = memd(r29); r17:r16 = memd(r29+8) }

l00007994:
	{ dealloc_return }

;; _Getpctype: 00007998
;;   Called from:
;;     00005830 (in _Printf)
;;     00005928 (in _Printf)
;;     000059A0 (in _Printf)
;;     000066E0 (in _Stoulx)
_Getpctype proc
	{ allocframe(+00000000); call	000078F0 }
	{ dealloc_return; r0 = memw(r0) }
000079A4             00 C0 00 7F 00 C0 00 7F 00 C0 00 7F     ............

;; _Exit: 000079B0
;;   Called from:
;;     00006FE0 (in exit)
_Exit proc
	{ allocframe(+00000000); call	0000AEB0 }
	{ nop }
	{ nop }

;; _Fwprep: 000079C0
;;   Called from:
;;     000070F4 (in fwrite)
;;     000079BC (in _Exit)
;;     000092FC (in fputc)
;;     00009390 (in fputs)
_Fwprep proc
	{ allocframe(00000008); memd(r29+496) = r17:r16; r16 = r0 }
	{ r1 = memw(r16+16) }
	{ if (!cmp.gtu(r0.new,r1)) jump:t	000079DC; r0 = memw(r16+24) }

l000079D8:
	{ r0 = memuh(r16) }

l000079DC:
	{ if (!cmp.eq(r2.new,00000004)) jump:t	00007A58; r2 = and(r0,00009002) }

l000079EC:
	{ r3 = and(r0,r2) }
	{ if (cmp.gtu(r2.new,r1)) jump:t	00007A14; r2 = memw(r16+12) }

l00007A00:
	{ r0 = r16 }
	{ r1 = FFFFFFFF; if (!p0.new) jump:t	00007A9C; p0 = cmp.eq(r0,00000000) }

l00007A0C:
	{ r0 = memh(r16) }
	{ if (!cmp.eq(r0.new,00000000)) jump:t	00007A8C; r0 = and(r0,00000800) }

l00007A14:
	{ if (!cmp.eq(r0.new,00000000)) jump:t	00007A8C; r0 = and(r0,00000000) }

l00007A20:
	{ if (!cmp.eq(r0.new,r17)) jump:t	00007A88; r0 = add(r16,0000004C) }

l00007A2C:
	{ r0 = 00000200 }
	{ memw(r16+8) = r0; if (p0.new) jump:nt	00007A74; p0 = cmp.eq(r0,00000000) }

l00007A38:
	{ memw(r16+16) = r0; r1 = memh(r16); r2 = add(r0,00000200) }
	{ memw(r16+48) = r0; memw(r16+52) = r0; r0 = setbit(r1,0000000C) }
	{ memuh(r16+8) = r0; memw(r16+12) = r2; jump	00007A80 }
00007A50 01 C0 60 70 00 41 00 00                         ..`p.A..       

l00007A58:
	{ r1 = and(00000002,asl(r1,00000002)) }
	{ r1 = FFFFFFFF; r2 = togglebit(r1,0000001C) }
	{ r0 = or(r2,r0) }
	{ memb(r16) = r0.new; jump	00007AA0; r0 = setbit(r0,00000012) }

l00007A74:
	{ memw(r16+16) = r17; memw(r16+8) = r17; r0 = add(r17,00000001) }
00007A78                         89 04 89 A2 03 C0 90 A1         ........

l00007A80:
	{ call	000090C0 }
	{ r2 = memh(r16); r0 = memw(r16+8); r1 = 00000000 }

l00007A88:
	{ r2 = memh(r16); r0 = memw(r16+8) }

l00007A8C:
	{ memw(r16+20) = r0; r3 = memw(r16+12); r2 = or(r2,00006000) }
	{ memuh(r16+8) = r2; memw(r16+24) = r3 }

l00007A9C:
	{ dealloc_return; r17:r16 = memd(r29); r0 = r1 }

l00007AA0:
	{ dealloc_return; r17:r16 = memd(r29) }
00007AA4             00 C0 00 7F 00 C0 00 7F 00 C0 00 7F     ............

;; _Getmem: 00007AB0
_Getmem proc
	{ allocframe(+00000000); if (!p0.new) jump:nt	00007AC4; p0 = cmp.gt(r0,00000000) }

l00007AB8:
	{ call	0000B0A0 }
	{ dealloc_return; r0 = -00000001; p0 = cmp.eq(r0,FFFFFFFF) }

l00007AC4:
	{ dealloc_return; r0 = 00000000 }
00007AC8                         00 C0 00 7F 00 C0 00 7F         ........

;; _Ldtob: 00007AD0
;;   Called from:
;;     00005CF0 (in fn00005B54)
_Ldtob proc
	{ allocframe(+00000100); call	0000A270 }
	{ r16 = r0; r26 = r1 }
	{ r1:r0 = memd(r16); r18 = setbit(r26,0000000A) }
	{ memd(r29+152) = r1:r0; p0 = cmp.eq(r18,00000061) }
	{ memb(r29) = r0.new; if (p0) jump:nt	00007B1C; r0 = p0 }

l00007B00:
	{ if (!tstbit(r0.new,-00000001)) jump:nt	00007B18 }

l00007B08:
	{ if (p0.new) memw(r16+48) = 00000001; p0 = cmp.eq(r18,00000067); jump	00007B18 }
00007B14             06 C6 50 3C                             ..P<       

l00007B18:
	{ r1 = r16; r0 = add(r29,00000096); call	00008100 }

l00007B1C:
	{ r1 = r16; r0 = add(r29,00000096) }

l00007B24:
	{ r1 = zxth(r0); r2 = setbit(r26,00000004) }
	{ r0 = memw(r16+16); r1 = 00000022; p0 = cmp.eq(r2,00000065) }
	{ if (!p0) r2 = add(r26,FFFFFF9A); if (p0) jump:nt	00007B8C }

l00007B44:
	{ r3 = 00000002; r4 = 00000026 }
	{ jump	00007B80 }
00007B50 00 40 40 75 00 C0 9D 91 01 40 40 85 22 C0 20 5C .@@u.....@@.". \
00007B60 02 42 DA 8C 5B 43 00 00 80 04 A1 4A 10 58 00 5C .B..[C.....J.X.\
00007B70 42 73 9A 74 A0 CC 02 75 5B 43 00 00 23 28 E4 2A Bs.t...u[C..#(.*

l00007B80:
	{ r2 = and(r2,000000FF) }
	{ if (!p0.new) r1 = add(r4,00000000); p0 = cmp.gtu(r3,r2) }

l00007B8C:
	{ memw(r16+28) = FFFFFF83; r2 = 00000003; call	000073E0 }
	{ jump	0000A350 }
00007B9C                                     1E 41 20 5C             .A \
00007BA0 80 C8 90 41 20 CC 1A 75 22 40 00 B0 04 D2 B0 A1 ...A ..u"@......
00007BB0 02 4F 00 7E 02 4B 80 7E 30 C0 00 3C 80 C0 90 91 .O.~.K.~0..<....
00007BC0 23 40 00 B0 04 D3 B0 A1 00 C2 00 A1 A0 C0 90 91 #@..............
00007BD0 40 40 00 B0 05 D2 B0 A1 EC 40 01 10 F4 C1 20 5C @@.......@.... \
00007BE0 82 41 90 91 14 C3 C0 49 E1 7F 62 75 22 40 02 B0 .A.....I..bu"@..
00007BF0 64 42 DD 91 00 C0 D0 91 40 54 E4 D2 13 40 22 74 dB......@T...@"t
00007C00 33 C4 A0 7E 16 C0 F3 70 06 40 00 5C 57 C0 16 B0 3..~...p.@.\W...
00007C10 41 DF C1 8C 02 54 1D B0 00 40 57 75 63 49 5D 91 A....T...@WucI].
00007C20 13 C0 DD A1 12 40 C2 8C 82 7F E3 BF 00 C0 02 3C .....@.........<
00007C30 5A 40 20 5C 19 40 72 70 4B C2 5D A1 06 40 00 58 Z@ \.@rpK.]..@.X
00007C40 18 E0 12 73 60 C2 DD 91 40 40 F4 D2 4E C8 00 5C ...s`...@@..N..\
00007C50 88 4F 00 5A 00 53 1D B0 C1 29 9F 27 00 40 57 75 .O.Z.S...).'.@Wu
00007C60 60 C2 DD 91 02 40 40 89 31 40 E0 88 01 D4 BD A1 `....@@.1@......
00007C70 08 C0 20 5C 42 40 91 84 18 D5 00 5A 13 C0 DD A1 .. \B@.....Z....
00007C80 1E 60 C9 10 E0 40 00 78 E1 C0 19 B0 C1 40 19 B0 .`...@.x.....@..
00007C90 C2 C0 00 78 00 C0 62 70 22 40 00 B0 0E C0 C2 24 ...x..bp"@.....$
00007CA0 11 44 11 8C E3 41 11 76 E2 7F E0 BF 78 C5 A1 AB .D...A.v....x...
00007CB0 F2 E0 B9 10 10 60 C0 10 21 C0 01 B0 18 40 00 60 .....`..!....@.`
00007CC0 02 40 40 76 E3 FF E1 BF 00 80 00 7F 78 D8 03 AB .@@v........x...
00007CD0 01 C2 01 F3 F9 40 01 B0 20 C0 9D 91 00 40 40 85 .....@.. ....@@.
00007CE0 B4 F8 DF 5C 01 D9 32 F3 00 41 56 F2 00 60 01 74 ...\..2..AV..`.t
00007CF0 00 E0 93 74 20 4C 1A 75 02 40 E0 70 52 C0 C2 26 ...t L.u.@.pR..&
00007D00 01 42 41 F2 5B 43 00 00 41 C6 00 78 5C 43 00 00 .BA.[C..A..x\C..
00007D10 03 28 35 28 0E C1 20 5C 03 D4 1D B0 03 C3 02 F3 .(5(.. \........
00007D20 23 C0 23 91 E1 40 83 75 E3 61 20 7E 03 E0 A0 7E #.#..@.u.a ~...~
00007D30 04 54 1D B0 01 40 85 74 06 34 00 31 24 C0 06 E2 .T...@.t.4.1$...
00007D40 E0 7F E0 BF E2 7F E2 BF E4 7F E4 BF E5 FF 24 97 ..............$.
00007D50 F8 E3 35 14 E0 41 03 75 23 60 05 74 00 C3 A4 42 ..5..A.u#`.t...B
00007D60 0C E1 82 11 12 54 1D B0 20 40 00 B0 62 C9 5D 91 .....T.. @..b.].
00007D70 82 40 02 B0 4B CA BD A1 02 40 E0 70 10 C0 C2 24 .@..K....@.p...$
00007D80 08 C0 02 60 03 42 12 F3 E2 FF E2 BF E4 FF 23 97 ...`.B........#.
00007D90 04 84 21 3A FF E2 A3 A7 81 41 90 91 A4 E0 93 26 ..!:.....A.....&
00007DA0 01 C0 E0 70 9E 41 00 58 E1 7F E1 BF 0C D3 B0 A1 ...p.A.X........
00007DB0 C1 52 1D B0 8A 2E 00 28 94 41 00 58 00 C0 21 3C .R.....(.A.X..!<
00007DC0 62 42 DD 91 00 C3 C0 49 40 40 E2 D2 0C 58 00 5C bB.....I@@...X.\
00007DD0 20 DA 9D 46 43 DF C3 8C 06 40 00 58 13 C2 DD A1  ..FC....@.X....
00007DE0 04 DA 9D A1 B6 42 00 5A E0 2D 31 28 D6 62 4F 01 .....B.Z.-1(.bO.
00007DF0 20 41 00 78 62 49 5D 91 01 C4 80 49 D6 41 00 00  A.xbI]....I.A..
00007E00 E3 42 02 E0 02 C0 61 70 20 C0 03 ED 24 5F 00 8C .B....ap ...$_..
00007E10 03 CD 00 8C 22 44 03 EF A3 DF 00 8E 00 43 01 D5 ...."D.......C..
00007E20 01 43 41 D5 4B C2 5D A1 1A 41 C1 11 13 E0 00 7E .CA.K.]..A.....~
00007E30 40 C0 C1 10 93 7F 20 76 FF 43 00 00 81 C7 00 76 @..... v.C.....v
00007E40 38 40 01 10 4B D3 5D A1 97 43 00 00 02 45 00 78 8@..K.]..C...E.x
00007E50 80 2D 31 28 50 C5 00 5A 2C C0 00 58 60 40 40 76 .-1(P..Z,..X`@@v
00007E60 13 C0 00 78 84 FF 20 76 24 40 04 10 00 40 44 76 ...x.. v$@...@Dv
00007E70 4B CA BD A1 00 4C 1D B0 61 40 00 78 13 40 64 70 K....L..a@.x.@dp
00007E80 22 C3 C0 49 66 C2 00 5A 14 40 00 58 00 C0 00 7F "..If..Z.@.X....
00007E90 32 45 00 5A 02 4C 1D B0 60 2C 31 28 04 46 1D B0 2E.Z.L..`,1(.F..
00007EA0 61 40 00 78 80 2D 33 28 A4 45 00 5A 02 C3 1D B0 a@.x.-3(.E.Z....
00007EB0 0C 63 CB 11 63 E0 00 7E 00 4F 1D B0 61 40 00 78 .c..c..~.O..a@.x
00007EC0 82 2D C4 2C 96 C5 00 5A 13 41 13 8C C0 4C 12 75 .-.,...Z.A...L.u
00007ED0 E4 E0 75 24 E1 40 00 78 58 08 80 CC 02 40 40 89 ..u$.@.xX....@@.
00007EE0 0A 40 20 5C 03 D4 BD A1 61 C9 5D 91 61 C1 01 B0 .@ \....a.].a...
00007EF0 63 42 00 78 10 38 82 2E 12 40 C2 8C 13 43 A0 D5 cB.x.8...@...C..
00007F00 30 C0 02 3C 70 40 CB 10 1B C0 72 70 1A 66 12 73 0..<p@....rp.f.s
00007F10 54 43 C0 49 78 C3 C0 49 60 42 DD 91 02 C3 C0 49 TC.Ix..I`B.....I
00007F20 40 40 E2 D2 62 48 00 5C 16 E0 80 7E E0 C1 DD 91 @@..bH.\...~....
00007F30 20 40 F8 D2 14 D8 00 5C 30 40 E0 88 E0 2D 31 28  @.....\0@...-1(
00007F40 42 C0 90 84 43 5F C3 8C 86 C2 00 5A 78 3E 8E 58 B...C_.....Zx>.X
00007F50 40 58 E0 D2 F4 F8 DF 5C 13 FF F3 BF 02 74 15 FD @X.....\.....t..
00007F60 00 C0 53 75 00 40 40 89 0A 40 20 5C 02 D4 BD A1 ..Su.@@..@ \....
00007F70 0C 44 00 5A E0 2D 31 28 22 60 CE 10 10 41 00 78 .D.Z.-1("`...A.x
00007F80 00 C1 1B B0 FB 40 1B B0 F1 C0 00 78 10 C0 71 70 .....@.....x..qp
00007F90 20 40 10 B0 12 C0 C2 24 94 4A 00 5A 40 61 36 73  @.....$.J.Z@a6s
00007FA0 F1 FF F0 BF 16 C0 01 F5 F2 60 BE 10 00 46 17 B0 .........`...F..
00007FB0 78 C2 BB AB 10 60 C8 10 20 C0 1B B0 18 40 10 60 x....`.. ....@.`
00007FC0 E2 7F E0 BF 01 C0 50 76 00 80 00 7F 78 DA 02 AB ......Pv....x...
00007FD0 00 C1 00 F3 1B 41 00 B0 41 C0 9D 91 00 40 41 85 .....A..A....@A.
00007FE0 9E F8 DF 5C 01 5B 32 F3 60 C9 5D 91 E0 40 00 B0 ...\.[2.`.]..@..
00007FF0 4B CA BD A1 02 C0 32 91 24 58 20 5C 00 46 02 75 K.....2.$X \.F.u
00008000 9A 40 9D 47 B0 C0 9D 47 02 54 1D B0 B0 40 9D 91 .@.G...G.T...@..
00008010 9A C0 9D 91 02 41 C2 8C 00 40 00 7F 00 C0 00 7F .....A...@......
00008020 E0 7F E0 BF E1 7F E1 BF 4B CC BD A1 23 C0 22 9B ........K...#.".
00008030 F8 78 DF 5C 00 C6 03 75 04 40 00 58 F2 FF E2 BF .x.\...u.@.X....
00008040 33 3C 82 0C 00 40 43 85 0A 48 20 5C 00 E4 E0 70 3<...@C..H \...p
00008050 0C 40 00 58 23 C0 00 B0 A0 4C 1A 75 A1 C8 1A 75 .@.X#....L.u...u
00008060 00 C0 21 6B 23 C0 00 7A 00 43 02 D5 00 7C FF 0F ..!k#..z.C...|..
00008070 32 38 13 28 00 41 40 F2 00 60 01 74 00 E0 82 74 28.(.A@..`.t...t
00008080 02 40 00 70 30 E3 82 21 03 46 00 78 02 40 E0 70 .@.p0..!.F.x.@.p
00008090 0E E1 C2 21 01 C2 32 3A 80 46 81 75 23 67 00 7E ...!..2:.F.u#g.~
000080A0 03 E6 80 7E 20 C0 00 B0 01 42 12 F3 22 33 00 33 ...~ ....B.."3.3
000080B0 E1 7F 21 97 FC E3 33 20 20 47 03 75 03 62 12 FB ..!...3  G.u.b..
000080C0 21 E0 01 74 0E 61 82 11 00 C1 03 40 F2 7F F2 BF !..t.a.....@....
000080D0 20 40 00 B0 61 C9 5D 91 21 40 01 B0 4B CB BD A1  @..a.].!@..K...
000080E0 03 40 E0 70 02 40 72 70 00 50 1A F5 64 C9 5D 91 .@.p.@rp.P..d.].
000080F0 48 CB 00 5A 2E D1 00 58 00 C0 00 7F 00 C0 00 7F H..Z...X........

;; _LDunscale: 00008100
;;   Called from:
;;     00007B18 (in _Ldtob)
;;     00008374 (in fn00008368)
;;     000083F4 (in fn00008368)
;;     00008468 (in fn00008468)
;;     00008530 (in fn00008368)
;;     00008634 (in _LXp_setw)
;;     000086D0 (in fn00008368)
;;     0000887C (in _LXp_mulh)
;;     00009528 (in sqrtl)
_LDunscale proc
	{ allocframe(+00000000); call	000095D0 }
	{ dealloc_return }
0000810C                                     00 C0 00 7F             ....

;; _Litob: 00008110
_Litob proc
	{ allocframe(00000048); r2 = 00000018; call	0000A270 }
	{ r16 = r0; r3 = 00000030; p0 = cmp.eq(r1,00000058) }
	{ p1 = cmp.eq(r1,0000006F); if (!p0) r17 = add(r3,00000000); if (p0) r17 = add(r2,00000000); if (!p1.new) jump:t	00008140 }

l00008138:
	{ r21:r20 = memd(r16); jump	00008180; r14 = 00000008 }

l00008140:
	{ r3:r2 = memd(r16); p2 = cmp.eq(r1,00000064); p1 = !cmp.eq(r1,00000058); p0 = !cmp.eq(r1,00000078) }
	{ if (!p0.new) r22 = 00000010; if (p0.new) r22 = 0000000A; if (p2) jump:nt	00008170; p0 = fastcorner9(p1,p0) }

l00008160:
	{ p0 = cmp.eq(r1,00000069); if (!p0.new) r21:r20 = combine(r3,r2); if (!p0.new) jump:t	00008180 }

l0000816C:
	{ r0 = 0000003F; r21:r20 = combine(r3,r2) }

l00008170:
	{ r0 = 0000003F }

l00008174:
	{ r21:r20 += asr(r21:r20,0000003F) }
	{ jump	00008184; XOREQ	r21:r20,asr(r3:r2,r0) }

l00008180:
	{ r1:r0 = combine(00000000,00000000) }

l00008184:
	{ if (!p0.new) jump:t	00008198; p0 = cmp.eq(r21:r20,r1:r0) }

l0000818C:
	{ if (cmp.eq(r0.new,00000001)) jump:nt	000082D8; r0 = memw(r16+48) }

l00008198:
	{ r19:r18 = combine(00000000,00000003); r23 = 00000017; r24 = add(r29,00000000) }
	{ r3:r2 = combine(r19,r18); call	0000A590 }
	{ memb(r24+23) = r0.new; r0 = memb(r20+r0) }
	{ r3:r2 = combine(r19,r18); r1:r0 = combine(r21,r20); call	0000A4E4 }
	{ r21:r20 = combine(r1,r0) }
	{ memd(r16) = r21:r20; if (p0.new) jump:nt	00008234; p0 = cmp.gt(r25:r24,r21:r20) }

l000081D0:
	{ nop; nop; r23 = add(r29,00000000); r26 = add(r23,FFFFFFFF) }

l000081E0:
	{ r27 = add(r23,r26); r3:r2 = combine(r19,r18); r1:r0 = combine(r21,r20); call	0000A3E0 }
	{ memd(r16) = r1:r0; r2 = add(r26,FFFFFFFF); r5:r4 = mpyu(r0,r18); p0 = cmp.gt(r25:r24,r1:r0) }
	{ r5 += mpyi(r0,r19) }
	{ r5 += mpyi(r18,r1) }
	{ r5:r4 = combine(r5,r4) }
	{ if (p0.new) r21:r20 = combine(r1,r0); r5:r4 = sub(r21:r20,r5:r4) }
	{ r3 = memb(r20+r4); if (p0) jump:nt	0000822C }

l00008220:
	{ r26 = r2; p0 = cmp.gt(r26,00000000); if (p0.new) jump:t	000081E0 }

l0000822C:
	{ r23 = add(r2,00000001) }
	{ if (p0.new) r0 = memb(r16-4); if (!p0.new) jump:t	00008268; p0 = cmp.eq(r14,00000010) }

l00008234:
	{ if (p0.new) r0 = memb(r16-4) }

l00008238:
	{ if (cmp.eq(r0.new,00000000)) jump:nt	00008270; r0 = and(r0,00000008); p0 = cmp.gtu(r23,00000017) }

l00008248:
	{ if (!p0) r0 = add(r29,00000000) }
	{ r0 = memb(r13+r23) }
	{ p0 = cmp.eq(r0,00000030); if (p0.new) jump:t	00008268 }

l00008258:
	{ r0 = add(r29,00000000) }
	{ r23 = add(r23,FFFFFFFF); r0 = add(r0,add(r23,0000003F)) }
	{ memb(r0) = 30 }

l00008268:
	{ r0 = memw(r16+16); r1 = add(r29,00000000); r2 = sub(00000018,r23) }

l00008270:
	{ memw(r16+28) = r2; r1 = add(r1,r23); call	000073E0 }
	{ r1 = memw(r16+48) }
	{ if (!cmp.gtu(r1,r0.new)) jump:t	000082AC; r0 = memw(r16+28); p0 = cmp.gt(r1,FFFFFFFF) }

l0000828C:
	{ r2 = memuh(r16+60) }
	{ memw(r16+24) = r0; r1 = and(r2,0000FFEF) }
	{ memuh(r16+60) = r1; jump	0000A350 }
000082A4             16 40 00 5C C1 C3 70 45                 .@.\..pE   

l000082AC:
	{ r1 = and(r1,00000014) }
	{ r2 = memw(r16+20); r1 = memw(r16+24) }
	{ r3 = memw(r16+24); r0 = sub(r1,r0) }
	{ r0 = sub(r0,r2) }
	{ r0 = sub(r0,r3) }
	{ if (p0.new) memw(r16+24) = r0; p0 = cmp.gt(r0,00000000) }
	{ jump	0000A350 }
000082D4             6E 58 3F 16                             nX?.       

l000082D8:
	{  }
	{ nop }

;; _LXp_getw: 000082E0
;;   Called from:
;;     000082DC (in _Litob)
_LXp_getw proc
	{ allocframe(00000008); memd(r29+496) = r17:r16; p0 = cmp.eq(r1,00000000) }
	{ r17:r16 = memd(gp+192); if (p0) jump:nt	00008348 }

l000082F0:
	{ if (!p0.new) jump:t	000082FC; p0 = cmp.eq(r1,00000002) }

l000082F4:
	{ r17:r16 = memd(r0); jump	00008348 }

l000082FC:
	{ r3:r2 = memd(gp+192); r17:r16 = memd(r0) }
	{ if (p0.new) jump:t	0000834C; p0 = dfcmp.eq(r17:r16,r3:r2) }

l0000830C:
	{ r5:r4 = memd(r0+8); if (!p0.new) jump:t	0000832C; p0 = cmp.gt(r1,00000002) }

l00008314:
	{ if (p0.new) jump:t	0000834C; p0 = dfcmp.eq(r5:r4,r3:r2) }

l0000831C:
	{ if (!p0) r1:r0 = combine(r17,r16); if (!p0) r3:r2 = combine(r5,r4); if (!p0.new) jump:t	0000832C; p0 = cmp.eq(r1,00000004) }

l00008328:
	{ jump	00008340 }

l0000832C:
	{ r3:r2 = memd(r0+16); r1:r0 = combine(r5,r4); call	0000A600 }
	{ r1:r0 = combine(r17,r16); r3:r2 = combine(r1,r0) }

l00008340:
	{ call	0000A600 }
	{ r17:r16 = combine(r1,r0) }

l00008348:
	{ dealloc_return; r17:r16 = memd(r29); r1:r0 = combine(r17,r16) }

l0000834C:
	{ dealloc_return; r17:r16 = memd(r29) }

;; _LXp_setw: 00008350
;;   Called from:
;;     00008BF0 (in fn00008B1C)
;;     00008C90 (in _LXp_sqrtx)
_LXp_setw proc
	{ allocframe(+00000030); call	0000A278 }

;; fn00008354: 00008354
;;   Called from:
;;     00008B5C (in fn00008B1C)
fn00008354 proc
	{ allocframe(+00000030) }
	{ r17:r16 = combine(r1,r0); r19:r18 = combine(r3,r2) }
	{ memd(r29+8) = r19:r18; if (!p0.new) jump:nt	00008448; p0 = cmp.gt(r9,00000000) }

;; fn00008368: 00008368
;;   Called from:
;;     00008360 (in fn00008354)
;;     00008360 (in _LXp_setw)
;;     00008514 (in fn00008468)
;;     000085BC (in _LXp_setw)
fn00008368 proc
	{ if (!p0.new) r1 = add(r29,00000008); if (!p0.new) r0 = add(r29,00000006); if (p0.new) jump:t	000083A0; p0 = cmp.eq(r9,00000002) }

l00008374:
	{ call	00008100 }
	{ r1 = zxth(r0); p0 = cmp.gt(r0,00000000) }
	{ if (!p0) jump:nt	000083AC }

l00008388:
	{ r1:r0 = memd(r29+8); r3:r2 = combine(00000000,00000000) }
	{ memd(r16+8) = r3:r2; memd(r16) = r1:r0; jump	0000845C; r0 = r8 }
0000839C                                     32 C0 DD 91             2...

l000083A0:
	{ memd(r16) = r19:r18; jump	00008420; r0 = r8 }

l000083AC:
	{ r0 = add(r29,00000008); r1 = 0000001A; call	00009B50 }
	{ r1 = memh(r29+6); r0 = add(r29,00000008); call	00009B60 }
	{ r3:r2 = memd(r29+8); r1:r0 = combine(r19,r18) }
	{ memd(r16) = r3:r2; call	0000A6A4 }
	{ p0 = cmp.gt(r17,00000002); r19:r18 = combine(r1,r0) }
	{ memd(r16+8) = r19:r18; if (!p0) jump:nt	0000843C }

l000083E0:
	{ r23:r22 = memd(gp+192) }
	{ if (!p1.new) r20 = add(r16,00000008); if (!p1.new) r0 = add(r29,00000006); if (p1.new) jump:t	00008440; p1 = dfcmp.eq(r19:r18,r23:r22) }

l000083F4:
	{ r1 = r20; call	00008100 }
	{ call	00009B50 }
	{ r1 = memh(r29+6); r0 = r20; call	00009B60 }
	{ r3:r2 = memd(r20); r1:r0 = combine(r19,r18); call	0000A6A4 }
	{ memd(r16+16) = r1:r0; if (!p0.new) jump:t	00008448; p0 = cmp.gt(r9,00000006) }

l00008420:
	{ memd(r16+16) = r1:r0 }

l00008424:
	{ if (p0.new) jump:t	0000844C; p0 = dfcmp.eq(r1:r0,r23:r22) }

l0000842C:
	{ r1:r0 = combine(00000000,00000000) }
	{ memd(r16+24) = r1:r0; jump	00008470; r0 = r8 }

l0000843C:
	{ if (!p0) jump:nt	00008448 }

l00008440:
	{ r1:r0 = combine(00000000,00000000) }
	{ memd(r16+16) = r1:r0 }

;; fn00008448: 00008448
;;   Called from:
;;     00008360 (in fn00008354)
;;     00008360 (in _LXp_setw)
;;     00008420 (in fn00008368)
;;     0000843C (in fn00008368)
;;     00008444 (in fn00008368)
fn00008448 proc
	{ jump	00008528; r0 = r8 }

l0000844C:
	{ jump	0000852C; r0 = r8 }

;; _LXp_addh: 00008450
;;   Called from:
;;     00008898 (in _LXp_mulh)
;;     000088AC (in _LXp_mulh)
;;     00008940 (in _LXp_addx)
;;     00008AA4 (in fn00008AA4)
;;     00008B80 (in fn00008B70)
;;     00008B80 (in fn00008B70)
;;     00008BB8 (in fn00008B70)
;;     00008CEC (in fn00008CCC)
;;     00008CEC (in fn00008CCC)
_LXp_addh proc
	{ allocframe(+00000060); call	0000A270 }

;; fn00008454: 00008454
;;   Called from:
;;     00008984 (in _LXp_mulh)
;;     00008984 (in fn00008970)
fn00008454 proc
	{ allocframe(+00000060) }

;; fn00008458: 00008458
;;   Called from:
;;     00008450 (in _LXp_addh)
;;     00008454 (in fn00008454)
fn00008458 proc
	{ memw(r29+8) = r0; r17 = r1; r19:r18 = combine(r3,r2) }

l0000845C:
	{ memw(r29+8) = r0; r17 = r1 }

;; fn00008460: 00008460
;;   Called from:
;;     00008458 (in fn00008458)
;;     00008458 (in fn00008458)
;;     0000845C (in fn00008368)
fn00008460 proc
	{ memd(r29+32) = r19:r18; memd(r29+40) = r19:r18; if (p0.new) jump:nt	00008780; p0 = cmp.eq(r25,00000001) }

;; fn00008468: 00008468
;;   Called from:
;;     00008438 (in fn00008368)
;;     00008460 (in fn00008460)
;;     00008460 (in fn00008460)
;;     0000852C (in fn00008368)
;;     0000862C (in _LXp_setw)
;;     0000863C (in _LXp_setw)
fn00008468 proc
	{ r0 = add(r29,0000001E); r1 = add(r29,00000020); call	00008100 }

l00008470:
	{ r0 = add(r29,0000001E) }
	{ if (!p0.new) jump:nt	000084E0; p0 = cmp.gt(r0,00000000) }

l00008478:
	{ if (!p0.new) r0 = memw(r29+8); if (p0.new) jump:t	00008758; p0 = cmph.eq(r0,0002) }

l00008484:
	{ call	00009B70 }
	{ if (!p0.new) jump:nt	00008750; p0 = cmp.gt(r16,00000000) }

l0000848C:
	{ if (p0.new) jump:t	00008784; p0 = cmph.eq(r0,0002) }

l00008494:
	{ r0 = memd(r29+8); r1 = add(r29,00000028) }
	{ r0 = memh(r0+6); r1 = or(r1,00000006) }
	{ r1 = memh(r1) }
	{ r0 = xor(r0,r1) }
	{ if (tstbit(r0.new,-00000001)) jump:t	00008784; r0 = sxth(r0) }

l000084B4:
	{ r0 = 00000001; r16 = 00000030 }
	{ r2 = memw(r29+8); r1:r0 = memd(r16); p0 = cmp.gt(r17,00000001) }
	{ memd(r2) = r1:r0; if (!p0) jump:nt	00008780 }

l000084D0:
	{ r2 = memd(r29+8); r1:r0 = combine(00000000,00000000) }
	{ memd(r2+8) = r1:r0; r0 = memw(r29+8); jump	0000A350 }

l000084E0:
	{ if (p0.new) jump:t	00008780; p0 = tstbit(r0,00000000) }

l000084E4:
	{ if (p0.new) r16 = 00000000; if (!p0.new) jump:t	00008780; p0 = cmp.gt(r25,00000000) }

l000084EC:
	{ r25:r24 = memd(gp+192); r0 = memw(r29+8); r19 = 00000800; r20 = add(r17,FFFFFFFF) }
	{ r21 = add(r0,FFFFFFF8); r1 = add(r0,00000008); r0 = addasl(r0,r20,00000003); r23:r22 = combine(00000000,00000000) }
	{ memw(r29) = r0; memw(r29+4) = r1 }

l00008510:
	{ r1 = memd(r29+4); r0 = memd(r29+8); r26 = add(r16,00000001) }
	{ r27 = addasl(r1,r16,00000003); r18 = addasl(r0,r16,00000003) }
	{ r3:r2 = memd(r18); jump	00008530 }

l00008528:
	{ memd(r18) = r3:r2; memd(r29+40) = r23:r22 }

l0000852C:
	{ memd(r18) = r3:r2 }

l00008530:
	{ memd(r29+16) = r3:r2; r1 = add(r29,00000010); r0 = add(r29,0000000E); call	00008100 }
	{ if (p0.new) jump:nt	00008780; p0 = cmp.gt(r16,00000000) }

l00008540:
	{ if (cmp.eq(r0.new,00000000)) jump:nt	00008768; r0 = zxth(r0) }

l0000854C:
	{ r4 = memh(r29+14) }
	{ r5 = sub(r4,r0) }
	{ p0 = cmp.gt(r5,FFFFFFE6); if (!p0.new) r1 = add(r27,00000000); if (!p0.new) r6 = add(r26,00000000); if (p0.new) jump:nt	000085C0 }

l00008564:
	{ r3:r2 = memd(r29+40) }
	{ if (p0.new) jump:nt	000085C4; p0 = dfcmp.eq(r3:r2,r25:r24) }

l00008570:
	{ if (!cmp.gtu(r17,r0.new)) jump:nt	00008590; r0 = r6 }

l00008574:
	{ if (!cmp.gtu(r17,r0.new)) jump:nt	00008590 }

l0000857C:
	{ r5:r4 = memd(r1); r1 = add(r1,00000008) }
	{ if (!p0.new) jump:t	00008574; p0 = dfcmp.eq(r5:r4,r25:r24) }

l0000858C:
	{ if (p0.new) r0 = add(r0,00000001); jump	000085A4; if (!p0.new) jump:t	00008598; p0 = cmp.gt(r12,-00000001) }

l00008590:
	{ if (p0.new) r0 = add(r0,00000001); jump	000085A4 }
00008598                         00 40 11 F2 E0 FF 00 74         .@.....t
000085A0 C4 E8 F0 14                                     ....           

l000085A4:
	{ r1 = sub(r0,r16); r0 = addasl(r21,r0,00000003) }
	{ loop0(000085B0,r1) }
	{ r5:r4 = memd(r0) }
	{ memd(r0+8) = r5:r4; r0 = add(r0,FFFFFFF8) }
	{ jump	00008528 }

l000085C0:
	{ r1:r0 = memd(r29+40); if (!p0.new) jump:t	000085D8; p0 = cmp.gt(r5,00000012) }

l000085C4:
	{ r1:r0 = memd(r29+40) }

l000085C8:
	{ if (p0.new) jump:t	000085DC; p0 = dfcmp.eq(r1:r0,r25:r24) }

l000085D0:
	{ r16 = add(r16,00000001); jump	00008748; r11 = r4 }

l000085D8:
	{ r3:r2 = memd(r18); call	0000A600 }

l000085DC:
	{ r3:r2 = memd(r18) }

l000085E0:
	{ r3:r2 = combine(r1,r0) }
	{ memd(r18) = r3:r2; if (!p0.new) jump:t	00008638; p0 = dfcmp.eq(r3:r2,r25:r24) }

l000085F0:
	{ r1 = memd(r29+4); r0 = r16 }
	{ nop; nop; r1 = addasl(r1,r16,00000003) }
	{ if (!cmp.gtu(r17,r0.new)) jump:nt	00008628; r0 = add(r0,00000001); r2 = add(r1,00000008) }

l00008604:
	{ if (!cmp.gtu(r17,r0.new)) jump:nt	00008628; r0 = add(r0,00000001) }

l00008610:
	{ memd(r1-8) = r5:r4; r1 = r2; if (!p0.new) jump:t	00008604; p0 = dfcmp.eq(r5:r4,r25:r24) }

l00008620:
	{ r0 = memw(r29) }
	{ memd(r0) = r23:r22 }

l00008628:
	{ r3:r2 = memd(r18) }
	{ if (p0.new) jump:nt	00008784; p0 = dfcmp.eq(r3:r2,r25:r24) }

l00008634:
	{ memd(r29+40) = r3:r2; r1 = add(r29,00000028); r0 = add(r29,0000001E); call	00008100 }

l00008638:
	{ memd(r29+40) = r3:r2; r1 = add(r29,00000028); r0 = add(r29,0000001E) }

l00008640:
	{ r0 = add(r19,FFFFFFE6) }
	{ r1 = memh(r29+30) }
	{ r0 = add(r29,00000028); call	00009B54; r1 = sub(r1.l,r0.l) }
	{ r1 = memh(r29+30); r0 = add(r29,00000028); call	00009B60 }
	{ r3:r2 = memd(r29+40); r1:r0 = memd(r18); call	0000A6A4 }
	{ memd(r18) = r1:r0; if (!p0.new) jump:t	000086B0; p0 = dfcmp.eq(r1:r0,r25:r24) }

l0000867C:
	{ r0 = memd(r29+4); r1 = r16 }
	{ r0 = addasl(r0,r16,00000003) }
	{ r1 = add(r1,00000001); r2 = add(r0,00000008) }

l00008688:
	{ r1 = add(r1,00000001) }
	{ r5:r4 = memd(r0) }
	{ memd(r0-8) = r5:r4; r0 = r2; if (!p0.new) jump:t	00008688; p0 = dfcmp.eq(r5:r4,r25:r24) }

l000086A4:
	{ r0 = memw(r29) }
	{ memd(r0) = r23:r22 }
	{ r16 = 00000000; r19 = 00000800; r26 = add(r16,FFFFFFFF) }

l000086B0:
	{ r16 = 00000000; r19 = 00000800 }

l000086B8:
	{ p0 = cmp.eq(r26,00000000); if (!p0.new) r0 = add(r29,0000000E); if (!p0.new) r1 = add(r29,00000020); if (p0.new) jump:t	00008748 }

l000086C8:
	{ r3:r2 = memd(r18-16); r16 = r26 }
	{ memd(r29+32) = r3:r2; call	00008100 }
	{ r19 = memh(r29+14); jump	00008748 }
000086E0 C0 41 1D B0 01 40 72 70 30 40 10 B0 50 D1 02 20 .A...@rp0@..P.. 
000086F0 02 C0 D2 91 06 7D FF 5B 05 C2 DD A1 2A 4A 00 5A .....}.[....*J.Z
00008700 40 E3 32 73 2E 4A 00 5A 00 40 72 70 E1 C0 5D 91 @.2s.J.Z.@rp..].
00008710 12 40 D2 91 A0 C0 DD 91 C6 4F 00 5A 02 D2 13 F5 .@.......O.Z....
00008720 00 58 E0 D2 05 C0 DD A1 00 40 C0 6B 02 60 01 FD .X.......@.k.`..
00008730 82 72 13 FD C0 C3 1D B0 E4 7C FF 5B 01 44 1D B0 .r.......|.[.D..
00008740 F3 40 5D 91 04 C2 DD A1                         .@].....       

l00008748:
	{ if (p0.new) jump:t	00008510; p0 = cmp.gt(r9,-00000001) }

l0000874C:
	{ jump	00008780 }

l00008750:
	{ r19:r18 = memd(r29+40) }
	{ r0 = memw(r29+8) }

l00008758:
	{ memd(r0) = r19:r18; r0 = memw(r29+8); jump	0000A350 }
00008764             29 3E 80 51                             )>.Q       

l00008768:
	{ memd(r18) = r3:r2; if (!p0.new) jump:t	00008780; p0 = cmp.gt(r9,-00000001) }

l00008770:
	{ r1 = memw(r29+8) }
	{ memd(r30+r0<<#3) = r23:r22; r0 = memw(r29+8); jump	0000A350 }

;; fn00008780: 00008780
;;   Called from:
;;     00008460 (in fn00008460)
;;     00008460 (in fn00008460)
;;     000084D4 (in fn00008468)
;;     000084E0 (in fn00008468)
;;     000084E8 (in fn00008468)
;;     0000853C (in fn00008368)
;;     00008750 (in fn00008368)
;;     00008768 (in fn00008368)
fn00008780 proc
	{ r0 = memw(r29+8); jump	0000A350 }

l00008784:
	{ r0 = memw(r29+8) }

;; _LXp_mulh: 00008788
;;   Called from:
;;     00008784 (in fn00008468)
;;     00008A2C (in fn00008A2C)
;;     00008A48 (in fn00008A48)
;;     00008A7C (in fn00008A48)
;;     00008B1C (in fn00008B1C)
;;     00008CC0 (in fn00008CB8)
;;     00008CC0 (in _LXp_sqrtx)
_LXp_mulh proc
	{ allocframe(+00000060); call	0000A270 }
	{ r19:r18 = combine(r3,r2); r17:r16 = combine(r1,r0) }
	{ if (!p0) r3:r2 = combine(r19,r18); if (!p0.new) jump:nt	000088EC; p0 = cmp.gt(r9,00000001) }

l000087A0:
	{ r1:r0 = memd(r16); call	0000AB20 }
	{ r0 = add(r29,00000010); r3:r2 = combine(r1,r0) }
	{ memd(r29+16) = r3:r2; call	00009B70 }
	{ if (!tstbit(r20.new,-00000001)) jump:nt	00008808; r20 = r0; r1 = add(r29,00000010); r23:r22 = combine(00000000,00000000) }

l000087CC:
	{ if (!cmp.eq(r0.new,00000004)) jump:t	000087DC }

l000087D4:
	{ r0 = 00000001 }
	{ r1:r0 = memd(r29+16); p0 = cmp.gt(r20,00000000) }

l000087DC:
	{ r1:r0 = memd(r29+16) }

l000087E0:
	{ memd(r16) = r1:r0; if (!p0) jump:nt	000088EC }

l000087E8:
	{ if (!p0.new) jump:t	000088EC; p0 = cmp.gt(r9,00000003) }

l000087EC:
	{ r1:r0 = combine(00000000,00000000) }
	{ memd(r16+8) = r1:r0; jump	00008870; r0 = r8 }
000087FC                                     00 41 01 B0             .A..
00008800 38 40 00 7C 1A C3 C0 49                         8@.|...I       

l00008808:
	{ memd(r16) = r23:r22; memw(r29) = r0 }
	{ p0 = cmp.gt(r25,00000003); if (!p0.new) r0 = add(r25,r24); if (!p0.new) r1 = add(r29,00000010); if (p0.new) jump:t	00008868 }

l00008818:
	{ p0 = cmp.gt(r25,00000003); if (!p0.new) r0 = add(r25,r24) }

l00008820:
	{ r20 = addasl(r16,r0,00000003); r21 = addasl(r1,r25,00000003) }

l00008828:
	{ if (!cmp.gtu(r17,r0.new)) jump:nt	00008864; r0 = add(r24,r25) }

l00008834:
	{ if (!p0.new) r3:r2 = combine(r19,r18); if (!p0.new) r25 = add(r25,00000001); if (p0.new) jump:nt	00008864; p0 = dfcmp.eq(r1:r0,r27:r26) }

l00008844:
	{ call	0000AB20 }
	{ memd(r21) = r1:r0; memd(r20++#8) = r23:r22; p0 = cmp.gt(r25,00000003); r21 = add(r21,00000008) }
	{ if (!p0) jump:nt	00008828 }

l0000885C:
	{ jump	00008868 }
00008860 19 41 00 78                                     .A.x           

l00008864:
	{ memd(r21) = r23:r22 }

l00008868:
	{ r3:r2 = memd(r29+16) }
	{ if (!p0.new) r0 = add(r29,00000006); if (!p0.new) r1 = add(r29,00000008); if (p0.new) jump:nt	000088F0; p0 = dfcmp.eq(r3:r2,r27:r26) }

l00008870:
	{ if (!p0.new) r0 = add(r29,00000006); if (!p0.new) r1 = add(r29,00000008); if (p0.new) jump:nt	000088F0 }

l0000887C:
	{ memd(r29+8) = r3:r2; call	00008100 }
	{ r0 = add(r29,00000008); r1 = 0000001A; call	00009B50 }
	{ r1 = memh(r29+6); r0 = add(r29,00000008); call	00009B60 }
	{ r3:r2 = memd(r29+8); r1:r0 = combine(r17,r16); call	00008450 }
	{ r1:r0 = memd(r29+16); r3:r2 = memd(r29+8); call	0000A6A4 }
	{ r1:r0 = combine(r17,r16); r3:r2 = combine(r1,r0); call	00008450 }
	{ r1 = memd(r29); r0 = 00000000; nop }
	{ if (!cmp.gtu(r25,r0.new)) jump:nt	000088E8; r0 = add(r0,00000001); r2 = add(r1,00000008) }

l000088C4:
	{ if (!cmp.gtu(r25,r0.new)) jump:nt	000088E8; r0 = add(r0,00000001) }

l000088D0:
	{ memd(r1-8) = r5:r4; r1 = r2; if (!p0.new) jump:t	000088C4; p0 = dfcmp.eq(r5:r4,r27:r26) }

l000088E0:
	{ if (cmp.gtu(r17,r24.new)) jump:t	00008818; r24 = add(r24,00000001); r25 = add(r25,FFFFFFFF) }

l000088E8:
	{ if (cmp.gtu(r17,r24.new)) jump:t	00008818 }

l000088EC:
	{ jump	0000897C; r0 = r8 }

l000088F0:
	{ jump	00008980; r0 = r8 }

;; _LXp_movx: 000088F4
_LXp_movx proc
	{ allocframe(00000008); r1 = r2; r3 = asl(r1,00000003) }
	{ memd(r29) = r17:r16; r2 = r3; r16 = r0; call	000073E0 }
	{ dealloc_return; r17:r16 = memd(r29); r0 = r16 }

;; _LXp_addx: 00008910
_LXp_addx proc
	{ allocframe(+00000020); call	0000A278 }
	{ r19:r18 = combine(r2,r1); r17:r16 = combine(r0,r3) }
	{ if (p0.new) r20 = 00000000; if (!p0.new) jump:nt	0000894C; p0 = cmp.gt(r8,00000000) }

l00008928:
	{ r23:r22 = memd(gp+192) }
	{ r3:r2 = memd(r19) }

l00008930:
	{ if (!p0.new) r1:r0 = combine(r18,r17); if (!p0.new) r19 = add(r19,00000008); if (p0.new) jump:nt	00008950; p0 = dfcmp.eq(r3:r2,r23:r22) }

l00008940:
	{ call	00008450 }
	{ if (cmp.gtu(r16,r20.new)) jump:t	00008930; r20 = add(r20,00000001) }

l0000894C:
	{ jump	00008A1C; r0 = r9 }

l00008950:
	{ jump	00008A20; r0 = r9 }

;; _LXp_subx: 00008954
_LXp_subx proc
	{ allocframe(+00000020); call	0000A278 }
	{ r19:r18 = combine(r2,r1); r17:r16 = combine(r0,r3) }
	{ if (p0.new) r20 = 00000000; if (!p0.new) jump:nt	00008994; p0 = cmp.gt(r8,00000000) }

l0000896C:
	{ r23:r22 = memd(gp+192) }

;; fn00008970: 00008970
;;   Called from:
;;     0000896C (in _LXp_subx)
;;     00008988 (in _LXp_mulh)
fn00008970 proc
	{ r3:r2 = memd(r19) }
	{ if (!p0.new) r1:r0 = combine(r18,r17); if (!p0.new) r20 = add(r20,00000001); if (p0.new) jump:nt	00008998; p0 = dfcmp.eq(r3:r2,r23:r22) }

l0000897C:
	{ if (!p0.new) r1:r0 = combine(r18,r17); if (!p0.new) r20 = add(r20,00000001) }

l00008980:
	{ if (!p0.new) r1:r0 = combine(r18,r17) }

l00008984:
	{ call	00008454; r3 = togglebit(r3,0000001E) }
	{ r19 = add(r19,00000008); if (p0.new) jump:t	00008970; p0 = cmp.gt(r8,-00000001) }

;; fn00008994: 00008994
;;   Called from:
;;     00008964 (in _LXp_subx)
;;     00008988 (in _LXp_mulh)
;;     0000899C (in fn00008970)
fn00008994 proc
	{ nop; jump	00008A44; r0 = r9 }

l00008998:
	{ nop; jump	00008A48; r0 = r9 }

;; _LXp_ldexpx: 000089A0
_LXp_ldexpx proc
	{ allocframe(+00000020); call	0000A278 }
	{ r17:r16 = combine(r1,r0) }
	{ r21:r20 = memd(gp+192) }
	{ nop; nop; r22 = r16 }
	{ r19 = add(r19,00000001); r2 = r18; r23 = add(r22,00000008) }

l000089C4:
	{ r19 = add(r19,00000001); r2 = r18 }
	{ r1:r0 = memd(r22); call	00009470 }
	{ memd(r22) = r1:r0; r22 = r23; if (!p0.new) jump:t	000089C4; p0 = dfcmp.eq(r1:r0,r21:r20) }

l000089E8:
	{ jump	00008A48; r0 = r8 }

;; _LXp_mulx: 000089F0
;;   Called from:
;;     00008B70 (in fn00008B70)
;;     00008B70 (in fn00008B70)
;;     00008B8C (in fn00008B70)
;;     00008B8C (in fn00008B70)
;;     00008CCC (in fn00008CCC)
;;     00008CCC (in fn00008CCC)
;;     00008CDC (in fn00008CCC)
;;     00008CDC (in fn00008CCC)
;;     00008CF8 (in fn00008CCC)
;;     00008CF8 (in fn00008CCC)
;;     00008D10 (in _LXp_sqrtx)
_LXp_mulx proc
	{ allocframe(+00000030); call	0000A270 }
	{ r20 = r4; r19:r18 = combine(r3,r2); r17:r16 = combine(r1,r0) }
	{ if (p0.new) jump:t	00008AB8; p0 = cmp.eq(r9,00000000) }

l00008A08:
	{ if (p0.new) jump:t	00008AB8; p0 = cmp.eq(r11,00000000) }

l00008A0C:
	{ r25:r24 = memd(gp+192); r3:r2 = memd(r18) }
	{ if (p0.new) jump:t	00008A30; p0 = dfcmp.eq(r3:r2,r25:r24) }

;; fn00008A1C: 00008A1C
;;   Called from:
;;     0000894C (in _LXp_addx)
;;     00008A18 (in _LXp_mulx)
fn00008A1C proc
	{ r1:r0 = memd(r18+8) }

;; fn00008A20: 00008A20
;;   Called from:
;;     00008950 (in _LXp_addx)
;;     00008A24 (in fn00008A1C)
fn00008A20 proc
	{ if (!p0.new) r1:r0 = combine(r16,r20); if (!p0.new) jump:nt	00008A40; p0 = dfcmp.eq(r1:r0,r25:r24) }

;; fn00008A2C: 00008A2C
;;   Called from:
;;     00008A20 (in fn00008A20)
;;     00008A20 (in fn00008A20)
;;     00008A30 (in _LXp_mulx)
fn00008A2C proc
	{ r1:r0 = combine(r17,r16); call	00008788 }

l00008A30:
	{ r1:r0 = combine(r17,r16) }

l00008A34:
	{ jump	00008AA4; r0 = r8 }
00008A3C                                     55 C3 11 8C             U...

;; fn00008A40: 00008A40
;;   Called from:
;;     00008A20 (in fn00008A20)
;;     00008A20 (in fn00008A20)
fn00008A40 proc
	{ r2 = r21; call	000073E0 }

l00008A44:
	{ r2 = r21 }

;; fn00008A48: 00008A48
;;   Called from:
;;     00008998 (in fn00008970)
;;     000089E8 (in _LXp_ldexpx)
;;     00008A40 (in fn00008A40)
;;     00008A44 (in fn00008970)
;;     00008AA4 (in fn00008AA4)
fn00008A48 proc
	{ r3:r2 = memd(r18); r1:r0 = combine(r17,r16); call	00008788 }
	{ if (p0.new) r23 = 00000001; if (!p0.new) jump:t	00008AB8; p0 = cmp.gt(r11,00000002) }

l00008A5C:
	{ r22 = addasl(r20,r17,00000003) }
	{ r26 = addasl(r18,r23,00000003) }
	{ r1:r0 = memd(r26) }
	{ if (!p0.new) r1:r0 = combine(r20,r22); if (!p0.new) r2 = add(r21,00000000); if (p0.new) jump:nt	00008ABC; p0 = dfcmp.eq(r1:r0,r25:r24) }

l00008A78:
	{ call	000073E0 }
	{ r1:r0 = combine(r17,r22); call	00008788 }
	{ r3:r2 = memd(r26) }
	{ if (!p0.new) jump:t	00008AB0; p0 = cmp.gt(r9,00000000) }

l00008A90:
	{ r3:r2 = memd(r27) }

l00008A94:
	{ if (!p0.new) r1:r0 = combine(r17,r16); if (!p0.new) r27 = add(r27,00000008); if (p0.new) jump:nt	00008AB4; p0 = dfcmp.eq(r3:r2,r25:r24) }

;; fn00008AA4: 00008AA4
;;   Called from:
;;     00008A34 (in fn00008A2C)
;;     00008A94 (in fn00008A48)
fn00008AA4 proc
	{ call	00008450 }
	{ if (cmp.gtu(r17,r26.new)) jump:t	00008A94; r26 = add(r26,00000001) }

l00008AB0:
	{ r23 = add(r23,00000001) }

l00008AB4:
	{  }

;; fn00008AB8: 00008AB8
;;   Called from:
;;     00008A04 (in _LXp_mulx)
;;     00008A08 (in _LXp_mulx)
;;     00008A54 (in fn00008A48)
;;     00008AB0 (in fn00008A48)
;;     00008AB4 (in fn00008AA4)
fn00008AB8 proc
	{ jump	00008B18; r0 = r8 }

l00008ABC:
	{ jump	00008B1C; r0 = r8 }

;; _LXp_invx: 00008AC0
_LXp_invx proc
	{ allocframe(+00000030); call	0000A270 }
	{ r22 = r2; r17:r16 = combine(r1,r0) }
	{ if (!p0.new) r0 = add(r16,00000000); if (p0.new) jump:nt	00008BFC; p0 = cmp.eq(r9,00000001) }

l00008AD8:
	{ call	00009B70 }
	{ if (!p0.new) jump:t	00008B00; p0 = tstbit(r0,00000000) }

l00008AE0:
	{ if (!p0.new) jump:t	00008BD4; p0 = cmph.eq(r0,0000) }

l00008AE8:
	{ r0 = 0000E620 }
	{ r1:r0 = memd(r0) }
	{ memd(r16) = r1:r0; jump	00008B64; r0 = r8 }

l00008B00:
	{ r27:r26 = memd(r16); r25:r24 = memd(gp+224); r20 = asl(r17,00000003); r19 = addasl(r22,r17,00000003) }
	{ r2 = r20; r1:r0 = combine(r16,r19); call	000073E0 }

l00008B18:
	{ r2 = r20 }

;; fn00008B1C: 00008B1C
;;   Called from:
;;     00008ABC (in fn00008A48)
;;     00008B10 (in _LXp_invx)
;;     00008B18 (in fn00008AB8)
fn00008B1C proc
	{ r3:r2 = combine(r25,r24); r1:r0 = combine(r17,r19); call	00008788 }
	{ if (!p0) r1:r0 = combine(r27,r26); if (!p0.new) r3:r2 = combine(r27,r26); if (!p0.new) jump:t	00008BE8; p0 = cmp.gt(r9,00000002) }

l00008B34:
	{ r25:r24 = memd(gp+216); r3:r2 = memd(r16+8); call	0000A600 }
	{ r1:r0 = combine(r25,r24); r3:r2 = combine(r1,r0); call	0000A880 }
	{ r27:r26 = memd(gp+192); r24 = 00000001; r1:r0 = combine(r17,r16); r3:r2 = combine(r1,r0) }
	{ call	00008354; r21 = addasl(r22,r17,00000004) }

;; fn00008B64: 00008B64
;;   Called from:
;;     00008AF4 (in _LXp_invx)
;;     00008B68 (in fn00008B1C)
fn00008B64 proc
	{ r2 = r20; r1:r0 = combine(r16,r22); call	000073E0 }

l00008B68:
	{ r2 = r20; r1:r0 = combine(r16,r22) }

;; fn00008B70: 00008B70
;;   Called from:
;;     00008B64 (in fn00008B64)
fn00008B70 proc
	{ r1:r0 = combine(r17,r22); r4 = r21; r3:r2 = combine(r17,r19); call	000089F0 }
	{ r3:r2 = memd(gp+216); r1:r0 = combine(r17,r22); call	00008450 }
	{ r4 = r21; r1:r0 = combine(r17,r22); r3:r2 = combine(r17,r16); call	000089F0 }
	{ r18 = r22; r25 = 00000000 }
	{ r3:r2 = memd(r18) }
	{ if (!p0.new) r1:r0 = combine(r17,r16); if (!p0.new) r18 = add(r18,00000008); if (p0.new) jump:nt	00008BC8; p0 = dfcmp.eq(r3:r2,r27:r26) }

;; fn00008BB8: 00008BB8
;;   Called from:
;;     00008BA8 (in fn00008B70)
;;     00008BC8 (in fn00008BC8)
;;     00008BC8 (in fn00008BC8)
fn00008BB8 proc
	{ call	00008450 }
	{ r25 = add(r25,00000001) }
	{ if (cmp.gtu(r17,r24.new)) jump:t	00008B68; r24 = asl(r24,00000001) }

;; fn00008BC8: 00008BC8
;;   Called from:
;;     00008B64 (in fn00008B64)
;;     00008BA8 (in fn00008B70)
;;     00008BA8 (in fn00008B70)
;;     00008BB8 (in fn00008BB8)
fn00008BC8 proc
	{ if (cmp.gtu(r17,r24.new)) jump:t	00008B68 }

l00008BD0:
	{ if (!cmp.eq(r0.new,00000002)) jump:t	00008C00; r0 = zxth(r0) }

;; fn00008BD4: 00008BD4
;;   Called from:
;;     00008AE0 (in _LXp_invx)
fn00008BD4 proc
	{ if (!cmp.eq(r0.new,00000002)) jump:t	00008C00 }

;; fn00008BDC: 00008BDC
;;   Called from:
;;     00008BD4 (in fn00008BD4)
;;     00008BD4 (in fn00008BD4)
fn00008BDC proc
	{ memd(r16) = r1:r0; jump	00008CAC; r0 = r8 }

l00008BE8:
	{ r1:r0 = memd(gp+216); call	0000A880 }
	{ r1:r0 = combine(r17,r16); r3:r2 = combine(r1,r0); call	00008350 }

;; fn00008BFC: 00008BFC
;;   Called from:
;;     00008AD0 (in _LXp_invx)
;;     00008BF0 (in fn00008B1C)
fn00008BFC proc
	{ jump	00008C4C; r0 = r8 }

;; fn00008C00: 00008C00
;;   Called from:
;;     00008BD4 (in fn00008BD4)
;;     00008BD4 (in fn00008BD4)
;;     00008BD4 (in fn00008BD4)
fn00008C00 proc
	{ jump	00008C50; r0 = r8 }

;; _LXp_sqrtx: 00008C04
_LXp_sqrtx proc
	{ allocframe(+00000030); call	0000A270 }
	{ r18 = r2; r17:r16 = combine(r1,r0) }
	{ if (!p0.new) r0 = add(r16,00000000); if (p0.new) jump:nt	00008D20; p0 = cmp.eq(r9,00000001) }

l00008C1C:
	{ call	00009B70 }
	{ r5:r4 = memd(r16); if (p0.new) jump:t	00008C34; p0 = tstbit(r0,00000000) }

l00008C28:
	{ r1:r0 = memd(gp+192) }
	{ if (p0.new) jump:t	00008C64; p0 = dfcmp.ge(r5:r4,r1:r0) }

l00008C34:
	{ r1:r0 = memd(gp+192) }
	{ if (!p0.new) r0 = 00000001; if (p0.new) jump:t	00008D24; p0 = dfcmp.ge(r5:r4,r1:r0) }

l00008C44:
	{ call	00009670 }
	{ r0 = 0000E630 }

;; fn00008C4C: 00008C4C
;;   Called from:
;;     00008BFC (in fn00008BFC)
;;     00008BFC (in fn00008BFC)
;;     00008C54 (in _LXp_sqrtx)
fn00008C4C proc
	{ r0 = 00000030 }

;; fn00008C50: 00008C50
;;   Called from:
;;     00008C00 (in fn00008C00)
;;     00008C4C (in fn00008C4C)
fn00008C50 proc
	{ r1:r0 = memd(r0) }
	{ memd(r16) = r1:r0; jump	00008D44; r0 = r8 }
00008C60 73 52 11 C4                                     sR..           

l00008C64:
	{ if (!p0) r1:r0 = combine(r5,r4); if (!p0.new) jump:t	00008C7C; p0 = cmp.gt(r9,00000002) }

l00008C6C:
	{ r3:r2 = memd(r16+8); call	0000A600 }
	{ r5:r4 = combine(r1,r0) }
	{ r21:r20 = memd(gp+216); r1:r0 = combine(r5,r4); call	00009520 }

l00008C7C:
	{ r21:r20 = memd(gp+216); r1:r0 = combine(r5,r4) }

l00008C84:
	{ r1:r0 = combine(r21,r20); r3:r2 = combine(r1,r0); call	0000A880 }
	{ r1:r0 = combine(r17,r19); r3:r2 = combine(r1,r0); r20 = addasl(r18,r17,00000004); call	00008350 }
	{ if (p0.new) r26 = 00000002; if (!p0.new) jump:t	00008D10; p0 = cmp.gt(r9,00000004) }

l00008CA8:
	{ r25:r24 = memd(gp+240); r23:r22 = memd(gp+232); r21 = asl(r17,00000003) }

;; fn00008CAC: 00008CAC
;;   Called from:
;;     00008BDC (in fn00008BDC)
;;     00008CB0 (in _LXp_sqrtx)
fn00008CAC proc
	{ r25:r24 = memd(gp+240); r23:r22 = memd(gp+232) }
	{ r2 = r21; r1:r0 = combine(r19,r18); call	000073E0 }

;; fn00008CB8: 00008CB8
;;   Called from:
;;     00008CB4 (in fn00008CAC)
;;     00008D08 (in fn00008CCC)
;;     00008D08 (in fn00008CCC)
;;     00008D14 (in fn00008D14)
fn00008CB8 proc
	{ r2 = r21; r1:r0 = combine(r19,r18) }
	{ r3:r2 = combine(r23,r22); r1:r0 = combine(r17,r18); call	00008788 }

;; fn00008CCC: 00008CCC
;;   Called from:
;;     00008CB8 (in fn00008CB8)
;;     00008CC0 (in _LXp_sqrtx)
fn00008CCC proc
	{ r3:r2 = combine(r17,r16); r1:r0 = combine(r17,r18); r4 = r20; call	000089F0 }
	{ r4 = r20; r1:r0 = combine(r17,r18); r3:r2 = combine(r17,r19); call	000089F0 }
	{ r3:r2 = combine(r25,r24); r1:r0 = combine(r17,r18); call	00008450 }
	{ r4 = r20; r3:r2 = combine(r17,r18); r1:r0 = combine(r17,r19); call	000089F0 }
	{ if (cmp.gtu(r17,r26.new)) jump:t	00008CB8; r26 = asl(r26,00000001) }

l00008D10:
	{ r3:r2 = combine(r17,r19); r4 = r20; r1:r0 = combine(r17,r16); call	000089F0 }

;; fn00008D14: 00008D14
;;   Called from:
;;     00008D08 (in fn00008CCC)
;;     00008D08 (in fn00008CCC)
fn00008D14 proc
	{ r3:r2 = combine(r17,r19); r4 = r20; r1:r0 = combine(r17,r16) }

;; fn00008D20: 00008D20
;;   Called from:
;;     00008C14 (in _LXp_sqrtx)
;;     00008D10 (in _LXp_sqrtx)
;;     00008D14 (in fn00008D14)
fn00008D20 proc
	{ jump	00008DE0; r0 = r8 }

l00008D24:
	{ jump	00008DE4; r0 = r8 }
00008D28                         00 C0 00 7F 00 C0 00 7F         ........

;; _Mbtowcx: 00008D30
;;   Called from:
;;     00008F5C (in _Mbtowc)
_Mbtowcx proc
	{ allocframe(00000000); p0 = cmp.eq(r1,00000000) }
	{ r6 = memh(r3+6); r5 = memw(r3) }
	{ r7 = memw(r4) }
	{ if (!p0) r8 = 00000000; if (!p0) r7 = add(r1,00000000); if (p0) jump:nt	00008EFC }

;; fn00008D44: 00008D44
;;   Called from:
;;     00008C54 (in fn00008C4C)
;;     00008C54 (in fn00008C50)
fn00008D44 proc
	{ if (!p0) r8 = 00000000; if (!p0) r7 = add(r1,00000000) }

;; fn00008D4C: 00008D4C
;;   Called from:
;;     00008D44 (in fn00008D44)
;;     00008D44 (in fn00008D44)
;;     00008D44 (in fn00008D44)
;;     00008DE0 (in fn00008DE0)
;;     00008DEC (in fn00008DEC)
fn00008D4C proc
	{ if (p0.new) jump:nt	00008EDC; p0 = cmp.eq(r2,00000001) }

l00008D50:
	{ if (!p0.new) r6 = zxtb(r6); if (!p0.new) r8 = add(r8,00000001); if (p0.new) jump:nt	00008EF0; p0 = cmpb.gtu(r6,0F) }

l00008D60:
	{ if (cmp.eq(r6.new,00000001)) jump:nt	00008EF8; r6 = memw(r6+r6<<#2); p0 = cmp.gt(r8,00000FEF) }

l00008D74:
	{ if (!p0) r12 = memb(r7); if (!p0) r13 = add(r5,00000000) }
	{ if (cmp.eq(r6.new,00000001)) jump:nt	00008EF0; r6 = memuh(r4+r12<<#1) }

l00008D88:
	{ r14 = and(r6,000000FF); r15 = and(r6,00000000) }
	{ p0 = cmp.eq(r15,00000000); r9 = and(r6,00004000); r13 = or(r14,and(r13,FFFFFF00)) }
	{ if (!p0) r5 = add(r13,00000000); p1 = cmp.eq(r9,00000000); r14 = and(r6,00001000) }
	{ p0 = cmp.eq(r14,00000000); r9 = asl(r5,00000008) }
	{ if (p1) jump:nt	00008DE0; r9 |= lsr(r5,00000018) }

l00008DC0:
	{ if (p2.new) r13 = FFFFFFFF; if (!p1.new) r7 = add(r7,00000001); p1 = cmp.eq(r12,00000000); p2 = !cmp.eq(r12,00000000) }
	{ if (!p1) r8 = 00000000; if (!p2) r13 = 00000000 }
	{ r2 = add(r13,r2) }
	{ if (!p0) r5 = add(r9,00000000); r12 = and(r6,00002000); r6 = extractu(r6,00000004,0000000C) }

;; fn00008DE0: 00008DE0
;;   Called from:
;;     00008D20 (in fn00008D20)
;;     00008DC4 (in fn00008D4C)
fn00008DE0 proc
	{ if (!p0) r5 = add(r9,00000000); r12 = and(r6,00002000) }

;; fn00008DE4: 00008DE4
;;   Called from:
;;     00008D24 (in _LXp_sqrtx)
fn00008DE4 proc
	{ if (!p0) r5 = add(r9,00000000); r12 = and(r6,00000000) }

;; fn00008DEC: 00008DEC
;;   Called from:
;;     00008DE4 (in fn00008DE4)
;;     00008DE4 (in fn00008D4C)
;;     00008DE4 (in fn00008DE4)
;;     00008DE4 (in fn00008DE4)
fn00008DEC proc
	{ p0 = cmp.eq(r12,00000000); if (!p0.new) r2 = sub(r7,r1); if (p0.new) jump:t	00008D4C }

l00008DF8:
	{ memw(r3) = r5; p0 = cmp.eq(r0,00000000); p1 = cmp.eq(r7,r1) }
	{ if (!p1) r0 = add(r2,00000000); if (p1) r0 = FFFFFFFD; p0 = cmp.eq(r5,00000000) }
	{ memuh(r3+8) = r6; r0 = -00000001 }
	{ dealloc_return }
00008E18                         7E C0 01 10 60 40 02 10         ~...`@..
00008E20 24 E0 81 74 00 40 06 DD 16 58 20 5C E7 FF 24 97 $..t.@...X \..$.
00008E30 05 50 07 76 78 C0 03 24 05 DC 07 76 1E 58 20 5C .P.vx..$...v.X \
00008E40 26 60 00 7E 00 D8 05 75 44 40 00 58 E5 C3 07 76 &`.~...uD@.X...v
00008E50 08 D8 07 76 4C 48 20 5C E6 7F 06 74 00 D0 08 75 ...vLH \...t...u
00008E60 00 40 06 DD E7 C7 07 76 C7 C6 45 8E 32 40 20 5C .@.....v..E.2@ \
00008E70 05 C0 67 70 56 C0 00 58 05 DE 07 76 0A 58 20 5C ..gpV..X...v.X \
00008E80 46 60 00 7E 00 DC 05 75 24 40 00 58 E5 C1 07 76 F`.~...u$@.X...v
00008E90 05 DF 07 76 0A 58 20 5C 66 60 00 7E 00 DE 05 75 ...v.X \f`.~...u
00008EA0 18 40 00 58 E5 C0 07 76 85 DF 07 76 0A 58 20 5C .@.X...v...v.X \
00008EB0 A6 60 00 7E 80 DF 05 75 0C 40 00 58 65 C0 07 76 .`.~...u.@.Xe..v
00008EC0 16 48 20 5C 86 60 00 7E 00 DF 05 75 65 C0 07 76 .H \.`.~...ue..v
00008ED0 24 40 04 B0 E2 7F E2 BF AA E0 72 24             $@........r$   

l00008EDC:
	{ memw(r3) = r5; r0 = and(r6,000000FF); r2 = FFFFFFFE }
	{ memuh(r3+8) = r0; r0 = r2 }
	{ dealloc_return }
00008EEC                                     12 F0 FF 5B             ...[

l00008EF0:
	{ memw(r0) = 00000058; r2 = FFFFFFFF }

l00008EF8:
	{ dealloc_return; r0 = r2 }

l00008EFC:
	{ memw(r3) = 00000000; memw(r3+4) = 00000000 }
	{ r0 = memw(r4) }
	{ r0 = memuh(r0) }
	{ r2 = and(r0,00000F00) }
	{ dealloc_return; r0 = r2 }
00008F14             02 40 00 78 31 10 30 F0 40 3F 20 50     .@.x1.0.@? P
00008F20 00 40 00 75 02 40 00 78 00 C7 80 46 F8 40 37 10 .@.u.@.x...F.@7.
00008F30 82 64 21 FB 80 C1 23 3C 40 3F 20 50             .d!...#<@? P   

;; _Mbtowc: 00008F3C
;;   Called from:
;;     000057C4 (in _Printf)
_Mbtowc proc
	{ allocframe(00000010); memd(r29+496) = r17:r16 }
	{ memd(r29) = r19:r18; r19:r18 = combine(r1,r2); r17:r16 = combine(r0,r3); call	00006604 }
	{ r17:r16 = memd(r29+8); r4 = r0; r1:r0 = combine(r19,r17); r3:r2 = combine(r16,r18) }
	{ deallocframe; r19:r18 = memd(r29); jump	00008D30 }
00008F64             00 C0 00 7F 00 C0 00 7F 00 C0 00 7F     ............

;; _Tls_get__Wcstate: 00008F70
;;   Called from:
;;     00006E14 (in _Wctomb)
;;     0000901C (in _Getpwcstate)
_Tls_get__Wcstate proc
	{ allocframe(00000010); memd(r29+496) = r17:r16; r1 = 00000001 }
	{ r17 = 00010058; r16 = 00010054 }
	{ memd(r29) = r19:r18 }

l00008F8C:
	{ r0 = memw_locked(r16) }
	{ p0 = cmp.gt(r0,00000000) }
	{ if (p0) jump:nt	00008FA0 }

l00008F98:
	{ memw_locked(r16,p0) = r1 }
	{ if (!p0) jump:nt	00008F8C }

l00008FA0:
	{ if (p0.new) r18 = 00000002; if (!p0.new) jump:t	00008FC0; p0 = cmp.eq(r0,00000000) }

l00008FA8:
	{ r1 = 00006FF0; r0 = 00010058 }
	{ call	0000B150 }
	{ memw(r16) = r18 }

l00008FC0:
	{ if (!cmp.gt(r0.new,00000002)) jump:t	00008FC4; r0 = memw(r16) }

l00008FC4:
	{ if (!cmp.gt(r0.new,00000002)) jump:t	00008FC4 }

l00008FCC:
	{ r0 = memw(r17) }
	{ if (!cmp.eq(r16.new,00000000)) jump:t	00009018; r16 = r0; r1:r0 = combine(00000040,00000001) }

l00008FE0:
	{ if (cmp.eq(r16.new,00000000)) jump:nt	00009014; r16 = r0 }

l00008FEC:
	{ r0 = memw(r17); r1 = r16 }
	{ if (p0.new) jump:nt	00009000; p0 = cmp.eq(r0,00000000) }

l00008FF4:
	{ r0 = r16; r16 = 00000000; call	00006FF0 }
	{ jump	00009010 }

l00009000:
	{ call	0000A380 }
	{ r2 = 00000040 }

l00009010:
	{ r19:r18 = memd(r29); r17:r16 = memd(r29+8); r0 = r16 }

l00009014:
	{ r19:r18 = memd(r29); r17:r16 = memd(r29+8) }

l00009018:
	{ dealloc_return }

;; _Getpwcstate: 0000901C
_Getpwcstate proc
	{ jump	00008F70 }

;; _Atrealloc: 00009020
;;   Called from:
;;     00006F40 (in atexit)
;;     000095A4 (in _Atexit)
_Atrealloc proc
	{ allocframe(00000008); memd(r29+496) = r17:r16 }
	{ r17 = memw(gp+4) }
	{ r0 = r17 }
	{ r0 += lsr(r0,00000001) }
	{ call	00007224; r0 = asl(r0,00000002) }
	{ if (cmp.eq(r16.new,00000000)) jump:nt	000090BC; r16 = r0; r1 = 00000000 }

l00009048:
	{ r1 = memw(gp+8); r2 = memw(gp+64); r0 = r16 }
	{ call	000073E4; r2 = asl(r2,00000002) }
	{ r3 = memw(gp+4); r0 = memw(gp+12) }
	{ r1 = memw(gp+8); r3 = sub(r3,r0); r2 = add(r0,r17) }
	{ r0 = addasl(r16,r2,00000002); r1 = addasl(r1,r0,00000002) }
	{ call	000073E4; r2 = asl(r3,00000002) }
	{ r0 = memw(gp+8) }
	{ r1 = 0000E940 }
	{ call	00006FF0 }
	{ r2 = memw(gp+4); r0 = memw(gp+12); r1 = 00000001 }
	{ memw(gp+512) = r16; r0 = add(r2,r17); r3 = add(r0,r17) }
	{ memw(gp) = r0; memw(gp+96) = r3 }
	{ dealloc_return; r17:r16 = memd(r29); r0 = r1 }

l000090BC:
	{ nop }

;; _Closreg: 000090C0
;;   Called from:
;;     00007A80 (in _Fwprep)
;;     000090BC (in _Atrealloc)
_Closreg proc
	{ allocframe(00000008); memd(r29+496) = r17:r16; r1 = 00000001 }
	{ r16 = 0001005C }

l000090D0:
	{ r0 = memw_locked(r16) }
	{ p0 = cmp.gt(r0,00000000) }
	{ if (p0) jump:nt	000090E4 }

l000090DC:
	{ memw_locked(r16,p0) = r1 }
	{ if (!p0) jump:nt	000090D0 }

l000090E4:
	{ if (p0.new) r0 = 00000002; if (!p0.new) jump:t	00009108; p0 = cmp.eq(r0,00000000) }

l000090EC:
	{ call	00006A44 }
	{ r0 = 00009114; call	00009590 }
	{ r17 = 00000002; r0 = 00000002; call	00006AF8 }
	{ memw(r16) = r17 }

l00009108:
	{ if (!cmp.gt(r0.new,00000002)) jump:t	0000910C; r0 = memw(r16) }

l0000910C:
	{ if (!cmp.gt(r0.new,00000002)) jump:t	0000910C }

;; closeall: 00009114
;;   Called from:
;;     00009108 (in closeall)
;;     00009108 (in _Closreg)
;;     0000910C (in _Closreg)
closeall proc
	{ allocframe(00000008); memd(r29+496) = r17:r16; r17:r16 = combine(0000E514,00000038) }
	{ if (cmp.eq(r0.new,00000000)) jump:t	00009130; r0 = memw(r16) }
	{ r17 = add(r17,FFFFFFFF); r16 = add(r16,00000004) }
	{ dealloc_return; r17:r16 = memd(r29) }
	{ nop }

;; fclose: 00009140
fclose proc
	{ allocframe(00000010); memd(r29+496) = r17:r16; r16 = r0 }
	{ memd(r29) = r19:r18; r0 = memb(r16) }
	{ if (cmp.eq(r0.new,00000000)) jump:nt	000091D4; r0 = and(r0,00000003) }

l00009158:
	{ if (!tstbit(r0.new,-00000001)) jump:nt	000091D4 }

l00009160:
	{ r0 = r16 }
	{ r17 = r0; r0 = 00000002; call	00006A44 }
	{ r0 = memb(r16) }
	{ if (cmp.eq(r0.new,00000000)) jump:nt	00009184; r0 = and(r0,00000040) }

l0000917C:
	{ r0 = memw(r16+8) }
	{ memw(r16+8) = 00000000; r0 = memw(r16+4); call	000094E0 }

l00009184:
	{ memw(r16+8) = 00000000; r0 = memw(r16+4) }

l00009188:
	{ r1 = memw(r16+64); if (!p0.new) r17 = FFFFFFFF; p0 = cmp.eq(r0,00000000) }
	{ r0 = r1; call	00009510 }
	{ r1 = memw(r16+64); r18 = r0 }
	{ r0 = r1; call	00006FF0 }
	{ memw(r16+64) = 00000000; if (!p0.new) r17 = FFFFFFFF; p0 = cmp.eq(r18,00000000) }
	{ r0 = r16; call	00009720 }
	{ r0 = 00000002; call	00006AF8 }
	{ jump	000091F4 }
000091D0 3A 6C FF 5B                                     :l.[           

l000091D4:
	{ r0 = 00000002 }
	{ r0 = r16; call	00009720 }
	{ r0 = 00000002; call	00006AF8 }
	{ r17 = FFFFFFFF; call	00006F10 }
	{ memw(r0) = 00000009 }

l000091F4:
	{ r19:r18 = memd(r29); r17:r16 = memd(r29+8); r0 = r17 }
	{ dealloc_return }

;; fflush: 00009200
;;   Called from:
;;     000071A4 (in fwrite)
;;     000071D8 (in fwrite)
;;     0000933C (in fputc)
;;     00009424 (in fputs)
fflush proc
	{ allocframe(00000010); memd(r29+496) = r17:r16; r16 = r0 }
	{ memd(r29) = r19:r18; if (!p0.new) r0 = add(r16,00000000); if (p0.new) jump:nt	0000926C; p0 = cmp.eq(r8,00000000) }

l00009214:
	{ call	00006958 }
	{ r0 = memuh(r16) }
	{ r1 = and(r0,00002000) }
	{ r17 = memw(r16+8) }
	{ r1 = memw(r16+16) }
	{ r0 = memw(r16+4); r1 = r17; r2 = sub(r1,r17); call	000094F0 }
	{ if (p0.new) r17 = add(r17,r0); if (!p0.new) jump:nt	000092C4; p0 = cmp.gt(r0,00000000) }

l00009248:
	{ r1 = memw(r16+16) }
	{ r0 = memh(r16); r17 = memw(r16+8) }
	{ memw(r16+16) = r17; r0 = r16; r1 = and(r0,0000DFFF) }
	{ memw(r16+24) = r17; memw(r16+52) = r17 }
	{ memuh(r16) = r1; jump	000092B0 }

l0000926C:
	{ r17:r16 = combine(0000E500,00000038); r0 = 00000002; call	00006A44 }
	{ r18 = 00000014 }
	{ if (cmp.eq(r0.new,00000000)) jump:t	00009298; r0 = memw(r16) }

l0000928C:
	{ if (!p0.new) r17 = FFFFFFFF; p0 = cmp.gt(r0,FFFFFFFF) }
	{ if (!cmp.eq(r18.new,00000001)) jump:t	0000928C; r18 = add(r18,FFFFFFFF); r16 = add(r16,00000004); r0 = 00000002 }

l00009298:
	{ if (!cmp.eq(r18.new,00000001)) jump:t	0000928C; r18 = add(r18,FFFFFFFF); r16 = add(r16,00000004) }

l000092A8:
	{ jump	000092B8 }
000092AC                                     00 C0 70 70             ..pp

l000092B0:
	{ r17 = 00000000 }

l000092B4:
	{ call	00006A10 }

l000092B8:
	{ r19:r18 = memd(r29); r17:r16 = memd(r29+8); r0 = r17 }
	{ dealloc_return }

l000092C4:
	{ r2 = memh(r16); r1 = memw(r16+8); r17 = FFFFFFFF; r0 = r16 }
	{ memw(r16+52) = r1; memw(r16+16) = r1; r2 = setbit(r2,00000012) }
	{ memuh(r16+8) = r2; memw(r16+24) = r1; jump	000092B4 }

;; fputc: 000092E0
;;   Called from:
;;     000073A8 (in puts)
fputc proc
	{ allocframe(00000008); memd(r29+496) = r17:r16; r17:r16 = combine(r1,r0) }
	{ r0 = r17; call	00006958 }
	{ r0 = memw(r17+16) }
	{ r1 = memw(r17+24) }
	{ r0 = r17; call	000079C0 }
	{ if (p0.new) r0 = memw(r17+16); if (!p0.new) jump:t	00009348; p0 = tstbit(r0,00000000) }

l0000930C:
	{ r1 = add(r0,00000001); p0 = cmpb.eq(r16,0A) }
	{ memb(r0) = r16 }
	{ r0 = memuh(r17) }
	{ r1 = and(r0,00000800) }
	{ if (cmp.eq(r0.new,00000000)) jump:nt	00009358; r0 = and(r0,00000400) }

l0000933C:
	{ r0 = r17; call	00009200 }
	{ if (p0.new) jump:nt	00009350; p0 = cmp.eq(r0,00000000) }

l00009348:
	{ r16 = FFFFFFFF; jump	00009354; r0 = r9 }

l00009350:
	{ r16 = and(r16,000000FF); r0 = r17 }

l00009354:
	{ call	00006A10 }

l00009358:
	{ dealloc_return; r17:r16 = memd(r29); r0 = r16 }

;; fputs: 00009360
;;   Called from:
;;     00007394 (in puts)
;;     000077D8 (in raise)
;;     00007850 (in raise)
;;     0000786C (in raise)
fputs proc
	{ allocframe(00000020); memd(r29+496) = r17:r16; r17:r16 = combine(r0,r1) }
	{ memd(r29+16) = r19:r18; r0 = r16; call	00006958 }
	{ jump	00009378 }

l00009374:
	{ r17 = add(r17,r18) }

l00009378:
	{ if (cmp.eq(r0.new,00000000)) jump:nt	00009434; r0 = memb(r17) }

l00009384:
	{ r1 = memw(r16+24); r0 = r16 }
	{ call	000079C0 }
	{ if (!p0.new) jump:t	00009448; p0 = tstbit(r0,00000000) }

l00009398:
	{ r0 = memb(r16+1) }
	{ if (cmp.eq(r0.new,00000000)) jump:t	000093B4; r0 = and(r0,00000004) }

l000093A8:
	{  }
	{ if (!p0.new) jump:t	000093CC; p0 = cmp.eq(r0,00000000) }

l000093B0:
	{ r0 = r17; call	000076E0 }

l000093B4:
	{ r0 = r17 }

l000093B8:
	{ r3 = r0; p0 = or(p0,!p0) }
	{ jump	000093E0; r1 = p0 }

l000093CC:
	{ r3 = add(r0,sub(00000041,r17)); p0 = and(p0,p0) }
	{ memb(r29+2) = r0.new; r0 = p0 }

l000093E0:
	{ r2 = memw(r16+24); r0 = memw(r16+16) }
	{ r4 = sub(r2,r0) }
	{ p0 = cmp.gtu(r3,r4); r18 = minu(r3,r4) }
	{ r2 = r18; call	000073E4; r3 = p0 }
	{ r1 = memd(r29+4); r0 = memw(r16+16) }
	{ memb(r16+4) = r0.new; r0 = add(r0,r18); if (p0.new) jump:t	00009378; p0 = r1 }

l00009418:
	{ if (!p0.new) r0 = add(r16,00000000); if (p0.new) jump:t	00009378; p0 = r0 }

l00009424:
	{ call	00009200 }
	{ if (p0.new) jump:t	00009374; p0 = cmp.eq(r16,00000001) }

l0000942C:
	{ jump	00009448 }
00009430 20 C0 30 91                                      .0.           

l00009434:
	{ if (cmp.eq(r0.new,00000000)) jump:nt	00009454; r0 = and(r0,00000008) }

l00009440:
	{ r0 = r16 }
	{ if (p0.new) jump:nt	00009450; p0 = cmp.eq(r0,00000000) }

l00009448:
	{ r16 = FFFFFFFF; jump	00009454; r0 = r8 }

l00009450:
	{ r0 = r16; r16 = 00000000 }

l00009454:
	{ call	00006A10 }
	{ r19:r18 = memd(r29+16); r17:r16 = memd(r29+24); r0 = r16 }
	{ dealloc_return }
00009464             00 C0 00 7F 00 C0 00 7F 00 C0 00 7F     ............

;; ldexpl: 00009470
;;   Called from:
;;     000089D0 (in _LXp_ldexpx)
ldexpl proc
	{ allocframe(00000010); memd(r29+496) = r17:r16; r16 = r2 }
	{ memd(r29) = r1:r0; if (!p0.new) r0 = add(r29,00000000); if (p0.new) jump:nt	000094AC; p0 = cmp.eq(r8,00000000) }

l00009484:
	{ call	00009B70 }
	{ if (p0.new) jump:t	000094AC; p0 = tstbit(r0,00000000) }

l0000948C:
	{ r1 = r16; r0 = add(r29,00000000); call	00009B60 }
	{ if (p0.new) r0 = 00000004; jump	000094AC; if (!p0.new) jump:t	000094A0; p0 = cmp.eq(r0,00000002) }
000094A0 06 60 40 10 00 E1 00 7E E4 C0 00 5A             .`@....~...Z   

l000094AC:
	{ r17:r16 = memd(r29+8); r1:r0 = memd(r29) }
	{ dealloc_return }
000094B4             00 C0 00 7F 00 C0 00 7F 00 C0 00 7F     ............

;; ldiv: 000094C0
ldiv proc
	{ allocframe(00000008); memd(r29+496) = r17:r16; r17:r16 = combine(r1,r0); call	0000A460 }
	{ r2 = mpyi(r0,r17) }
	{ dealloc_return; r17:r16 = memd(r29); r1 = sub(r16,r2) }
000094D8                         00 C0 00 7F 00 C0 00 7F         ........

;; close: 000094E0
;;   Called from:
;;     00009180 (in fclose)
close proc
	{ jump	0000AFC0 }
000094E4             00 C0 00 7F 00 C0 00 7F 00 C0 00 7F     ............

;; write: 000094F0
;;   Called from:
;;     00009234 (in fflush)
write proc
	{ allocframe(00000008); memd(r29+496) = r17:r16; r16 = r2; call	0000B2A0 }
	{ dealloc_return; r17:r16 = memd(r29); r0 = sub(r16,r0) }
00009504             00 C0 00 7F 00 C0 00 7F 00 C0 00 7F     ............

;; remove: 00009510
;;   Called from:
;;     00009198 (in fclose)
remove proc
	{ jump	0000B020 }
00009514             00 C0 00 7F 00 C0 00 7F 00 C0 00 7F     ............

;; sqrtl: 00009520
;;   Called from:
;;     00008C78 (in _LXp_sqrtx)
sqrtl proc
	{ allocframe(00000018); memd(r29+496) = r17:r16; r17:r16 = combine(r1,r0) }
	{ memd(r29+8) = r17:r16; r1 = add(r29,00000008); r0 = add(r29,00000006); call	00008100 }
	{ if (p0.new) jump:nt	00009558; p0 = cmp.eq(r0,00000000) }

l00009538:
	{ if (p0.new) jump:t	00009540; p0 = cmp.eq(r0,00000002) }

l0000953C:
	{ if (p0.new) jump:t	00009558; p0 = cmp.eq(r0,00000004) }

l00009540:
	{ r0 = add(r29,00000008) }
	{ r0 = or(r0,00000006) }
	{ if (tstbit(r0.new,-00000001)) jump:t	0000955C; r0 = memh(r0) }

l00009554:
	{ r0 = 00000001 }

l00009558:
	{ r1:r0 = combine(r17,r16); call	0000ADC0 }

l0000955C:
	{ r1:r0 = combine(r17,r16) }

l00009560:
	{ dealloc_return; r17:r16 = memd(r29+16) }
00009564             00 C0 00 7F 00 C0 00 7F 00 C0 00 7F     ............

;; strrchr: 00009570
strrchr proc
	{ r1 = and(r1,000000FF); r2 = 00000000 }

l00009574:
	{ r3 = r0 }
	{ r4 = memb(r3++#1) }
	{ p0 = cmp.eq(r4,00000000); r0 = r3; if (p1.new) r2 = add(r0,00000000); p1 = cmp.eq(r4,r1) }
	{ if (!p0) jump:nt	00009574 }

l0000958C:
	{ jumpr	r31; r0 = r2 }

;; _Atexit: 00009590
;;   Called from:
;;     000090F0 (in _Closreg)
_Atexit proc
	{ allocframe(00000008); memd(r29+496) = r17:r16; r16 = r0 }
	{ r2 = memw(gp+64) }
	{ r1 = memw(gp+12) }
	{ call	00009020 }
	{ if (p0.new) jump:nt	000095C4; p0 = cmp.eq(r0,00000000) }

l000095AC:
	{ r1 = memw(gp+12) }
	{ r1 = memw(gp+8); r0 = add(r1,FFFFFFFF) }
	{ memw(r30+r0<<#2) = r16; memw(gp) = r0 }
	{ dealloc_return; r17:r16 = memd(r29) }

l000095C4:
	{ call	00006E30 }
	{ nop }
	{ nop }

;; _Dunscale: 000095D0
;;   Called from:
;;     00008100 (in _LDunscale)
;;     000095CC (in _Atexit)
;;     0000B318 (in sqrt)
_Dunscale proc
	{ allocframe(00000008); memd(r29+496) = r17:r16; r17:r16 = combine(r0,r1) }
	{ r2 = memh(r16+6); r0 = r16 }
	{ r1 = extractu(r2,0000000B,00000003) }
	{ call	00009E20 }
	{ r1 = r0; r0 = 00000000 }
	{ memuh(r17) = 0000; jump	00009664 }
000095FC                                     00 C0 C1 70             ...p
00009600 40 40 00 78 E3 7F 03 78 22 E0 43 20 00 C0 31 3C @@.x...x".C ..1<
00009610 C1 C0 30 91 E1 41 01 76 28 E0 43 24 41 40 70 91 ..0..A.v(.C$A@p.
00009620 24 E0 43 24 21 40 70 91 20 E0 43 24 00 C0 70 91 $.C$!@p. .C$..p.
00009630 1A 40 00 58 10 40 00 75 40 60 00 7E 20 E0 80 7E .@.X.@.u@`.~ ..~
00009640 62 C0 50 91 03 7C 1F 78 41 40 C1 BF FF 43 00 00 b.P..|.xA@...C..
00009650 E0 C7 00 78 00 42 00 00 E3 41 42 DA 03 CA B0 A1 ...x.B...AB.....
00009660 00 C1 51 A1                                     ..Q.           

l00009664:
	{ dealloc_return; r17:r16 = memd(r29); r0 = sxth(r0) }
0000966C                                     00 C0 00 7F             ....

;; _Feraise: 00009670
;;   Called from:
;;     00008C44 (in _LXp_sqrtx)
_Feraise proc
	{ allocframe(+00000008); r2 = and(r0,0000000C); r1 = setbit(r0,00000008) }
	{ memd(r29) = r17:r16; p0 = cmp.eq(r2,00000000); if (!p0.new) r16 = add(r1,00000000); if (p0.new) r16 = add(r0,00000000) }
	{ r17 = and(r16,00000003); r0 = r16; call	00009BA0 }
	{ if (p0.new) jump:nt	000096A8; p0 = cmp.eq(r9,00000000) }

l00009698:
	{ call	00006F10 }
	{ memw(r0) = 00000021; r17:r16 = memd(r29) }
	{ dealloc_return }

l000096A8:
	{ if (cmp.eq(r0.new,00000000)) jump:nt	000096BC; r0 = and(r16,0000000C) }

l000096B4:
	{ memw(r0) = 00000022 }
	{ dealloc_return; r17:r16 = memd(r29) }

l000096BC:
	{ nop }

;; _Fofind: 000096C0
;;   Called from:
;;     000096BC (in _Feraise)
_Fofind proc
	{ allocframe(00000008); memd(r29+496) = r17:r16; r17:r16 = combine(0000E538,00000000) }
	{ if (p0.new) jump:t	000096F4; p0 = cmp.gtu(r8,-00000001) }

l000096D0:
	{ if (cmp.eq(r0.new,00000000)) jump:nt	00009700; r0 = memw(r17) }

l000096DC:
	{ r1 = memuh(r0); r16 = add(r16,00000001) }
	{ memuh(r0) = FF7F; jump	0000971C }

l000096F4:
	{ dealloc_return; r17:r16 = memd(r29); r0 = 00000000 }
000096FC                                     92 6D FF 5B             .m.[

l00009700:
	{ r0 = 00000050 }
	{ if (p0.new) jump:nt	0000971C; p0 = cmp.eq(r0,00000000) }

l00009708:
	{ memb(r0+2) = r16; memw(r17) = r0 }
	{ memuh(r0) = 0080; r17:r16 = memd(r29) }
	{ dealloc_return }

l0000971C:
	{ dealloc_return; r17:r16 = memd(r29) }

;; _Fofree: 00009720
;;   Called from:
;;     000091BC (in fclose)
;;     000091D8 (in fclose)
_Fofree proc
	{ allocframe(+00000000); r2 = add(r0,0000004C) }
	{ r1 = memb(r0) }
	{ r1 = and(r1,00000080) }
	{ r1 = -00000001; r2 = 00000034; nop }

l00009740:
	{ r1 = add(r1,00000001) }
	{ r4 = memw(r2+4); r2 = add(r2,00000004) }
	{ if (p0.new) r3 = add(r2,00000000); if (!p0.new) jump:t	00009740; p0 = cmp.eq(r4,-00000001) }

l00009754:
	{ memw(r3) = 00000000 }
	{ call	00006FF0 }
	{ dealloc_return }
00009760 81 45 00 B0 FF 60 40 3C 00 C0 20 3C 02 06 02 AD .E...`@<.. <....
00009770 02 05 02 AC 02 02 02 A4 01 08 02 A7 1E C0 1E 96 ................

;; _Genld: 00009780
_Genld proc
	{ allocframe(+00000030); call	0000A278 }
	{ r17:r16 = combine(r2,r0); r19:r18 = combine(r4,r3); r20 = r1; call	00009CEC }
	{ r0 = memw(r0+44); r3:r2 = combine(0000D788,00000001); r1 = setbit(r20,0000000A) }
	{ if (!p0.new) r17 = add(r3,00000000); p1 = cmp.eq(r1,00000066); p0 = cmp.gt(r18,00000000); r18 = max(r2,r18) }
	{ r21 = memb(r0); if (p1) jump:nt	000097E0 }

l000097C0:
	{ p2 = cmp.eq(r20,00000047); p0 = cmp.eq(r20,00000067) }
	{ if (!p3.new) jump:t	00009800; p3 = or(p0,p2) }

l000097D0:
	{ p3 = cmp.gt(r19,FFFFFFFB); if (!p3.new) jump:t	000097FC }

l000097D8:
	{ if (!cmp.gt(r19,r0.new)) jump:t	00009800; r0 = memw(r16+48) }

l000097E0:
	{ if (!p1) r0 = memb(r16-4); r20 = add(r19,00000001); if (p1) jump:nt	00009868 }

l000097E4:
	{ if (!p1) r0 = memb(r16-4); r20 = add(r19,00000001) }

l000097EC:
	{ if (cmp.eq(r0.new,00000000)) jump:nt	00009848; r0 = and(r0,00000008) }

l000097F8:
	{ r0 = memw(r16+48) }

l000097FC:
	{ if (!p2) r22 = 00000070; if (p2) jump:nt	00009810 }

l00009800:
	{ if (!p2) r22 = 00000070 }

l00009804:
	{ p1 = cmp.eq(r20,00000061); if (!p0) jump:nt	000099CC; if (p1.new) jump:t	000099D4 }

l00009810:
	{ if (!cmp.gt(r18,r0.new)) jump:t	00009830; r0 = memw(r16+48) }
	{ r1 = and(r1,00000008) }
	{ if (p1.new) memw(r16+48) = r18; if (p1.new) r0 = add(r18,00000000); p1 = cmp.eq(r1,00000000) }
	{ r1 = 00000000; r0 = add(r0,FFFFFFFF); if (!p0) r22 = 00000045; if (p0) r22 = 00000065 }
	{ memb(r16+12) = r0.new; jump	000099D8; r0 = max(r1,r0) }

l00009848:
	{ if (p0.new) memw(r16+48) = r18; if (p0.new) r0 = add(r18,00000000); p0 = cmp.gt(r0,r18) }
	{ r1 = sxth(r20) }
	{ r0 = sub(r0,r1) }
	{ if (!p0.new) memw(r16+48) = 00000000; memw(r16+48) = r0; p0 = cmp.gt(r0,FFFFFFFF) }

l00009868:
	{ r19 = sxth(r20) }
	{ r1 = memw(r16+16); r0 = memw(r16+28); p0 = cmp.gt(r19,r18) }
	{ r0 = add(r1,r0); if (!p0) jump:nt	00009958 }

l00009880:
	{ r2 = r18; r1 = r17; call	000073E0 }
	{ r0 = memw(r16+16); r1 = memw(r16+28); r2 = sub(r19,r18) }
	{ memw(r16+32) = r2; r1 = add(r1,r18); p0 = cmp.gt(r0,00000000) }
	{ memw(r16+28) = r1; if (!p0) r2 = memb(r16-4); if (p0) jump:nt	000098AC }

l000098A4:
	{ if (cmp.eq(r2.new,00000000)) jump:nt	000098C8; r2 = and(r2,00000008) }

l000098AC:
	{ r0 = memw(r16+16) }

l000098B0:
	{ r0 = add(r0,r1) }
	{ memb(r0) = r21 }
	{ r0 = memw(r16+16); r1 = memw(r16+4) }
	{ r1 = add(r1,00000001) }
	{ memw(r16+40) = r0; jump	00009B18 }

l000098C8:
	{ memw(r16+40) = r0 }
000098CC                                     82 04 80 07             ....
000098D0 21 40 00 B0 00 40 02 F3 07 D5 B0 A1 30 C0 00 3C !@...@......0..<
000098E0 82 41 90 91 0A E0 82 24 80 C7 30 91 00 41 00 76 .A.....$..0..A.v
000098F0 10 C0 02 24 82 04 80 07 21 40 00 B0 00 40 02 F3 ...$....!@...@..
00009900 07 D5 B0 A1 00 D5 00 A1 82 C1 90 91 00 40 53 76 .............@Sv
00009910 03 40 42 76 84 04 81 07 00 42 40 F2 00 41 04 F3 .@Bv.....B@..A..
00009920 01 40 71 70 03 E0 94 74 03 C0 E3 70 04 42 03 F3 .@qp...t...p.B..
00009930 03 C0 43 76 02 44 B2 D5 83 08 84 AC 11 C0 E2 70 ..Cv.D.........p
00009940 50 6D FF 5B 89 09 92 70 80 C1 90 91 E6 40 00 58 Pm.[...p.....@.X
00009950 00 40 31 F3 0A D2 B0 A1                         .@1.....       

l00009958:
	{ r2 = r19; r1 = r17; call	000073E0 }
	{ r3 = memw(r16+16); r0 = memw(r16+28); r2 = sub(r18,r20) }
	{ memb(r16+7) = r0.new; r0 = add(r0,r19); if (p0.new) jump:t	00009980; p0 = cmp.gt(r3,00000000) }

l00009978:
	{ r1 = and(r1,00000008) }

l00009980:
	{ r1 = memw(r16+16); r3 = r0 }
	{ memw(r16+28) = r3; r0 = add(r0,r1) }
	{ memb(r0) = r21 }
	{ r0 = memw(r16+28); r3 = memw(r16+16) }
	{ r4 = memw(r16+16); r5 = sxth(r2); r1 = add(r17,r19) }
	{ if (p0.new) r2 = add(r3,00000000); r0 = add(r4,r0); p0 = cmp.gt(r5,r3) }
	{ r17 = sxth(r2) }
	{ r2 = r17; call	000073E0 }
	{ r1 = memw(r16+16); r0 = memw(r16+28) }
	{ memb(r16+7) = r0.new; r1 = sub(r1,r17); r0 = add(r0,r17) }
	{ memw(r16+32) = r1 }
	{ r22 = r20; p0 = cmp.eq(r20,00000041) }

l000099CC:
	{ r22 = r20 }

l000099D0:
	{ if (p0) r22 = 00000050 }

l000099D4:
	{ r1 = memw(r16+16); r0 = memw(r16+28) }
	{ r2 = memb(r17++#1); r0 = add(r1,r0); r3 = add(r0,00000001) }
	{ memb(r0) = r2 }
	{ if (cmp.gt(r0.new,00000000)) jump:t	00009A04; r0 = memw(r16+48) }

l000099F8:
	{ if (cmp.eq(r0.new,00000000)) jump:nt	00009A60; r0 = and(r0,00000008) }

l00009A04:
	{ r0 = add(r2,r0); r1 = add(r0,00000001) }
	{ memb(r0) = r21 }
	{ if (!cmp.gt(r2.new,00000000)) jump:nt	00009A60; r2 = memw(r16+48) }

l00009A20:
	{ r5 = memw(r16+16); r1 = memw(r16+28) }
	{ r1 = r17; r0 = add(r5,r1); r4 = add(r18.l,r0.l) }
	{ if (!p0.new) r2 = add(r18,FFFFFFFF); p0 = cmp.gt(r4,r2) }
	{ r17 = sxth(r2) }
	{ r2 = r17; call	000073E0 }
	{ r1 = memw(r16+28); r0 = memw(r16+16) }
	{ memb(r16+7) = r20.new; r0 = sub(r0,r17); r20 = add(r1,r17) }
	{ memw(r16+32) = r0 }
	{ r20 = memw(r16+28) }

l00009A60:
	{ r17 = memw(r16+16); r21 = r20; p0 = cmp.gt(r19,FFFFFFFF) }
	{ r0 = add(r17,r20); r21 += add(r17,00000002) }
	{ memb(r0++#1) = r22; if (!p0) jump:nt	00009A80 }

l00009A78:
	{ memb(r0) = 2B; jump	00009A88 }

l00009A80:
	{ memb(r0) = 2D; r19 = sub(00000000,r19) }

l00009A88:
	{ r18 = 00000000; if (p0.new) r23 = add(r29,00000000); if (!p0.new) jump:nt	00009AB4; p0 = cmp.gt(r11,00000000) }

l00009A94:
	{ call	00009B80 }
	{ r18 = add(r18,00000001) }
	{ memb(r23) = r1; r23 = r23 }
	{ r19 = sxth(r0) }
	{ if (p0.new) r17 = add(r21,00000000); if (p0.new) jump:t	00009AD0; p0 = cmp.gt(r10,00000002) }

l00009AB4:
	{ r0 = setbit(r22,0000000A) }
	{ p0 = cmp.eq(r0,00000065); if (!p0.new) r17 = add(r21,00000000); if (!p0.new) jump:nt	00009AD4 }

l00009AC4:
	{ memb(r21) = 30; jump	00009AD8; r17 += add(r20,00000003) }

l00009AD0:
	{ jump	00009ADC }

l00009AD4:
	{ if (p0.new) jump:nt	00009B04; p0 = cmp.eq(r10,00000000) }

l00009AD8:
	{ if (!p0.new) jump:nt	00009B0C; p0 = cmp.gt(r10,00000000) }

l00009ADC:
	{ r2 = r18; r0 = add(r29,00000000); r1 = r17; loop0(00009AE8,r18) }
	{ r2 = add(r2,FFFFFFFF); r3 = add(r0,r2) }
	{ r3 = memb(r3-1) }
	{ r3 = add(r3,00000030) }
	{ r17 = add(r17,r18); jump	00009B0C }

l00009B04:
	{ memb(r17++#1) = r0.new; r0 = 00000030 }

l00009B0C:
	{ r1 = memw(r16+16); r0 = memw(r16+28) }

l00009B10:
	{ r17 -= add(r1,r0) }

l00009B18:
	{ r0 = memuh(r16+60) }
	{ if (!cmp.eq(r0.new,00000000)) jump:t	00009B48; r0 = and(r0,00000014) }

l00009B28:
	{ r0 = memw(r16+8); r3 = memw(r16) }
	{ r4 = memw(r16+24); r5 = memw(r16+4); r3 += add(r2,r1) }
	{ r0 += add(r3,r5) }
	{ if (p0.new) memw(r16+24) = r0.new; if (p0.new) r0 = sub(r4,r0); p0 = cmp.gt(r4,r0) }

l00009B48:
	{ nop }
	{ nop }

;; _LDint: 00009B50
;;   Called from:
;;     000083AC (in fn00008368)
;;     000083FC (in fn00008368)
;;     00008884 (in _LXp_mulh)
;;     00009B4C (in _Genld)
_LDint proc
	{ allocframe(+00000000); call	00009CF0 }

;; fn00009B54: 00009B54
;;   Called from:
;;     0000864C (in fn00008368)
fn00009B54 proc
	{ allocframe(+00000000) }
	{ dealloc_return }
00009B5C                                     00 C0 00 7F             ....

;; _LDscale: 00009B60
;;   Called from:
;;     000083B4 (in fn00008368)
;;     00008404 (in fn00008368)
;;     00008658 (in fn00008368)
;;     0000888C (in _LXp_mulh)
;;     0000948C (in ldexpl)
_LDscale proc
	{ allocframe(+00000000); call	00009F70 }
	{ dealloc_return }
00009B6C                                     00 C0 00 7F             ....

;; _LDtest: 00009B70
;;   Called from:
;;     00008484 (in fn00008468)
;;     000087B0 (in _LXp_mulh)
;;     00008AD8 (in _LXp_invx)
;;     00008C1C (in _LXp_sqrtx)
;;     00009484 (in ldexpl)
_LDtest proc
	{ allocframe(+00000000); call	0000A1E0 }
	{ dealloc_return }
00009B7C                                     00 C0 00 7F             ....

;; div: 00009B80
;;   Called from:
;;     00009A94 (in _Genld)
div proc
	{ allocframe(00000008); memd(r29+496) = r17:r16; r17:r16 = combine(r1,r0); call	0000A460 }
	{ r2 = mpyi(r0,r17) }
	{ dealloc_return; r17:r16 = memd(r29); r1 = sub(r16,r2) }
00009B98                         00 C0 00 7F 00 C0 00 7F         ........

;; feraiseexcept: 00009BA0
;;   Called from:
;;     00009688 (in _Feraise)
feraiseexcept proc
	{ allocframe(00000010); memd(r29+496) = r17:r16 }
	{ if (cmp.eq(r16.new,00000000)) jump:nt	00009BE0; r16 = and(r0,0000001F); r0 = add(r29,00000004) }

l00009BB4:
	{ r1 = memd(r29+4); r0 = add(r29,00000004) }
	{ call	00009C30; r1 |= asl(r16,00000001) }
	{ r0 = memw(r29+4) }
	{ r16 &= lsr(r0,00000019) }
	{ r0 = r16 }
	{ dealloc_return; r17:r16 = memd(r29+8); r0 = 00000000 }

;; _Force_raise: 00009BE0
;;   Called from:
;;     00009BA4 (in feraiseexcept)
_Force_raise proc
	{ allocframe(+00000010); r3:r2 = memd(gp+192) }
	{  }
	{ memd(r29) = r19:r18; memd(r29+8) = r17:r16 }
	{ r18 = 0000D798 }
	{ r0 = memw(r18-8) }
	{ if (cmp.eq(r0.new,00000000)) jump:t	00009C18; r0 = and(r0,r16) }

l00009C08:
	{ r3:r2 = memd(r18+8); r1:r0 = memd(r18) }
	{ r3:r2 = combine(r1,r0) }
	{ r17 = add(r17,FFFFFFFF); r18 = add(r18,00000018); r1:r0 = combine(r3,r2) }

l00009C18:
	{ r17 = add(r17,FFFFFFFF); r18 = add(r18,00000018) }

l00009C24:
	{ r19:r18 = memd(r29); r17:r16 = memd(r29+8) }
	{ dealloc_return }

;; fesetenv: 00009C2C
fesetenv proc
	{ r1 = memw(r0) }

;; fn00009C30: 00009C30
;;   Called from:
;;     00009BB8 (in feraiseexcept)
fn00009C30 proc
	{ USR = r1 }
	{ jumpr	r31; r0 = 00000000 }
00009C38                         00 C0 00 7F 00 C0 00 7F         ........

;; _Tls_get__Locale: 00009C40
;;   Called from:
;;     00009CEC (in localeconv)
_Tls_get__Locale proc
	{ allocframe(00000010); memd(r29+496) = r17:r16; r1 = 00000001 }
	{ r17 = 00010064; r16 = 00010060 }
	{ memd(r29) = r19:r18 }

l00009C5C:
	{ r0 = memw_locked(r16) }
	{ p0 = cmp.gt(r0,00000000) }
	{ if (p0) jump:nt	00009C70 }

l00009C68:
	{ memw_locked(r16,p0) = r1 }
	{ if (!p0) jump:nt	00009C5C }

l00009C70:
	{ if (p0.new) r18 = 00000002; if (!p0.new) jump:t	00009C90; p0 = cmp.eq(r0,00000000) }

l00009C78:
	{ r1 = 00006FF0; r0 = 00010064 }
	{ call	0000B150 }
	{ memw(r16) = r18 }

l00009C90:
	{ if (!cmp.gt(r0.new,00000002)) jump:t	00009C94; r0 = memw(r16) }

l00009C94:
	{ if (!cmp.gt(r0.new,00000002)) jump:t	00009C94 }

l00009C9C:
	{ r0 = memw(r17) }
	{ if (!cmp.eq(r16.new,00000000)) jump:t	00009CE8; r16 = r0; r1:r0 = combine(00000050,00000001) }

l00009CB0:
	{ if (cmp.eq(r16.new,00000000)) jump:nt	00009CE4; r16 = r0 }

l00009CBC:
	{ r0 = memw(r17); r1 = r16 }
	{ if (p0.new) jump:nt	00009CD0; p0 = cmp.eq(r0,00000000) }

l00009CC4:
	{ r0 = r16; r16 = 00000000; call	00006FF0 }
	{ jump	00009CE0 }

l00009CD0:
	{ call	0000A380 }
	{ r2 = 00000050 }

l00009CE0:
	{ r19:r18 = memd(r29); r17:r16 = memd(r29+8); r0 = r16 }

l00009CE4:
	{ r19:r18 = memd(r29); r17:r16 = memd(r29+8) }

l00009CE8:
	{ dealloc_return }

;; localeconv: 00009CEC
;;   Called from:
;;     00009788 (in _Genld)
localeconv proc
	{ jump	00009C40 }

;; _Dint: 00009CF0
;;   Called from:
;;     00009B50 (in _LDint)
_Dint proc
	{ r2 = memuh(r0+6); r3 = 000007FF }
	{ if (!cmp.eq(r4.new,r3)) jump:t	00009D38; r3 = 00000002; r4 = extractu(r2,0000000B,00000003) }

l00009D08:
	{  }
	{ r1 = memuh(r0+4) }
	{ r1 = memuh(r0+2) }
	{ r0 = memuh(r0) }
	{ if (!p0.new) r3 = 00000002; if (p0.new) r3 = 00000001; p0 = cmp.eq(r0,00000000) }
	{ jumpr	r31; r0 = sxth(r3) }
00009D30 FF 41 00 00 E3 47 02 76                         .A...G.v       

l00009D38:
	{  }
	{ r3 = memuh(r0+4) }
	{ r3 = memuh(r0+2) }
	{ r5 = memuh(r0); r3 = 00000000 }
	{ r3 = 00000000; r5 = sub(00000433,r4) }
	{ if (!cmp.gt(r4.new,00000000)) jump:nt	00009E20; r1 = sub(r5,r1); r4 = sub(r5.l,r1.l) }

l00009D74:
	{ p0 = cmp.gt(r1,00000034); if (p0.new) r3 = 0000FFFF; if (!p0.new) jump:t	00009DA4 }

l00009D84:
	{ memuh(r0+4) = 0000; memuh(r0) = 0000; r1 = and(r2,00008000) }
	{ memuh(r0+6) = r1; memuh(r0+2) = FF80; jumpr	r31; r0 = sxth(r3) }

l00009DA4:
	{ r1 = and(r4,0000000F); r2 = asr(r4,00000004) }
	{ r5 = memuh(r1<<#1+0000D868); r1 = extractu(r4,00000010,00000000) }
	{ r3 = memw(r2<<#2+0000D888); p0 = cmp.eq(r1,00000001) }
	{ r1 = memuh(r12+r3<<#1) }
	{ r1 = and(r1,r5); r4 = r1 }
	{ if (p0) jump:nt	00009E00; XOREQ	r4,and(r4,r5) }

l00009DE0:
	{ if (!p0.new) jump:t	00009E08; p0 = cmp.eq(r2,00000006) }

l00009DE4:
	{ memuh(r0+4) = 0000; r2 = memh(r0+4) }
	{ r1 = or(r2,r1) }
	{ memuh(r0+2) = FF80; r2 = memh(r0+2) }
	{ r1 = or(r2,r1) }
	{ memuh(r0) = 0000; r2 = memh(r0) }

l00009E00:
	{ memuh(r0) = 0000 }

l00009E04:
	{ r1 = or(r2,r1) }

l00009E08:
	{ r0 = zxth(r1) }
	{ if (!p0.new) r3 = 00000000; if (p0.new) r3 = FFFFFFFF; p0 = !cmp.eq(r0,00000000) }
	{ jumpr	r31; r0 = sxth(r3) }
00009E1C                                     00 C0 00 7F             ....

;; _Dnorm: 00009E20
;;   Called from:
;;     000095E4 (in _Dunscale)
;;     00009D64 (in _Dint)
_Dnorm proc
	{ r1 = memuh(r0+6) }
	{ r1 = and(r1,00008000); r3 = and(r1,0000000F) }
	{ memuh(r0+6) = r3; if (!p0.new) jump:t	00009E58; p0 = cmp.eq(r3,00000000) }

l00009E38:
	{ if (!cmp.eq(r2.new,00000000)) jump:t	00009E60; r2 = memuh(r0+4); r3 = 00000000 }

l00009E48:
	{ if (!cmp.eq(r2.new,00000000)) jump:t	00009E5C }

l00009E50:
	{ if (cmp.eq(r4.new,00000001)) jump:nt	00009F64; r4 = memuh(r0) }

l00009E58:
	{ nop; jump	00009E78; r2 = 00000001 }

l00009E5C:
	{ nop }

l00009E60:
	{ r5 = memh(r0+2); r3 = memh(r0+4); r2 = add(r2,FFFFFFF0) }

l00009E64:
	{ r5 = memh(r0+2); r3 = memh(r0+4) }

l00009E68:
	{ memuh(r0) = 0000; r4 = memh(r0) }
	{ memuh(r0) = r5; memuh(r0+8) = r3 }
	{ memuh(r0+2) = r4 }

l00009E78:
	{ if (p0.new) jump:t	00009E64; p0 = cmph.eq(r3,0000) }

l00009E80:
	{ if (p0.new) r4 = add(r3,00000000); if (p0.new) jump:t	00009EF8; p0 = cmph.gtu(r3,000F) }

l00009E8C:
	{ r8 = memh(r0+2); r5 = memh(r0); r7 = 00000010 }
	{ r6 = memw(gp+132); r9 = memh(r0+4) }
	{ r2 = add(r2,FFFFFFFF); r12 = and(r8,r6); r4 = and(r9,r6); r13 = and(r5,r6) }

l00009EA4:
	{ r2 = add(r2,FFFFFFFF); r12 = and(r8,r6); r4 = and(r9,r6) }
	{ r12 = lsr(r12,0000000F); r4 = lsr(r4,0000000F) }
	{ r4 |= asl(r3,00000001); r13 = lsr(r13,0000000F) }
	{ r3 = r4; r14 = zxth(r4); r13 |= asl(r8,00000001); r12 |= asl(r9,00000001) }
	{ p0 = cmp.gtu(r7,r14); r9:r8 = combine(r12,r13); if (p0.new) jump:t	00009EA4; r5 = asl(r5,00000001) }

l00009EE0:
	{ memuh(r0+6) = r4; memuh(r0+2) = r13 }
	{ memuh(r0) = r5; memuh(r0+4) = r12; jump	00009EF4 }

l00009EF4:
	{ r3 = zxth(r4) }

l00009EF8:
	{ r5 = 00000020 }
	{ r13 = memh(r0+2); r3 = memh(r0) }
	{ r5 = memw(gp+136); r12 = memh(r0+4) }
	{ r2 = add(r2,00000001); r8 = and(r13,r5); r9 = and(r12,r5); r7 = asl(r4,0000000F) }

l00009F14:
	{ r2 = add(r2,00000001); r8 = and(r13,r5); r9 = and(r12,r5) }
	{ r13 = zxth(r4); r12 = and(r3,r5); r3 = asl(r13,0000000F); r6 = asl(r12,0000000F) }
	{ r6 |= lsr(r8,00000001); r7 |= lsr(r9,00000001) }
	{ r3 |= lsr(r12,00000001); p0 = cmph.gtu(r4,003F) }
	{ r13:r12 = combine(r6,r7); if (p0) jump:nt	00009F14; r4 = lsr(r13,00000001) }

l00009F4C:
	{ memuh(r0) = r6; memuh(r0+8) = r7 }
	{ memuh(r0) = r4; memuh(r0+8) = r3 }
	{ r3 = and(r4,0000000F) }
	{ r1 = sxth(r2); r3 = or(r3,r1) }

l00009F64:
	{  }

l00009F68:
	{ jumpr	r31; r0 = r1 }
00009F6C                                     00 C0 00 7F             ....

;; _Dscale: 00009F70
;;   Called from:
;;     00009B60 (in _LDscale)
_Dscale proc
	{ allocframe(00000008); memd(r29+496) = r17:r16; r17:r16 = combine(r1,r0) }
	{ r2 = memh(r16+6) }
	{ if (!cmp.eq(r0.new,00000000)) jump:t	00009F9C; r0 = extractu(r2,0000000B,00000003) }

l00009F88:
	{ r0 = r16 }
	{ r1 = 00000000; if (p0.new) jump:t	0000A1D8; p0 = cmp.gt(r16,00000000) }

l00009F94:
	{ jump	00009FD4 }
00009F98                         01 C0 C0 70                     ...p   

l00009F9C:
	{ r3 = 000007FF; r1 = 00000002 }
	{ if (!cmp.eq(r0.new,00000000)) jump:t	0000A1DC; r0 = and(r2,0000000F) }

l00009FB4:
	{ if (!cmp.eq(r0.new,00000000)) jump:t	0000A1DC }

l00009FBC:
	{ if (!cmp.eq(r0.new,00000000)) jump:t	0000A1DC }

l00009FC4:
	{ if (!p0.new) r1 = 00000001; if (p0.new) r1 = 00000002; p0 = !cmp.eq(r0,00000000); jump	0000A1D8 }

l00009FD4:
	{ r2 = sxth(r0); if (!p0.new) jump:nt	00009FE8; p0 = cmp.gt(r9,00000000) }

l00009FDC:
	{ if (!cmp.gt(r17,r0.new)) jump:t	0000A054; r0 = sub(000007FF,r2) }

l00009FE8:
	{ r0 = memuh(r16+6); r1 = sub(00000000,r2); r3 = FFFFFFCB }

l00009FEC:
	{ r0 = memuh(r16+6); r1 = sub(00000000,r2) }

l00009FF8:
	{ r2 = add(r2,r17); r0 = and(r0,0000800F) }
	{ r1 = 0000FFFF; r0 |= asl(r2,00000004) }
	{ r0 = and(r0,00008000); r1 = and(r0,0000000F) }
	{ if (p0.new) memuh(r16+4) = 0000; if (p0.new) memuh(r16) = 0000; p0 = cmp.gtu(r3,r2); r1 = setbit(r1,00000008) }
	{ memuh(r16+8) = r1; r1 = -00000001; if (!p0) jump:nt	0000A06C }

l0000A040:
	{ memuh(r16+6) = r0; memuh(r16+2) = FF80; jump	0000A1D8 }
0000A04C                                     9A 43 00 00             .C..
0000A050 00 C2 00 78                                     ...x           

l0000A054:
	{ r1:r0 = memd(r0) }
	{ if (tstbit(r2.new,-00000001)) jump:t	0000A068; r2 = memh(r16+6) }

l0000A064:
	{ memd(r16) = r1:r0; jump	0000A1D8; r1 = 00000001 }

l0000A068:
	{ memd(r16) = r1:r0 }

l0000A06C:
	{ r2 = sxth(r2); r3 = 00000000; r4 = aslh(r2) }
	{ p0 = cmp.gt(r4,FFF0FFFF); if (p0.new) r4 = 00000000; if (p0.new) jump:t	0000A0F0 }

l0000A084:
	{ r13 = memh(r16+2); r12 = memh(r16+4); r4 = 00000000 }
	{ r5 = memh(r16); r6 = 00000000; nop; nop }

l0000A0A0:
	{ r9 = r1; r4 = zxth(r4); r14 = 00100000 }
	{ r13:r12 = combine(r12,r9); r4 = !cmp.eq(r4,00000000); r7 = r13; r14 += asl(r2,00000010) }
	{ r5 = r7; r1 = 00000000; r2 = asrh(r14); r4 = or(r5,r4) }
	{ p0 = cmp.gt(r6,r14); if (p0.new) jump:t	0000A0A0 }

l0000A0D4:
	{ memuh(r16+4) = r9; memuh(r16+6) = FF80; r1 = 00000000; r8 = r13 }
	{ memuh(r16) = r7; memuh(r16+2) = r8; jump	0000A0F0 }

l0000A0F0:
	{ r5 = sub(00000000,r2) }
	{ if (!p0.new) r8 = zxth(r1); if (p0.new) jump:nt	0000A148; p0 = cmph.eq(r5,0000) }

l0000A100:
	{ r3 = memuh(r16+2); r4 = zxth(r4); r2 = sub(r3.l,r2.l) }
	{ r5 = memuh(r16); r6 = memuh(r16+4); r7 = sub(00000010,r2); r1 &= lsr(r8,r2) }
	{ memuh(r16+6) = r1; r4 = !cmp.eq(r4,00000000); r12 &= asl(r6,r7); r8 &= asl(r8,r7) }
	{ r4 |= asl(r5,r7); r9 &= asl(r3,r7) }
	{ r12 |= lsr(r3,r2); r8 |= lsr(r6,r2) }
	{ memuh(r16+2) = r12; memuh(r16+4) = r8; r9 |= lsr(r5,r2) }
	{ memuh(r16) = r9 }
	{ r2 = zxth(r4); r3 = 00000001; r1 = or(r1,r0) }

l0000A148:
	{ r2 = zxth(r4); r3 = 00000001 }

l0000A150:
	{ memuh(r16+6) = r1; if (!p0.new) r2 = memh(r16); if (!p0.new) jump:t	0000A170; p0 = cmp.gtu(r3,r2) }

l0000A15C:
	{ r3 = 00008000 }
	{ r2 = memh(r16) }
	{ if (!p0.new) jump:t	0000A19C; p0 = tstbit(r2,00000000) }

l0000A170:
	{ r2 = add(r2,00000001) }
	{ memuh(r16+8) = r2; r3 = zxth(r2) }
	{ if (p0.new) r2 = memh(r16+2); if (!p0.new) jump:t	0000A19C; p0 = cmp.eq(r3,00000000) }

l0000A180:
	{ r2 = add(r2,00000001) }
	{ memuh(r16+8) = r2; r3 = zxth(r2) }
	{ if (p0.new) r2 = memh(r16+4); if (!p0.new) jump:t	0000A19C; p0 = cmp.eq(r3,00000000) }

l0000A190:
	{ r2 = add(r2,00000001) }
	{ memuh(r16+8) = r2; r3 = zxth(r2) }
	{ if (p0.new) jump:nt	0000A1C8; p0 = cmp.eq(r3,00000000) }

l0000A19C:
	{ r1 = zxth(r1) }
	{ if (!cmp.eq(r0.new,00000000)) jump:t	0000A1D4; r0 = memuh(r16+4) }

l0000A1B0:
	{ if (!cmp.eq(r0.new,00000000)) jump:t	0000A1D4 }

l0000A1B8:
	{ if (!p0.new) r1 = 0000FFFF; p0 = cmp.eq(r0,00000000); jump	0000A1D8 }

l0000A1C8:
	{ memb(r16+3) = r0.new; r0 = add(r1,00000001) }

l0000A1D4:
	{ r1 = 0000003F }

l0000A1D8:
	{ dealloc_return; r17:r16 = memd(r29); r0 = sxth(r1) }

l0000A1DC:
	{ dealloc_return; r17:r16 = memd(r29) }

;; _Dtest: 0000A1E0
;;   Called from:
;;     00009B70 (in _LDtest)
_Dtest proc
	{ r2 = memuh(r0+6); r1 = 00007FF0 }
	{ r3 = and(r2,r1); r1 = 00000002 }
	{ if (!cmp.eq(r2.new,00000000)) jump:t	0000A260; r2 = and(r2,0000000F) }

l0000A200:
	{ if (!cmp.eq(r2.new,00000000)) jump:t	0000A260 }

l0000A208:
	{ if (!cmp.eq(r2.new,00000000)) jump:t	0000A260 }

l0000A210:
	{ if (!p0.new) r1 = 00000001; if (p0.new) r1 = 00000002; p0 = !cmp.eq(r0,00000000) }
	{ jumpr	r31; r0 = r1 }
0000A220 FF 41 00 00 E1 47 02 76 14 E0 43 24 41 40 60 91 .A...G.v..C$A@`.
0000A230 0E E0 43 24 21 40 60 91 0A E0 43 24 01 40 00 78 ..C$!@`...C$.@.x
0000A240 00 40 60 91 10 C0 02 24 FF 41 00 00 00 C6 02 76 .@`....$.A.....v
0000A250 00 40 00 75 C1 7F 0F 7E E1 FF 8F 7E C0 3F 10 50 .@.u...~...~.?.P

;; fegetenv: 0000A260
;;   Called from:
;;     0000A1F4 (in _Dtest)
;;     0000A200 (in _Dtest)
;;     0000A208 (in _Dtest)
fegetenv proc
	{ r1 = USR }
	{ memw(r0) = r1 }
	{ jumpr	r31; r0 = 00000000 }
0000A26C                                     00 C0 00 7F             ....

;; __save_r16_through_r27: 0000A270
;;   Called from:
;;     000066C0 (in _Stoulx)
;;     00007AD0 (in _Ldtob)
;;     00008110 (in _Litob)
;;     00008450 (in _LXp_addh)
;;     00008788 (in _LXp_mulh)
;;     000089F0 (in _LXp_mulx)
;;     00008AC0 (in _LXp_invx)
;;     00008C04 (in _LXp_sqrtx)
__save_r16_through_r27 proc
	{ memd(r30-40) = r25:r24; memd(r30-48) = r27:r26 }

;; __save_r16_through_r23: 0000A278
;;   Called from:
;;     00006200 (in _Putstr)
;;     00006320 (in _Puttxt)
;;     00006C10 (in _Wctombx)
;;     00008350 (in _LXp_setw)
;;     00008910 (in _LXp_addx)
;;     00008954 (in _LXp_subx)
;;     000089A0 (in _LXp_ldexpx)
;;     00009780 (in _Genld)
;;     0000A270 (in __save_r16_through_r27)
__save_r16_through_r23 proc
	{ memd(r30-24) = r21:r20; memd(r30-32) = r23:r22 }

;; __save_r16_through_r19: 0000A280
;;   Called from:
;;     0000A278 (in __save_r16_through_r23)
__save_r16_through_r19 proc
	{ memd(r30-8) = r17:r16; memd(r30-16) = r19:r18; jumpr	r31; nop }

;; __save_r16_through_r27_stkchk: 0000A290
__save_r16_through_r27_stkchk proc
	{ memd(r30-40) = r25:r24; memd(r30-48) = r27:r26 }

;; __save_r16_through_r23_stkchk: 0000A298
;;   Called from:
;;     0000A290 (in __save_r16_through_r27_stkchk)
__save_r16_through_r23_stkchk proc
	{ memd(r30-24) = r21:r20; memd(r30-32) = r23:r22 }

;; __save_r16_through_r19_stkchk: 0000A2A0
;;   Called from:
;;     0000A298 (in __save_r16_through_r23_stkchk)
__save_r16_through_r19_stkchk proc
	{ memd(r30-8) = r17:r16; memd(r30-16) = r19:r18; r17 = UGP }
	{ r16 = memw(r17+68) }
	{ if (!p0.new) jumpr:t	r31; p0 = cmp.gtu(r16,r29) }
0000A2B8                         BC 65 FF 5B 00 C0 9D A0         .e.[....

;; __save_r16_through_r25: 0000A2C0
;;   Called from:
;;     00005770 (in _Printf)
;;     000070C0 (in fwrite)
__save_r16_through_r25 proc
	{ memd(r30-32) = r23:r22; memd(r30-40) = r25:r24 }

;; __save_r16_through_r21: 0000A2C8
;;   Called from:
;;     00006958 (in _Lockfilelock)
;;     00006A44 (in _Locksyslock)
;;     0000A2C0 (in __save_r16_through_r25)
__save_r16_through_r21 proc
	{ memd(r30-16) = r19:r18; memd(r30-24) = r21:r20 }

;; __save_r16_through_r17: 0000A2D0
;;   Called from:
;;     0000A2C8 (in __save_r16_through_r21)
__save_r16_through_r17 proc
	{ memd(r30-8) = r17:r16; jumpr	r31 }

;; __save_r16_through_r25_stkchk: 0000A2D8
__save_r16_through_r25_stkchk proc
	{ memd(r30-32) = r23:r22; memd(r30-40) = r25:r24 }

;; __save_r16_through_r21_stkchk: 0000A2E0
;;   Called from:
;;     0000A2D8 (in __save_r16_through_r25_stkchk)
__save_r16_through_r21_stkchk proc
	{ memd(r30-16) = r19:r18; memd(r30-24) = r21:r20 }

;; __save_r16_through_r17_stkchk: 0000A2E8
;;   Called from:
;;     0000A2E0 (in __save_r16_through_r21_stkchk)
__save_r16_through_r17_stkchk proc
	{ memd(r30-8) = r17:r16; r17 = UGP }
	{ r16 = memw(r17+68) }
	{ if (!p0.new) jumpr:t	r31; p0 = cmp.gtu(r16,r29) }
0000A2FC                                     9A 65 FF 5B             .e.[
0000A300 00 C0 9D A0                                     ....           

;; __restore_r16_through_r23_and_deallocframe_before_tailcall: 0000A304
__restore_r16_through_r23_and_deallocframe_before_tailcall proc
	{ r21:r20 = memd(r30-24); r23:r22 = memd(r30-32); nop }

;; __restore_r16_through_r19_and_deallocframe_before_tailcall: 0000A310
;;   Called from:
;;     0000A304 (in __restore_r16_through_r23_and_deallocframe_before_tailcall)
__restore_r16_through_r19_and_deallocframe_before_tailcall proc
	{ r19:r18 = memd(r30-16); jump	0000A330 }

;; __restore_r16_through_r27_and_deallocframe_before_tailcall: 0000A318
__restore_r16_through_r27_and_deallocframe_before_tailcall proc
	{ r27:r26 = memd(r30-48); nop }

;; __restore_r16_through_r25_and_deallocframe_before_tailcall: 0000A320
;;   Called from:
;;     0000A318 (in __restore_r16_through_r27_and_deallocframe_before_tailcall)
__restore_r16_through_r25_and_deallocframe_before_tailcall proc
	{ r23:r22 = memd(r30-32); r25:r24 = memd(r30-40) }

;; __restore_r16_through_r21_and_deallocframe_before_tailcall: 0000A328
;;   Called from:
;;     0000A320 (in __restore_r16_through_r25_and_deallocframe_before_tailcall)
__restore_r16_through_r21_and_deallocframe_before_tailcall proc
	{ r19:r18 = memd(r30-16); r21:r20 = memd(r30-24) }

;; __restore_r16_through_r17_and_deallocframe_before_tailcall: 0000A330
;;   Called from:
;;     0000A310 (in __restore_r16_through_r19_and_deallocframe_before_tailcall)
;;     0000A328 (in __restore_r16_through_r21_and_deallocframe_before_tailcall)
__restore_r16_through_r17_and_deallocframe_before_tailcall proc
	{ deallocframe; r17:r16 = memd(r30-8); jumpr	r31; nop }

;; __restore_r16_through_r23_and_deallocframe: 0000A340
__restore_r16_through_r23_and_deallocframe proc
	{ r21:r20 = memd(r30-24); r23:r22 = memd(r30-32) }

;; __restore_r16_through_r19_and_deallocframe: 0000A348
;;   Called from:
;;     0000A340 (in __restore_r16_through_r23_and_deallocframe)
__restore_r16_through_r19_and_deallocframe proc
	{ r19:r18 = memd(r30-16); jump	0000A368 }

;; __restore_r16_through_r27_and_deallocframe: 0000A350
;;   Called from:
;;     00006738 (in _Stoulx)
;;     00006888 (in _Stoulx)
;;     00006890 (in _Stoulx)
;;     00007B98 (in _Ldtob)
;;     0000829C (in _Litob)
;;     000082D0 (in _Litob)
;;     000084D4 (in fn00008468)
;;     00008758 (in fn00008468)
;;     00008774 (in fn00008368)
;;     00008780 (in fn00008780)
__restore_r16_through_r27_and_deallocframe proc
	{ r27:r26 = memd(r30-48) }

;; __restore_r16_through_r25_and_deallocframe: 0000A354
;;   Called from:
;;     00007208 (in fwrite)
;;     0000A350 (in __restore_r16_through_r27_and_deallocframe)
__restore_r16_through_r25_and_deallocframe proc
	{ r23:r22 = memd(r30-32); r25:r24 = memd(r30-40); nop }

;; __restore_r16_through_r21_and_deallocframe: 0000A360
;;   Called from:
;;     00006A08 (in _Lockfilelock)
;;     00006AF4 (in _Locksyslock)
;;     0000A354 (in __restore_r16_through_r25_and_deallocframe)
__restore_r16_through_r21_and_deallocframe proc
	{ r19:r18 = memd(r30-16); r21:r20 = memd(r30-24) }

;; __restore_r16_through_r17_and_deallocframe: 0000A368
;;   Called from:
;;     0000A348 (in __restore_r16_through_r19_and_deallocframe)
;;     0000A360 (in __restore_r16_through_r21_and_deallocframe)
__restore_r16_through_r17_and_deallocframe proc
	{ dealloc_return; r17:r16 = memd(r30-8) }

;; __deallocframe: 0000A370
__deallocframe proc
	{ dealloc_return }
0000A374             00 C0 00 7F 00 C0 00 7F 00 C0 00 7F     ............

;; __hexagon_memcpy_likely_aligned_min32bytes_mult8bytes: 0000A380
;;   Called from:
;;     00006694 (in fn00006620)
;;     00009000 (in _Tls_get__Wcstate)
;;     00009CD0 (in _Tls_get__Locale)
__hexagon_memcpy_likely_aligned_min32bytes_mult8bytes proc
	{ if (p0.new) r5:r4 = memd(r1); r3 = FFFFFFFD; p0 = bitsclr(r0,00000007); p0 = bitsclr(r1,00000007) }
	{ if (p0) memd(r0++#8) = r5:r4; if (p0) r5:r4 = memd(r1+8); r3 += lsr(r2,00000003); if (!p0) jump:nt	000073E0 }

l0000A3A0:
	{ memd(r0++#8) = r5:r4; r5:r4 = memd(r1+16); r1 = add(r1,00000018); loop0(0000A3B0,r3) }
	{ memd(r0++#8) = r5:r4; r5:r4 = memd(r1++#8) }
	{ memd(r0) = r5:r4; jumpr	r31; r0 -= add(r2,FFFFFFF8) }
0000A3C4             00 C0 00 7F 00 C0 00 7F 00 C0 00 7F     ............
0000A3D0 00 C0 00 7F 00 C0 00 7F 00 C0 00 7F 00 C0 00 7F ................

;; __qdsp_divdi3: 0000A3E0
;;   Called from:
;;     000081E0 (in _Litob)
__qdsp_divdi3 proc
	{ p3 = tstbit(r3,0000001F); p2 = tstbit(r1,0000001F) }
	{ r3:r2 = abs(r3:r2); r1:r0 = abs(r1:r0) }
	{ r3:r2 = combine(r1,r0); r5:r4 = combine(r3,r2); r7 = cl0(r3:r2); r6 = cl0(r1:r0) }
	{ r15:r14 = combine(00000000,00000001); r1:r0 = combine(00000000,00000000); r10 = sub(r7,r6); p3 = xor(p2,p3) }
	{ r11 = add(r10,00000001); r15:r14 = lsl(r15:r14,r10); r13:r12 = lsl(r5:r4,r10) }
	{ p0 = cmp.gtu(r5:r4,r3:r2); loop0(0000A428,r11) }
	{ if (p0) jump:nt	0000A444 }

l0000A428:
	{ p0 = cmp.gtu(r13:r12,r3:r2) }
	{ r9:r8 = add(r15:r14,r1:r0); r7:r6 = sub(r3:r2,r13:r12) }
	{ r3:r2 = vmux(p0,r3:r2,r7:r6); r1:r0 = vmux(p0,r1:r0,r9:r8) }
	{ r13:r12 = lsr(r13:r12,00000001); r15:r14 = lsr(r15:r14,00000001) }

l0000A444:
	{ r3:r2 = neg(r1:r0) }
	{ jumpr	r31; r1:r0 = vmux(p3,r3:r2,r1:r0) }
0000A450 00 C0 00 7F 00 C0 00 7F 00 C0 00 7F 00 C0 00 7F ................

;; __hexagon_divsi3: 0000A460
;;   Called from:
;;     000094C0 (in ldiv)
;;     00009B80 (in div)
__hexagon_divsi3 proc
	{ p1 = cmp.gt(r1,FFFFFFFF); p0 = cmp.gt(r0,FFFFFFFF); r2 = abs(r1); r1 = abs(r0) }
	{ p2 = cmp.gtu(r2,r1); r5 = sub(r1,r2); r4 = cl0(r2); r3 = cl0(r1) }
	{ p0 = cmp.gtu(r2,r5); r0 = 00000000; if (p2) jumpr:nt	r31; p1 = xor(p0,p1) }
0000A490 E0 7F 80 7A 04 44 23 F3 C4 3F 13 48 08 41 04 60 ...z.D#..?.H.A.`
0000A4A0 C2 44 02 C3 00 40 00 78 00 C0 00 7F 00 C0 00 7F .D...@.x........
0000A4B0 00 81 62 F2 22 41 42 80 81 61 22 FB 80 E3 00 FB ..b."AB..a".....
0000A4C0 00 41 62 F2 00 41 7F 53 80 E3 00 FB 00 40 40 76 .Ab..A.S.....@@v
0000A4D0 00 C0 9F 52 00 C0 00 7F 00 C0 00 7F 00 C0 00 7F ...R............

;; __hexagon_udivdi3: 0000A4E0
__hexagon_udivdi3 proc
	{ r3:r2 = combine(r1,r0); r5:r4 = combine(r3,r2); r7 = cl0(r3:r2); r6 = cl0(r1:r0) }

;; fn0000A4E4: 0000A4E4
;;   Called from:
;;     000081B4 (in _Litob)
fn0000A4E4 proc
	{ r3:r2 = combine(r1,r0); r5:r4 = combine(r3,r2); r7 = cl0(r3:r2) }
	{ r15:r14 = combine(00000000,00000001); r1:r0 = combine(00000000,00000000); r10 = sub(r7,r6) }
	{ r11 = add(r10,00000001); r15:r14 = lsl(r15:r14,r10); r13:r12 = lsl(r5:r4,r10) }
	{ p0 = cmp.gtu(r5:r4,r3:r2); loop0(0000A514,r11) }
	{ if (p0) jumpr:nt	r31 }
0000A514             80 C2 8C D2 E6 42 2C D3 E8 CE 00 D3     .....B,.....
0000A520 00 48 00 D1 02 C6 02 D1 2E 81 0E 80 2C C1 0C 80 .H..........,...
0000A530 00 C0 9F 52 00 C0 00 7F 00 C0 00 7F 00 C0 00 7F ...R............

;; __qdsp_udivsi3: 0000A540
;;   Called from:
;;     000071FC (in fwrite)
__qdsp_udivsi3 proc
	{ p0 = cmp.gtu(r1,r0); r5:r4 = combine(00000001,00000000); r3 = cl0(r1); r2 = cl0(r0) }
	{ if (p0) jumpr	r31; r4 = r1; r1:r0 = combine(r0,r4); r6 = sub(r3,r2) }
0000A55C                                     08 41 06 60             .A.`
0000A560 C2 46 04 C3 00 40 00 7F 00 C0 00 7F 00 C0 00 7F .F...@..........
0000A570 00 81 62 F2 22 41 42 80 81 61 22 FB 80 E3 00 FB ..b."AB..a".....
0000A580 00 41 62 F2 00 40 9F 52 80 E3 00 FB 00 C0 00 7F .Ab..@.R........

;; __qdsp_umoddi3: 0000A590
;;   Called from:
;;     000081A0 (in _Litob)
__qdsp_umoddi3 proc
	{ r3:r2 = combine(r1,r0); r5:r4 = combine(r3,r2); r7 = cl0(r3:r2); r6 = cl0(r1:r0) }
	{ r15:r14 = combine(00000000,00000001); r1:r0 = combine(00000000,00000000); r10 = sub(r7,r6) }
	{ r11 = add(r10,00000001); r15:r14 = lsl(r15:r14,r10); r13:r12 = lsl(r5:r4,r10) }
	{ p0 = cmp.gtu(r5:r4,r3:r2); loop0(0000A5C4,r11) }
	{ if (p0) jump:nt	0000A5E0 }

l0000A5C4:
	{ p0 = cmp.gtu(r13:r12,r3:r2) }
	{ r9:r8 = add(r15:r14,r1:r0); r7:r6 = sub(r3:r2,r13:r12) }
	{ r3:r2 = vmux(p0,r3:r2,r7:r6); r1:r0 = vmux(p0,r1:r0,r9:r8) }
	{ r13:r12 = lsr(r13:r12,00000001); r15:r14 = lsr(r15:r14,00000001) }

l0000A5E0:
	{ jumpr	r31; r1:r0 = combine(r3,r2) }
0000A5E8                         00 C0 00 7F 00 C0 00 7F         ........
0000A5F0 00 C0 00 7F 00 C0 00 7F 00 C0 00 7F 00 C0 00 7F ................

;; __hexagon_adddf3: 0000A600
;;   Called from:
;;     0000832C (in _LXp_getw)
;;     00008340 (in _LXp_getw)
;;     000085D8 (in fn00008368)
;;     00008B34 (in fn00008B1C)
;;     00008C6C (in _LXp_sqrtx)
__hexagon_adddf3 proc
	{ r13:r12 = combine(20000000,00000000); r5 = extractu(r3,0000000B,00000013); r4 = extractu(r1,0000000B,00000013) }

l0000A604:
	{ r13:r12 = combine(20000000,00000000); r5 = extractu(r3,0000000B,00000013) }

;; fn0000A610: 0000A610
;;   Called from:
;;     0000A600 (in __hexagon_adddf3)
;;     0000A604 (in __hexagon_fast2_subdf3)
fn0000A610 proc
	{ p2 = cmp.gtu(r5,r4); r9:r8 = combine(r13,r12); p3 = dfclass(r3:r2,00000002); p3 = dfclass(r1:r0,00000002) }
	{ if (p2) r5:r4 = combine(r4,r5); if (p2) r3:r2 = combine(r1,r0); if (p2) r1:r0 = combine(r3,r2); if (!p3) jump:nt	0000A764 }

;; fn0000A630: 0000A630
;;   Called from:
;;     0000A620 (in fn0000A610)
;;     0000A620 (in fn0000A610)
fn0000A630 proc
	{ r7:r6 = combine(0000003E,00000001); r15 = sub(r4,r5); r9:r8 = insert(r2,00000034,0000000C); r13:r12 = insert(r0,00000034,0000000C) }
	{ r14 = 00000000; p2 = cmp.gt(r1,FFFFFFFF); r11:r10 = neg(r13:r12); r15 = min(r7,r15) }

l0000A644:
	{ r14 = 00000000; p2 = cmp.gt(r1,FFFFFFFF); r11:r10 = neg(r13:r12) }
	{ r15:r14 = combine(00000000,00000000); if (p2.new) r13:r12 = combine(r11,r10); r9:r8 = asr(r9:r8,r15); r11:r10 = extractu(r9:r8,r15:r14) }
	{ p3 = cmp.gt(r3,FFFFFFFF); r5 = add(r4,FFFFFBC4); if (!p1.new) r8 = or(r8,r6); p1 = cmp.eq(r11:r10,r15:r14) }
	{ r7:r6 = combine(000007F6,0000003D); r11:r10 = sub(r13:r12,r9:r8); r13:r12 = add(r9:r8,r13:r12) }
	{ if (p3.new) r13:r12 = combine(r11,r10); if (!p0.new) jump:nt	0000A6D4; p0 = cmp.gtu(r4,r7); p0 = !cmp.gtu(r4,r6) }

l0000A68C:
	{ p0 = cmp.eq(r12,00000000); p0 = cmp.eq(r13,00000000); if (p0.new) jump:nt	0000A6B4; r1:r0 = convert_d2df(r13:r12) }

l0000A69C:
	{ jumpr	r31; r1 += asl(r5,00000014) }

;; __hexagon_fast2_subdf3: 0000A6A4
;;   Called from:
;;     000083C8 (in fn00008368)
;;     00008410 (in fn00008368)
;;     00008664 (in fn00008368)
;;     000088A4 (in _LXp_mulh)
__hexagon_fast2_subdf3 proc
	{ nop; jump	0000A604; r3 = togglebit(r3,0000001E) }
0000A6B0 1C 40 08 6A                                     .@.j           

l0000A6B4:
	{ r1:r0 = combine(00000000,00000000); r3 = 00000001 }
	{ r3 = asl(r3,0000001F); r28 = extractu(r28,00000002,00000012) }
	{ nop; if (p0.new) r1 = xor(r1,r3); jumpr	r31; p0 = cmp.eq(r28,00000002) }
0000A6D0 60 40 EC 80                                     `@..           

l0000A6D4:
	{ p0 = cmp.eq(r12,00000000); p0 = cmp.eq(r13,00000000); if (p0.new) jump:nt	0000A6B4 }

l0000A6E0:
	{ r1 += asl(r5,00000014); r28 = extractu(r1,0000000B,00000013) }
	{ r3:r2 = combine(00100000,00000000); r5 = add(r5,r28) }
	{ if (p0.new) jump:nt	0000A728; p0 = cmp.gt(r5,000007FE) }

l0000A700:
	{ r28 = sub(00000001,r5); if (p0.new) jumpr:t	r31; p0 = cmp.gt(r5,00000000) }
0000A70C                                     02 74 00 83             .t..
0000A710 00 CC 0D F5 42 DC 82 C3 00 7F 02 83 00 C0 9F 52 ....B..........R
0000A720 1C 40 08 6A 00 4C 0D F5                         .@.j.L..       

l0000A728:
	{ r13:r12 = combine(7FEFFFFF,FFFFFFFF) }
	{ r9:r8 = combine(7FF00000,00000000); r28 = or(r28,00000028); r5 = extractu(r28,00000002,00000012) }
	{ r28 = r5; XOREQ	r5,lsr(r1,0000001F); USR = r28 }
	{ if (!p0) r13:r12 = combine(r9,r8); p0 = !cmp.eq(r5,00000002); p0 = !cmp.eq(r28,00000001) }
	{ r1:r0 = insert(r12,0000003F,00000007) }
	{ jumpr	r31; p0 = dfcmp.eq(r1:r0,r1:r0) }

;; fn0000A764: 0000A764
;;   Called from:
;;     0000A620 (in fn0000A610)
;;     0000A620 (in fn0000A610)
;;     0000A640 (in fn0000A630)
fn0000A764 proc
	{ r9:r8 = extractu(r3:r2,0000003F,00000007); r13:r12 = extractu(r1:r0,0000003F,00000007) }
	{ if (!p3.new) r3:r2 = combine(r1,r0); if (!p3.new) r1:r0 = combine(r3,r2); p3 = cmp.gtu(r13:r12,r9:r8) }
	{ if (p3.new) r9:r8 = combine(r13,r12); if (p3.new) r13:r12 = combine(r9,r8); if (!p0.new) jump:nt	0000A81C; p0 = dfclass(r1:r0,0000000F) }

l0000A788:
	{ if (p1.new) jump:nt	0000A860; p1 = dfclass(r1:r0,00000008) }

l0000A790:
	{ r13:r12 = combine(00000000,00000000); if (p2.new) jump:nt	0000A834; p2 = dfclass(r3:r2,00000001) }

l0000A79C:
	{ r13:r12 = combine(20000000,00000000); if (p0.new) jump:nt	0000A7CC; p0 = dfclass(r1:r0,00000004) }

l0000A7AC:
	{ r5 = 00000001; r9:r8 = asl(r9:r8,00000009); r4 = extractu(r1,0000000B,00000013) }
	{ r7:r6 = combine(0000003E,00000001); r15 = sub(r4,r5); jump	0000A644; r13:r12 = insert(r0,00000034,0000000C) }
0000A7C8                         0C 7F 00 81                     ....   

l0000A7CC:
	{ r9:r8 = extractu(r3:r2,0000003F,00000007) }
	{ p1 = cmp.gt(r3,FFFFFFFF); p0 = cmp.gt(r1,FFFFFFFF); r9:r8 = neg(r9:r8); r13:r12 = neg(r13:r12) }
	{ if (p1) r9:r8 = combine(r3,r2); if (p0) r13:r12 = combine(r1,r0) }
	{ r13:r12 = add(r9:r8,r13:r12) }
	{ r3:r2 = combine(00000000,00000000); p0 = cmp.gt(r13,FFFFFFFF); r9:r8 = neg(r13:r12) }
	{ r3 = 80000000; if (p0) r1:r0 = combine(r13,r12); if (p0.new) r1:r0 = combine(r9,r8) }
	{ if (!p0) r1 = or(r1,r3); if (p0.new) jump:nt	0000A83C; p0 = dfcmp.eq(r1:r0,r3:r2) }

l0000A814:
	{ jumpr	r31 }
0000A818                         3C 40 00 88                     <@..   

l0000A81C:
	{ if (!p0) r3:r2 = combine(r1,r0); p0 = dfclass(r3:r2,0000000F) }
	{ r1:r0 = combine(FFFFFFFF,FFFFFFFF); jumpr	r31; r2 = convert_df2sf(r3:r2) }
0000A830 00 40 EC D2                                     .@..           

l0000A834:
	{ if (!p0.new) jumpr:t	r31 }
0000A838                         00 42 80 D2                     .B..   

l0000A83C:
	{ if (p0.new) jumpr:t	r31 }
0000A840 1C C0 08 6A DC 42 5C 8D 00 C0 00 7C 40 40 1C 75 ...j.B\....|@@.u
0000A850 00 40 9F 52 00 40 00 08 01 E0 00 7E 10 41 82 DC .@.R.@.....~.A..

l0000A860:
	{ p0 = !cmp.eq(r1,r3); if (!p0.new) jumpr:t	r31 }
0000A868                         00 40 F8 07 22 C0 00 78         .@.."..x
0000A870 00 40 82 84 00 C0 9F 52 00 C0 00 7F 00 C0 00 7F .@.....R........

;; __hexagon_divdf3: 0000A880
;;   Called from:
;;     00008B40 (in fn00008B1C)
;;     00008BE8 (in fn00008B1C)
;;     00008C84 (in _LXp_sqrtx)
__hexagon_divdf3 proc
	{ r15:r14 = combine(40000000,00000000); p3 = dfclass(r3:r2,00000002); p3 = dfclass(r1:r0,00000002) }
	{ r7:r6 = combine(00000000,00000000); r13:r12 = combine(r15,r14); r15:r14 = insert(r0,00000034,0000000C); if (!p3) jump:nt	0000AA18 }

l0000A8A0:
	{ r11:r10 = combine(00000000,00000001); r5 = extractu(r3,0000000B,00000013); r4 = extractu(r1,0000000B,00000013) }
	{ r4 = sub(r4,r5); r9:r8 = combine(r15,r14); r13:r12 = insert(r2,00000034,0000000C); loop0(0000A8BC,00000018) }
	{ r15:r14 = sub(r9:r8,r13:r12) }
	{ if (!p0) r9:r8 = combine(r15,r14); p0 = cmp.gt(r15,FFFFFFFF) }
	{ r9:r8 = asl(r9:r8,00000001); r7:r6 = add(r7:r6,r7:r6,p0):carry }
	{ r8 = 000003FE; r9 = FFFFFC02; if (!p1.new) r6 = or(r6,r10); p1 = cmp.gtu(r11:r10,r9:r8) }
	{ p0 = !cmp.gt(r4,r8); p0 = cmp.gt(r4,r9); r28 = xor(r1,r3); r15:r14 = neg(r7:r6) }
	{ if (!p1) r15:r14 = combine(r7,r6); p1 = cmp.gt(r28,FFFFFFFF); if (!p0) jump:nt	0000A914 }

l0000A8FC:
	{ r4 = add(r4,FFFFFFC9); r1:r0 = convert_d2df(r15:r14) }
	{ jumpr	r31; r1 += asl(r4,00000014) }
0000A90C                                     C0 5B 01 69             .[.i
0000A910 D8 FF FF 59                                     ...Y           

l0000A914:
	{ r4 = add(r4,FFFFFFC9); r1:r0 = convert_d2df(r15:r14) }
	{ r5 = extractu(r1,0000000B,00000013); r1 += asl(r4,00000014) }
	{ r13:r12 = abs(r15:r14); r4 = add(r4,r5) }
	{ if (p0.new) jump:nt	0000A9DC; p0 = cmp.gt(r4,000007FE) }

l0000A938:
	{ r28 = 0000003F; if (p0.new) jump:nt	0000A99C; p0 = cmp.gt(r4,00000000) }

l0000A940:
	{ p3 = cmp.gt(r15,FFFFFFFF); r4 = sub(00000003,r4); r5 = add(clb(r12),FFFFFFF4); r7 = USR }
	{ r6 = 00000030; r4 = 00000000; r5 = min(r28,r4); r13:r12 = asl(r13:r12,r5) }
	{ r13:r12 = asr(r13:r12,r5); r9:r8 = extractu(r13:r12,r5:r4) }
	{ if (!p0.new) r12 = or(r12,r10); r13 = setbit(r13,0000000E); p0 = cmp.gtu(r11:r10,r9:r8) }
	{ if (!p1.new) r7 = or(r7,r6); p1 = bitsclr(r12,00000007); r15:r14 = neg(r13:r12) }
	{ r28 = FFFFFBCA; r3:r2 = combine(00000000,00000000); if (p3) r15:r14 = combine(r13,r12); USR = r7 }
	{ p0 = dfcmp.uo(r3:r2,r3:r2); r1:r0 = convert_d2df(r15:r14) }
	{ jumpr	r31; r1 += asl(r28,00000014) }

l0000A99C:
	{ r15:r14 = abs(r15:r14); r28 = 7FEFFFFF }
	{ r28 = 00007FFF; p0 = cmp.eq(r0,00000000); if (!p0.new) jumpr:t	r31; p0 = bitsclr(r1,r28) }
0000A9B8                         07 40 08 6A 00 5C 4F C7         .@.j.\O.
0000A9C0 06 C6 00 78 07 C6 27 F9 08 C0 27 62 00 40 E0 D2 ...x..'...'b.@..
0000A9D0 00 C0 9F 52 1C 40 08 6A FF 7F FE 07             ...R.@.j....   

l0000A9DC:
	{ r1:r0 = combine(r15,r14); r15:r14 = combine(0000003F,FFFFFFFF) }
	{ r28 = or(r28,00000028); r7 = extractu(r28,00000002,00000012); r13:r12 = combine(7FF00000,00000000) }
	{ r6 = r7; XOREQ	r7,lsr(r1,0000001F); USR = r28 }
	{ if (!p0) r15:r14 = combine(r13,r12); p0 = !cmp.eq(r7,00000002); p0 = dfcmp.eq(r15:r14,r15:r14); p0 = !cmp.eq(r6,00000001) }
	{ jumpr	r31; r1:r0 = insert(r14,0000003F,00000007) }

l0000AA18:
	{ p0 = dfclass(r3:r2,0000000F); p0 = dfclass(r1:r0,0000000F) }
	{ p1 = dfclass(r3:r2,00000008); p1 = dfclass(r1:r0,00000008) }
	{ p2 = dfclass(r3:r2,00000001); p2 = dfclass(r1:r0,00000001) }
	{ if (p1) jump:nt	0000AB14; if (!p0) jump:nt	0000AAF0 }

l0000AA38:
	{ if (p2) jump:nt	0000AB10 }
	{ p0 = dfclass(r3:r2,00000007); p0 = dfclass(r1:r0,0000000E) }
	{ p1 = dfclass(r3:r2,0000000E); p1 = dfclass(r1:r0,00000007) }
	{ if (!p1) jump:nt	0000AAC4; if (!p0) jump:nt	0000AAB0 }
	{ r13:r12 = combine(00000000,00000000); r15:r14 = combine(00000000,00000000); p1 = dfclass(r3:r2,00000002); p0 = dfclass(r1:r0,00000002) }
	{ r28 = 40000000; r13:r12 = insert(r2,00000034,0000000C); r15:r14 = insert(r0,00000034,0000000C) }
	{ if (p1) r13 = or(r13,r28); if (p0) r15 = or(r15,r28); r5 = extractu(r3,0000000B,00000013); r4 = extractu(r1,0000000B,00000013) }
	{ r11:r10 = combine(00000000,00000001); r6 = add(clb(r12),FFFFFFFE); r7 = add(clb(r14),FFFFFFFE) }
	{ if (!p1) r5 = sub(r10,r6); if (!p0) r4 = sub(r10,r7); r13:r12 = asl(r13:r12,r6); r15:r14 = asl(r15:r14,r7) }
	{ r4 = sub(r4,r5); r9:r8 = combine(r15,r14); r7:r6 = combine(00000000,00000000); jump	0000A90C }
	{ r3:r2 = combine(00000000,00000000); r1:r0 = xor(r1:r0,r3:r2) }
	{ jumpr	r31; r1:r0 = insert(r2,0000003F,00000007) }
	{ p2 = dfclass(r1:r0,00000007); p2 = dfclass(r3:r2,00000001) }
	{ r1 = xor(r1,r3); if (!p2) jump:nt	0000AAE0; r28 = USR }
	{ r28 = or(r28,00000004) }
	{ USR = r28 }
	{ p0 = dfcmp.uo(r3:r2,r3:r2); r3:r2 = combine(7FF00000,00000000) }
	{ jumpr	r31; r1:r0 = insert(r2,0000003F,00000007) }

l0000AAF0:
	{ if (!p1.new) r3:r2 = combine(r1,r0); if (!p0.new) r1:r0 = combine(r3,r2); p1 = dfclass(r3:r2,00000010); p0 = dfclass(r1:r0,00000010) }
	{ r14 = convert_df2sf(r3:r2); r15 = convert_df2sf(r1:r0) }
	{ jumpr	r31; r1:r0 = combine(FFFFFFFF,FFFFFFFF) }
0000AB10 00 40 F8 07                                     .@..           

l0000AB14:
	{ r28 = 00000001 }
	{ jumpr	r31; r1:r0 = convert_sf2df(r28) }

;; __hexagon_fast_muldf3: 0000AB20
;;   Called from:
;;     000087A0 (in _LXp_mulh)
;;     00008844 (in _LXp_mulh)
__hexagon_fast_muldf3 proc
	{ r13:r12 = combine(40000000,00000000); p0 = dfclass(r3:r2,00000002); p0 = dfclass(r1:r0,00000002) }
	{ r9:r8 = combine(00000000,00000001); r28 = FFFFFC00; r5:r4 = asl(r3:r2,0000000A); r13:r12 = insert(r0,00000034,0000000C) }
	{ r5:r4 = insert(r8,00000002,0000003A); r7:r6 = mpyu(r4,r13) }
	{ r15:r14 = mpyu(r12,r4) }
	{ r5:r4 = combine(000007FC,00000000); r11:r10 = mpyu(r13,r5); r7:r6 += lsr(r15:r14,00000020) }
	{ p1 = cmp.eq(r6,00000000); p1 = cmp.eq(r14,00000000); if (!p0) jump:nt	0000ACC8; r11:r10 += lsr(r7:r6,00000020) }

l0000AB70:
	{ if (!p1) r10 = or(r10,r8); r7 = extractu(r3,0000000B,00000013); r6 = extractu(r1,0000000B,00000013) }
	{ r28 = xor(r1,r3); r6 += add(r28,r7); r15:r14 = neg(r11:r10) }
	{ p0 = !cmp.gt(r6,r5); p2 = cmp.gt(r28,FFFFFFFF); if (!p0.new) jump:nt	0000ABE4; p0 = cmp.gt(r6,-00000001); if (!p2.new) r11:r10 = combine(r15,r14) }

l0000AB98:
	{ r6 = add(r6,FFFFFBC6); r1:r0 = convert_d2df(r11:r10) }
	{ nop; nop; jumpr	r31; r1 += asl(r6,00000014) }

l0000ABB0:
	{ r5 = 00007FFF; p0 = cmp.eq(r0,00000000); if (!p0.new) jumpr:t	r31; p0 = bitsclr(r1,r4) }
0000ABC0 04 40 08 6A 00 45 4D C7 05 C6 00 78 04 C5 24 F9 .@.j.EM....x..$.
0000ABD0 08 C0 24 62 00 40 E0 D2 00 40 9F 52 00 C0 00 7F ..$b.@...@.R....
0000ABE0 60 40 EA 80                                     `@..           

l0000ABE4:
	{ r7 = add(r6,FFFFFBC6); r13:r12 = abs(r11:r10) }
	{ r4 = 7FEFFFFF; r7 = extractu(r1,0000000B,00000013); r1 += asl(r7,00000014) }
	{ r5 = 00000000; r7 += add(r6,FFFFFBC6) }
	{ if (p0.new) jump:nt	0000AC88; p0 = cmp.gt(r7,000007FE) }

l0000AC14:
	{ r28 = 0000003F; r5 = sub(r6,r5); if (p0.new) jump:nt	0000ABB0; p0 = cmp.gt(r23,00000001) }

l0000AC20:
	{ r5 = sub(00000005,r5); r4 = 00000000 }
	{ r11:r10 = combine(r13,r12); r5 = min(r28,r5); p3 = cmp.gt(r11,FFFFFFFF) }
	{ r15:r14 = extractu(r11:r10,r5:r4); r28 = USR }
	{ r4 = 00000030; r1 = insert(0000000B,00000013); r11:r10 = asr(r11:r10,r5) }
	{ if (!p0.new) r10 = or(r10,r8); r11 = setbit(r11,0000000E); p0 = cmp.gtu(r9:r8,r15:r14) }
	{ if (!p1.new) r28 = or(r4,r28); p1 = bitsclr(r10,00000007); r15:r14 = neg(r11:r10) }
	{ if (p3.new) r11:r10 = combine(r15,r14); USR = r28 }
	{ p0 = dfcmp.eq(r1:r0,r1:r0); r1:r0 = convert_d2df(r11:r10) }
	{ nop; nop; jumpr	r31; r1 = insert(0000000A,00000012) }
0000AC80 1C 40 08 6A FF 7F FE 07                         .@.j....       

l0000AC88:
	{ r1:r0 = combine(r11,r10); r13:r12 = combine(0000003F,FFFFFFFF) }
	{ r5:r4 = combine(7FF00000,00000000); r28 = or(r28,00000028); r14 = extractu(r28,00000002,00000012) }
	{ r28 = r14; XOREQ	r14,lsr(r1,0000001F); USR = r28 }
	{ if (!p0) r13:r12 = combine(r5,r4); p0 = !cmp.eq(r14,00000002); p0 = dfcmp.eq(r1:r0,r1:r0); p0 = !cmp.eq(r28,00000001) }
	{ jumpr	r31; r1:r0 = insert(r12,0000003F,00000007) }
0000ACC4             0C 7F 00 81                             ....       

l0000ACC8:
	{ r5:r4 = extractu(r3:r2,0000003F,00000007) }
	{ if (!p3.new) r3:r2 = combine(r1,r0); if (!p3.new) r1:r0 = combine(r3,r2); p3 = cmp.gtu(r13:r12,r5:r4) }
	{ if (p3.new) r5:r4 = combine(r13,r12); if (p3.new) r13:r12 = combine(r5,r4); if (!p0.new) jump:nt	0000AD78; p0 = dfclass(r1:r0,0000000F) }

l0000ACE8:
	{ p1 = dfclass(r3:r2,0000000E); p1 = dfclass(r1:r0,00000008) }
	{ p0 = dfclass(r3:r2,00000001); p0 = dfclass(r1:r0,00000008) }
	{ p2 = dfclass(r3:r2,00000001); if (p1) jump:nt	0000AD98 }

l0000AD00:
	{ r28 = 7C000000; if (p2) jump:nt	0000AD94; if (p0) jump:nt	0000AD5C }

l0000AD10:
	{ if (p0.new) jump:nt	0000AD34; p0 = bitsclr(r1,r28) }
	{ r28 = cl0(r5:r4) }
	{ r28 = add(r28,FFFFFFF5) }
	{ r5:r4 = asl(r5:r4,r28) }
	{ r1 -= asl(r28,00000014); r3:r2 = insert(r4,0000003F,00000007) }
	{ jump	0000AB20 }
	{ r1:r0 = xor(r1:r0,r3:r2); r28 = USR }
	{ r28 = or(r28,00000030); r5 = extractu(r28,00000002,00000012); r1:r0 = insert(r8,0000003F,00000007) }
	{ if (!p0.new) r0 = 00000000; p0 = cmp.gt(r5,00000001); XOREQ	r5,lsr(r1,0000001F); USR = r28 }
	{ jumpr	r31; p0 = cmp.eq(r5,00000003); if (!p0.new) r0 = 00000000 }

l0000AD5C:
	{ r28 = USR }
	{ r28 = or(r28,00000002); r1:r0 = combine(FFFFFFFF,FFFFFFFF) }
	{ USR = r28 }
	{ jumpr	r31; p0 = dfcmp.uo(r1:r0,r1:r0) }
0000AD74             F0 41 82 DC                             .A..       

l0000AD78:
	{ if (!p0) r3:r2 = combine(r1,r0); r28 = convert_df2sf(r1:r0) }
	{ nop; r1:r0 = combine(FFFFFFFF,FFFFFFFF); jumpr	r31; r2 = convert_df2sf(r3:r2) }
0000AD90 00 42 03 F5                                     .B..           

l0000AD94:
	{ r3:r2 = combine(r1,r0) }

l0000AD98:
	{ r3 = extract(r3,00000001,00000019) }
	{ jumpr	r31; XOREQ	r1,asl(r3,0000001F) }
0000ADA4             00 C0 00 7F 00 C0 00 7F 00 C0 00 7F     ............
0000ADB0 00 C0 00 7F 00 C0 00 7F 00 C0 00 7F 00 C0 00 7F ................

;; fn0000ADC0: 0000ADC0
;;   Called from:
;;     00009558 (in sqrtl)
;;     0000B348 (in sqrt)
fn0000ADC0 proc
	{ r15:r14 = combine(10000000,00000000); if (!p3.new) jump:nt	0000AE50; p3 = dfclass(r1:r0,00000002) }

l0000ADD0:
	{ r7:r6 = combine(r15,r14); r4 = extractu(r1,0000000B,00000013); r15:r14 = insert(r0,00000034,0000000C) }
	{  }

l0000ADE0:
	{  }
	{ r28 = 000003FF }
	{ r4 = vavgh(r28,r4); r13:r12 = asl(r15:r14,00000001); p0 = tstbit(r4,00000000) }
	{ r3:r2 = lsr(r7:r6,00000001); r9:r8 = vmux(p0,r15:r14,r13:r12) }
	{ r28 = 00000001; r9:r8 = sub(r9:r8,r7:r6) }
	{ r11:r10 = combine(r3,r2); r9:r8 = asl(r9:r8,00000001); r3:r2 += asl(r7:r6,00000001) }
	{ r13:r12 = combine(r9,r8); r3:r2 = combine(r11,r10); r11:r10 = or(r7:r6,r11:r10); r9:r8 = sub(r9:r8,r3:r2) }
	{ if (!p0) r7:r6 = combine(r11,r10); if (!p0.new) r9:r8 = combine(r13,r12); r3:r2 = lsr(r3:r2,00000001); p0 = cmp.gt(r9,FFFFFFFF) }
	{ if (!p0.new) r6 = or(r6,r28); p0 = cmp.eq(r8,00000000); p0 = cmp.eq(r9,00000000) }
	{ r4 = add(r4,FFFFFBC5); r1:r0 = convert_d2df(r7:r6) }
	{ jumpr	r31; r1 += asl(r4,00000014) }
0000AE4C                                     10 42 80 DC             .B..

l0000AE50:
	{ if (p0.new) jump:nt	0000AE88 }

l0000AE54:
	{ if (p0.new) jump:nt	0000AE94; p0 = dfclass(r1:r0,00000001) }

l0000AE5C:
	{ if (!p0.new) jump:t	0000AE94; p0 = tstbit(r1,00000000) }

l0000AE60:
	{ if (p0.new) jump:nt	0000AE94; p0 = dfclass(r1:r0,00000008) }

l0000AE68:
	{ r7:r6 = combine(10000000,00000000); r4 = add(clb(r0),FFFFFFEA) }
	{ r5 = add(r4,00000008); r4 = sub(00000001,r4) }
	{ jump	0000ADE0; r15:r14 = asl(r1:r0,r5) }
0000AE84             24 40 00 88                             $@..       

l0000AE88:
	{ r1:r0 = combine(FFFFFFFF,FFFFFFFF); jumpr	r31 }
0000AE90 00 C0 9F 52                                     ...R           

l0000AE94:
	{ r4 = 7F800001 }
	{ jumpr	r31; r1:r0 = convert_sf2df(r4) }
0000AEA4             00 C0 00 7F 00 C0 00 7F 00 C0 00 7F     ............

;; _exit: 0000AEB0
;;   Called from:
;;     000079B0 (in _Exit)
_exit proc
	{ allocframe(+00000008); r1 = memw(gp+224); r3 = r0 }
	{ memw(r29+4) = r3; if (!p0.new) r4 = add(r29,00000004); if (p0.new) jump:nt	0000AEE4; p0 = cmp.eq(r1,00000000) }

l0000AECC:
	{ r0 = 00000018 }
	{ r1 = r4 }
	{ r2 = r3 }
	{ trap0(00000000) }
	{ r3 = r0 }
	{ dealloc_return; r0 = r3 }

l0000AEE4:
	{ call	00005240 }
	{ r3 = 00000000 }
	{ dealloc_return; r0 = r3 }

;; lockMutex: 0000AEF0
;;   Called from:
;;     00006A04 (in _Lockfilelock)
;;     0000AF1C (in fn0000AF10)
;;     0000AF24 (in fn0000AF20)
;;     0000B0A8 (in __sys_sbrk)
;;     0000B15C (in sys_Tlsalloc)
;;     0000B204 (in sys_Tlsfree)
lockMutex proc
	{ r2 = memw_locked(r0) }

;; fn0000AEF4: 0000AEF4
;;   Called from:
;;     00006AF0 (in _Locksyslock)
fn0000AEF4 proc
	{ r1 = sxth(r2); r3 = asr(r2,00000010); r4 = htid }
	{ r2 = add(r2,00000001); r4 = asl(r4,00000010); p1 = cmp.eq(r3,r4) }
	{ if (p1) jump:nt	0000AF20 }

;; fn0000AF10: 0000AF10
;;   Called from:
;;     0000AF0C (in fn0000AEF4)
;;     0000AF0C (in lockMutex)
fn0000AF10 proc
	{ r2 = add(r4,00000001); p1 = cmp.eq(r1,00000000) }
	{ if (p1) jump:nt	0000AF20 }

l0000AF1C:
	{ jump	0000AEF0 }

;; fn0000AF20: 0000AF20
;;   Called from:
;;     0000AF0C (in fn0000AEF4)
;;     0000AF0C (in lockMutex)
;;     0000AF18 (in fn0000AF10)
fn0000AF20 proc
	{ memw_locked(r0,p0) = r2 }
	{ if (!p0) jump:nt	0000AEF0 }

l0000AF28:
	{ jumpr	r31 }
0000AF2C                                     00 C0 00 7F             ....

;; __sys_Mtxunlock: 0000AF30
;;   Called from:
;;     0000B118 (in __sys_sbrk)
;;     0000B1B4 (in sys_Tlsalloc)
;;     0000B210 (in sys_Tlsfree)
__sys_Mtxunlock proc
	{ r1 = memw_locked(r0) }

;; fn0000AF34: 0000AF34
;;   Called from:
;;     00006A38 (in _Unlockfilelock)
;;     00006B18 (in _Unlocksyslock)
;;     0000AF30 (in __sys_Mtxunlock)
fn0000AF34 proc
	{ r3 = 00000001; r5 = extractu(r1,00000003,00000013); r4 = htid }
	{ r3 = vsubh(r1,r3); p1 = cmp.eq(r5,r4) }
	{ if (!p1) jumpr:nt	r31 }
0000AF4C                                     00 C3 A0 A0             ....
0000AF50 F0 E0 FF 5C 00 C0 9F 52 00 40 00 7F 00 C0 00 7F ...\...R.@......

;; __sys_Mtxinit: 0000AF60
;;   Called from:
;;     00006910 (in _Initlocks)
;;     00006934 (in _Initlocks)
;;     000069A0 (in _Lockfilelock)
;;     000069C0 (in _Lockfilelock)
;;     00006A90 (in _Locksyslock)
;;     00006AB4 (in _Locksyslock)
;;     0000B130 (in BeforeBegin)
__sys_Mtxinit proc
	{ r1 = 00000000 }
	{ memw(r0) = r1; jumpr	r31 }
0000AF6C                                     00 C0 00 7F             ....

;; __sys_Mtxdst: 0000AF70
;;   Called from:
;;     000068C0 (in _Clearlocks)
;;     000068E4 (in _Clearlocks)
;;     0000B140 (in AtEnd)
__sys_Mtxdst proc
	{ jumpr	r31 }
0000AF74             00 40 00 7F 00 40 00 7F 00 C0 00 7F     .@...@......

;; __trylockMutex: 0000AF80
__trylockMutex proc
	{ r4 = htid }

l0000AF84:
	{ r2 = memw_locked(r0) }
	{ r3 = asr(r2,00000010) }
	{ p1 = cmp.eq(r3,r4) }
	{ if (p1) r2 = add(r2,00000001) }
	{ if (p1) jump:nt	0000AFB4 }

l0000AF98:
	{ r3 = sxth(r2) }
	{ p1 = cmp.eq(r3,00000000) }
	{ r5 = asl(r4,00000010) }
	{ if (p1) r2 = add(r5,00000000) }
	{ if (p1) r2 = add(r2,00000001) }
	{ if (p1) jump:nt	0000AFB4 }

l0000AFB0:
	{ jumpr	r31; r0 = 00000000 }

l0000AFB4:
	{ memw_locked(r0,p0) = r2 }
	{ if (!p0) jump:nt	0000AF84 }

l0000AFBC:
	{ jumpr	r31; r0 = 00000001 }

;; __sys_close: 0000AFC0
;;   Called from:
;;     000094E0 (in close)
__sys_close proc
	{ allocframe(+00000010); r1 = memw(gp+224) }
	{ memw(r29+4) = r0; memd(r29+8) = r17:r16; if (p0.new) jump:nt	0000B004; p0 = cmp.eq(r1,00000000) }

l0000AFD4:
	{ r16 = add(r29,00000004); r1 = 00000004; r0 = add(r29,00000004); call	00005610 }
	{ r0 = 00000002 }
	{ r1 = r16 }
	{ trap0(00000000) }
	{ r2 = r0 }
	{ r16 = r1 }
	{ if (!p0.new) jump:t	0000B010; p0 = cmp.eq(r2,-00000001) }

l0000AFF8:
	{ call	00006F10 }
	{ memw(r0) = r16; r2 = -00000001; jump	0000B010 }

l0000B004:
	{ call	00006F10 }
	{ memw(r0) = 00000059; r2 = FFFFFFFF }

l0000B010:
	{ dealloc_return; r17:r16 = memd(r29+8); r0 = r2 }
0000B018                         00 C0 00 7F 00 C0 00 7F         ........

;; __sys_remove: 0000B020
;;   Called from:
;;     00009510 (in remove)
__sys_remove proc
	{ allocframe(+00000010); r1 = memw(gp+224) }
	{ memd(r29+8) = r17:r16; r16 = r0; if (p0.new) jump:nt	0000B084; p0 = cmp.eq(r1,00000000) }

l0000B034:
	{ memw(r29) = r16; r0 = r16; r17 = add(r29,00000000); call	000076E0 }
	{ r0 = r16; r1 = r0; r2 = setbit(r17,00000004) }
	{ memw(r2) = r1; call	000076E0 }
	{ r1 = r0; r0 = r16; call	00005610 }
	{ r0 = add(r29,00000000); r1 = 00000008; call	00005610 }
	{ r0 = 0000000E }
	{ r1 = r17 }
	{ trap0(00000000) }
	{ r2 = r0 }
	{ r16 = r1 }
	{ if (!p0.new) jump:t	0000B090; p0 = cmp.eq(r2,-00000001) }

l0000B078:
	{ call	00006F10 }
	{ memw(r0) = r16; r2 = -00000001; jump	0000B090 }

l0000B084:
	{ call	00006F10 }
	{ memw(r0) = 00000059; r2 = FFFFFFFF }

l0000B090:
	{ dealloc_return; r17:r16 = memd(r29+8); r0 = r2 }
0000B098                         00 C0 00 7F 00 C0 00 7F         ........

;; __sys_sbrk: 0000B0A0
;;   Called from:
;;     00007AB8 (in _Getmem)
__sys_sbrk proc
	{ allocframe(00000008); memd(r29+496) = r17:r16; r17 = r0 }
	{ r0 = 0001006C; call	0000AEF0 }
	{ r1 = 0000E018 }
	{  }
	{  }
	{ r2 = memw(r1); r3 = 00000000 }
	{ if (!p0.new) r16 = add(r3,00000000); if (p0.new) r16 = add(r2,00000000); p0 = !cmp.eq(r2,00000000) }
	{ memw(r0) = r16 }
	{ if (p0.new) jump:nt	0000B118; p0 = cmp.eq(r9,00000000) }

l0000B0E4:
	{ r2 = memw(r1); r3 = r17 }
	{ r3 += add(r16,00000007) }
	{ r1 = and(r3,FFFFFFF8) }
	{ if (cmp.eq(r2.new,00000000)) jump:t	0000B10C; r2 = memw(gp+112) }

l0000B104:
	{ memw(r16) = r17; memw(r0) = r1; jump	0000B118 }

l0000B10C:
	{ r16 = FFFFFFFF; call	00006F10 }
	{ memw(r0) = 0000000C }

l0000B118:
	{ r0 = 0001006C; call	0000AF30 }
	{ dealloc_return; r17:r16 = memd(r29); r0 = r16 }
0000B12C                                     00 C0 00 7F             ....

;; BeforeBegin: 0000B130
BeforeBegin proc
	{ nop; r0 = 00010070; jump	0000AF60 }

;; AtEnd: 0000B140
AtEnd proc
	{ nop; r0 = 00010070; jump	0000AF70 }

;; sys_Tlsalloc: 0000B150
;;   Called from:
;;     000065A4 (in _Tls_get__Mbcurmax)
;;     0000664C (in fn00006620)
;;     00006B78 (in _Tls_get__Tolotab)
;;     00006EB8 (in _Tls_get__Errno)
;;     00007938 (in _Tls_get__Ctype)
;;     00008FB8 (in _Tls_get__Wcstate)
;;     00009C88 (in _Tls_get__Locale)
sys_Tlsalloc proc
	{  }
	{ allocframe(00000008); memd(r29+496) = r17:r16 }
	{ if (p0.new) jump:nt	0000B1C4; p0 = cmp.eq(r8,00000000) }

l0000B15C:
	{ r0 = 00010070; call	0000AEF0 }
	{ r1 = 0000EC18; r0 = FE104FFF }
	{ r17 = 0000000B; r2 = 0000002C }

l0000B180:
	{ r3 = add(r0,01EFB001) }
	{ p0 = cmp.gtu(r3,0000003F); if (p0.new) jump:nt	0000B1B4 }

l0000B190:
	{ r3 = memw(r2+4); r1 = add(r1,00000018); r2 = add(r2,00000004); r0 = add(r0,00000001) }
	{ if (!p0.new) jump:t	0000B180; p0 = cmp.eq(r19,00000001) }

l0000B1A0:
	{ memw(r2) = 00000001; r3 = 00000000; loop0(0000B1A8,00000006) }
	{ memw(r1++#4) = r3; nop }
	{ memw(r16) = r0; r17 = 00000000 }

l0000B1B4:
	{ nop; r0 = 00010070; call	0000AF30 }

l0000B1C4:
	{ dealloc_return; r17:r16 = memd(r29); nop; r0 = r17 }

;; sys_Tlsfree: 0000B1D0
sys_Tlsfree proc
	{ allocframe(00000008); memd(r29+496) = r17:r16; r17 = add(r0,01EFB000) }
	{ p0 = cmp.gtu(r17,0000003F); r16 = 00000016; if (p0.new) jump:t	0000B21C }

l0000B1E8:
	{ if (cmp.eq(r0.new,00000000)) jump:nt	0000B224; r0 = memw(r17<<#2+0000EB30) }

l0000B1F8:
	{ r16 = 0000EB30; r0 = 00000030 }
	{ call	0000AEF0 }
	{ r16 = 00000000; r0 = addasl(r16,r17,00000002) }
	{ memw(r0) = 00000000; r0 = 00000030; call	0000AF30 }

l0000B21C:
	{ dealloc_return; r17:r16 = memd(r29); r0 = r16 }

;; sys_Tlsset: 0000B224
;;   Called from:
;;     000065D8 (in _Tls_get__Mbcurmax)
;;     0000B1E8 (in sys_Tlsfree)
sys_Tlsset proc
	{ r0 = 00000016; r2 = add(r0,01EFB000) }
	{ p0 = cmp.gtu(r2,0000003F); if (p0.new) jump:t	0000B258 }

l0000B238:
	{ r3 = memw(r2<<#2+0000EB30) }
	{ r3 = htid }
	{ r0 = 00000000; r4 = 00000030 }
	{ r2 = add(r4,mpyi(00000018,r2)) }
	{ memw(r14+r3<<#2) = r1 }

l0000B258:
	{ jumpr	r31; nop }

;; sys_Tlsget: 0000B260
sys_Tlsget proc
	{ r0 = 00000000; r1 = add(r0,01EFB000) }
	{ p0 = cmp.gtu(r1,0000003F); if (p0.new) jump:t	0000B294 }

l0000B274:
	{ if (cmp.eq(r2.new,00000000)) jump:nt	0000B29C; r2 = memw(r1<<#2+0000EB30) }

l0000B284:
	{ r2 = 0000EC30 }
	{ r1 = add(r2,mpyi(00000018,r1)) }
	{ r0 = memw(r30+r0<<#2) }

l0000B294:
	{ jumpr	r31 }
0000B298                         00 C0 00 7F                     ....   

l0000B29C:
	{ nop }

;; __sys_write: 0000B2A0
;;   Called from:
;;     000094F0 (in write)
;;     0000B29C (in sys_Tlsget)
__sys_write proc
	{ allocframe(+00000018); r4 = memw(gp+224); r3 = r0 }
	{ memd(r29+16) = r17:r16; r0 = r1; if (p0.new) jump:nt	0000B2F8; p0 = cmp.eq(r4,00000000) }

l0000B2B8:
	{ memw(r29) = r3; r16 = add(r29,00000000); r1 = r2 }
	{ r4 = setbit(r16,00000004) }
	{ memw(r16+8) = r2; memw(r4) = r0; call	00005610 }
	{ r0 = add(r29,00000000); r1 = 0000000C; call	00005610 }
	{ r0 = 00000005 }
	{ r1 = r16 }
	{ trap0(00000000) }
	{ r2 = r0 }
	{ r16 = r1 }
	{ if (!p0.new) jump:t	0000B304; p0 = cmp.eq(r2,-00000001) }

l0000B2EC:
	{ call	00006F10 }
	{ memw(r0) = r16; r2 = -00000001; jump	0000B304 }

l0000B2F8:
	{ call	00006F10 }
	{ memw(r0) = 00000059; r2 = FFFFFFFF }

l0000B304:
	{ dealloc_return; r17:r16 = memd(r29+16); r0 = r2 }
0000B30C                                     00 C0 00 7F             ....

;; sqrt: 0000B310
sqrt proc
	{ allocframe(00000018); memd(r29+496) = r17:r16; r17:r16 = combine(r1,r0) }
	{ memd(r29+8) = r17:r16; r1 = add(r29,00000008); r0 = add(r29,00000006); call	000095D0 }
	{ if (p0.new) jump:nt	0000B348; p0 = cmp.eq(r0,00000000) }

l0000B328:
	{ if (p0.new) jump:t	0000B330; p0 = cmp.eq(r0,00000002) }

l0000B32C:
	{ if (p0.new) jump:t	0000B348; p0 = cmp.eq(r0,00000004) }

l0000B330:
	{ r0 = add(r29,00000008) }
	{ r0 = or(r0,00000006) }
	{ if (tstbit(r0.new,-00000001)) jump:t	0000B34C; r0 = memh(r0) }

l0000B344:
	{ r0 = 00000001 }

l0000B348:
	{ r1:r0 = combine(r17,r16); call	0000ADC0 }

l0000B34C:
	{ r1:r0 = combine(r17,r16) }

l0000B350:
	{ dealloc_return; r17:r16 = memd(r29+16) }
