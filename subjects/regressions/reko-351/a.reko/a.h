// a.h
// Generated by decompiling a.out
// using Reko decompiler version 0.9.4.0.

/*
// Equivalence classes ////////////
Eq_1: (struct "Globals" (8000270C (ptr32 code) ptr8000270C) (80002714 (arr (ptr32 code)) a80002714) (8000271C word32 dw8000271C) (80002724 byte b80002724) (80002726 uint32 dtor_idx.3228) (FFFFFFFF code tFFFFFFFF))
	globals_t (in globals : (ptr32 (struct "Globals")))
Eq_48: (fn word32 ())
	T_48 (in deregister_tm_clones : ptr32)
	T_49 (in signature of deregister_tm_clones : void)
Eq_51: (struct "Eq_51" (FFFFFFFC ptr32 ptrFFFFFFFC))
	T_51 (in a7_53 : (ptr32 Eq_51))
	T_52 (in <invalid> : void)
Eq_86: (struct "Eq_86" (FFFFFFFC ptr32 ptrFFFFFFFC))
	T_86 (in a7_23 : (ptr32 Eq_86))
	T_87 (in fp - 4<32> : word32)
	T_99 (in a7_17 + 8<i32> : word32)
Eq_109: (fn void ())
	T_109 (in register_tm_clones : ptr32)
	T_110 (in signature of register_tm_clones : void)
	T_112 (in register_tm_clones : ptr32)
Eq_138: (fn void (real64, int32))
	T_138 (in pow_int : ptr32)
	T_139 (in signature of pow_int : void)
	T_149 (in pow_int : ptr32)
Eq_141: (fn void (int32))
	T_141 (in factorial : ptr32)
	T_142 (in signature of factorial : void)
	T_151 (in factorial : ptr32)
Eq_158: (fn void (real64))
	T_158 (in sine_taylor : ptr32)
	T_159 (in signature of sine_taylor : void)
Eq_162: (fn void (real64, real64, Eq_166))
	T_162 (in _sin : ptr32)
	T_163 (in signature of _sin : void)
Eq_166: (union "Eq_166" ((ptr32 word32) u0) ((ref int32) u1))
	T_166 (in tArg14 : Eq_166)
	T_171 (in fp - 8<32> : word32)
Eq_183: (ref int32)
	T_183 (in tArg14 + 0<32> : word32)
Eq_188: (union "Eq_188" ((ptr32 word32) u0) ((ref int32) u1))
	T_188 (in tArg14 + 0<32> : word32)
Eq_241: (struct "Eq_241" (FFFFFFFC (ptr32 code) ptrFFFFFFFC))
	T_241 (in a2_23 : (ptr32 Eq_241))
// Type Variables ////////////
globals_t: (in globals : (ptr32 (struct "Globals")))
  Class: Eq_1
  DataType: (ptr32 Eq_1)
  OrigDataType: (ptr32 (struct "Globals"))
T_2: (in a6 : word32)
  Class: Eq_2
  DataType: word32
  OrigDataType: word32
T_3: (in a6_23 : (ptr32 word32))
  Class: Eq_3
  DataType: (ptr32 word32)
  OrigDataType: (ptr32 (struct (0 T_10 t0000)))
T_4: (in fp : ptr32)
  Class: Eq_4
  DataType: ptr32
  OrigDataType: ptr32
T_5: (in 4<32> : word32)
  Class: Eq_5
  DataType: ui32
  OrigDataType: ui32
T_6: (in fp - 4<32> : word32)
  Class: Eq_3
  DataType: (ptr32 word32)
  OrigDataType: ptr32
T_7: (in true : bool)
  Class: Eq_7
  DataType: bool
  OrigDataType: bool
T_8: (in 0<32> : word32)
  Class: Eq_8
  DataType: word32
  OrigDataType: word32
T_9: (in a6_23 + 0<32> : word32)
  Class: Eq_9
  DataType: ptr32
  OrigDataType: ptr32
T_10: (in Mem31[a6_23 + 0<32>:word32] : word32)
  Class: Eq_2
  DataType: word32
  OrigDataType: word32
T_11: (in 00000000 : ptr32)
  Class: Eq_11
  DataType: ptr32
  OrigDataType: ptr32
T_12: (in 0<32> : word32)
  Class: Eq_11
  DataType: ptr32
  OrigDataType: word32
T_13: (in 0<u32> == 0<32> : bool)
  Class: Eq_13
  DataType: bool
  OrigDataType: bool
T_14: (in a0_26 : word32)
  Class: Eq_14
  DataType: word32
  OrigDataType: word32
T_15: (in 00000000 : ptr32)
  Class: Eq_15
  DataType: (ptr32 code)
  OrigDataType: (ptr32 code)
T_16: (in d0_12 : int32)
  Class: Eq_16
  DataType: int32
  OrigDataType: int32
T_17: (in 0<32> : word32)
  Class: Eq_16
  DataType: int32
  OrigDataType: word32
T_18: (in false : bool)
  Class: Eq_18
  DataType: bool
  OrigDataType: bool
T_19: (in 1<32> : word32)
  Class: Eq_16
  DataType: int32
  OrigDataType: word32
T_20: (in d0_18 : int32)
  Class: Eq_20
  DataType: int32
  OrigDataType: int32
T_21: (in 1<32> : word32)
  Class: Eq_21
  DataType: word32
  OrigDataType: word32
T_22: (in d0_12 >> 1<32> : word32)
  Class: Eq_20
  DataType: int32
  OrigDataType: int32
T_23: (in 0<32> : word32)
  Class: Eq_20
  DataType: int32
  OrigDataType: word32
T_24: (in d0_18 == 0<32> : bool)
  Class: Eq_24
  DataType: bool
  OrigDataType: bool
T_25: (in 00000000 : ptr32)
  Class: Eq_25
  DataType: ptr32
  OrigDataType: ptr32
T_26: (in 0<32> : word32)
  Class: Eq_25
  DataType: ptr32
  OrigDataType: word32
T_27: (in 0<u32> == 0<32> : bool)
  Class: Eq_27
  DataType: bool
  OrigDataType: bool
T_28: (in a0_36 : word32)
  Class: Eq_28
  DataType: word32
  OrigDataType: word32
T_29: (in 00000000 : ptr32)
  Class: Eq_29
  DataType: (ptr32 code)
  OrigDataType: (ptr32 code)
T_30: (in a6_35 : ptr32)
  Class: Eq_30
  DataType: ptr32
  OrigDataType: ptr32
T_31: (in fp : ptr32)
  Class: Eq_31
  DataType: ptr32
  OrigDataType: ptr32
T_32: (in 4<32> : word32)
  Class: Eq_32
  DataType: ui32
  OrigDataType: ui32
T_33: (in fp - 4<32> : word32)
  Class: Eq_30
  DataType: ptr32
  OrigDataType: ptr32
T_34: (in 80002724 : ptr32)
  Class: Eq_34
  DataType: (ptr32 byte)
  OrigDataType: (ptr32 (struct (0 T_35 t0000)))
T_35: (in Mem13[0x80002724<p32>:byte] : byte)
  Class: Eq_35
  DataType: byte
  OrigDataType: byte
T_36: (in 0<8> : byte)
  Class: Eq_35
  DataType: byte
  OrigDataType: byte
T_37: (in g_b80002724 != 0<8> : bool)
  Class: Eq_37
  DataType: bool
  OrigDataType: bool
T_38: (in d0_19 : uint32)
  Class: Eq_38
  DataType: uint32
  OrigDataType: up32
T_39: (in 80002726 : ptr32)
  Class: Eq_39
  DataType: (ptr32 uint32)
  OrigDataType: (ptr32 (struct (0 T_40 t0000)))
T_40: (in Mem13[0x80002726<p32>:word32] : word32)
  Class: Eq_38
  DataType: uint32
  OrigDataType: word32
T_41: (in a2_18 : (arr (ptr32 code)))
  Class: Eq_41
  DataType: (ptr32 (arr (ptr32 code)))
  OrigDataType: (ptr32 (struct (0 (arr T_250) a0000)))
T_42: (in 80002714 : ptr32)
  Class: Eq_41
  DataType: (ptr32 (arr (ptr32 code)))
  OrigDataType: ptr32
T_43: (in d2_23 : up32)
  Class: Eq_43
  DataType: up32
  OrigDataType: up32
T_44: (in 0<32> : word32)
  Class: Eq_43
  DataType: up32
  OrigDataType: word32
T_45: (in 0<32> : word32)
  Class: Eq_38
  DataType: uint32
  OrigDataType: up32
T_46: (in d0_19 >= 0<32> : bool)
  Class: Eq_46
  DataType: bool
  OrigDataType: bool
T_47: (in a6_52 : word32)
  Class: Eq_47
  DataType: word32
  OrigDataType: word32
T_48: (in deregister_tm_clones : ptr32)
  Class: Eq_48
  DataType: (ptr32 Eq_48)
  OrigDataType: (ptr32 (fn T_50 ()))
T_49: (in signature of deregister_tm_clones : void)
  Class: Eq_48
  DataType: (ptr32 Eq_48)
  OrigDataType: 
T_50: (in deregister_tm_clones() : word32)
  Class: Eq_47
  DataType: word32
  OrigDataType: word32
T_51: (in a7_53 : (ptr32 Eq_51))
  Class: Eq_51
  DataType: (ptr32 Eq_51)
  OrigDataType: (ptr32 (struct (FFFFFFFC T_77 tFFFFFFFC)))
T_52: (in <invalid> : void)
  Class: Eq_51
  DataType: (ptr32 Eq_51)
  OrigDataType: void
T_53: (in 00000000 : ptr32)
  Class: Eq_53
  DataType: ptr32
  OrigDataType: ptr32
T_54: (in 0<32> : word32)
  Class: Eq_53
  DataType: ptr32
  OrigDataType: word32
T_55: (in 0<u32> == 0<32> : bool)
  Class: Eq_55
  DataType: bool
  OrigDataType: bool
T_56: (in d0_29 : uint32)
  Class: Eq_38
  DataType: uint32
  OrigDataType: uint32
T_57: (in 1<32> : word32)
  Class: Eq_57
  DataType: up32
  OrigDataType: up32
T_58: (in d0_19 + 1<32> : word32)
  Class: Eq_38
  DataType: uint32
  OrigDataType: up32
T_59: (in 80002726 : ptr32)
  Class: Eq_59
  DataType: (ptr32 uint32)
  OrigDataType: (ptr32 (struct (0 T_60 t0000)))
T_60: (in Mem31[0x80002726<p32>:word32] : word32)
  Class: Eq_38
  DataType: uint32
  OrigDataType: word32
T_61: (in a0_43 : word32)
  Class: Eq_61
  DataType: word32
  OrigDataType: word32
T_62: (in d1_91 : word32)
  Class: Eq_62
  DataType: word32
  OrigDataType: word32
T_63: (in 4<i32> : int32)
  Class: Eq_63
  DataType: int32
  OrigDataType: int32
T_64: (in d0_29 * 4<i32> : word32)
  Class: Eq_64
  DataType: ui32
  OrigDataType: ui32
T_65: (in a2_18[d0_29 * 4<i32>] : word32)
  Class: Eq_65
  DataType: (ptr32 code)
  OrigDataType: (ptr32 code)
T_66: (in 80002726 : ptr32)
  Class: Eq_66
  DataType: (ptr32 uint32)
  OrigDataType: (ptr32 (struct (0 T_67 t0000)))
T_67: (in Mem31[0x80002726<p32>:word32] : word32)
  Class: Eq_38
  DataType: uint32
  OrigDataType: word32
T_68: (in d2_23 - d0_19 : word32)
  Class: Eq_68
  DataType: up32
  OrigDataType: up32
T_69: (in 0<32> : word32)
  Class: Eq_68
  DataType: up32
  OrigDataType: up32
T_70: (in d2_23 - d0_19 > 0<32> : bool)
  Class: Eq_70
  DataType: bool
  OrigDataType: bool
T_71: (in 1<8> : byte)
  Class: Eq_35
  DataType: byte
  OrigDataType: byte
T_72: (in 80002724 : ptr32)
  Class: Eq_72
  DataType: (ptr32 byte)
  OrigDataType: (ptr32 (struct (0 T_73 t0000)))
T_73: (in Mem77[0x80002724<p32>:byte] : byte)
  Class: Eq_35
  DataType: byte
  OrigDataType: byte
T_74: (in 8000065C : ptr32)
  Class: Eq_74
  DataType: ptr32
  OrigDataType: ptr32
T_75: (in -4<i32> : int32)
  Class: Eq_75
  DataType: int32
  OrigDataType: int32
T_76: (in a7_53 + -4<i32> : word32)
  Class: Eq_76
  DataType: word32
  OrigDataType: word32
T_77: (in Mem65[a7_53 + -4<i32>:word32] : word32)
  Class: Eq_74
  DataType: ptr32
  OrigDataType: word32
T_78: (in d0_72 : word32)
  Class: Eq_78
  DataType: word32
  OrigDataType: word32
T_79: (in a0_73 : word32)
  Class: Eq_79
  DataType: word32
  OrigDataType: word32
T_80: (in d1_74 : word32)
  Class: Eq_80
  DataType: word32
  OrigDataType: word32
T_81: (in 00000000 : ptr32)
  Class: Eq_81
  DataType: (ptr32 code)
  OrigDataType: (ptr32 code)
T_82: (in a6_18 : ptr32)
  Class: Eq_82
  DataType: ptr32
  OrigDataType: ptr32
T_83: (in fp : ptr32)
  Class: Eq_83
  DataType: ptr32
  OrigDataType: ptr32
T_84: (in 4<32> : word32)
  Class: Eq_84
  DataType: ui32
  OrigDataType: ui32
T_85: (in fp - 4<32> : word32)
  Class: Eq_82
  DataType: ptr32
  OrigDataType: ptr32
T_86: (in a7_23 : (ptr32 Eq_86))
  Class: Eq_86
  DataType: (ptr32 Eq_86)
  OrigDataType: (ptr32 (struct (FFFFFFFC T_106 tFFFFFFFC)))
T_87: (in fp - 4<32> : word32)
  Class: Eq_86
  DataType: (ptr32 Eq_86)
  OrigDataType: ptr32
T_88: (in 00000000 : ptr32)
  Class: Eq_88
  DataType: ptr32
  OrigDataType: ptr32
T_89: (in 0<32> : word32)
  Class: Eq_88
  DataType: ptr32
  OrigDataType: word32
T_90: (in 0<u32> == 0<32> : bool)
  Class: Eq_90
  DataType: bool
  OrigDataType: bool
T_91: (in 8000271C : ptr32)
  Class: Eq_91
  DataType: (ptr32 word32)
  OrigDataType: (ptr32 (struct (0 T_92 t0000)))
T_92: (in Mem25[0x8000271C<p32>:word32] : word32)
  Class: Eq_92
  DataType: word32
  OrigDataType: word32
T_93: (in 0<32> : word32)
  Class: Eq_92
  DataType: word32
  OrigDataType: word32
T_94: (in g_dw8000271C != 0<32> : bool)
  Class: Eq_94
  DataType: bool
  OrigDataType: bool
T_95: (in a7_17 : word32)
  Class: Eq_95
  DataType: word32
  OrigDataType: word32
T_96: (in a1_20 : word32)
  Class: Eq_96
  DataType: word32
  OrigDataType: word32
T_97: (in 00000000 : ptr32)
  Class: Eq_97
  DataType: (ptr32 code)
  OrigDataType: (ptr32 code)
T_98: (in 8<i32> : int32)
  Class: Eq_98
  DataType: int32
  OrigDataType: int32
T_99: (in a7_17 + 8<i32> : word32)
  Class: Eq_86
  DataType: (ptr32 Eq_86)
  OrigDataType: word32
T_100: (in 00000000 : ptr32)
  Class: Eq_100
  DataType: ptr32
  OrigDataType: ptr32
T_101: (in 0<32> : word32)
  Class: Eq_100
  DataType: ptr32
  OrigDataType: word32
T_102: (in 0<u32> == 0<32> : bool)
  Class: Eq_102
  DataType: bool
  OrigDataType: bool
T_103: (in 8000271C : ptr32)
  Class: Eq_103
  DataType: ptr32
  OrigDataType: ptr32
T_104: (in -4<i32> : int32)
  Class: Eq_104
  DataType: int32
  OrigDataType: int32
T_105: (in a7_23 + -4<i32> : word32)
  Class: Eq_105
  DataType: ptr32
  OrigDataType: ptr32
T_106: (in Mem37[a7_23 + -4<i32>:word32] : word32)
  Class: Eq_103
  DataType: ptr32
  OrigDataType: word32
T_107: (in a1_43 : word32)
  Class: Eq_107
  DataType: word32
  OrigDataType: word32
T_108: (in 00000000 : ptr32)
  Class: Eq_108
  DataType: (ptr32 code)
  OrigDataType: (ptr32 code)
T_109: (in register_tm_clones : ptr32)
  Class: Eq_109
  DataType: (ptr32 Eq_109)
  OrigDataType: (ptr32 (fn T_111 ()))
T_110: (in signature of register_tm_clones : void)
  Class: Eq_109
  DataType: (ptr32 Eq_109)
  OrigDataType: 
T_111: (in register_tm_clones() : void)
  Class: Eq_111
  DataType: void
  OrigDataType: void
T_112: (in register_tm_clones : ptr32)
  Class: Eq_109
  DataType: (ptr32 Eq_109)
  OrigDataType: (ptr32 (fn T_113 ()))
T_113: (in register_tm_clones() : void)
  Class: Eq_111
  DataType: void
  OrigDataType: void
T_114: (in rArg04 : real64)
  Class: Eq_114
  DataType: real64
  OrigDataType: real64
T_115: (in dwArg04 : int32)
  Class: Eq_115
  DataType: int32
  OrigDataType: int32
T_116: (in dwLoc08_32 : int32)
  Class: Eq_116
  DataType: int32
  OrigDataType: int32
T_117: (in 2<i32> : int32)
  Class: Eq_116
  DataType: int32
  OrigDataType: int32
T_118: (in 1<32> : word32)
  Class: Eq_118
  DataType: word32
  OrigDataType: word32
T_119: (in dwLoc08_32 + 1<32> : word32)
  Class: Eq_116
  DataType: int32
  OrigDataType: int32
T_120: (in dwLoc08_32 - dwArg04 : word32)
  Class: Eq_120
  DataType: int32
  OrigDataType: int32
T_121: (in 0<32> : word32)
  Class: Eq_120
  DataType: int32
  OrigDataType: int32
T_122: (in dwLoc08_32 - dwArg04 > 0<32> : bool)
  Class: Eq_122
  DataType: bool
  OrigDataType: bool
T_123: (in rArg04 : real64)
  Class: Eq_123
  DataType: real64
  OrigDataType: real64
T_124: (in dwArg0C : int32)
  Class: Eq_115
  DataType: int32
  OrigDataType: int32
T_125: (in dwLoc08_46 : int32)
  Class: Eq_125
  DataType: int32
  OrigDataType: int32
T_126: (in 0<32> : word32)
  Class: Eq_125
  DataType: int32
  OrigDataType: word32
T_127: (in 1<32> : word32)
  Class: Eq_127
  DataType: word32
  OrigDataType: word32
T_128: (in dwLoc08_46 + 1<32> : word32)
  Class: Eq_125
  DataType: int32
  OrigDataType: word32
T_129: (in dwLoc08_46 - dwArg0C : word32)
  Class: Eq_129
  DataType: int32
  OrigDataType: int32
T_130: (in 0<32> : word32)
  Class: Eq_129
  DataType: int32
  OrigDataType: int32
T_131: (in dwLoc08_46 - dwArg0C >= 0<32> : bool)
  Class: Eq_131
  DataType: bool
  OrigDataType: bool
T_132: (in rArg04 : real64)
  Class: Eq_123
  DataType: real64
  OrigDataType: real64
T_133: (in dwArg0C : int32)
  Class: Eq_133
  DataType: int32
  OrigDataType: int32
T_134: (in dwLoc08_115 : int32)
  Class: Eq_115
  DataType: int32
  OrigDataType: int32
T_135: (in 3<i32> : int32)
  Class: Eq_115
  DataType: int32
  OrigDataType: int32
T_136: (in dwLoc08_118 : int32)
  Class: Eq_115
  DataType: int32
  OrigDataType: int32
T_137: (in 5<i32> : int32)
  Class: Eq_115
  DataType: int32
  OrigDataType: int32
T_138: (in pow_int : ptr32)
  Class: Eq_138
  DataType: (ptr32 Eq_138)
  OrigDataType: (ptr32 (fn T_140 (T_132, T_134)))
T_139: (in signature of pow_int : void)
  Class: Eq_138
  DataType: (ptr32 Eq_138)
  OrigDataType: 
T_140: (in pow_int(rArg04, dwLoc08_115) : void)
  Class: Eq_140
  DataType: void
  OrigDataType: void
T_141: (in factorial : ptr32)
  Class: Eq_141
  DataType: (ptr32 Eq_141)
  OrigDataType: (ptr32 (fn T_143 (T_134)))
T_142: (in signature of factorial : void)
  Class: Eq_141
  DataType: (ptr32 Eq_141)
  OrigDataType: 
T_143: (in factorial(dwLoc08_115) : void)
  Class: Eq_143
  DataType: void
  OrigDataType: void
T_144: (in 4<32> : word32)
  Class: Eq_144
  DataType: word32
  OrigDataType: word32
T_145: (in dwLoc08_115 + 4<32> : word32)
  Class: Eq_115
  DataType: int32
  OrigDataType: int32
T_146: (in dwLoc08_115 - dwArg0C : word32)
  Class: Eq_146
  DataType: int32
  OrigDataType: int32
T_147: (in 0<32> : word32)
  Class: Eq_146
  DataType: int32
  OrigDataType: int32
T_148: (in dwLoc08_115 - dwArg0C > 0<32> : bool)
  Class: Eq_148
  DataType: bool
  OrigDataType: bool
T_149: (in pow_int : ptr32)
  Class: Eq_138
  DataType: (ptr32 Eq_138)
  OrigDataType: (ptr32 (fn T_150 (T_132, T_136)))
T_150: (in pow_int(rArg04, dwLoc08_118) : void)
  Class: Eq_140
  DataType: void
  OrigDataType: void
T_151: (in factorial : ptr32)
  Class: Eq_141
  DataType: (ptr32 Eq_141)
  OrigDataType: (ptr32 (fn T_152 (T_136)))
T_152: (in factorial(dwLoc08_118) : void)
  Class: Eq_143
  DataType: void
  OrigDataType: void
T_153: (in 4<32> : word32)
  Class: Eq_153
  DataType: word32
  OrigDataType: word32
T_154: (in dwLoc08_118 + 4<32> : word32)
  Class: Eq_115
  DataType: int32
  OrigDataType: int32
T_155: (in dwLoc08_118 - dwArg0C : word32)
  Class: Eq_155
  DataType: int32
  OrigDataType: int32
T_156: (in 0<32> : word32)
  Class: Eq_155
  DataType: int32
  OrigDataType: int32
T_157: (in dwLoc08_118 - dwArg0C > 0<32> : bool)
  Class: Eq_157
  DataType: bool
  OrigDataType: bool
T_158: (in sine_taylor : ptr32)
  Class: Eq_158
  DataType: (ptr32 Eq_158)
  OrigDataType: (ptr32 (fn T_161 (T_160)))
T_159: (in signature of sine_taylor : void)
  Class: Eq_158
  DataType: (ptr32 Eq_158)
  OrigDataType: 
T_160: (in 3.14 : real64)
  Class: Eq_114
  DataType: real64
  OrigDataType: real64
T_161: (in sine_taylor(3.14) : void)
  Class: Eq_161
  DataType: void
  OrigDataType: void
T_162: (in _sin : ptr32)
  Class: Eq_162
  DataType: (ptr32 Eq_162)
  OrigDataType: (ptr32 (fn T_172 (T_167, T_168, T_171)))
T_163: (in signature of _sin : void)
  Class: Eq_162
  DataType: (ptr32 Eq_162)
  OrigDataType: 
T_164: (in rArg04 : real64)
  Class: Eq_164
  DataType: real64
  OrigDataType: real64
T_165: (in rArg0C : real64)
  Class: Eq_165
  DataType: real64
  OrigDataType: real64
T_166: (in tArg14 : Eq_166)
  Class: Eq_166
  DataType: Eq_166
  OrigDataType: (union ((ptr32 (struct (0 T_184 t0000))) u1) ((ref int32) u0))
T_167: (in 3.14 : real64)
  Class: Eq_164
  DataType: real64
  OrigDataType: real64
T_168: (in 0.003 : real64)
  Class: Eq_165
  DataType: real64
  OrigDataType: real64
T_169: (in fp : ptr32)
  Class: Eq_169
  DataType: ptr32
  OrigDataType: ptr32
T_170: (in 8<32> : word32)
  Class: Eq_170
  DataType: ui32
  OrigDataType: ui32
T_171: (in fp - 8<32> : word32)
  Class: Eq_166
  DataType: Eq_166
  OrigDataType: (union (ptr32 u0) ((ref int32) u1))
T_172: (in _sin(3.14, 0.003, fp - 8<32>) : void)
  Class: Eq_172
  DataType: void
  OrigDataType: void
T_173: (in rLoc0C_109 : real64)
  Class: Eq_164
  DataType: real64
  OrigDataType: real64
T_174: (in v9_14 : real64)
  Class: Eq_174
  DataType: real64
  OrigDataType: real64
T_175: (in CONVERT(rArg04, real64, real96) : real96)
  Class: Eq_175
  DataType: real96
  OrigDataType: real96
T_176: (in (real96) rArg04 *96 rArg04 : real96)
  Class: Eq_176
  DataType: real96
  OrigDataType: real96
T_177: (in CONVERT(CONVERT(rArg04, real64, real96) *96 rArg04, real96, real64) : real64)
  Class: Eq_174
  DataType: real64
  OrigDataType: real64
T_178: (in dwLoc20_115 : word32)
  Class: Eq_178
  DataType: word32
  OrigDataType: word32
T_179: (in 2<32> : word32)
  Class: Eq_178
  DataType: word32
  OrigDataType: word32
T_180: (in rLoc14_117 : real64)
  Class: Eq_180
  DataType: real64
  OrigDataType: real64
T_181: (in 0x3FF0000000000000<64> : word64)
  Class: Eq_180
  DataType: real64
  OrigDataType: word64
T_182: (in 0<32> : word32)
  Class: Eq_182
  DataType: word32
  OrigDataType: word32
T_183: (in tArg14 + 0<32> : word32)
  Class: Eq_183
  DataType: Eq_183
  OrigDataType: (ref int32)
T_184: (in Mem94[tArg14 + 0<32>:word32] : word32)
  Class: Eq_184
  DataType: word32
  OrigDataType: word32
T_185: (in 1<32> : word32)
  Class: Eq_185
  DataType: word32
  OrigDataType: word32
T_186: (in Mem94[tArg14 + 0<32>:word32] + 1<32> : word32)
  Class: Eq_184
  DataType: word32
  OrigDataType: word32
T_187: (in 0<32> : word32)
  Class: Eq_187
  DataType: word32
  OrigDataType: word32
T_188: (in tArg14 + 0<32> : word32)
  Class: Eq_188
  DataType: Eq_188
  OrigDataType: (union ((ptr32 word32) u1) ((ref int32) u0))
T_189: (in Mem101[tArg14 + 0<32>:word32] : word32)
  Class: Eq_184
  DataType: Eq_166
  OrigDataType: word32
T_190: (in v18_53 : word32)
  Class: Eq_190
  DataType: word32
  OrigDataType: word32
T_191: (in 0<32> : word32)
  Class: Eq_191
  DataType: word32
  OrigDataType: word32
T_192: (in dwLoc20_115 + 0<32> : word32)
  Class: Eq_190
  DataType: word32
  OrigDataType: word32
T_193: (in CONVERT(rLoc0C_109, real64, real96) : real96)
  Class: Eq_193
  DataType: real96
  OrigDataType: real96
T_194: (in (real96) rLoc0C_109 *96 v9_14 : real96)
  Class: Eq_194
  DataType: real96
  OrigDataType: real96
T_195: (in CONVERT(CONVERT(rLoc0C_109, real64, real96) *96 v9_14, real96, real64) : real64)
  Class: Eq_195
  DataType: real64
  OrigDataType: real64
T_196: (in CONVERT(CONVERT(CONVERT(rLoc0C_109, real64, real96) *96 v9_14, real96, real64), real64, real96) : real96)
  Class: Eq_196
  DataType: real96
  OrigDataType: real96
T_197: (in (real96) (real64) ((real96) rLoc0C_109 *96 v9_14) *96 v9_14 : real96)
  Class: Eq_197
  DataType: real96
  OrigDataType: real96
T_198: (in CONVERT(CONVERT(CONVERT(CONVERT(rLoc0C_109, real64, real96) *96 v9_14, real96, real64), real64, real96) *96 v9_14, real96, real64) : real64)
  Class: Eq_164
  DataType: real64
  OrigDataType: real64
T_199: (in 3<32> : word32)
  Class: Eq_199
  DataType: word32
  OrigDataType: word32
T_200: (in v18_53 + 3<32> : word32)
  Class: Eq_178
  DataType: word32
  OrigDataType: word32
T_201: (in CONVERT(rLoc14_117, real64, real96) : real96)
  Class: Eq_201
  DataType: real96
  OrigDataType: real96
T_202: (in CONVERT(v18_53, word32, real96) : real96)
  Class: Eq_202
  DataType: real96
  OrigDataType: real96
T_203: (in CONVERT(CONVERT(v18_53, word32, real96), real96, real80) : real80)
  Class: Eq_203
  DataType: real80
  OrigDataType: real80
T_204: (in (real96) rLoc14_117 *96 (real80) ((real96) v18_53) : real96)
  Class: Eq_204
  DataType: real96
  OrigDataType: real96
T_205: (in CONVERT(CONVERT(rLoc14_117, real64, real96) *96 CONVERT(CONVERT(v18_53, word32, real96), real96, real80), real96, real64) : real64)
  Class: Eq_205
  DataType: real64
  OrigDataType: real64
T_206: (in CONVERT(CONVERT(CONVERT(rLoc14_117, real64, real96) *96 CONVERT(CONVERT(v18_53, word32, real96), real96, real80), real96, real64), real64, real96) : real96)
  Class: Eq_206
  DataType: real96
  OrigDataType: real96
T_207: (in 1<32> : word32)
  Class: Eq_207
  DataType: word32
  OrigDataType: word32
T_208: (in v18_53 + 1<32> : word32)
  Class: Eq_208
  DataType: word32
  OrigDataType: word32
T_209: (in CONVERT(v18_53 + 1<32>, word32, real96) : real96)
  Class: Eq_209
  DataType: real96
  OrigDataType: real96
T_210: (in CONVERT(CONVERT(v18_53 + 1<32>, word32, real96), real96, real80) : real80)
  Class: Eq_210
  DataType: real80
  OrigDataType: real80
T_211: (in (real96) (real64) ((real96) rLoc14_117 *96 (real80) ((real96) v18_53)) *96 (real80) ((real96) (v18_53 + 1<32>)) : real96)
  Class: Eq_211
  DataType: real96
  OrigDataType: real96
T_212: (in CONVERT(CONVERT(CONVERT(CONVERT(rLoc14_117, real64, real96) *96 CONVERT(CONVERT(v18_53, word32, real96), real96, real80), real96, real64), real64, real96) *96 CONVERT(CONVERT(v18_53 + 1<32>, word32, real96), real96, real80), real96, real64) : real64)
  Class: Eq_212
  DataType: real64
  OrigDataType: real64
T_213: (in CONVERT(CONVERT(CONVERT(CONVERT(CONVERT(rLoc14_117, real64, real96) *96 CONVERT(CONVERT(v18_53, word32, real96), real96, real80), real96, real64), real64, real96) *96 CONVERT(CONVERT(v18_53 + 1<32>, word32, real96), real96, real80), real96, real64), real64, real96) : real96)
  Class: Eq_213
  DataType: real96
  OrigDataType: real96
T_214: (in 2<32> : word32)
  Class: Eq_214
  DataType: word32
  OrigDataType: word32
T_215: (in v18_53 + 2<32> : word32)
  Class: Eq_215
  DataType: word32
  OrigDataType: word32
T_216: (in CONVERT(v18_53 + 2<32>, word32, real96) : real96)
  Class: Eq_216
  DataType: real96
  OrigDataType: real96
T_217: (in CONVERT(CONVERT(v18_53 + 2<32>, word32, real96), real96, real80) : real80)
  Class: Eq_217
  DataType: real80
  OrigDataType: real80
T_218: (in (real96) (real64) ((real96) (real64) ((real96) rLoc14_117 *96 (real80) ((real96) v18_53)) *96 (real80) ((real96) (v18_53 + 1<32>))) *96 (real80) ((real96) (v18_53 + 2<32>)) : real96)
  Class: Eq_218
  DataType: real96
  OrigDataType: real96
T_219: (in CONVERT(CONVERT(CONVERT(CONVERT(CONVERT(CONVERT(rLoc14_117, real64, real96) *96 CONVERT(CONVERT(v18_53, word32, real96), real96, real80), real96, real64), real64, real96) *96 CONVERT(CONVERT(v18_53 + 1<32>, word32, real96), real96, real80), real96, real64), real64, real96) *96 CONVERT(CONVERT(v18_53 + 2<32>, word32, real96), real96, real80), real96, real64) : real64)
  Class: Eq_219
  DataType: real64
  OrigDataType: real64
T_220: (in CONVERT(CONVERT(CONVERT(CONVERT(CONVERT(CONVERT(CONVERT(rLoc14_117, real64, real96) *96 CONVERT(CONVERT(v18_53, word32, real96), real96, real80), real96, real64), real64, real96) *96 CONVERT(CONVERT(v18_53 + 1<32>, word32, real96), real96, real80), real96, real64), real64, real96) *96 CONVERT(CONVERT(v18_53 + 2<32>, word32, real96), real96, real80), real96, real64), real64, real96) : real96)
  Class: Eq_220
  DataType: real96
  OrigDataType: real96
T_221: (in v18_53 + 3<32> : word32)
  Class: Eq_221
  DataType: word32
  OrigDataType: word32
T_222: (in CONVERT(v18_53 + 3<32>, word32, real96) : real96)
  Class: Eq_222
  DataType: real96
  OrigDataType: real96
T_223: (in CONVERT(CONVERT(v18_53 + 3<32>, word32, real96), real96, real80) : real80)
  Class: Eq_223
  DataType: real80
  OrigDataType: real80
T_224: (in (real96) (real64) ((real96) (real64) ((real96) (real64) ((real96) rLoc14_117 *96 (real80) ((real96) v18_53)) *96 (real80) ((real96) (v18_53 + 1<32>))) *96 (real80) ((real96) (v18_53 + 2<32>))) *96 (real80) ((real96) (v18_53 + 3<32>)) : real96)
  Class: Eq_224
  DataType: real96
  OrigDataType: real96
T_225: (in CONVERT(CONVERT(CONVERT(CONVERT(CONVERT(CONVERT(CONVERT(CONVERT(rLoc14_117, real64, real96) *96 CONVERT(CONVERT(v18_53, word32, real96), real96, real80), real96, real64), real64, real96) *96 CONVERT(CONVERT(v18_53 + 1<32>, word32, real96), real96, real80), real96, real64), real64, real96) *96 CONVERT(CONVERT(v18_53 + 2<32>, word32, real96), real96, real80), real96, real64), real64, real96) *96 CONVERT(CONVERT(v18_53 + 3<32>, word32, real96), real96, real80), real96, real64) : real64)
  Class: Eq_180
  DataType: real64
  OrigDataType: real64
T_226: (in CONVERT(rLoc0C_109, real64, real96) : real96)
  Class: Eq_226
  DataType: real96
  OrigDataType: real96
T_227: (in (real96) rLoc0C_109 /96 rLoc14_117 : real96)
  Class: Eq_227
  DataType: real96
  OrigDataType: real96
T_228: (in CONVERT(CONVERT(rLoc0C_109, real64, real96) /96 rLoc14_117, real96, real64) : real64)
  Class: Eq_165
  DataType: real64
  OrigDataType: real64
T_229: (in (real64) ((real96) rLoc0C_109 /96 rLoc14_117) < rArg0C : bool)
  Class: Eq_229
  DataType: bool
  OrigDataType: bool
T_230: (in a0_11 : (ptr32 code))
  Class: Eq_230
  DataType: (ptr32 code)
  OrigDataType: (ptr32 code)
T_231: (in 8000270C : ptr32)
  Class: Eq_231
  DataType: (ptr32 (ptr32 code))
  OrigDataType: (ptr32 (struct (0 T_232 t0000)))
T_232: (in Mem10[0x8000270C<p32>:word32] : word32)
  Class: Eq_230
  DataType: (ptr32 code)
  OrigDataType: word32
T_233: (in a6_18 : ptr32)
  Class: Eq_233
  DataType: ptr32
  OrigDataType: ptr32
T_234: (in fp : ptr32)
  Class: Eq_234
  DataType: ptr32
  OrigDataType: ptr32
T_235: (in 4<32> : word32)
  Class: Eq_235
  DataType: ui32
  OrigDataType: ui32
T_236: (in fp - 4<32> : word32)
  Class: Eq_233
  DataType: ptr32
  OrigDataType: ptr32
T_237: (in a2_12 : ptr32)
  Class: Eq_237
  DataType: ptr32
  OrigDataType: ptr32
T_238: (in 8000270C : ptr32)
  Class: Eq_237
  DataType: ptr32
  OrigDataType: ptr32
T_239: (in -1<i32> : int32)
  Class: Eq_230
  DataType: (ptr32 code)
  OrigDataType: int32
T_240: (in a0_11 == (<anonymous> *) -1<i32> : bool)
  Class: Eq_240
  DataType: bool
  OrigDataType: bool
T_241: (in a2_23 : (ptr32 Eq_241))
  Class: Eq_241
  DataType: (ptr32 Eq_241)
  OrigDataType: (ptr32 (struct (FFFFFFFC T_244 tFFFFFFFC)))
T_242: (in -4<i32> : int32)
  Class: Eq_242
  DataType: int32
  OrigDataType: int32
T_243: (in a2_23 + -4<i32> : word32)
  Class: Eq_243
  DataType: word32
  OrigDataType: word32
T_244: (in Mem10[a2_23 + -4<i32>:word32] : word32)
  Class: Eq_230
  DataType: (ptr32 code)
  OrigDataType: word32
T_245: (in 4<i32> : int32)
  Class: Eq_245
  DataType: int32
  OrigDataType: int32
T_246: (in a2_23 - 4<i32> : word32)
  Class: Eq_237
  DataType: ptr32
  OrigDataType: ptr32
T_247: (in -1<i32> : int32)
  Class: Eq_230
  DataType: (ptr32 code)
  OrigDataType: int32
T_248: (in a0_11 != (<anonymous> *) -1<i32> : bool)
  Class: Eq_248
  DataType: bool
  OrigDataType: bool
T_249:
  Class: Eq_38
  DataType: uint32
  OrigDataType: word32
T_250:
  Class: Eq_250
  DataType: (ptr32 code)
  OrigDataType: (struct 0004 (0 T_65 t0000))
*/
typedef struct Globals {
	<anonymous> * ptr8000270C;	// 8000270C
	<anonymous> * a80002714[];	// 80002714
	word32 dw8000271C;	// 8000271C
	byte b80002724;	// 80002724
	uint32 dtor_idx.3228;	// 80002726
	<anonymous> tFFFFFFFF;	// FFFFFFFF
} Eq_1;

typedef word32 (Eq_48)();

typedef struct Eq_51 {
	ptr32 ptrFFFFFFFC;	// FFFFFFFC
} Eq_51;

typedef struct Eq_86 {
	ptr32 ptrFFFFFFFC;	// FFFFFFFC
} Eq_86;

typedef void (Eq_109)();

typedef void (Eq_138)(real64, int32);

typedef void (Eq_141)(int32);

typedef void (Eq_158)(real64);

typedef void (Eq_162)(real64, real64, Eq_166);

typedef union Eq_166 {
	word32 * u0;
	int32 & u1;
} Eq_166;

typedef int32 & Eq_183;

typedef union Eq_188 {
	word32 * u0;
	int32 & u1;
} Eq_188;

typedef struct Eq_241 {
	<anonymous> * ptrFFFFFFFC;	// FFFFFFFC
} Eq_241;
