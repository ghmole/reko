// main_rdata.c
// Generated by decompiling main.exe
// using Reko decompiler version 0.9.4.0.

#include "main.h"

<anonymous> * __imp__GetModuleHandleW = &g_t2AA8; // 00402000
<anonymous> * __imp__IsDebuggerPresent = &g_t2A94; // 00402004
<anonymous> * __imp__InitializeSListHead = &g_t2A7E; // 00402008
<anonymous> * __imp__GetSystemTimeAsFileTime = &g_t2A64; // 0040200C
<anonymous> * __imp__SetUnhandledExceptionFilter = &g_t29BC; // 00402010
<anonymous> * __imp__GetCurrentProcess = &g_t29DA; // 00402014
<anonymous> * __imp__TerminateProcess = &g_t29EE; // 00402018
<anonymous> * __imp__UnhandledExceptionFilter = &g_t29A0; // 0040201C
<anonymous> * __imp__GetCurrentThreadId = &g_t2A4E; // 00402020
<anonymous> * __imp__GetCurrentProcessId = &g_t2A38; // 00402024
<anonymous> * __imp__QueryPerformanceCounter = &g_t2A1E; // 00402028
<anonymous> * __imp__IsProcessorFeaturePresent = &g_t2A02; // 0040202C
<anonymous> * __imp__memset = &g_t26D8; // 00402034
<anonymous> * __imp___except_handler4_common = &g_t26E2; // 00402038
<anonymous> * __imp___set_new_mode = &g_t287A; // 00402040
<anonymous> * __imp___configthreadlocale = &g_t2864; // 00402048
<anonymous> * __imp____setusermatherr = &g_t275C; // 00402050
<anonymous> * __imp____p___argv = &g_t2814; // 00402058
<anonymous> * __imp___cexit = &g_t2822; // 0040205C
<anonymous> * __imp___c_exit = &g_t282C; // 00402060
<anonymous> * __imp___register_thread_local_exe_atexit_callback = &g_t2836; // 00402064
<anonymous> * __imp____p___argc = &g_t2806; // 00402068
<anonymous> * __imp___initterm_e = &g_t27DA; // 0040206C
<anonymous> * __imp___set_app_type = &g_t274C; // 00402070
<anonymous> * __imp___exit = &g_t27F0; // 00402074
<anonymous> * __imp___initialize_onexit_table = &g_t289A; // 00402078
<anonymous> * __imp___register_onexit_function = &g_t28B6; // 0040207C
<anonymous> * __imp___crt_atexit = &g_t28D2; // 00402080
<anonymous> * __imp___controlfp_s = &g_t28E0; // 00402084
<anonymous> * __imp__terminate = &g_t28F0; // 00402088
<anonymous> * __imp___configure_narrow_argv = &g_t2770; // 0040208C
<anonymous> * __imp__exit = &g_t27E8; // 00402090
<anonymous> * __imp___initterm = &g_t27CE; // 00402094
<anonymous> * __imp___get_initial_narrow_environment = &g_t27AC; // 00402098
<anonymous> * __imp___initialize_narrow_environment = &g_t278A; // 0040209C
<anonymous> * __imp___seh_filter_exe = &g_t273A; // 004020A0
<anonymous> * __imp___set_fmode = &g_t27F8; // 004020A8
<anonymous> * __imp____p__commode = &g_t288A; // 004020AC
<anonymous> * __imp____stdio_common_vfprintf = &g_t2720; // 004020B0
<anonymous> * __imp____acrt_iob_func = &g_t270E; // 004020B4
<anonymous> * __imp__driver.dll_n = &g_t80000001; // 004020BC
<anonymous> * __imp__driver.dll_n = &g_t80000002; // 004020C0
<anonymous> * __imp__driver.dll_n = &g_t80000004; // 004020C4
<anonymous> * __imp__driver.dll_n = &g_t80000003; // 004020C8
<anonymous> * __imp__driver.dll_n = &g_t8000000B; // 004020CC
<anonymous> * g_ptr4020D4 = &g_t401731; // 004020D4
Eq_n g_t4020D8 = null; // 004020D8
Eq_n g_t4020E0 = null; // 004020E0
Eq_n g_t4020E4 = null; // 004020E4
Eq_n g_t4020F0 = null; // 004020F0
word32 g_dw4025F8 = 0x2AA8; // 004025F8
word32 g_dw4025FC = 10900; // 004025FC
word32 g_dw402600 = 10878; // 00402600
word32 g_dw402604 = 0x2A64; // 00402604
word32 g_dw402608 = 0x29BC; // 00402608
word32 g_dw40260C = 10714; // 0040260C
word32 g_dw402610 = 0x29EE; // 00402610
word32 g_dw402614 = 0x29A0; // 00402614
word32 g_dw402618 = 10830; // 00402618
word32 g_dw40261C = 10808; // 0040261C
word32 g_dw402620 = 0x2A1E; // 00402620
word32 g_dw402624 = 0x2A02; // 00402624
word32 g_dw40262C = 9944; // 0040262C
word32 g_dw402630 = 0x26E2; // 00402630
word32 g_dw402638 = 0x287A; // 00402638
word32 g_dw402640 = 10340; // 00402640
word32 g_dw402648 = 10076; // 00402648
word32 g_dw402650 = 10260; // 00402650
word32 g_dw402654 = 0x2822; // 00402654
word32 g_dw402658 = 0x282C; // 00402658
word32 g_dw40265C = 0x2836; // 0040265C
word32 g_dw402660 = 0x2806; // 00402660
word32 g_dw402664 = 10202; // 00402664
word32 g_dw402668 = 10060; // 00402668
word32 g_dw40266C = 0x27F0; // 0040266C
word32 g_dw402670 = 0x289A; // 00402670
word32 g_dw402674 = 10422; // 00402674
word32 g_dw402678 = 0x28D2; // 00402678
word32 g_dw40267C = 0x28E0; // 0040267C
word32 g_dw402680 = 0x28F0; // 00402680
word32 g_dw402684 = 0x2770; // 00402684
word32 g_dw402688 = 10216; // 00402688
word32 g_dw40268C = 10190; // 0040268C
word32 g_dw402690 = 10156; // 00402690
word32 g_dw402694 = 10122; // 00402694
word32 g_dw402698 = 10042; // 00402698
word32 g_dw4026A0 = 10232; // 004026A0
word32 g_dw4026A4 = 0x288A; // 004026A4
word32 g_dw4026A8 = 0x2720; // 004026A8
word32 g_dw4026AC = 9998; // 004026AC
word32 g_dw4026B4 = 0x80000001; // 004026B4
word32 g_dw4026B8 = 0x80000002; // 004026B8
word32 g_dw4026BC = 0x80000004; // 004026BC
word32 g_dw4026C0 = 0x80000003; // 004026C0
word32 g_dw4026C4 = 0x8000000B; // 004026C4