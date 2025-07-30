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
extern void execute_5(char*, char *);
extern void execute_7(char*, char *);
extern void execute_8(char*, char *);
extern void execute_225(char*, char *);
extern void execute_226(char*, char *);
extern void execute_227(char*, char *);
extern void execute_24(char*, char *);
extern void execute_40(char*, char *);
extern void execute_56(char*, char *);
extern void execute_72(char*, char *);
extern void execute_88(char*, char *);
extern void execute_104(char*, char *);
extern void execute_120(char*, char *);
extern void execute_136(char*, char *);
extern void execute_152(char*, char *);
extern void execute_168(char*, char *);
extern void execute_184(char*, char *);
extern void execute_200(char*, char *);
extern void execute_203(char*, char *);
extern void execute_205(char*, char *);
extern void execute_207(char*, char *);
extern void execute_209(char*, char *);
extern void execute_211(char*, char *);
extern void execute_213(char*, char *);
extern void execute_215(char*, char *);
extern void execute_217(char*, char *);
extern void execute_219(char*, char *);
extern void execute_221(char*, char *);
extern void execute_223(char*, char *);
extern void execute_21(char*, char *);
extern void execute_22(char*, char *);
extern void execute_23(char*, char *);
extern void execute_12(char*, char *);
extern void execute_13(char*, char *);
extern void execute_20(char*, char *);
extern void execute_15(char*, char *);
extern void execute_17(char*, char *);
extern void transaction_0(char*, char*, unsigned, unsigned, unsigned);
extern void vhdl_transfunc_eventcallback(char*, char*, unsigned, unsigned, unsigned, char *);
funcp funcTab[41] = {(funcp)execute_3, (funcp)execute_4, (funcp)execute_5, (funcp)execute_7, (funcp)execute_8, (funcp)execute_225, (funcp)execute_226, (funcp)execute_227, (funcp)execute_24, (funcp)execute_40, (funcp)execute_56, (funcp)execute_72, (funcp)execute_88, (funcp)execute_104, (funcp)execute_120, (funcp)execute_136, (funcp)execute_152, (funcp)execute_168, (funcp)execute_184, (funcp)execute_200, (funcp)execute_203, (funcp)execute_205, (funcp)execute_207, (funcp)execute_209, (funcp)execute_211, (funcp)execute_213, (funcp)execute_215, (funcp)execute_217, (funcp)execute_219, (funcp)execute_221, (funcp)execute_223, (funcp)execute_21, (funcp)execute_22, (funcp)execute_23, (funcp)execute_12, (funcp)execute_13, (funcp)execute_20, (funcp)execute_15, (funcp)execute_17, (funcp)transaction_0, (funcp)vhdl_transfunc_eventcallback};
const int NumRelocateId= 41;

void relocate(char *dp)
{
	iki_relocate(dp, "xsim.dir/cont_3300_tb_behav/xsim.reloc",  (void **)funcTab, 41);

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
