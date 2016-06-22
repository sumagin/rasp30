/**********************************/
/* FP (Fine Program) parameters   */
/**********************************/
.set ADC_1nA, 2360 /* 1nA ADC value */

/* Vg decreased because of increasement in diode ADC (+150) */

/* sub threshold */
.set FPS_GATE_S_SWC, 0x2800 /*0x2400 /* Gate(SWC) = 3.0V @ IVDD 6.0V */
.set FPS_INJ_T_SWC, 1 /* Injection time (*10us) */
.set FPS_NUM_SWC, 50 /* # of Fine Progrm */
.set FPS_VD_A_SWC, 8 /* Vd constant A */
.set FPS_VD_B_SWC, 5 /* Vd constant B */
.set FPS_VD_OS_SWC, 40 /* Vd table offset */
.set FPS_VD_SA_SWC, 0 /* 0:Subtraction 1:Add */
.set FPS_VD_GND_SWC, 0 /* 0:Vd table 1:GND */
.set FPS_GATE_S_OTA, 0x2800 /*0x2400 /* Gate(OTA) = 3.0V @ IVDD 6.0V */
.set FPS_INJ_T_OTA, 1 /* Injection time (*10us) */
.set FPS_NUM_OTA, 50 /* # of Fine Progrm */
.set FPS_VD_A_OTA, 8 /* Vd constant A */
.set FPS_VD_B_OTA, 5 /* Vd constant B */
.set FPS_VD_OS_OTA, 50 /* 47 /* Vd table offset */
.set FPS_VD_SA_OTA, 0 /* 0:Subtraction 1:Add */
.set FPS_VD_GND_OTA, 0 /* 0:Vd table 1:GND */
.set FPS_GATE_S_OTAREF, 0x2800 /*0x2400 /* Gate(OTAREF) = 3.0V @ IVDD 6.0V */
.set FPS_INJ_T_OTAREF, 2 /* Injection time (*10us) */
.set FPS_NUM_OTAREF, 50 /* # of Fine Progrm */
.set FPS_VD_A_OTAREF, 8 /* Vd constant A */
.set FPS_VD_B_OTAREF, 5 /* Vd constant B */
.set FPS_VD_OS_OTAREF, 53 /* Vd table offset */
.set FPS_VD_SA_OTAREF, 0 /* 0:Subtraction 1:Add */
.set FPS_VD_GND_OTAREF, 0 /* 0:Vd table 1:GND */
.set FPS_GATE_S_MITE, 0x2800 /*0x2400 /* Gate(MITE) = 3.0V @ IVDD 6.0V */
.set FPS_INJ_T_MITE, 1 /* Injection time (*10us) */
.set FPS_NUM_MITE, 50 /* # of Fine Progrm */
.set FPS_VD_A_MITE, 8 /* Vd constant A */
.set FPS_VD_B_MITE, 5 /* Vd constant B */
.set FPS_VD_OS_MITE, 54 /* 49 /* Vd table offset */
.set FPS_VD_SA_MITE, 0 /* 0:Subtraction 1:Add */
.set FPS_VD_GND_MITE, 0 /* 0:Vd table 1:GND */
.set FPS_GATE_S_DIRSWC, 0x2800 /* Gate(DIRSWC) = 3.0V @ IVDD 6.0V */
.set FPS_INJ_T_DIRSWC, 1 /* Injection time (*10us) */
.set FPS_NUM_DIRSWC, 50 /* # of Fine Progrm */
.set FPS_VD_A_DIRSWC, 8 /* Vd constant A */
.set FPS_VD_B_DIRSWC, 5 /* Vd constant B */
.set FPS_VD_OS_DIRSWC, 46 /* 40 /* Vd table offset */
.set FPS_VD_SA_DIRSWC, 0 /* 0:Subtraction 1:Add */
.set FPS_VD_GND_DIRSWC, 0 /* 0:Vd table 1:GND */

