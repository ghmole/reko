// simd_double.h
// Generated by decompiling simd_double
// using Reko decompiler version 0.9.4.0.

/*
// Equivalence classes ////////////
Eq_1: (struct "Globals" (5D6 code t05D6) (5E6 code t05E6) (5F6 code t05F6) (606 code t0606) (898 (fn int32 (int32, (ptr64 (ptr64 char)), (ptr64 (ptr64 char)))) t0898) (A70 (fn void ()) t0A70) (AE0 (fn void ()) t0AE0) (B00 uint64 double_size.21529) (200DE8 (arr (ptr64 code)) a200DE8) (200FD8 (ptr64 code) _ITM_deregisterTMCloneTable_GOT) (200FE0 (ptr64 code) __libc_start_main_GOT) (200FE8 (ptr64 code) __gmon_start___GOT) (200FF0 (ptr64 code) _ITM_registerTMCloneTable_GOT) (200FF8 (ptr64 code) __cxa_finalize_GOT) (201018 (ptr64 code) free_GOT) (201020 (ptr64 code) printf_GOT) (201028 (ptr64 code) malloc_GOT) (201030 (ptr64 code) posix_memalign_GOT) (201048 byte b201048))
	globals_t (in globals : (ptr64 (struct "Globals")))
Eq_7: (fn void ())
	T_7 (in rdx : (ptr64 Eq_7))
	T_23 (in rtld_fini : (ptr64 (fn void ())))
Eq_8: (union "Eq_8" (int32 u0) (word64 u1))
	T_8 (in qwArg00 : Eq_8)
	T_19 (in argc : int32)
Eq_9: (fn void (ptr64))
	T_9 (in __align : ptr64)
	T_10 (in signature of __align : void)
	T_108 (in __align : ptr64)
Eq_16: (fn int32 ((ptr64 Eq_18), Eq_8, (ptr64 (ptr64 char)), (ptr64 Eq_21), (ptr64 Eq_22), (ptr64 Eq_7), (ptr64 void)))
	T_16 (in __libc_start_main : ptr64)
	T_17 (in signature of __libc_start_main : void)
Eq_18: (fn int32 (int32, (ptr64 (ptr64 char)), (ptr64 (ptr64 char))))
	T_18 (in main : (ptr64 (fn int32 (int32, (ptr64 (ptr64 char)), (ptr64 (ptr64 char))))))
	T_25 (in 0000000000000898 : ptr64)
Eq_21: (fn void ())
	T_21 (in init : (ptr64 (fn void ())))
	T_27 (in 0000000000000A70 : ptr64)
Eq_22: (fn void ())
	T_22 (in fini : (ptr64 (fn void ())))
	T_28 (in 0000000000000AE0 : ptr64)
Eq_30: (fn void ())
	T_30 (in __hlt : ptr64)
	T_31 (in signature of __hlt : void)
Eq_41: (union "Eq_41" (int64 u0) (ptr64 u1))
	T_41 (in 0000000000201048 : ptr64)
Eq_42: (union "Eq_42" (int64 u0) (ptr64 u1))
	T_42 (in 0000000000201048 : ptr64)
Eq_45: (union "Eq_45" (int64 u0) (uint64 u1))
	T_45 (in rsi_9 >> 3<64> : word64)
Eq_46: (union "Eq_46" (int64 u0) (uint64 u1))
	T_46 (in rsi_9 >> 3<64> : word64)
Eq_48: (union "Eq_48" (int64 u0) (uint64 u1))
	T_48 (in rsi_9 >> 3<64> >> 0x3F<64> : word64)
Eq_49: (union "Eq_49" (int64 u0) (uint64 u1))
	T_49 (in (rsi_9 >> 3<64>) + ((rsi_9 >> 3<64>) >>u 0x3F<64>) : word64)
Eq_66: (fn void ())
	T_66 (in deregister_tm_clones : ptr64)
	T_67 (in signature of deregister_tm_clones : void)
Eq_75: (fn void ())
	T_75 (in register_tm_clones : ptr64)
	T_76 (in signature of register_tm_clones : void)
Eq_80: (union "Eq_80" (word64 u0) (size_t u1))
	T_80 (in rdi : Eq_80)
	T_89 (in size : size_t)
	T_124 (in 0x2000<64> : word64)
	T_129 (in 0x2000<64> : word64)
	T_134 (in 0x2000<64> : word64)
Eq_103: (fn void ((ptr64 (arr real64))))
	T_103 (in free : ptr64)
	T_104 (in signature of free : void)
Eq_119: (union "Eq_119" (uint128 u0) ((arr word64 2) u1))
	T_119 (in xmm0 : Eq_119)
	T_161 (in CONVERT(v26_71 + v26_71, real64, uint128) : uint128)
	T_164 (in SEQ(SLICE(xmm0, word64, 64), CONVERT(qwLoc10_205, word64, real64)) : word128)
	T_195 (in CONVERT(v19_108 + v19_108, real64, uint128) : uint128)
	T_199 (in SEQ(SLICE(xmm0, word64, 64), CONVERT(qwLoc18_211 + 1<64>, word64, real64)) : word128)
	T_208 (in  : (arr word64 2))
	T_209 (in  : (arr word64 2))
	T_210 (in __xorpd(xmm0, xmm0) : (arr word64 2))
Eq_121: (fn (ptr64 (arr real64)) (uint64, Eq_80))
	T_121 (in _mm_malloc : ptr64)
	T_122 (in signature of _mm_malloc : void)
	T_127 (in _mm_malloc : ptr64)
	T_132 (in _mm_malloc : ptr64)
Eq_136: (union "Eq_136" (int64 u0) (uint64 u1))
	T_136 (in qwLoc10_205 : Eq_136)
	T_137 (in 0<64> : word64)
	T_138 (in 0x400<64> : word64)
	T_146 (in 0<64> : word64)
	T_170 (in qwLoc10_205 + 1<64> : word64)
Eq_148: (union "Eq_148" (int64 u0) (uint64 u1))
	T_148 (in qwLoc18_211 : Eq_148)
	T_149 (in 0<64> : word64)
	T_150 (in 0x400<64> : word64)
	T_179 (in 1<64> : word64)
	T_205 (in qwLoc18_211 + 1<64> : word64)
Eq_169: (union "Eq_169" (int64 u0) (uint64 u1))
	T_169 (in 1<64> : word64)
Eq_172: (union "Eq_172" (int64 u0) (uint64 u1))
	T_172 (in 1<64> : word64)
Eq_186: (union "Eq_186" (int64 u0) (uint64 u1))
	T_186 (in qwLoc18_211 + 1<64> : word64)
Eq_197: (union "Eq_197" (int64 u0) (uint64 u1))
	T_197 (in qwLoc18_211 + 1<64> : word64)
Eq_204: (union "Eq_204" (int64 u0) (uint64 u1))
	T_204 (in 1<64> : word64)
Eq_206: (fn Eq_119 (Eq_119, Eq_119))
	T_206 (in __xorpd : ptr64)
	T_207 (in signature of __xorpd : void)
Eq_217: (fn void (word64))
	T_217 (in vec_add : ptr64)
	T_218 (in signature of vec_add : void)
Eq_225: (fn int32 ((ptr64 char), word32))
	T_225 (in printf : ptr64)
	T_226 (in signature of printf : void)
Eq_233: (fn void ((ptr64 (arr real64))))
	T_233 (in _mm_free : ptr64)
	T_234 (in signature of _mm_free : void)
	T_236 (in _mm_free : ptr64)
	T_238 (in _mm_free : ptr64)
Eq_245: (fn void ())
	T_245 (in _init : ptr64)
	T_246 (in signature of _init : void)
Eq_252: (union "Eq_252" (int64 u0) (ptr64 u1))
	T_252 (in 0000000000200DF0 : ptr64)
Eq_253: (union "Eq_253" (int64 u0) (ptr64 u1))
	T_253 (in 0000000000200DE8 : ptr64)
Eq_259: (union "Eq_259" (int64 u0) (uint64 u1))
	T_259 (in rbx_44 : Eq_259)
	T_260 (in 0<u64> : uint64)
	T_266 (in rbx_44 + 1<64> : word64)
	T_267 (in rbp_31 >> 3<64> : word64)
// Type Variables ////////////
globals_t: (in globals : (ptr64 (struct "Globals")))
  Class: Eq_1
  DataType: (ptr64 Eq_1)
  OrigDataType: (ptr64 (struct "Globals"))
T_2: (in __gmon_start__ : ptr64)
  Class: Eq_2
  DataType: word64
  OrigDataType: 
T_3: (in signature of __gmon_start__ : void)
  Class: Eq_3
  DataType: Eq_3
  OrigDataType: 
T_4: (in 0<64> : word64)
  Class: Eq_2
  DataType: word64
  OrigDataType: word64
T_5: (in __gmon_start__ == 0<64> : bool)
  Class: Eq_5
  DataType: bool
  OrigDataType: bool
T_6: (in __gmon_start__ : ptr64)
  Class: Eq_6
  DataType: (ptr64 code)
  OrigDataType: (ptr64 code)
T_7: (in rdx : (ptr64 Eq_7))
  Class: Eq_7
  DataType: (ptr64 Eq_7)
  OrigDataType: (ptr64 (fn void ()))
T_8: (in qwArg00 : Eq_8)
  Class: Eq_8
  DataType: Eq_8
  OrigDataType: (union (int32 u1) (word64 u0))
T_9: (in __align : ptr64)
  Class: Eq_9
  DataType: (ptr64 Eq_9)
  OrigDataType: (ptr64 (fn T_15 (T_14)))
T_10: (in signature of __align : void)
  Class: Eq_9
  DataType: (ptr64 Eq_9)
  OrigDataType: 
T_11: (in  : word64)
  Class: Eq_11
  DataType: ptr64
  OrigDataType: 
T_12: (in fp : ptr64)
  Class: Eq_12
  DataType: (ptr64 void)
  OrigDataType: (ptr64 void)
T_13: (in 8<i64> : int64)
  Class: Eq_13
  DataType: int64
  OrigDataType: int64
T_14: (in fp + 8<i64> : word64)
  Class: Eq_11
  DataType: ptr64
  OrigDataType: ptr64
T_15: (in __align((char *) fp + 8<i32>) : void)
  Class: Eq_15
  DataType: void
  OrigDataType: void
T_16: (in __libc_start_main : ptr64)
  Class: Eq_16
  DataType: (ptr64 Eq_16)
  OrigDataType: (ptr64 (fn T_29 (T_25, T_8, T_26, T_27, T_28, T_7, T_12)))
T_17: (in signature of __libc_start_main : void)
  Class: Eq_16
  DataType: (ptr64 Eq_16)
  OrigDataType: 
T_18: (in main : (ptr64 (fn int32 (int32, (ptr64 (ptr64 char)), (ptr64 (ptr64 char))))))
  Class: Eq_18
  DataType: (ptr64 Eq_18)
  OrigDataType: 
T_19: (in argc : int32)
  Class: Eq_8
  DataType: Eq_8
  OrigDataType: 
T_20: (in ubp_av : (ptr64 (ptr64 char)))
  Class: Eq_20
  DataType: (ptr64 (ptr64 char))
  OrigDataType: 
T_21: (in init : (ptr64 (fn void ())))
  Class: Eq_21
  DataType: (ptr64 Eq_21)
  OrigDataType: 
T_22: (in fini : (ptr64 (fn void ())))
  Class: Eq_22
  DataType: (ptr64 Eq_22)
  OrigDataType: 
T_23: (in rtld_fini : (ptr64 (fn void ())))
  Class: Eq_7
  DataType: (ptr64 Eq_7)
  OrigDataType: 
T_24: (in stack_end : (ptr64 void))
  Class: Eq_12
  DataType: (ptr64 void)
  OrigDataType: 
T_25: (in 0000000000000898 : ptr64)
  Class: Eq_18
  DataType: (ptr64 Eq_18)
  OrigDataType: (ptr64 (fn int32 (int32, (ptr64 (ptr64 char)), (ptr64 (ptr64 char)))))
T_26: (in fp + 8<i64> : word64)
  Class: Eq_20
  DataType: (ptr64 (ptr64 char))
  OrigDataType: (ptr64 (ptr64 char))
T_27: (in 0000000000000A70 : ptr64)
  Class: Eq_21
  DataType: (ptr64 Eq_21)
  OrigDataType: (ptr64 (fn void ()))
T_28: (in 0000000000000AE0 : ptr64)
  Class: Eq_22
  DataType: (ptr64 Eq_22)
  OrigDataType: (ptr64 (fn void ()))
T_29: (in __libc_start_main(&g_t0898, qwArg00, (char *) fp + 8<i32>, &g_t0A70, &g_t0AE0, rdx, fp) : int32)
  Class: Eq_29
  DataType: int32
  OrigDataType: int32
T_30: (in __hlt : ptr64)
  Class: Eq_30
  DataType: (ptr64 Eq_30)
  OrigDataType: (ptr64 (fn T_32 ()))
T_31: (in signature of __hlt : void)
  Class: Eq_30
  DataType: (ptr64 Eq_30)
  OrigDataType: 
T_32: (in __hlt() : void)
  Class: Eq_32
  DataType: void
  OrigDataType: void
T_33: (in 0000000000201048 : ptr64)
  Class: Eq_33
  DataType: ptr64
  OrigDataType: ptr64
T_34: (in 0000000000201048 : ptr64)
  Class: Eq_33
  DataType: ptr64
  OrigDataType: ptr64
T_35: (in 0x201048<u64> == 0x201048<u64> : bool)
  Class: Eq_35
  DataType: bool
  OrigDataType: bool
T_36: (in _ITM_deregisterTMCloneTable : ptr64)
  Class: Eq_36
  DataType: (ptr64 code)
  OrigDataType: (ptr64 code)
T_37: (in signature of _ITM_deregisterTMCloneTable : void)
  Class: Eq_37
  DataType: Eq_37
  OrigDataType: 
T_38: (in 0<64> : word64)
  Class: Eq_36
  DataType: (ptr64 code)
  OrigDataType: word64
T_39: (in _ITM_deregisterTMCloneTable == null : bool)
  Class: Eq_39
  DataType: bool
  OrigDataType: bool
T_40: (in rsi_9 : int64)
  Class: Eq_40
  DataType: int64
  OrigDataType: int64
T_41: (in 0000000000201048 : ptr64)
  Class: Eq_41
  DataType: int64
  OrigDataType: (union (int64 u0) (ptr64 u1))
T_42: (in 0000000000201048 : ptr64)
  Class: Eq_42
  DataType: int64
  OrigDataType: (union (int64 u1) (ptr64 u0))
T_43: (in 0x201048<u64> - 0x201048<u64> : word64)
  Class: Eq_40
  DataType: int64
  OrigDataType: int64
T_44: (in 3<64> : word64)
  Class: Eq_44
  DataType: word64
  OrigDataType: word64
T_45: (in rsi_9 >> 3<64> : word64)
  Class: Eq_45
  DataType: Eq_45
  OrigDataType: (union (int64 u1) (uint64 u0))
T_46: (in rsi_9 >> 3<64> : word64)
  Class: Eq_46
  DataType: Eq_46
  OrigDataType: (union (int64 u0) (uint64 u1))
T_47: (in 0x3F<64> : word64)
  Class: Eq_47
  DataType: word64
  OrigDataType: word64
T_48: (in rsi_9 >> 3<64> >> 0x3F<64> : word64)
  Class: Eq_48
  DataType: Eq_48
  OrigDataType: (union (int64 u1) (uint64 u0))
T_49: (in (rsi_9 >> 3<64>) + ((rsi_9 >> 3<64>) >>u 0x3F<64>) : word64)
  Class: Eq_49
  DataType: Eq_49
  OrigDataType: (union (int64 u1) (uint64 u0))
T_50: (in 1<64> : word64)
  Class: Eq_50
  DataType: word64
  OrigDataType: word64
T_51: (in (rsi_9 >> 3<64>) + ((rsi_9 >> 3<64>) >>u 0x3F<64>) >> 1<64> : word64)
  Class: Eq_51
  DataType: int64
  OrigDataType: int64
T_52: (in 0<64> : word64)
  Class: Eq_51
  DataType: int64
  OrigDataType: word64
T_53: (in (rsi_9 >> 3<64>) + ((rsi_9 >> 3<64>) >>u 0x3F<64>) >> 1<64> == 0<64> : bool)
  Class: Eq_53
  DataType: bool
  OrigDataType: bool
T_54: (in _ITM_registerTMCloneTable : ptr64)
  Class: Eq_54
  DataType: (ptr64 code)
  OrigDataType: (ptr64 code)
T_55: (in signature of _ITM_registerTMCloneTable : void)
  Class: Eq_55
  DataType: Eq_55
  OrigDataType: 
T_56: (in 0<64> : word64)
  Class: Eq_54
  DataType: (ptr64 code)
  OrigDataType: word64
T_57: (in _ITM_registerTMCloneTable == null : bool)
  Class: Eq_57
  DataType: bool
  OrigDataType: bool
T_58: (in 0000000000201048 : ptr64)
  Class: Eq_58
  DataType: (ptr64 byte)
  OrigDataType: (ptr64 (struct (0 T_59 t0000)))
T_59: (in Mem0[0x0000000000201048<p64>:byte] : byte)
  Class: Eq_59
  DataType: byte
  OrigDataType: byte
T_60: (in 0<8> : byte)
  Class: Eq_59
  DataType: byte
  OrigDataType: byte
T_61: (in g_b201048 != 0<8> : bool)
  Class: Eq_61
  DataType: bool
  OrigDataType: bool
T_62: (in __cxa_finalize : ptr64)
  Class: Eq_62
  DataType: word64
  OrigDataType: 
T_63: (in signature of __cxa_finalize : void)
  Class: Eq_63
  DataType: Eq_63
  OrigDataType: 
T_64: (in 0<64> : word64)
  Class: Eq_62
  DataType: word64
  OrigDataType: word64
T_65: (in __cxa_finalize == 0<64> : bool)
  Class: Eq_65
  DataType: bool
  OrigDataType: bool
T_66: (in deregister_tm_clones : ptr64)
  Class: Eq_66
  DataType: (ptr64 Eq_66)
  OrigDataType: (ptr64 (fn T_68 ()))
T_67: (in signature of deregister_tm_clones : void)
  Class: Eq_66
  DataType: (ptr64 Eq_66)
  OrigDataType: 
T_68: (in deregister_tm_clones() : void)
  Class: Eq_68
  DataType: void
  OrigDataType: void
T_69: (in 1<8> : byte)
  Class: Eq_59
  DataType: byte
  OrigDataType: byte
T_70: (in 0000000000201048 : ptr64)
  Class: Eq_70
  DataType: (ptr64 byte)
  OrigDataType: (ptr64 (struct (0 T_71 t0000)))
T_71: (in Mem22[0x0000000000201048<p64>:byte] : byte)
  Class: Eq_59
  DataType: byte
  OrigDataType: byte
T_72: (in rax_27 : word64)
  Class: Eq_72
  DataType: word64
  OrigDataType: word64
T_73: (in __cxa_finalize : ptr64)
  Class: Eq_73
  DataType: (ptr64 code)
  OrigDataType: (ptr64 code)
T_74: (in signature of __cxa_finalize : void)
  Class: Eq_74
  DataType: Eq_74
  OrigDataType: 
T_75: (in register_tm_clones : ptr64)
  Class: Eq_75
  DataType: (ptr64 Eq_75)
  OrigDataType: (ptr64 (fn T_77 ()))
T_76: (in signature of register_tm_clones : void)
  Class: Eq_75
  DataType: (ptr64 Eq_75)
  OrigDataType: 
T_77: (in register_tm_clones() : void)
  Class: Eq_77
  DataType: void
  OrigDataType: void
T_78: (in rax : (ptr64 void))
  Class: Eq_78
  DataType: (ptr64 void)
  OrigDataType: word64
T_79: (in rsi : uint64)
  Class: Eq_79
  DataType: uint64
  OrigDataType: word64
T_80: (in rdi : Eq_80)
  Class: Eq_80
  DataType: Eq_80
  OrigDataType: (union (word64 u0) (size_t u1))
T_81: (in rax_43 : (ptr64 void))
  Class: Eq_78
  DataType: (ptr64 void)
  OrigDataType: (ptr64 void)
T_82: (in qwLoc28_55 : uint64)
  Class: Eq_79
  DataType: uint64
  OrigDataType: word64
T_83: (in 1<64> : word64)
  Class: Eq_79
  DataType: uint64
  OrigDataType: word64
T_84: (in rsi != 1<64> : bool)
  Class: Eq_84
  DataType: bool
  OrigDataType: bool
T_85: (in 2<64> : word64)
  Class: Eq_79
  DataType: uint64
  OrigDataType: word64
T_86: (in rsi == 2<64> : bool)
  Class: Eq_86
  DataType: bool
  OrigDataType: bool
T_87: (in malloc : ptr64)
  Class: Eq_87
  DataType: ptr64
  OrigDataType: ptr64
T_88: (in signature of malloc : void)
  Class: Eq_87
  DataType: ptr64
  OrigDataType: 
T_89: (in size : size_t)
  Class: Eq_80
  DataType: Eq_80
  OrigDataType: 
T_90: (in malloc(rdi) : (ptr64 void))
  Class: Eq_78
  DataType: (ptr64 void)
  OrigDataType: (ptr64 void)
T_91: (in 8<64> : word64)
  Class: Eq_79
  DataType: uint64
  OrigDataType: word64
T_92: (in 4<64> : word64)
  Class: Eq_79
  DataType: uint64
  OrigDataType: word64
T_93: (in rsi != 4<64> : bool)
  Class: Eq_93
  DataType: bool
  OrigDataType: bool
T_94: (in rax_34 : word64)
  Class: Eq_94
  DataType: word64
  OrigDataType: word64
T_95: (in posix_memalign : ptr64)
  Class: Eq_95
  DataType: (ptr64 code)
  OrigDataType: (ptr64 code)
T_96: (in signature of posix_memalign : void)
  Class: Eq_96
  DataType: Eq_96
  OrigDataType: 
T_97: (in SLICE(rax_34, word32, 0) : word32)
  Class: Eq_97
  DataType: word32
  OrigDataType: word32
T_98: (in 0<32> : word32)
  Class: Eq_97
  DataType: word32
  OrigDataType: word32
T_99: (in (word32) rax_34 != 0<32> : bool)
  Class: Eq_99
  DataType: bool
  OrigDataType: bool
T_100: (in 0<u64> : uint64)
  Class: Eq_78
  DataType: (ptr64 void)
  OrigDataType: uint64
T_101: (in qwLoc10 : word64)
  Class: Eq_78
  DataType: (ptr64 void)
  OrigDataType: word64
T_102: (in rdi : (ptr64 (arr real64)))
  Class: Eq_102
  DataType: (ptr64 (arr real64))
  OrigDataType: (ptr64 void)
T_103: (in free : ptr64)
  Class: Eq_103
  DataType: (ptr64 Eq_103)
  OrigDataType: (ptr64 (fn T_106 (T_102)))
T_104: (in signature of free : void)
  Class: Eq_103
  DataType: (ptr64 Eq_103)
  OrigDataType: 
T_105: (in p : (ptr64 void))
  Class: Eq_102
  DataType: (ptr64 (arr real64))
  OrigDataType: 
T_106: (in free(rdi) : void)
  Class: Eq_106
  DataType: void
  OrigDataType: void
T_107: (in rdi : word64)
  Class: Eq_107
  DataType: word64
  OrigDataType: word64
T_108: (in __align : ptr64)
  Class: Eq_9
  DataType: (ptr64 Eq_9)
  OrigDataType: (ptr64 (fn T_110 (T_109)))
T_109: (in fp : ptr64)
  Class: Eq_11
  DataType: ptr64
  OrigDataType: ptr64
T_110: (in __align(fp) : void)
  Class: Eq_15
  DataType: void
  OrigDataType: void
T_111: (in rax_31 : uint64)
  Class: Eq_111
  DataType: uint64
  OrigDataType: uint64
T_112: (in CONVERT(rdi, word64, uint128) : uint128)
  Class: Eq_112
  DataType: uint128
  OrigDataType: uint128
T_113: (in 0000000000000B00 : ptr64)
  Class: Eq_113
  DataType: (ptr64 uint64)
  OrigDataType: (ptr64 (struct (0 T_114 t0000)))
T_114: (in Mem23[0x0000000000000B00<p64>:word64] : word64)
  Class: Eq_114
  DataType: uint64
  OrigDataType: uint64
T_115: (in (uint128) rdi /u double_size.21529 : word64)
  Class: Eq_115
  DataType: uint64
  OrigDataType: uint64
T_116: (in CONVERT(CONVERT(rdi, word64, uint128) /u Mem23[0x0000000000000B00<p64>:word64], word64, uint64) : uint64)
  Class: Eq_111
  DataType: uint64
  OrigDataType: uint64
T_117: (in 0<64> : word64)
  Class: Eq_111
  DataType: uint64
  OrigDataType: up64
T_118: (in rax_31 > 0<64> : bool)
  Class: Eq_118
  DataType: bool
  OrigDataType: bool
T_119: (in xmm0 : Eq_119)
  Class: Eq_119
  DataType: Eq_119
  OrigDataType: uint128
T_120: (in rax_16 : (arr real64))
  Class: Eq_102
  DataType: (ptr64 (arr real64))
  OrigDataType: word64
T_121: (in _mm_malloc : ptr64)
  Class: Eq_121
  DataType: (ptr64 Eq_121)
  OrigDataType: (ptr64 (fn T_125 (T_123, T_124)))
T_122: (in signature of _mm_malloc : void)
  Class: Eq_121
  DataType: (ptr64 Eq_121)
  OrigDataType: 
T_123: (in 0x20<u64> : uint64)
  Class: Eq_79
  DataType: uint64
  OrigDataType: uint64
T_124: (in 0x2000<64> : word64)
  Class: Eq_80
  DataType: word64
  OrigDataType: word64
T_125: (in _mm_malloc(0x20<u64>, 0x2000<64>) : word64)
  Class: Eq_102
  DataType: (ptr64 (arr real64))
  OrigDataType: word64
T_126: (in rax_29 : (arr real64))
  Class: Eq_102
  DataType: (ptr64 (arr real64))
  OrigDataType: word64
T_127: (in _mm_malloc : ptr64)
  Class: Eq_121
  DataType: (ptr64 Eq_121)
  OrigDataType: (ptr64 (fn T_130 (T_128, T_129)))
T_128: (in 0x20<u64> : uint64)
  Class: Eq_79
  DataType: uint64
  OrigDataType: uint64
T_129: (in 0x2000<64> : word64)
  Class: Eq_80
  DataType: word64
  OrigDataType: word64
T_130: (in _mm_malloc(0x20<u64>, 0x2000<64>) : word64)
  Class: Eq_102
  DataType: (ptr64 (arr real64))
  OrigDataType: word64
T_131: (in rax_42 : (arr real64))
  Class: Eq_102
  DataType: (ptr64 (arr real64))
  OrigDataType: (ptr64 (struct (0 (arr T_270) a0000)))
T_132: (in _mm_malloc : ptr64)
  Class: Eq_121
  DataType: (ptr64 Eq_121)
  OrigDataType: (ptr64 (fn T_135 (T_133, T_134)))
T_133: (in 0x20<u64> : uint64)
  Class: Eq_79
  DataType: uint64
  OrigDataType: uint64
T_134: (in 0x2000<64> : word64)
  Class: Eq_80
  DataType: word64
  OrigDataType: word64
T_135: (in _mm_malloc(0x20<u64>, 0x2000<64>) : word64)
  Class: Eq_102
  DataType: (ptr64 (arr real64))
  OrigDataType: word64
T_136: (in qwLoc10_205 : Eq_136)
  Class: Eq_136
  DataType: Eq_136
  OrigDataType: word64
T_137: (in 0<64> : word64)
  Class: Eq_136
  DataType: int64
  OrigDataType: word64
T_138: (in 0x400<64> : word64)
  Class: Eq_136
  DataType: int64
  OrigDataType: up64
T_139: (in qwLoc10_205 < 0x400<64> : bool)
  Class: Eq_139
  DataType: bool
  OrigDataType: bool
T_140: (in rcx_58 : (ptr64 real64))
  Class: Eq_140
  DataType: (ptr64 real64)
  OrigDataType: (ptr64 (struct (0 T_168 t0000)))
T_141: (in 8<64> : word64)
  Class: Eq_141
  DataType: ui64
  OrigDataType: ui64
T_142: (in qwLoc10_205 * 8<64> : word64)
  Class: Eq_142
  DataType: ui64
  OrigDataType: ui64
T_143: (in qwLoc10_205 * 8<64> + rax_16 : word64)
  Class: Eq_140
  DataType: (ptr64 real64)
  OrigDataType: ui64
T_144: (in eax_65 : ui32)
  Class: Eq_144
  DataType: ui32
  OrigDataType: ui32
T_145: (in SLICE(qwLoc10_205, word32, 0) : word32)
  Class: Eq_144
  DataType: ui32
  OrigDataType: word32
T_146: (in 0<64> : word64)
  Class: Eq_136
  DataType: int64
  OrigDataType: int64
T_147: (in qwLoc10_205 < 0<64> : bool)
  Class: Eq_147
  DataType: bool
  OrigDataType: bool
T_148: (in qwLoc18_211 : Eq_148)
  Class: Eq_148
  DataType: Eq_148
  OrigDataType: word64
T_149: (in 0<64> : word64)
  Class: Eq_148
  DataType: int64
  OrigDataType: word64
T_150: (in 0x400<64> : word64)
  Class: Eq_148
  DataType: int64
  OrigDataType: up64
T_151: (in qwLoc18_211 < 0x400<64> : bool)
  Class: Eq_151
  DataType: bool
  OrigDataType: bool
T_152: (in v26_71 : real64)
  Class: Eq_152
  DataType: real64
  OrigDataType: real64
T_153: (in 1<64> : word64)
  Class: Eq_153
  DataType: word64
  OrigDataType: word64
T_154: (in qwLoc10_205 >> 1<64> : word64)
  Class: Eq_154
  DataType: uint64
  OrigDataType: uint64
T_155: (in 1<32> : word32)
  Class: Eq_155
  DataType: ui32
  OrigDataType: ui32
T_156: (in eax_65 & 1<32> : word32)
  Class: Eq_156
  DataType: ui32
  OrigDataType: ui32
T_157: (in CONVERT(eax_65 & 1<32>, word32, uint64) : uint64)
  Class: Eq_157
  DataType: uint64
  OrigDataType: uint64
T_158: (in qwLoc10_205 >> 1<64> | (uint64) (eax_65 & 1<32>) : word64)
  Class: Eq_158
  DataType: ui64
  OrigDataType: ui64
T_159: (in CONVERT(qwLoc10_205 >>u 1<64> | CONVERT(eax_65 & 1<32>, word32, uint64), word64, real64) : real64)
  Class: Eq_152
  DataType: real64
  OrigDataType: real64
T_160: (in v26_71 + v26_71 : real64)
  Class: Eq_160
  DataType: real64
  OrigDataType: real64
T_161: (in CONVERT(v26_71 + v26_71, real64, uint128) : uint128)
  Class: Eq_119
  DataType: Eq_119
  OrigDataType: uint128
T_162: (in SLICE(xmm0, word64, 64) : word64)
  Class: Eq_162
  DataType: word64
  OrigDataType: word64
T_163: (in CONVERT(qwLoc10_205, word64, real64) : real64)
  Class: Eq_163
  DataType: real64
  OrigDataType: real64
T_164: (in SEQ(SLICE(xmm0, word64, 64), CONVERT(qwLoc10_205, word64, real64)) : word128)
  Class: Eq_119
  DataType: Eq_119
  OrigDataType: word128
T_165: (in SLICE(xmm0, real64, 0) : real64)
  Class: Eq_165
  DataType: real64
  OrigDataType: real64
T_166: (in 0<64> : word64)
  Class: Eq_166
  DataType: word64
  OrigDataType: word64
T_167: (in rcx_58 + 0<64> : word64)
  Class: Eq_167
  DataType: ui64
  OrigDataType: ui64
T_168: (in Mem80[rcx_58 + 0<64>:real64] : real64)
  Class: Eq_165
  DataType: real64
  OrigDataType: real64
T_169: (in 1<64> : word64)
  Class: Eq_169
  DataType: int64
  OrigDataType: (union (int64 u1) (uint64 u0))
T_170: (in qwLoc10_205 + 1<64> : word64)
  Class: Eq_136
  DataType: Eq_136
  OrigDataType: (union (int64 u1) (uint64 u0))
T_171: (in eax_102 : ui32)
  Class: Eq_171
  DataType: ui32
  OrigDataType: ui32
T_172: (in 1<64> : word64)
  Class: Eq_172
  DataType: int64
  OrigDataType: (union (int64 u1) (uint64 u0))
T_173: (in qwLoc18_211 + 1<64> : word64)
  Class: Eq_173
  DataType: up64
  OrigDataType: up64
T_174: (in SLICE(qwLoc18_211 + 1<64>, word32, 0) : word32)
  Class: Eq_171
  DataType: ui32
  OrigDataType: word32
T_175: (in rcx_96 : (ptr64 real64))
  Class: Eq_175
  DataType: (ptr64 real64)
  OrigDataType: (ptr64 (struct (0 T_203 t0000)))
T_176: (in 8<64> : word64)
  Class: Eq_176
  DataType: ui64
  OrigDataType: ui64
T_177: (in qwLoc18_211 * 8<64> : word64)
  Class: Eq_177
  DataType: ui64
  OrigDataType: ui64
T_178: (in qwLoc18_211 * 8<64> + rax_29 : word64)
  Class: Eq_175
  DataType: (ptr64 real64)
  OrigDataType: ui64
T_179: (in 1<64> : word64)
  Class: Eq_148
  DataType: int64
  OrigDataType: int64
T_180: (in qwLoc18_211 < 1<64> : bool)
  Class: Eq_180
  DataType: bool
  OrigDataType: bool
T_181: (in qwLoc20_217 : uint64)
  Class: Eq_181
  DataType: uint64
  OrigDataType: uint64
T_182: (in 0<64> : word64)
  Class: Eq_181
  DataType: uint64
  OrigDataType: word64
T_183: (in 0x400<64> : word64)
  Class: Eq_181
  DataType: uint64
  OrigDataType: up64
T_184: (in qwLoc20_217 < 0x400<64> : bool)
  Class: Eq_184
  DataType: bool
  OrigDataType: bool
T_185: (in v19_108 : real64)
  Class: Eq_185
  DataType: real64
  OrigDataType: real64
T_186: (in qwLoc18_211 + 1<64> : word64)
  Class: Eq_186
  DataType: Eq_186
  OrigDataType: (union (int64 u1) (uint64 u0))
T_187: (in 1<64> : word64)
  Class: Eq_187
  DataType: word64
  OrigDataType: word64
T_188: (in (word64) qwLoc18_211 + 1<i32> >> 1<64> : word64)
  Class: Eq_188
  DataType: uint64
  OrigDataType: uint64
T_189: (in 1<32> : word32)
  Class: Eq_189
  DataType: ui32
  OrigDataType: ui32
T_190: (in eax_102 & 1<32> : word32)
  Class: Eq_190
  DataType: ui32
  OrigDataType: ui32
T_191: (in CONVERT(eax_102 & 1<32>, word32, uint64) : uint64)
  Class: Eq_191
  DataType: uint64
  OrigDataType: uint64
T_192: (in (word64) qwLoc18_211 + 1<i32> >> 1<64> | (uint64) (eax_102 & 1<32>) : word64)
  Class: Eq_192
  DataType: ui64
  OrigDataType: ui64
T_193: (in CONVERT(qwLoc18_211 + 1<64> >>u 1<64> | CONVERT(eax_102 & 1<32>, word32, uint64), word64, real64) : real64)
  Class: Eq_185
  DataType: real64
  OrigDataType: real64
T_194: (in v19_108 + v19_108 : real64)
  Class: Eq_194
  DataType: real64
  OrigDataType: real64
T_195: (in CONVERT(v19_108 + v19_108, real64, uint128) : uint128)
  Class: Eq_119
  DataType: Eq_119
  OrigDataType: uint128
T_196: (in SLICE(xmm0, word64, 64) : word64)
  Class: Eq_196
  DataType: word64
  OrigDataType: word64
T_197: (in qwLoc18_211 + 1<64> : word64)
  Class: Eq_197
  DataType: Eq_197
  OrigDataType: (union (int64 u1) (uint64 u0))
T_198: (in CONVERT(qwLoc18_211 + 1<64>, word64, real64) : real64)
  Class: Eq_198
  DataType: real64
  OrigDataType: real64
T_199: (in SEQ(SLICE(xmm0, word64, 64), CONVERT(qwLoc18_211 + 1<64>, word64, real64)) : word128)
  Class: Eq_119
  DataType: Eq_119
  OrigDataType: word128
T_200: (in SLICE(xmm0, real64, 0) : real64)
  Class: Eq_200
  DataType: real64
  OrigDataType: real64
T_201: (in 0<64> : word64)
  Class: Eq_201
  DataType: word64
  OrigDataType: word64
T_202: (in rcx_96 + 0<64> : word64)
  Class: Eq_202
  DataType: ui64
  OrigDataType: ui64
T_203: (in Mem117[rcx_96 + 0<64>:real64] : real64)
  Class: Eq_200
  DataType: real64
  OrigDataType: real64
T_204: (in 1<64> : word64)
  Class: Eq_204
  DataType: int64
  OrigDataType: (union (int64 u1) (uint64 u0))
T_205: (in qwLoc18_211 + 1<64> : word64)
  Class: Eq_148
  DataType: Eq_148
  OrigDataType: (union (int64 u1) (uint64 u0))
T_206: (in __xorpd : ptr64)
  Class: Eq_206
  DataType: (ptr64 Eq_206)
  OrigDataType: (ptr64 (fn T_210 (T_119, T_119)))
T_207: (in signature of __xorpd : void)
  Class: Eq_206
  DataType: (ptr64 Eq_206)
  OrigDataType: 
T_208: (in  : (arr word64 2))
  Class: Eq_119
  DataType: Eq_119
  OrigDataType: 
T_209: (in  : (arr word64 2))
  Class: Eq_119
  DataType: Eq_119
  OrigDataType: 
T_210: (in __xorpd(xmm0, xmm0) : (arr word64 2))
  Class: Eq_119
  DataType: Eq_119
  OrigDataType: (arr word64 2)
T_211: (in SLICE(xmm0, real64, 0) : real64)
  Class: Eq_211
  DataType: real64
  OrigDataType: real64
T_212: (in 8<64> : word64)
  Class: Eq_212
  DataType: ui64
  OrigDataType: ui64
T_213: (in qwLoc20_217 * 8<64> : word64)
  Class: Eq_213
  DataType: ui64
  OrigDataType: ui64
T_214: (in rax_42[qwLoc20_217 * 8<64>] : real64)
  Class: Eq_211
  DataType: real64
  OrigDataType: real64
T_215: (in 1<64> : word64)
  Class: Eq_215
  DataType: word64
  OrigDataType: word64
T_216: (in qwLoc20_217 + 1<64> : word64)
  Class: Eq_181
  DataType: uint64
  OrigDataType: uint64
T_217: (in vec_add : ptr64)
  Class: Eq_217
  DataType: (ptr64 Eq_217)
  OrigDataType: (ptr64 (fn T_220 (T_219)))
T_218: (in signature of vec_add : void)
  Class: Eq_217
  DataType: (ptr64 Eq_217)
  OrigDataType: 
T_219: (in 0x400<64> : word64)
  Class: Eq_107
  DataType: word64
  OrigDataType: word64
T_220: (in vec_add(0x400<64>) : void)
  Class: Eq_220
  DataType: void
  OrigDataType: void
T_221: (in qwLoc28_226 : up64)
  Class: Eq_221
  DataType: up64
  OrigDataType: up64
T_222: (in 0<64> : word64)
  Class: Eq_221
  DataType: up64
  OrigDataType: word64
T_223: (in 0x400<64> : word64)
  Class: Eq_221
  DataType: up64
  OrigDataType: up64
T_224: (in qwLoc28_226 < 0x400<64> : bool)
  Class: Eq_224
  DataType: bool
  OrigDataType: bool
T_225: (in printf : ptr64)
  Class: Eq_225
  DataType: (ptr64 Eq_225)
  OrigDataType: (ptr64 (fn T_230 (T_228, T_229)))
T_226: (in signature of printf : void)
  Class: Eq_225
  DataType: (ptr64 Eq_225)
  OrigDataType: 
T_227: (in format : (ptr64 char))
  Class: Eq_227
  DataType: (ptr64 char)
  OrigDataType: 
T_228: (in 0000000000000AF8 : ptr64)
  Class: Eq_227
  DataType: (ptr64 char)
  OrigDataType: (ptr64 char)
T_229: (in 0<32> : word32)
  Class: Eq_229
  DataType: word32
  OrigDataType: word32
T_230: (in printf("%g\n", 0<32>) : int32)
  Class: Eq_230
  DataType: int32
  OrigDataType: int32
T_231: (in 1<64> : word64)
  Class: Eq_231
  DataType: up64
  OrigDataType: up64
T_232: (in qwLoc28_226 + 1<64> : word64)
  Class: Eq_221
  DataType: up64
  OrigDataType: up64
T_233: (in _mm_free : ptr64)
  Class: Eq_233
  DataType: (ptr64 Eq_233)
  OrigDataType: (ptr64 (fn T_235 (T_120)))
T_234: (in signature of _mm_free : void)
  Class: Eq_233
  DataType: (ptr64 Eq_233)
  OrigDataType: 
T_235: (in _mm_free(rax_16) : void)
  Class: Eq_235
  DataType: void
  OrigDataType: void
T_236: (in _mm_free : ptr64)
  Class: Eq_233
  DataType: (ptr64 Eq_233)
  OrigDataType: (ptr64 (fn T_237 (T_126)))
T_237: (in _mm_free(rax_29) : void)
  Class: Eq_235
  DataType: void
  OrigDataType: void
T_238: (in _mm_free : ptr64)
  Class: Eq_233
  DataType: (ptr64 Eq_233)
  OrigDataType: (ptr64 (fn T_239 (T_131)))
T_239: (in _mm_free(rax_42) : void)
  Class: Eq_235
  DataType: void
  OrigDataType: void
T_240: (in rdx : word64)
  Class: Eq_240
  DataType: word64
  OrigDataType: word64
T_241: (in rsi : word64)
  Class: Eq_241
  DataType: word64
  OrigDataType: word64
T_242: (in edi : word32)
  Class: Eq_242
  DataType: word32
  OrigDataType: word32
T_243: (in rdi : word64)
  Class: Eq_243
  DataType: word64
  OrigDataType: word64
T_244: (in SLICE(rdi, word32, 0) : word32)
  Class: Eq_242
  DataType: word32
  OrigDataType: word32
T_245: (in _init : ptr64)
  Class: Eq_245
  DataType: (ptr64 Eq_245)
  OrigDataType: (ptr64 (fn T_247 ()))
T_246: (in signature of _init : void)
  Class: Eq_245
  DataType: (ptr64 Eq_245)
  OrigDataType: 
T_247: (in _init() : void)
  Class: Eq_247
  DataType: void
  OrigDataType: void
T_248: (in r15d_87 : word32)
  Class: Eq_248
  DataType: word32
  OrigDataType: word32
T_249: (in CONVERT(edi, word32, uint64) : uint64)
  Class: Eq_249
  DataType: uint64
  OrigDataType: uint64
T_250: (in SLICE(CONVERT(edi, word32, uint64), word32, 0) : word32)
  Class: Eq_248
  DataType: word32
  OrigDataType: word32
T_251: (in rbp_31 : int64)
  Class: Eq_251
  DataType: int64
  OrigDataType: int64
T_252: (in 0000000000200DF0 : ptr64)
  Class: Eq_252
  DataType: int64
  OrigDataType: (union (int64 u0) (ptr64 u1))
T_253: (in 0000000000200DE8 : ptr64)
  Class: Eq_253
  DataType: int64
  OrigDataType: (union (int64 u1) (ptr64 u0))
T_254: (in 0x200DF0<u64> - 0x200DE8<u64> : word64)
  Class: Eq_251
  DataType: int64
  OrigDataType: int64
T_255: (in 3<64> : word64)
  Class: Eq_255
  DataType: word64
  OrigDataType: word64
T_256: (in rbp_31 >> 3<64> : word64)
  Class: Eq_256
  DataType: int64
  OrigDataType: int64
T_257: (in 0<64> : word64)
  Class: Eq_256
  DataType: int64
  OrigDataType: word64
T_258: (in rbp_31 >> 3<64> == 0<64> : bool)
  Class: Eq_258
  DataType: bool
  OrigDataType: bool
T_259: (in rbx_44 : Eq_259)
  Class: Eq_259
  DataType: Eq_259
  OrigDataType: word64
T_260: (in 0<u64> : uint64)
  Class: Eq_259
  DataType: uint64
  OrigDataType: uint64
T_261: (in 0000000000200DE8 : ptr64)
  Class: Eq_261
  DataType: (ptr64 (arr (ptr64 code)))
  OrigDataType: (ptr64 (struct (0 (arr T_271) a0000)))
T_262: (in 8<64> : word64)
  Class: Eq_262
  DataType: ui64
  OrigDataType: ui64
T_263: (in rbx_44 * 8<64> : word64)
  Class: Eq_263
  DataType: ui64
  OrigDataType: ui64
T_264: (in 0x0000000000200DE8<p64>[rbx_44 * 8<64>] : word64)
  Class: Eq_264
  DataType: (ptr64 code)
  OrigDataType: (ptr64 code)
T_265: (in 1<64> : word64)
  Class: Eq_265
  DataType: word64
  OrigDataType: word64
T_266: (in rbx_44 + 1<64> : word64)
  Class: Eq_259
  DataType: Eq_259
  OrigDataType: uint64
T_267: (in rbp_31 >> 3<64> : word64)
  Class: Eq_259
  DataType: Eq_259
  OrigDataType: int64
T_268: (in rbp_31 >> 3<64> != rbx_44 : bool)
  Class: Eq_268
  DataType: bool
  OrigDataType: bool
T_269:
  Class: Eq_114
  DataType: uint64
  OrigDataType: word64
T_270:
  Class: Eq_270
  DataType: real64
  OrigDataType: (struct 0008 (0 T_214 t0000))
T_271:
  Class: Eq_271
  DataType: (ptr64 code)
  OrigDataType: (struct 0008 (0 T_264 t0000))
*/
typedef Eq_1Eq_1Eq_1struct Globals {
	<anonymous> t05D6;	// 5D6
	<anonymous> t05E6;	// 5E6
	<anonymous> t05F6;	// 5F6
	<anonymous> t0606;	// 606
	int32 t0898(int32 rdi, char ** rsi, char ** rdx);	// 898
	void t0A70();	// A70
	void t0AE0();	// AE0
	uint64 double_size.21529;	// B00
	<anonymous> * a200DE8[];	// 200DE8
	<anonymous> * _ITM_deregisterTMCloneTable_GOT;	// 200FD8
	<anonymous> * __libc_start_main_GOT;	// 200FE0
	<anonymous> * __gmon_start___GOT;	// 200FE8
	<anonymous> * _ITM_registerTMCloneTable_GOT;	// 200FF0
	<anonymous> * __cxa_finalize_GOT;	// 200FF8
	<anonymous> * free_GOT;	// 201018
	<anonymous> * printf_GOT;	// 201020
	<anonymous> * malloc_GOT;	// 201028
	<anonymous> * posix_memalign_GOT;	// 201030
	byte b201048;	// 201048
} Eq_1;

