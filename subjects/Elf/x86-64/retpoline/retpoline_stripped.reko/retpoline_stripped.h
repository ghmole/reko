// retpoline_stripped.h
// Generated by decompiling retpoline_stripped.elf
// using Reko decompiler version 0.9.4.0.

/*
// Equivalence classes ////////////
Eq_1: (struct "Globals" (400456 code t400456) (400466 code t400466) (400476 code t400476) (400660 Eq_18 t400660) (400710 Eq_21 t400710) (400780 Eq_22 t400780) (600FF0 (ptr64 code) __libc_start_main_GOT) (600FF8 (ptr64 code) __gmon_start___GOT) (601018 (ptr64 code) free_GOT) (601020 (ptr64 code) puts_GOT) (601028 (ptr64 code) calloc_GOT))
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
Eq_16: (fn int32 ((ptr64 Eq_18), Eq_8, (ptr64 (ptr64 char)), (ptr64 Eq_21), (ptr64 Eq_22), (ptr64 Eq_7), (ptr64 void)))
	T_16 (in __libc_start_main : ptr64)
	T_17 (in signature of __libc_start_main : void)
Eq_18: (fn int32 (int32, (ptr64 (ptr64 char)), (ptr64 (ptr64 char))))
	T_18 (in main : (ptr64 (fn int32 (int32, (ptr64 (ptr64 char)), (ptr64 (ptr64 char))))))
	T_25 (in 0x400660<64> : word64)
Eq_21: (fn void ())
	T_21 (in init : (ptr64 (fn void ())))
	T_27 (in 0x400710<64> : word64)
Eq_22: (fn void ())
	T_22 (in fini : (ptr64 (fn void ())))
	T_28 (in 0x400780<64> : word64)
Eq_30: (fn void ())
	T_30 (in __hlt : ptr64)
	T_31 (in signature of __hlt : void)
Eq_45: (fn void ())
	T_45 (in fn0000000000400700 : ptr64)
	T_46 (in signature of fn0000000000400700 : void)
Eq_48: (fn void ())
	T_48 (in __pause : ptr64)
	T_49 (in signature of __pause : void)
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
T_25: (in 0x400660<64> : word64)
  Class: Eq_18
  DataType: (ptr64 Eq_18)
  OrigDataType: (ptr64 (fn int32 (int32, (ptr64 (ptr64 char)), (ptr64 (ptr64 char)))))
T_26: (in fp + 8<i64> : word64)
  Class: Eq_20
  DataType: (ptr64 (ptr64 char))
  OrigDataType: (ptr64 (ptr64 char))
T_27: (in 0x400710<64> : word64)
  Class: Eq_21
  DataType: (ptr64 Eq_21)
  OrigDataType: (ptr64 (fn void ()))
T_28: (in 0x400780<64> : word64)
  Class: Eq_22
  DataType: (ptr64 Eq_22)
  OrigDataType: (ptr64 (fn void ()))
T_29: (in __libc_start_main(&g_t400660, qwArg00, (char *) fp + 8<i32>, &g_t400710, &g_t400780, rdx, fp) : int32)
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
T_33: (in true : bool)
  Class: Eq_33
  DataType: bool
  OrigDataType: bool
T_34: (in true : bool)
  Class: Eq_34
  DataType: bool
  OrigDataType: bool
T_35: (in 0<u64> : uint64)
  Class: Eq_35
  DataType: (ptr64 code)
  OrigDataType: (ptr64 code)
T_36: (in esi : word32)
  Class: Eq_36
  DataType: word32
  OrigDataType: word32
T_37: (in edi : word32)
  Class: Eq_37
  DataType: word32
  OrigDataType: word32
T_38: (in calloc : ptr64)
  Class: Eq_38
  DataType: ptr64
  OrigDataType: ptr64
T_39: (in signature of calloc : void)
  Class: Eq_38
  DataType: ptr64
  OrigDataType: 
T_40: (in num : size_t)
  Class: Eq_40
  DataType: int64
  OrigDataType: 
T_41: (in size : size_t)
  Class: Eq_40
  DataType: int64
  OrigDataType: 
T_42: (in CONVERT(edi, word32, int64) : int64)
  Class: Eq_40
  DataType: int64
  OrigDataType: int64
T_43: (in CONVERT(esi, word32, int64) : int64)
  Class: Eq_40
  DataType: int64
  OrigDataType: int64
T_44: (in calloc((int64) edi, (int64) esi) : (ptr64 void))
  Class: Eq_44
  DataType: (ptr64 void)
  OrigDataType: (ptr64 void)
T_45: (in fn0000000000400700 : ptr64)
  Class: Eq_45
  DataType: (ptr64 Eq_45)
  OrigDataType: (ptr64 (fn T_47 ()))
T_46: (in signature of fn0000000000400700 : void)
  Class: Eq_45
  DataType: (ptr64 Eq_45)
  OrigDataType: 
T_47: (in fn0000000000400700() : void)
  Class: Eq_47
  DataType: void
  OrigDataType: void
T_48: (in __pause : ptr64)
  Class: Eq_48
  DataType: (ptr64 Eq_48)
  OrigDataType: (ptr64 (fn T_50 ()))
T_49: (in signature of __pause : void)
  Class: Eq_48
  DataType: (ptr64 Eq_48)
  OrigDataType: 
T_50: (in __pause() : void)
  Class: Eq_50
  DataType: void
  OrigDataType: void
*/
typedef struct Globals {
	<anonymous> t400456;	// 400456
	<anonymous> t400466;	// 400466
	<anonymous> t400476;	// 400476
	Eq_18 t400660;	// 400660
	Eq_21 t400710;	// 400710
	Eq_22 t400780;	// 400780
	<anonymous> * __libc_start_main_GOT;	// 600FF0
	<anonymous> * __gmon_start___GOT;	// 600FF8
	<anonymous> * free_GOT;	// 601018
	<anonymous> * puts_GOT;	// 601020
	<anonymous> * calloc_GOT;	// 601028
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

typedef void (Eq_45)();

typedef void (Eq_48)();