/* above threshold */
.set FPA_GATE_S_SWC, 0x2A00 /*0x2400 /* Gate(SWC) = 3.0V @ IVDD 6.0V */
.set FPA_INJ_T_SWC, 1 /* Injection time (*10us) */
.set FPA_NUM_SWC, 50 /* # of Fine Progrm */
.set FPA_VD_A_SWC, 8 /* Vd constant A */
.set FPA_VD_B_SWC, 5 /* Vd constant B */
.set FPA_VD_OS_SWC, 38 /* 28 /* Vd table offset */
.set FPA_VD_SA_SWC, 1 /* 0:Subtraction 1:Add */
.set FPA_VD_GND_SWC, 0 /* 0:Vd table 1:GND */
.set FPA_GATE_S_OTA, 0x2800 /*0x2400 /* Gate(OTA) = 3.0V @ IVDD 6.0V */
.set FPA_INJ_T_OTA, 1 /* Injection time (*10us) */
.set FPA_NUM_OTA, 50 /* # of Fine Progrm */
.set FPA_VD_A_OTA, 8 /* Vd constant A */
.set FPA_VD_B_OTA, 5 /* Vd constant B */
.set FPA_VD_OS_OTA, 44 /* 34 /* Vd table offset */
.set FPA_VD_SA_OTA, 1 /* 0:Subtraction 1:Add */
.set FPA_VD_GND_OTA, 0 /* 0:Vd table 1:GND */
.set FPA_GATE_S_OTAREF, 0x3000 /*0x2400 /* Gate(OTAREF) = 3.0V @ IVDD 6.0V */
.set FPA_INJ_T_OTAREF, 2 /* Injection time (*10us) */
.set FPA_NUM_OTAREF, 50 /* # of Fine Progrm */
.set FPA_VD_A_OTAREF, 8 /* Vd constant A */
.set FPA_VD_B_OTAREF, 5 /* Vd constant B */
.set FPA_VD_OS_OTAREF, 45 /* 35 /* Vd table offset */
.set FPA_VD_SA_OTAREF, 1 /* 0:Subtraction 1:Add */
.set FPA_VD_GND_OTAREF, 0 /* 0:Vd table 1:GND */
.set FPA_GATE_S_MITE, 0x2E00 /*0x2400 /* Gate(MITE) = 3.0V @ IVDD 6.0V */
.set FPA_INJ_T_MITE, 1 /* Injection time (*10us) */
.set FPA_NUM_MITE, 50 /* # of Fine Progrm */
.set FPA_VD_A_MITE, 8 /* Vd constant A */
.set FPA_VD_B_MITE, 5 /* Vd constant B */
.set FPA_VD_OS_MITE, 47 /* 37 /* Vd table offset */
.set FPA_VD_SA_MITE, 1 /* 0:Subtraction 1:Add */
.set FPA_VD_GND_MITE, 0 /* 0:Vd table 1:GND */
.set FPA_GATE_S_DIRSWC, 0x2800 /*0x2400 /* Gate(DIRSWC) = 3.0V @ IVDD 6.0V */
.set FPA_INJ_T_DIRSWC, 1 /* Injection time (*10us) */
.set FPA_NUM_DIRSWC, 50 /* # of Fine Progrm */
.set FPA_VD_A_DIRSWC, 8 /* Vd constant A */
.set FPA_VD_B_DIRSWC, 5 /* Vd constant B */
.set FPA_VD_OS_DIRSWC, 41 /* 30 /* Vd table offset */
.set FPA_VD_SA_DIRSWC, 1 /* 0:Subtraction 1:Add */
.set FPA_VD_GND_DIRSWC, 0 /* 0:Vd table 1:GND */

/* low sub threshold */
.set FPL_GATE_S_SWC, 0x0040 /* Gate(SWC) = gnd */
.set FPL_INJ_T_SWC, 1 /* Injection time (*10us) */
.set FPL_NUM_SWC, 50 /* # of Fine Progrm */
.set FPL_VD_A_SWC, 8 /* Vd constant A */
.set FPL_VD_B_SWC, 5 /* Vd constant B */
.set FPL_VD_OS_SWC, 54 /* 50 /* Vd table offset */
.set FPL_VD_SA_SWC, 1 /* 0:Subtraction 1:Add */
.set FPL_VD_GND_SWC, 0 /* 0:Vd table 1:GND */
.set FPL_GATE_S_OTA, 0x3300 /* Gate(OTA) = 2.4V */
.set FPL_INJ_T_OTA, 1 /* Injection time (*10us) */
.set FPL_NUM_OTA, 50 /* # of Fine Progrm */
.set FPL_VD_A_OTA, 8 /* Vd constant A */
.set FPL_VD_B_OTA, 5 /* Vd constant B */
.set FPL_VD_OS_OTA, 48 /* 44 /* Vd table offset */
.set FPL_VD_SA_OTA, 1 /* 0:Subtraction 1:Add */
.set FPL_VD_GND_OTA, 0 /* 0:Vd table 1:GND */
.set FPL_GATE_S_OTAREF, 0x0040 /* Gate(OTAREF) = gnd */
.set FPL_INJ_T_OTAREF, 1 /* Injection time (*10us) */
.set FPL_NUM_OTAREF, 50 /* # of Fine Progrm */
.set FPL_VD_A_OTAREF, 8 /* Vd constant A */
.set FPL_VD_B_OTAREF, 5 /* Vd constant B */
.set FPL_VD_OS_OTAREF, 58 /* 54 /* Vd table offset */
.set FPL_VD_SA_OTAREF, 1 /* 0:Subtraction 1:Add */
.set FPL_VD_GND_OTAREF, 0 /* 0:Vd table 1:GND */
.set FPL_GATE_S_MITE, 0x2900 /* Gate(MITE) = 2.2V */
.set FPL_INJ_T_MITE, 1 /* Injection time (*10us) */
.set FPL_NUM_MITE, 50 /* # of Fine Progrm */
.set FPL_VD_A_MITE, 8 /* Vd constant A */
.set FPL_VD_B_MITE, 5 /* Vd constant B */
.set FPL_VD_OS_MITE, 56 /* 47 /* Vd table offset */
.set FPL_VD_SA_MITE, 1 /* 0:Subtraction 1:Add */
.set FPL_VD_GND_MITE, 0 /* 0:Vd table 1:GND */
.set FPL_GATE_S_DIRSWC, 0x0100 /* Gate(DIRSWC) = 1.5V */
.set FPL_INJ_T_DIRSWC, 1 /* Injection time (*10us) */
.set FPL_NUM_DIRSWC, 50 /* # of Fine Progrm */
.set FPL_VD_A_DIRSWC, 8 /* Vd constant A */
.set FPL_VD_B_DIRSWC, 5 /* Vd constant B */
.set FPL_VD_OS_DIRSWC, 52 /* 48 /* Vd table offset */
.set FPL_VD_SA_DIRSWC, 1 /* 0:Subtraction 1:Add */
.set FPL_VD_GND_DIRSWC, 0 /* 0:Vd table 1:GND */
