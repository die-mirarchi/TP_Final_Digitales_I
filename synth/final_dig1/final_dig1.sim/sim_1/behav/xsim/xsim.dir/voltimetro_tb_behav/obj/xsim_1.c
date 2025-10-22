/**********************************************************************/
/*   ____  ____                                                       */
/*  /   /\/   /                                                       */
/* /___/  \  /                                                        */
/* \   \   \/                                                         */
/*  \   \        Copyright (c) 2003-2013 Xilinx, Inc.                 */
/*  /   /        All Right Reserved.                                  */
/* /---/   /\                                                         */
/* \   \  /  \                                                        */
/*  \___\/\___\                                                       */
/**********************************************************************/


#include "iki.h"
#include <string.h>
#include <math.h>
#ifdef __GNUC__
#include <stdlib.h>
#else
#include <malloc.h>
#define alloca _alloca
#endif
/**********************************************************************/
/*   ____  ____                                                       */
/*  /   /\/   /                                                       */
/* /___/  \  /                                                        */
/* \   \   \/                                                         */
/*  \   \        Copyright (c) 2003-2013 Xilinx, Inc.                 */
/*  /   /        All Right Reserved.                                  */
/* /---/   /\                                                         */
/* \   \  /  \                                                        */
/*  \___\/\___\                                                       */
/**********************************************************************/


