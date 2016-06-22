/* RI (Recover Injection Above & Sub threshold) parameters */
.set RI_GATE_S_SWC, 0x0040 /* Gate(SWC) = gnd */
.set RI_VC1_SWC, 6518 /* Ivfg @Vgm=0V -> 1nA@Vgm=0.6V */
.set RI_VC2_SWC, 6329 /* Ivfg*2/5 @Vgm=0V */
.set RI_VC3_SWC, 5763 /* Ivfg*1/10 @Vgm=0V */
.set RI_VC4_SWC, 4630 /* Ivfg=1nA @Vgm=0V */
.set RI_VD1_SWC, 0xea0e /* Vd @ final stage */
.set RI_VD2_SWC, 0xfe0e /* Vd @ pre-final stage */
.set RI_INJ_T_SWC, 1 /* Injection time unit (*10us) */
.set RI_NUM_SWC, 300 /* # of Recover Injection */

.set RI_GATE_S_OTA, 0x0030 /* Gate(OTA) = gnd */
.set RI_VC1_OTA, 7645 /* Ivfg @Vgm=0V -> 1nA@Vgm=0.6V */
.set RI_VC2_OTA, 7344 /* Ivfg*2/5 @Vgm=0V */
.set RI_VC3_OTA, 6439 /* Ivfg*1/10 @Vgm=0V */
.set RI_VC4_OTA, 4630 /* Ivfg=1nA @Vgm=0V */
.set RI_VD1_OTA, 0xea0e /* Vd @ final stage */
.set RI_VD2_OTA, 0xfe0e /* Vd @ pre-final stage */
.set RI_INJ_T_OTA, 1 /* Injection time unit (*10us) */
.set RI_NUM_OTA, 300 /* # of Recover Injection */

.set RI_GATE_S_OTAREF, 0x0040 /* Gate(OTAREF) = gnd */
.set RI_VC1_OTAREF, 6680 /* Ivfg @Vgm=0V -> 1nA@Vgm=0.6V */
.set RI_VC2_OTAREF, 6475 /* Ivfg*2/5 @Vgm=0V */
.set RI_VC3_OTAREF, 5860 /* Ivfg*1/10 @Vgm=0V */
.set RI_VC4_OTAREF, 4630 /* Ivfg=1nA @Vgm=0V */
.set RI_VD1_OTAREF, 0xea0e /* Vd @ final stage */
.set RI_VD2_OTAREF, 0xfe0e /* Vd @ pre-final stage */
.set RI_INJ_T_OTAREF, 1 /* Injection time unit (*10us) */
.set RI_NUM_OTAREF, 300 /* # of Recover Injection */

.set RI_GATE_S_MITE, 0x0030 /* Gate(MITE) */
.set RI_VC1_MITE, 8096 /* Ivfg @Vgm=0V -> 1nA@Vgm=0.6V */
.set RI_VC2_MITE, 7749 /* Ivfg*2/5 @Vgm=0V */
.set RI_VC3_MITE, 6709 /* Ivfg*1/10 @Vgm=0V */
.set RI_VC4_MITE, 4630 /* Ivfg=1nA @Vgm=0V */
.set RI_VD1_MITE, 0xea0e /* Vd @ final stage */
.set RI_VD2_MITE, 0xfe0e /* Vd @ pre-final stage */
.set RI_INJ_T_MITE, 1 /* Injection time unit (*10us) */
.set RI_NUM_MITE, 300 /* # of Recover Injection */

.set RI_GATE_S_DIRSWC, 0x0130 /* Gate(DIRSWC) = gnd */
.set RI_VC1_DIRSWC, 6613 /* Ivfg @Vgm=0V -> 1nA@Vgm=0.6V */
.set RI_VC2_DIRSWC, 6415 /* Ivfg*2/5 @Vgm=0V */
.set RI_VC3_DIRSWC, 5820 /* Ivfg*1/10 @Vgm=0V */
.set RI_VC4_DIRSWC, 4630 /* Ivfg=1nA @Vgm=0V */
.set RI_VD1_DIRSWC, 0xea0e /* Vd @ final stage */
.set RI_VD2_DIRSWC, 0xfe0e /* Vd @ pre-final stage */
.set RI_INJ_T_DIRSWC, 1 /* Injection time unit (*10us) */
.set RI_NUM_DIRSWC, 300 /* # of Recover Injection */

/* RIL (Recover Injection low sub threshold) parameters */
.set RIL_GATE_S_SWC, 0x0040 /* Gate(SWC) = gnd */
.set RIL_VC1_SWC, 4630 /* Ivfg=1n A@Vgm=0V */
.set RIL_VC2_SWC, 4172 /* Ivfg=lowest current @Vgm=0V */
.set RIL_VD1_SWC, 0xea0e /* Vd @ final stage */
.set RIL_INJ_T_SWC, 1 /* Injection time unit (*10us) */
.set RIL_NUM_SWC, 300 /* # of Recover Injection */

.set RIL_GATE_S_OTA, 0x0030 /* Gate(OTA) = gnd */
.set RIL_VC1_OTA, 4630 /* Ivfg=1n A@Vgm=0V */
.set RIL_VC2_OTA, 4173 /* Ivfg=lowest current @Vgm=0V */
.set RIL_VD1_OTA, 0xea0e /* Vd @ final stage */
.set RIL_INJ_T_OTA, 1 /* Injection time unit (*10us) */
.set RIL_NUM_OTA, 300 /* # of Recover Injection */

.set RIL_GATE_S_OTAREF, 0x0040 /* Gate(OTAREF) = gnd */
.set RIL_VC1_OTAREF, 4630 /* Ivfg=1n A@Vgm=0V */
.set RIL_VC2_OTAREF, 4167 /* Ivfg=lowest current @Vgm=0V */
.set RIL_VD1_OTAREF, 0x0026 /* Vd @ final stage */
.set RIL_INJ_T_OTAREF, 1 /* Injection time unit (*10us) */
.set RIL_NUM_OTAREF, 300 /* # of Recover Injection */

.set RIL_GATE_S_MITE, 0x0030 /* Gate(MITE) = gnd */
.set RIL_VC1_MITE, 4630 /* Ivfg=1n A@Vgm=0V */
.set RIL_VC2_MITE, 4155 /* Ivfg=lowest current @Vgm=0V */
.set RIL_VD1_MITE, 0xea0e /* Vd @ final stage */
.set RIL_INJ_T_MITE, 1 /* Injection time unit (*10us) */
.set RIL_NUM_MITE, 300 /* # of Recover Injection */

.set RIL_GATE_S_DIRSWC, 0x0130 /* Gate(DIRSWC) = gnd */
.set RIL_VC1_DIRSWC, 4630 /* Ivfg=1n A@Vgm=0V */
.set RIL_VC2_DIRSWC, 4173 /* Ivfg=lowest current @Vgm=0V */
.set RIL_VD1_DIRSWC, 0xba0e /* Vd @ final stage */
.set RIL_INJ_T_DIRSWC, 1 /* Injection time unit (*10us) */
.set RIL_NUM_DIRSWC, 300 /* # of Recover Injection */

