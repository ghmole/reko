// retpoline_stripped.c
// Generated by decompiling retpoline_stripped.elf
// using Reko decompiler version 0.7.2.0.

#include "retpoline_stripped.h"

// 0000000000400428: void fn0000000000400428()
void fn0000000000400428()
{
	word64 rax_4 = globals->qw600FF8;
	if (rax_4 != 0x00)
	{
		word64 rsp_17;
		byte SCZO_18;
		word64 rax_19;
		byte SZO_20;
		byte C_21;
		byte Z_22;
		word32 eax_23;
		eax();
	}
}

// 0000000000400480: void fn0000000000400480(Stack Eq_17 qwArg00)
void fn0000000000400480(Eq_17 qwArg00)
{
	__align(fp + 0x08);
	calloc(0x00400660, qwArg00);
	__hlt();
}

// 00000000004004B0: void fn00000000004004B0(Register word64 r8)
void fn00000000004004B0(word64 r8)
{
	if (r8 == 0x00601040 || 0x00 == 0x00)
		;
	else
	{
		word64 rsp_39;
		word64 rbp_40;
		word32 eax_41;
		word64 rax_42;
		word64 r8_43;
		byte SCZO_44;
		byte Z_45;
		byte SZO_46;
		byte C_47;
		word32 edi_48;
		word64 rdi_49;
		eax();
	}
}

// 0000000000400560: void fn0000000000400560(Register word32 esi, Register word32 edi)
void fn0000000000400560(word32 esi, word32 edi)
{
	calloc((int64) edi, (int64) esi);
}

// 00000000004006F0: void fn00000000004006F0()
void fn00000000004006F0()
{
	fn0000000000400700(qwLoc08);
	while (true)
		__pause();
}

// 0000000000400700: void fn0000000000400700(Stack word64 qwArg00)
void fn0000000000400700(word64 qwArg00)
{
}