#include "iki.h"
#include <string.h>
#include <math.h>
#ifdef __GNUC__
#include <stdlib.h>
#else
#include <malloc.h>
#define alloca _alloca
#endif
typedef void (*funcp)(char *, char *);
extern int main(int, char**);
extern void execute_1320(char*, char *);
extern void execute_1321(char*, char *);
extern void execute_18(char*, char *);
extern void execute_906(char*, char *);
extern void execute_922(char*, char *);
extern void execute_923(char*, char *);
extern void execute_1314(char*, char *);
extern void execute_1315(char*, char *);
extern void execute_1316(char*, char *);
extern void execute_1317(char*, char *);
extern void execute_1318(char*, char *);
extern void execute_1319(char*, char *);
extern void execute_9(char*, char *);
extern void execute_10(char*, char *);
extern void execute_17(char*, char *);
extern void execute_12(char*, char *);
extern void execute_14(char*, char *);
extern void execute_20(char*, char *);
extern void execute_21(char*, char *);
extern void execute_364(char*, char *);
extern void execute_365(char*, char *);
extern void execute_366(char*, char *);
extern void execute_37(char*, char *);
extern void execute_53(char*, char *);
extern void execute_69(char*, char *);
extern void execute_85(char*, char *);
extern void execute_101(char*, char *);
extern void execute_117(char*, char *);
extern void execute_133(char*, char *);
extern void execute_149(char*, char *);
extern void execute_165(char*, char *);
extern void execute_181(char*, char *);
extern void execute_197(char*, char *);
extern void execute_213(char*, char *);
extern void execute_229(char*, char *);
extern void execute_245(char*, char *);
extern void execute_261(char*, char *);
extern void execute_277(char*, char *);
extern void execute_293(char*, char *);
extern void execute_309(char*, char *);
extern void execute_325(char*, char *);
extern void execute_328(char*, char *);
extern void execute_330(char*, char *);
extern void execute_332(char*, char *);
extern void execute_334(char*, char *);
extern void execute_336(char*, char *);
extern void execute_338(char*, char *);
extern void execute_340(char*, char *);
extern void execute_342(char*, char *);
extern void execute_344(char*, char *);
extern void execute_346(char*, char *);
extern void execute_348(char*, char *);
extern void execute_350(char*, char *);
extern void execute_352(char*, char *);
extern void execute_354(char*, char *);
extern void execute_356(char*, char *);
extern void execute_358(char*, char *);
extern void execute_360(char*, char *);
extern void execute_362(char*, char *);
extern void execute_34(char*, char *);
extern void execute_35(char*, char *);
extern void execute_36(char*, char *);
extern void execute_770(char*, char *);
extern void execute_432(char*, char *);
extern void execute_497(char*, char *);
extern void execute_562(char*, char *);
extern void execute_627(char*, char *);
extern void execute_692(char*, char *);
extern void execute_757(char*, char *);
extern void execute_760(char*, char *);
extern void execute_762(char*, char *);
extern void execute_764(char*, char *);
extern void execute_766(char*, char *);
extern void execute_768(char*, char *);
extern void execute_426(char*, char *);
extern void execute_427(char*, char *);
extern void execute_428(char*, char *);
extern void execute_429(char*, char *);
extern void execute_430(char*, char *);
extern void execute_431(char*, char *);
extern void execute_908(char*, char *);
extern void execute_909(char*, char *);
extern void execute_910(char*, char *);
extern void execute_911(char*, char *);
extern void execute_912(char*, char *);
extern void execute_914(char*, char *);
extern void execute_916(char*, char *);
extern void execute_918(char*, char *);
extern void execute_920(char*, char *);
extern void execute_926(char*, char *);
extern void execute_927(char*, char *);
extern void execute_929(char*, char *);
extern void execute_1100(char*, char *);
extern void execute_1101(char*, char *);
extern void execute_1102(char*, char *);
extern void execute_1103(char*, char *);
extern void execute_1104(char*, char *);
extern void execute_1105(char*, char *);
extern void execute_1106(char*, char *);
extern void execute_1107(char*, char *);
extern void execute_1278(char*, char *);
extern void execute_1279(char*, char *);
extern void execute_1280(char*, char *);
extern void execute_1281(char*, char *);
extern void execute_1282(char*, char *);
extern void execute_1283(char*, char *);
extern void execute_1284(char*, char *);
extern void execute_1295(char*, char *);
extern void execute_1296(char*, char *);
extern void execute_1307(char*, char *);
extern void execute_1308(char*, char *);
extern void execute_1309(char*, char *);
extern void execute_1310(char*, char *);
extern void execute_1311(char*, char *);
extern void execute_1312(char*, char *);
extern void execute_1313(char*, char *);
extern void execute_1082(char*, char *);
extern void execute_1084(char*, char *);
extern void execute_1086(char*, char *);
extern void execute_1088(char*, char *);
extern void execute_1090(char*, char *);
extern void execute_1092(char*, char *);
extern void execute_1094(char*, char *);
extern void execute_1096(char*, char *);
extern void execute_1098(char*, char *);
extern void execute_1260(char*, char *);
extern void execute_1262(char*, char *);
extern void execute_1264(char*, char *);
extern void execute_1266(char*, char *);
extern void execute_1268(char*, char *);
extern void execute_1270(char*, char *);
extern void execute_1272(char*, char *);
extern void execute_1274(char*, char *);
extern void execute_1276(char*, char *);
extern void transaction_0(char*, char*, unsigned, unsigned, unsigned);
extern void transaction_1(char*, char*, unsigned, unsigned, unsigned);
extern void vhdl_transfunc_eventcallback(char*, char*, unsigned, unsigned, unsigned, char *);
extern void transaction_11(char*, char*, unsigned, unsigned, unsigned);
funcp funcTab[138] = {(funcp)execute_1320, (funcp)execute_1321, (funcp)execute_18, (funcp)execute_906, (funcp)execute_922, (funcp)execute_923, (funcp)execute_1314, (funcp)execute_1315, (funcp)execute_1316, (funcp)execute_1317, (funcp)execute_1318, (funcp)execute_1319, (funcp)execute_9, (funcp)execute_10, (funcp)execute_17, (funcp)execute_12, (funcp)execute_14, (funcp)execute_20, (funcp)execute_21, (funcp)execute_364, (funcp)execute_365, (funcp)execute_366, (funcp)execute_37, (funcp)execute_53, (funcp)execute_69, (funcp)execute_85, (funcp)execute_101, (funcp)execute_117, (funcp)execute_133, (funcp)execute_149, (funcp)execute_165, (funcp)execute_181, (funcp)execute_197, (funcp)execute_213, (funcp)execute_229, (funcp)execute_245, (funcp)execute_261, (funcp)execute_277, (funcp)execute_293, (funcp)execute_309, (funcp)execute_325, (funcp)execute_328, (funcp)execute_330, (funcp)execute_332, (funcp)execute_334, (funcp)execute_336, (funcp)execute_338, (funcp)execute_340, (funcp)execute_342, (funcp)execute_344, (funcp)execute_346, (funcp)execute_348, (funcp)execute_350, (funcp)execute_352, (funcp)execute_354, (funcp)execute_356, (funcp)execute_358, (funcp)execute_360, (funcp)execute_362, (funcp)execute_34, (funcp)execute_35, (funcp)execute_36, (funcp)execute_770, (funcp)execute_432, (funcp)execute_497, (funcp)execute_562, (funcp)execute_627, (funcp)execute_692, (funcp)execute_757, (funcp)execute_760, (funcp)execute_762, (funcp)execute_764, (funcp)execute_766, (funcp)execute_768, (funcp)execute_426, (funcp)execute_427, (funcp)execute_428, (funcp)execute_429, (funcp)execute_430, (funcp)execute_431, (funcp)execute_908, (funcp)execute_909, (funcp)execute_910, (funcp)execute_911, (funcp)execute_912, (funcp)execute_914, (funcp)execute_916, (funcp)execute_918, (funcp)execute_920, (funcp)execute_926, (funcp)execute_927, (funcp)execute_929, (funcp)execute_1100, (funcp)execute_1101, (funcp)execute_1102, (funcp)execute_1103, (funcp)execute_1104, (funcp)execute_1105, (funcp)execute_1106, (funcp)execute_1107, (funcp)execute_1278, (funcp)execute_1279, (funcp)execute_1280, (funcp)execute_1281, (funcp)execute_1282, (funcp)execute_1283, (funcp)execute_1284, (funcp)execute_1295, (funcp)execute_1296, (funcp)execute_1307, (funcp)execute_1308, (funcp)execute_1309, (funcp)execute_1310, (funcp)execute_1311, (funcp)execute_1312, (funcp)execute_1313, (funcp)execute_1082, (funcp)execute_1084, (funcp)execute_1086, (funcp)execute_1088, (funcp)execute_1090, (funcp)execute_1092, (funcp)execute_1094, (funcp)execute_1096, (funcp)execute_1098, (funcp)execute_1260, (funcp)execute_1262, (funcp)execute_1264, (funcp)execute_1266, (funcp)execute_1268, (funcp)execute_1270, (funcp)execute_1272, (funcp)execute_1274, (funcp)execute_1276, (funcp)transaction_0, (funcp)transaction_1, (funcp)vhdl_transfunc_eventcallback, (funcp)transaction_11};
const int NumRelocateId= 138;

