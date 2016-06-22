/**********************************/
/* CP (Coarse Program) parameters */
/**********************************/
.set ADC_1nA, 4129 /* 1nA ADC value */

/* above & sub threshold */
.set CP_GATE_S_SWC, 0x2600 /* Gate(SWC) = 3.0V @ IVDD 6.0V */
.set CP_INJ_T_SWC, 1 /* Injection time (*10us) */
.set CP_NUM_SWC, 20 /* # of Measured Coarse Progrm */
.set CP_GATE_S_OTA, 0x2600 /* Gate(OTA) = 3.0V @ IVDD 6.0V */
.set CP_INJ_T_OTA, 1 /* Injection time (*10us) */
.set CP_NUM_OTA, 20 /* # of Measured Coarse Progrm */
.set CP_GATE_S_OTAREF, 0x2600 /* Gate(OTAREF) = 3.0V @ IVDD 6.0V */
.set CP_INJ_T_OTAREF, 2 /* Injection time (*10us) */
.set CP_NUM_OTAREF, 20 /* # of Measured Coarse Progrm */
.set CP_GATE_S_MITE, 0x2600 /* Gate(MITE) = 3.0V @ IVDD 6.0V */
.set CP_INJ_T_MITE, 1 /* Injection time (*10us) */
.set CP_NUM_MITE, 20 /* # of Measured Coarse Progrm */
.set CP_GATE_S_DIRSWC, 0x2600 /* Gate(DIRSWC) = 3.0V @ IVDD 6.0V */
.set CP_INJ_T_DIRSWC, 1 /* Injection time (*10us) */
.set CP_NUM_DIRSWC, 20 /* # of Measured Coarse Progrm */

/* low sub threshold */
.set CPL_GATE_S_SWC, 0x0040 /* Gate(SWC) = gnd */
.set CPL_INJ_T_SWC, 1 /* Injection time (*10us) */
.set CPL_NUM_SWC, 20 /* # of Measured Coarse Progrm */
.set CPL_GATE_S_OTA, 0x3500 /* Gate(OTA) = 2.4V */
.set CPL_INJ_T_OTA, 1 /* Injection time (*10us) */
.set CPL_NUM_OTA, 20 /* # of Measured Coarse Progrm */
.set CPL_GATE_S_OTAREF, 0x0040 /* Gate(OTAREF) = gnd */
.set CPL_INJ_T_OTAREF, 1 /* Injection time (*10us) */
.set CPL_NUM_OTAREF, 20 /* # of Measured Coarse Progrm */
.set CPL_GATE_S_MITE, 0x2d00 /* Gate(MITE) = 2.2V */
.set CPL_INJ_T_MITE, 1 /* Injection time (*10us) */
.set CPL_NUM_MITE, 20 /* # of Measured Coarse Progrm */
.set CPL_GATE_S_DIRSWC, 0x0700 /* Gate(DIRSWC) = 1.5V */
.set CPL_INJ_T_DIRSWC, 1 /* Injection time (*10us) */
.set CPL_NUM_DIRSWC, 20 /* # of Measured Coarse Progrm */