typedef void (Eq_7)();

typedef union Eq_8 {
	int32 u0;
	word64 u1;
} Eq_8;

typedef void (Eq_9)(ptr64);

typedef int32 (Eq_16)( *, Eq_8, char * *,  *,  *,  *, void);

typedef int32 (Eq_18)(int32 rdi, char * * rsi, char * * rdx);

typedef void (Eq_21)();

typedef void (Eq_22)();

typedef void (Eq_30)();

typedef union Eq_41 {
	int64 u0;
	ptr64 u1;
} Eq_41;

typedef union Eq_42 {
	int64 u0;
	ptr64 u1;
} Eq_42;

typedef union Eq_45 {
	int64 u0;
	uint64 u1;
} Eq_45;

typedef union Eq_46 {
	int64 u0;
	uint64 u1;
} Eq_46;

typedef union Eq_48 {
	int64 u0;
	uint64 u1;
} Eq_48;

typedef union Eq_49 {
	int64 u0;
	uint64 u1;
} Eq_49;

typedef void (Eq_66)();

typedef void (Eq_75)();

typedef union Eq_80 {
	word64 u0;
	size_t u1;
} Eq_80;

typedef void (Eq_103)(real64 *[]);

typedef union Eq_119 {
	uint128 u0;
	word64 u1[2];
} Eq_119;

typedef real64 *[] (Eq_121)(uint64, Eq_80);

typedef union Eq_136 {
	int64 u0;
	uint64 u1;
} Eq_136;

typedef union Eq_148 {
	int64 u0;
	uint64 u1;
} Eq_148;

typedef union Eq_169 {
	int64 u0;
	uint64 u1;
} Eq_169;

typedef union Eq_172 {
	int64 u0;
	uint64 u1;
} Eq_172;

typedef union Eq_186 {
	int64 u0;
	uint64 u1;
} Eq_186;

typedef union Eq_197 {
	int64 u0;
	uint64 u1;
} Eq_197;

typedef union Eq_204 {
	int64 u0;
	uint64 u1;
} Eq_204;

typedef Eq_119 (Eq_206)(Eq_119, Eq_119);

typedef void (Eq_217)(word64);

typedef int32 (Eq_225)(char *, word32);

typedef void (Eq_233)(real64 *[]);

typedef void (Eq_245)();

typedef union Eq_252 {
	int64 u0;
	ptr64 u1;
} Eq_252;

typedef union Eq_253 {
	int64 u0;
	ptr64 u1;
} Eq_253;

typedef union Eq_259 {
	int64 u0;
	uint64 u1;
} Eq_259;

