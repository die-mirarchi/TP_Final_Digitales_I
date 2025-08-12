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
extern void execute_3(char*, char *);
extern void execute_4(char*, char *);
extern void execute_6(char*, char *);
extern void execute_7(char*, char *);
extern void execute_350(char*, char *);
extern void execute_351(char*, char *);
extern void execute_352(char*, char *);
extern void execute_23(char*, char *);
extern void execute_39(char*, char *);
extern void execute_55(char*, char *);
extern void execute_71(char*, char *);
extern void execute_87(char*, char *);
extern void execute_103(char*, char *);
extern void execute_119(char*, char *);
extern void execute_135(char*, char *);
extern void execute_151(char*, char *);
extern void execute_167(char*, char *);
extern void execute_183(char*, char *);
extern void execute_199(char*, char *);
extern void execute_215(char*, char *);
extern void execute_231(char*, char *);
extern void execute_247(char*, char *);
extern void execute_263(char*, char *);
extern void execute_279(char*, char *);
extern void execute_295(char*, char *);
extern void execute_311(char*, char *);
extern void execute_314(char*, char *);
extern void execute_316(char*, char *);
extern void execute_318(char*, char *);
extern void execute_320(char*, char *);
extern void execute_322(char*, char *);
extern void execute_324(char*, char *);
extern void execute_326(char*, char *);
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
extern void execute_20(char*, char *);
extern void execute_21(char*, char *);
extern void execute_22(char*, char *);
extern void execute_11(char*, char *);
extern void execute_12(char*, char *);
extern void execute_19(char*, char *);
extern void execute_14(char*, char *);
extern void execute_16(char*, char *);
extern void transaction_0(char*, char*, unsigned, unsigned, unsigned);
extern void vhdl_transfunc_eventcallback(char*, char*, unsigned, unsigned, unsigned, char *);
funcp funcTab[54] = {(funcp)execute_3, (funcp)execute_4, (funcp)execute_6, (funcp)execute_7, (funcp)execute_350, (funcp)execute_351, (funcp)execute_352, (funcp)execute_23, (funcp)execute_39, (funcp)execute_55, (funcp)execute_71, (funcp)execute_87, (funcp)execute_103, (funcp)execute_119, (funcp)execute_135, (funcp)execute_151, (funcp)execute_167, (funcp)execute_183, (funcp)execute_199, (funcp)execute_215, (funcp)execute_231, (funcp)execute_247, (funcp)execute_263, (funcp)execute_279, (funcp)execute_295, (funcp)execute_311, (funcp)execute_314, (funcp)execute_316, (funcp)execute_318, (funcp)execute_320, (funcp)execute_322, (funcp)execute_324, (funcp)execute_326, (funcp)execute_328, (funcp)execute_330, (funcp)execute_332, (funcp)execute_334, (funcp)execute_336, (funcp)execute_338, (funcp)execute_340, (funcp)execute_342, (funcp)execute_344, (funcp)execute_346, (funcp)execute_348, (funcp)execute_20, (funcp)execute_21, (funcp)execute_22, (funcp)execute_11, (funcp)execute_12, (funcp)execute_19, (funcp)execute_14, (funcp)execute_16, (funcp)transaction_0, (funcp)vhdl_transfunc_eventcallback};
const int NumRelocateId= 54;

void relocate(char *dp)
{
	iki_relocate(dp, "xsim.dir/cont_3300_tb_behav/xsim.reloc",  (void **)funcTab, 54);

	/*Populate the transaction function pointer field in the whole net structure */
}

void sensitize(char *dp)
{
	iki_sensitize(dp, "xsim.dir/cont_3300_tb_behav/xsim.reloc");
}

void simulate(char *dp)
{
		iki_schedule_processes_at_time_zero(dp, "xsim.dir/cont_3300_tb_behav/xsim.reloc");
	// Initialize Verilog nets in mixed simulation, for the cases when the value at time 0 should be propagated from the mixed language Vhdl net
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
    iki_set_sv_type_file_path_name("xsim.dir/cont_3300_tb_behav/xsim.svtype");
    iki_set_crvs_dump_file_path_name("xsim.dir/cont_3300_tb_behav/xsim.crvsdump");
    void* design_handle = iki_create_design("xsim.dir/cont_3300_tb_behav/xsim.mem", (void *)relocate, (void *)sensitize, (void *)simulate, 0, isimBridge_getWdbWriter(), 0, argc, argv);
     iki_set_rc_trial_count(100);
    (void) design_handle;
    return iki_simulate_design();
}
