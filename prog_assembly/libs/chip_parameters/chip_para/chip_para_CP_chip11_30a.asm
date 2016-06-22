/**********************************/
/* CP (Coarse Program) parameters */
/**********************************/
.set ADC_1nA, 4630 /* 1nA ADC value */

/* above & sub threshold */
.set CP_GATE_S_SWC, 0x0100 /* Gate(SWC) = 3.5V @ IVDD 6.0V */
.set CP_INJ_T_SWC, 1 /* Injection time (*10us) */
.set CP_NUM_SWC, 20 /* # of Measured Coarse Progrm */
.set CP_GATE_S_OTA, 0x0100
.set CP_INJ_T_OTA, 1
.set CP_NUM_OTA, 20 
.set CP_GATE_S_OTAREF, 0x0100
.set CP_INJ_T_OTAREF, 2
.set CP_NUM_OTAREF, 20 
.set CP_GATE_S_MITE, 0x0100
.set CP_INJ_T_MITE, 1
.set CP_NUM_MITE, 20 
.set CP_GATE_S_DIRSWC, 0x0100
.set CP_INJ_T_DIRSWC, 1
.set CP_NUM_DIRSWC, 20 

/* low sub threshold */
.set CPL_GATE_S_SWC, 0x0040
.set CPL_INJ_T_SWC, 1 
.set CPL_NUM_SWC, 20 
.set CPL_GATE_S_OTA, 0x0030
.set CPL_INJ_T_OTA, 1
.set CPL_NUM_OTA, 20 
.set CPL_GATE_S_OTAREF, 0x0040
.set CPL_INJ_T_OTAREF, 1
.set CPL_NUM_OTAREF, 20 
.set CPL_GATE_S_MITE, 0x0030
.set CPL_INJ_T_MITE, 1
.set CPL_NUM_MITE, 20 
.set CPL_GATE_S_DIRSWC, 0x0130
.set CPL_INJ_T_DIRSWC, 1
.set CPL_NUM_DIRSWC, 20 

/* high above threshold */
.set CPH_GATE_S_SWC, 0x0000
.set CPH_INJ_T_SWC, 1
.set CPH_GATE_S_OTA, 0x0000
.set CPH_INJ_T_OTA, 20


