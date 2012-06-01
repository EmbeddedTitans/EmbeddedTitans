/**********************************************************************/
/*   ____  ____                                                       */
/*  /   /\/   /                                                       */
/* /___/  \  /                                                        */
/* \   \   \/                                                       */
/*  \   \        Copyright (c) 2003-2009 Xilinx, Inc.                */
/*  /   /          All Right Reserved.                                 */
/* /---/   /\                                                         */
/* \   \  /  \                                                      */
/*  \___\/\___\                                                    */
/***********************************************************************/

/* This file is designed for use with ISim build 0x2f00eba5 */

#define XSI_HIDE_SYMBOL_SPEC true
#include "xsi.h"
#include <memory.h>
#ifdef __GNUC__
#include <stdlib.h>
#else
#include <malloc.h>
#define alloca _alloca
#endif
static const char *ng0 = "C:/Documents and Settings/AssA/Moje dokumenty/Xilinx/EmbeddedTitans/nvsramSim.vhd";



static void work_a_1112788267_3212880686_p_0(char *t0)
{
    unsigned char t1;
    char *t2;
    unsigned char t3;
    char *t4;
    char *t5;
    unsigned char t6;
    unsigned char t7;
    unsigned char t8;
    unsigned char t9;
    unsigned char t10;
    char *t11;
    unsigned char t12;
    unsigned char t13;
    char *t14;
    unsigned char t15;
    unsigned char t16;
    char *t17;
    unsigned char t18;
    unsigned char t19;
    char *t20;
    unsigned char t22;
    unsigned int t23;
    char *t24;
    char *t25;
    char *t26;
    char *t28;
    char *t29;
    char *t30;
    char *t31;
    char *t32;

LAB0:    xsi_set_current_line(22, ng0);
    t2 = (t0 + 1028U);
    t3 = xsi_signal_has_event(t2);
    if (t3 == 1)
        goto LAB5;

LAB6:    t1 = (unsigned char)0;

LAB7:    if (t1 != 0)
        goto LAB2;

LAB4:
LAB3:    t2 = (t0 + 1908);
    *((int *)t2) = 1;

LAB1:    return;
LAB2:    xsi_set_current_line(23, ng0);
    t4 = (t0 + 776U);
    t11 = *((char **)t4);
    t12 = *((unsigned char *)t11);
    t13 = (t12 == (unsigned char)3);
    if (t13 == 1)
        goto LAB17;

LAB18:    t10 = (unsigned char)0;

LAB19:    if (t10 == 1)
        goto LAB14;

LAB15:    t9 = (unsigned char)0;

LAB16:    if (t9 == 1)
        goto LAB11;

LAB12:    t8 = (unsigned char)0;

LAB13:    if (t8 != 0)
        goto LAB8;

LAB10:    xsi_set_current_line(26, ng0);
    t2 = (t0 + 3586);
    t5 = (t0 + 1952);
    t11 = (t5 + 32U);
    t14 = *((char **)t11);
    t17 = (t14 + 40U);
    t20 = *((char **)t17);
    memcpy(t20, t2, 8U);
    xsi_driver_first_trans_fast_port(t5);

LAB9:    goto LAB3;

LAB5:    t4 = (t0 + 1052U);
    t5 = *((char **)t4);
    t6 = *((unsigned char *)t5);
    t7 = (t6 == (unsigned char)3);
    t1 = t7;
    goto LAB7;

LAB8:    xsi_set_current_line(24, ng0);
    t26 = (t0 + 3578);
    t28 = (t0 + 1952);
    t29 = (t28 + 32U);
    t30 = *((char **)t29);
    t31 = (t30 + 40U);
    t32 = *((char **)t31);
    memcpy(t32, t26, 8U);
    xsi_driver_first_trans_fast_port(t28);
    goto LAB9;

LAB11:    t4 = (t0 + 592U);
    t20 = *((char **)t4);
    t4 = (t0 + 3567);
    t22 = 1;
    if (11U == 11U)
        goto LAB20;

LAB21:    t22 = 0;

LAB22:    t8 = t22;
    goto LAB13;

LAB14:    t4 = (t0 + 960U);
    t17 = *((char **)t4);
    t18 = *((unsigned char *)t17);
    t19 = (t18 == (unsigned char)2);
    t9 = t19;
    goto LAB16;

LAB17:    t4 = (t0 + 868U);
    t14 = *((char **)t4);
    t15 = *((unsigned char *)t14);
    t16 = (t15 == (unsigned char)3);
    t10 = t16;
    goto LAB19;

LAB20:    t23 = 0;

LAB23:    if (t23 < 11U)
        goto LAB24;
    else
        goto LAB22;

LAB24:    t24 = (t20 + t23);
    t25 = (t4 + t23);
    if (*((unsigned char *)t24) != *((unsigned char *)t25))
        goto LAB21;

LAB25:    t23 = (t23 + 1);
    goto LAB23;

}


extern void work_a_1112788267_3212880686_init()
{
	static char *pe[] = {(void *)work_a_1112788267_3212880686_p_0};
	xsi_register_didat("work_a_1112788267_3212880686", "isim/testFSMD_isim_beh.exe.sim/work/a_1112788267_3212880686.didat");
	xsi_register_executes(pe);
}