void relocate(char *dp)
{
	iki_relocate(dp, "xsim.dir/voltimetro_tb_behav/xsim.reloc",  (void **)funcTab, 138);
	iki_vhdl_file_variable_register(dp + 166376);
	iki_vhdl_file_variable_register(dp + 166432);


	/*Populate the transaction function pointer field in the whole net structure */
}

void sensitize(char *dp)
{
	iki_sensitize(dp, "xsim.dir/voltimetro_tb_behav/xsim.reloc");
}

	// Initialize Verilog nets in mixed simulation, for the cases when the value at time 0 should be propagated from the mixed language Vhdl net

void simulate(char *dp)
{
		iki_schedule_processes_at_time_zero(dp, "xsim.dir/voltimetro_tb_behav/xsim.reloc");

	iki_execute_processes();

	// Schedule resolution functions for the multiply driven Verilog nets that have strength
	// Schedule transaction functions for the singly driven Verilog nets that have strength

}
#include "iki_bridge.h"
void relocate(char *);

void sensitize(char *);

void simulate(char *);

extern SYSTEMCLIB_IMP_DLLSPEC void local_register_implicit_channel(int, char*);
extern void implicit_HDL_SCinstatiate();

extern SYSTEMCLIB_IMP_DLLSPEC int xsim_argc_copy ;
extern SYSTEMCLIB_IMP_DLLSPEC char** xsim_argv_copy ;

int main(int argc, char **argv)
{
    iki_heap_initialize("ms", "isimmm", 0, 2147483648) ;
    iki_set_sv_type_file_path_name("xsim.dir/voltimetro_tb_behav/xsim.svtype");
    iki_set_crvs_dump_file_path_name("xsim.dir/voltimetro_tb_behav/xsim.crvsdump");
    void* design_handle = iki_create_design("xsim.dir/voltimetro_tb_behav/xsim.mem", (void *)relocate, (void *)sensitize, (void *)simulate, 0, isimBridge_getWdbWriter(), 0, argc, argv);
     iki_set_rc_trial_count(100);
    (void) design_handle;
    return iki_simulate_design();
}
