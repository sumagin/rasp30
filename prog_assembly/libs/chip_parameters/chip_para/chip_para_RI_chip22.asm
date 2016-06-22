/* RI (Recover Injection Above & Sub threshold) parameters */
.set RI_GATE_S_SWC, 0x0040 /* Gate(SWC) = gnd */
.set RI_VC1_SWC, 5028 /* Ivfg @Vgm=0V -> 1nA@Vgm=0.6V */
.set RI_VC2_SWC, 4899 /* Ivfg*2/5 @Vgm=0V */
.set RI_VC3_SWC, 4514 /* Ivfg*1/10 @Vgm=0V */
.set RI_VC4_SWC, 3743 /* Ivfg=1nA @Vgm=0V */
.set RI_VD1_SWC, 0xea0e /* Vd @ final stage */
.set RI_VD2_SWC, 0xfe0e /* Vd @ pre-final stage */
.set RI_INJ_T_SWC, 1 /* Injection time unit (*10us) */
.set RI_NUM_SWC, 300 /* # of Recover Injection */

.set RI_GATE_S_OTA, 0x0000 /* Gate(OTA) = 2.5V */
.set RI_VC1_OTA, 5669 /* Ivfg @Vgm=0V -> 1nA@Vgm=0.6V */
.set RI_VC2_OTA, 5476 /* Ivfg*2/5 @Vgm=0V */
.set RI_VC3_OTA, 4898 /* Ivfg*1/10 @Vgm=0V */
.set RI_VC4_OTA, 3743 /* Ivfg=1nA @Vgm=0V */
.set RI_VD1_OTA, 0xea0e /* Vd @ final stage */
.set RI_VD2_OTA, 0xfe0e /* Vd @ pre-final stage */
.set RI_INJ_T_OTA, 1 /* Injection time unit (*10us) */
.set RI_NUM_OTA, 300 /* # of Recover Injection */

.set RI_GATE_S_OTAREF, 0x0040 /* Gate(OTAREF) = gnd */
.set RI_VC1_OTAREF, 5128 /* Ivfg @Vgm=0V -> 1nA@Vgm=0.6V */
.set RI_VC2_OTAREF, 4989 /* Ivfg*2/5 @Vgm=0V */
.set RI_VC3_OTAREF, 4574 /* Ivfg*1/10 @Vgm=0V */
.set RI_VC4_OTAREF, 3743 /* Ivfg=1nA @Vgm=0V */
.set RI_VD1_OTAREF, 0xea0e /* Vd @ final stage */
.set RI_VD2_OTAREF, 0xfe0e /* Vd @ pre-final stage */
.set RI_INJ_T_OTAREF, 1 /* Injection time unit (*10us) */
.set RI_NUM_OTAREF, 300 /* # of Recover Injection */

.set RI_GATE_S_MITE, 0x3300 /* Gate(MITE) = 2.0V */
.set RI_VC1_MITE, 5936 /* Ivfg @Vgm=0V -> 1nA@Vgm=0.6V */
.set RI_VC2_MITE, 5716 /* Ivfg*2/5 @Vgm=0V */
.set RI_VC3_MITE, 5059 /* Ivfg*1/10 @Vgm=0V */
.set RI_VC4_MITE, 3743 /* Ivfg=1nA @Vgm=0V */
.set RI_VD1_MITE, 0xea0e /* Vd @ final stage */
.set RI_VD2_MITE, 0xfe0e /* Vd @ pre-final stage */
.set RI_INJ_T_MITE, 1 /* Injection time unit (*10us) */
.set RI_NUM_MITE, 300 /* # of Recover Injection */

.set RI_GATE_S_DIRSWC, 0x0100 /* Gate(DIRSWC) = 1.4V */
.set RI_VC1_DIRSWC, 5048 /* Ivfg @Vgm=0V -> 1nA@Vgm=0.6V */
.set RI_VC2_DIRSWC, 4918 /* Ivfg*2/5 @Vgm=0V */
.set RI_VC3_DIRSWC, 4526 /* Ivfg*1/10 @Vgm=0V */
.set RI_VC4_DIRSWC, 3743 /* Ivfg=1nA @Vgm=0V */
.set RI_VD1_DIRSWC, 0xea0e /* Vd @ final stage */
.set RI_VD2_DIRSWC, 0xfe0e /* Vd @ pre-final stage */
.set RI_INJ_T_DIRSWC, 1 /* Injection time unit (*10us) */
.set RI_NUM_DIRSWC, 300 /* # of Recover Injection */

/* RIL (Recover Injection low sub threshold) parameters */
.set RIL_GATE_S_SWC, 0x0040 /* Gate(SWC) = gnd */
.set RIL_VC1_SWC, 3743 /* Ivfg=1n A@Vgm=0V */
.set RIL_VC2_SWC, 3497 /* Ivfg=lowest current @Vgm=0V */
.set RIL_VD1_SWC, 0xea0e /* Vd @ final stage */
.set RIL_INJ_T_SWC, 1 /* Injection time unit (*10us) */
.set RIL_NUM_SWC, 300 /* # of Recover Injection */

.set RIL_GATE_S_OTA, 0x0000 /* Gate(OTA) = 2.5V */
.set RIL_VC1_OTA, 3743 /* Ivfg=1n A@Vgm=0V */
.set RIL_VC2_OTA, 3538 /* Ivfg=lowest current @Vgm=0V */
.set RIL_VD1_OTA, 0xea0e /* Vd @ final stage */
.set RIL_INJ_T_OTA, 1 /* Injection time unit (*10us) */
.set RIL_NUM_OTA, 300 /* # of Recover Injection */

.set RIL_GATE_S_OTAREF, 0x0040 /* Gate(OTAREF) = gnd */
.set RIL_VC1_OTAREF, 3743 /* Ivfg=1n A@Vgm=0V */
.set RIL_VC2_OTAREF, 3561 /* Ivfg=lowest current @Vgm=0V */
.set RIL_VD1_OTAREF, 0xea0e /* Vd @ final stage */
.set RIL_INJ_T_OTAREF, 1 /* Injection time unit (*10us) */
.set RIL_NUM_OTAREF, 300 /* # of Recover Injection */

.set RIL_GATE_S_MITE, 0x3300 /* Gate(MITE) = 2.0V */
.set RIL_VC1_MITE, 3743 /* Ivfg=1n A@Vgm=0V */
.set RIL_VC2_MITE, 3566 /* Ivfg=lowest current @Vgm=0V */
.set RIL_VD1_MITE, 0xea0e /* Vd @ final stage */
.set RIL_INJ_T_MITE, 1 /* Injection time unit (*10us) */
.set RIL_NUM_MITE, 300 /* # of Recover Injection */

.set RIL_GATE_S_DIRSWC, 0x0100 /* Gate(DIRSWC) = 1.4V */
.set RIL_VC1_DIRSWC, 3743 /* Ivfg=1n A@Vgm=0V */
.set RIL_VC2_DIRSWC, 3579 /* Ivfg=lowest current @Vgm=0V */
.set RIL_VD1_DIRSWC, 0xea0e /* Vd @ final stage */
.set RIL_INJ_T_DIRSWC, 1 /* Injection time unit (*10us) */
.set RIL_NUM_DIRSWC, 300 /* # of Recover Injection */

