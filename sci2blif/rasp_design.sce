// clear the console window
clc 

//Turn off the warning messages in the console
previousprot = funcprot(1) //integer with possible values 0, 1, 2 returns previous value
funcprot(0) //allows the user to specify what scilab do when such variables are redefined. 0=nothing, 1=warning, 2=error
// Import some useful Xcos macros into Scilab.
loadXcosLibs(); 

//Loads all .sci files (containing Scilab functions) defined in the path directory.

//SUMA-UBUNTU
getd('/home/ubuntu/rasp30/xcos_blocks/') ;

home_dir = '/home/ubuntu/rasp30/xcos_blocks/';

//Create custon palette for all blocks

pal1 = xcosPal("Level One"); //Instanciate a new xcos palette
pal2 = xcosPal("Level Two");
pal3 = xcosPal("Digital Blocks");
pal4 = xcosPal("Input & Output Blocks");
pal5 = xcosPal("Complex Blocks");
pal6 = xcosPal("Build a Block")
pal7 = xcosPal("Modelica Blocks")

// Add blocks to the palette

//Create block icon

//Set the style of each icon
style= struct();
style.noLabel=0;
style.align="center";
style.fontSize=16;
style.overflow="fill";

style.displayedLabel="ADC";
pal5 = xcosPalAddBlock(pal5,"adc",[],style);


style.fontSize=14;
style.displayedLabel="<b>ARB GEN</b><br>%1$s";
pal4 = xcosPalAddBlock(pal4,"GENARB_f",[],style); //arbitrary waveform generator

style.fontSize=16;
style.displayedLabel="<table> <tr> <td align=left><b>bias<br>input</b></td> <td></td> <td></td> <td align=center>C4</td> <td></td> <td></td> <td align=right><b>Vout</b></td> </tr> </table>";
pal5 = xcosPalAddBlock(pal5,"c4_sp",[],style); //C4


//style.fontSize=16;
//style.displayedLabel="<table> <tr> <td align=left><b>bias<br>input</b></td> <td></td> <td></td> <td align=center>HHneuron</td> <td></td> <td></td> <td align=right><b>Vout</b></td> </tr> </table>";
//pal5 = xcosPalAddBlock(pal5,"hh_mm",[],style); //HHneuron

//style.displayedLabel="C4 (1:N)";
//pal = xcosPalAddBlock(pal,"c41_block",[],style);

//style.displayedLabel="C4 (N:N)";
//pal5 = xcosPalAddBlock(pal5,"c4_block",[],style);

//style.displayedLabel="Capacitor";
style.fontSize=12;
//figure_path = unix_g("ls ~/rasp30/sci2blif/xcos_figures/cap_symbol.png");
style.displayedLabel="<table> <tr> <td><b>In</b></td> <td>CAP</td> <td align=left><b>Out</b></td> </tr> </table>";
//pal1 = xcosPalAddBlock(pal1,"cap",[],figure_path);//Capacitor
pal1 = xcosPalAddBlock(pal1,"cap",[],style);//Capacitor

style.fontSize=12;
//figure_path = unix_g("ls ~/rasp30/sci2blif/xcos_figures/cap_symbol.png");
style.displayedLabel="<table> <tr> <td><b>In</b></td> <td>CAP</td> <td align=left><b>Out</b></td> </tr> </table>";
//pal6 = xcosPalAddBlock(pal6,"cap",[],figure_path);//Capacitor
pal6 = xcosPalAddBlock(pal6,"cap",[],style);//Capacitor

style.fontSize=16;
style.displayedLabel="<table> <tr> <td align=center><b>G</b></td> <td align=center>NMOS_mod</td> <td align=right><b>D<br>B<br>S</b></td> </tr> </table>";
pal7 = xcosPalAddBlock(pal7,"NMOS_mod",[],style);

style.displayedLabel="<table> <tr> <td align=center><b>G</b></td> <td align=center>PMOS_mod</td> <td align=right><b>D<br>B<br>S</b></td> </tr> </table>";
pal7 = xcosPalAddBlock(pal7,"PMOS_mod",[],style);

style.displayedLabel="<table> <tr> <td align=center><b>+<br><br> -</b></td> <td></td> <td></td> <td>OTA_mod</td> <td></td> <td></td> <td><b>Vout</b></td> </tr> </table>"
pal7 = xcosPalAddBlock(pal7,"Ota_mod",[],style);

style.displayedLabel="<table> <tr> <td align=center><b>Vin</b></td> <td align=center>Common<br>Source</td> <td><b>Vout</b></td> </tr> </table>";
pal5 = xcosPalAddBlock(pal5,"common_source",[],style);

style.displayedLabel="<table> <tr> <td align=left><b>CLK<br><br><br>RESET</b></td> <td></td> <td></td> <td align=center>counter8<br></td> <td></td> <td></td> <td align=right><b>out0<br>out1<br>out2<br>out3<br>out4<br>out5<br>out6<br>out7</b></td> </tr> </table>";
pal3 = xcosPalAddBlock(pal3,"counter8",[],style);

style.fontSize=12;
style.displayedLabel="<table> <tr><td align=center>DC<br>Voltage</td></tr></table>";
pal4 = xcosPalAddBlock(pal4,"dac",[],style);

style.fontSize=16;
style.displayedLabel="<table> <tr><td align=center>DC<br>Voltage</td></tr></table>";
pal4 = xcosPalAddBlock(pal4,"dac_o",[],style);

style.fontSize=16;
style.displayedLabel="DC_in";
pal4 = xcosPalAddBlock(pal4,"dc_in",[],style);
 
//style.displayedLabel="<table> <tr><td align=center>DC<br>Voltage</td></tr></table>"
//pal = xcosPalAddBlock(pal,"dc_out1",[],style);

style.displayedLabel="Dendritic Diffuser";
pal5 = xcosPalAddBlock(pal5,"dendiff",[],style);

style.fontSize=12;
style.displayedLabel="<table> <tr> <td align=left><b>D<br>Clk<br>Reset</b></td> <td>DFF</td> <td><b>Q</b></td> </tr> </table>"
pal3 = xcosPalAddBlock(pal3,"dff",[],style);

style.fontSize=16;
style.displayedLabel="<table> <tr><td align=left><b>CLK<br><br><br>RESET<b></td> <td></td> <td></td> <td>Divide by 2</td> <td></td> <td></td> <td align=right><b>OUT</b></td></tr></table>"
pal3 = xcosPalAddBlock(pal3,"div2",[],style);

style.displayedLabel="<table> <tr><td align=left><b>CLK<br><br><br>RESET<b></td> <td></td> <td></td> <td>Divide by N</td> <td></td> <td></td> <td align=right><b>OUT<br>1:%2$s</b></td></tr></table>";
pal3 = xcosPalAddBlock(pal3,"div_by_n",[],style);

style.displayedLabel="<table> <tr> <td align=center><b>+<br><br>-</b></td> <td>FG OTA</td> <td><b>Vout</b></td> </tr> </table>"
pal1 = xcosPalAddBlock(pal1,"fgota",[],style);

style.displayedLabel="<table> <tr> <td align=center><b>+<br><br>-</b></td> <td>Comparator FGota</td> <td><b>Vout</b></td> </tr> </table>"
pal1 = xcosPalAddBlock(pal1,"comparator_fgota",[],style);

style.displayedLabel="<table> <tr> <td align=center><b>+<br><br>-</b></td> <td>FG OTA</td> <td><b>Vout</b></td> </tr> </table>"
pal6 = xcosPalAddBlock(pal6,"fgota",[],style);

style.displayedLabel="FG Switch";
pal2 = xcosPalAddBlock(pal2,"fgswitch",[],style);

style.displayedLabel="FG Switch";
pal6 = xcosPalAddBlock(pal6,"fgswitch",[],style);

style.displayedLabel="Generic Digital";
pal3 = xcosPalAddBlock(pal3,"generic_dig",[],style);

style.fontSize=12;
style.displayedLabel="GND";
pal4 = xcosPalAddBlock(pal4,"gnd_i",[],style);

style.fontSize=12;
style.displayedLabel="GND";
pal4 = xcosPalAddBlock(pal4,"gnd_o",[],style);

style.fontSize=12;
style.displayedLabel="GND_dig";
pal4 = xcosPalAddBlock(pal4,"gnd_dig",[],style);

style.fontSize=16;

style.displayedLabel="<table> <tr> <td align=left><b>Vin<br> E<sub>Na</sub><br>E<sub>K</sub><br>Vref</b></td> <td></td> <td></td> <td>HH Neuron</td> <td></td> <td></td> <td align=right><b>Vout<br>V<sub>Na</sub><br>V<sub>K</sub></b></td> </tr> </table>";
pal5 = xcosPalAddBlock(pal5,"hhneuron",[],style)

//style.fontSize=12;
//style.displayedLabel="<table> <tr> <td align=left><b>Vin<br>E_Na<br>E_K<br>Vref</b></td> <td align=center>HH Neuron<br>_b_<br>debug</td> <td><b>Vout<br>V_Na<br>V_K</b></td> </tr> </table>"
//pal5 = xcosPalAddBlock(pal5,"hh_neuron_b_debug",[],style);

style.fontSize=14;
style.displayedLabel="<table> <tr><td align=center>Half Wave<br>Rectifier</td></tr></table>";
pal5 = xcosPalAddBlock(pal5,"h_rect",[],style);

style.fontSize=12;
style.displayedLabel="<table> <tr> <td><b>Iin</b></td> <td>i2v_pfet<br>Gate-fgota</td> <td align=right><b>Vout</b></td> </tr> </table>";
pal5 = xcosPalAddBlock(pal5,"i2v_pfet_gatefgota",[],style);

style.fontSize=16;
style.displayedLabel="<table><tr><td align=center>Input<br>Port %1$s</td></tr></table>";
pal6 = xcosPalAddBlock(pal6,"in_port",[],style)

style.fontSize=12;
style.displayedLabel="<table> <tr> <td align=center><b>in1<br>in1</b></td> <td align=center>In2In_x1</td></tr></table>";
pal5 = xcosPalAddBlock(pal5,"in2in_x1",[],style);

style.fontSize=12;
style.displayedLabel="<table> <tr> <td align=center><b>in1<br>in1<br>in2<br>in2<br>in3<br>in3<br>in4<br>in4<br>in5<br>in5<br>in6<br>in6</b></td> <td align=center>In2In_x6</td></tr></table>";
pal5 = xcosPalAddBlock(pal5,"in2in_x6",[],style);

style.fontSize=14;
style.displayedLabel="<table> <tr><td align=center>INF<br>Neuron</td></tr></table>";
pal5 = xcosPalAddBlock(pal5,"infneuron",[],style);

//style.displayedLabel="Input:%1$s<br>Ports:%2$s";
//pal = xcosPalAddBlock(pal,"IN_m",[],style);

//style.fontSize=12;
//style.displayedLabel="First input- Vref: Second input:Vbias Block to be named:hpf Output:Vout"
//style.displayedLabel="<table> <tr> <td align=left><b>Vref<br>Vin</b></td> <td>hpf</td> <td><b>Vout</b></td> </tr> </table>"
//pal5 = xcosPalAddBlock(pal5,"hpf",[],style)

//style.fontSize=16;
//style.displayedLabel="<table> <tr> <td align=left><b>bias<br>input</b></td> <td></td> <td></td> <td align=center>HPF</td> <td></td> <td></td> <td align=right><b>Vout</b></td> </tr> </table>";
//pal5 = xcosPalAddBlock(pal5,"hpf",[],style); 

style.fontSize=12;
style.displayedLabel="<table> <tr> <td align=left><b>Vref<br>Vin<br>Clear</b></td> <td>Integrator</td> <td><b>Vout</b></td> </tr> </table>"
pal5 = xcosPalAddBlock(pal5,"integrator",[],style)

style.fontSize=12;
style.displayedLabel="<table> <tr> <td align=left><b>Vref<br>Vin<br>Clear</b></td> <td>Integrator<br>compensator</td> <td><b>Vout</b></td> </tr> </table>"
pal5 = xcosPalAddBlock(pal5,"integrator_nmirror",[],style);

style.fontSize=14;
style.displayedLabel="<b>IO PAD</b><br>%2$s";
pal4 = xcosPalAddBlock(pal4,"pad_in",[],style); //input pad

style.fontSize=14;
style.displayedLabel="<table> <tr><td align=center><b>IO Buf A</b><br>%2$s</td></tr></table>";
pal4 = xcosPalAddBlock(pal4,"pad_ina",[],style); //input pad analog buffered

style.displayedLabel="<table> <tr><td align=center><b>IO Buf D</b><br>%2$s</td></tr></table>";
pal4 = xcosPalAddBlock(pal4,"pad_ind",[],style); //input pad digial buffered

style.displayedLabel="<b>IO PAD</b><br>%2$s";
pal4 = xcosPalAddBlock(pal4,"pad_out",[],style); //output pad

style.displayedLabel="<table> <tr><td align=center><b>IO Buf A</b><br>%2$s</td></tr></table>";
pal4 = xcosPalAddBlock(pal4,"pad_outa",[],style); //output pad analog buffered

style.displayedLabel="<table> <tr><td align=center><b>IO Buf D</b><br>%2$s</td></tr></table>";
pal4 = xcosPalAddBlock(pal4,"pad_outd",[],style); //output pad digial buffered

style.displayedLabel="Join";
pal5 = xcosPalAddBlock(pal5,"join",[],style);

//style.fontSize=16;
//style.displayedLabel="Ladder Filter";
//pal = xcosPalAddBlock(pal,"ladfltr",[],style);

style.fontSize=14;
style.displayedLabel="%1$s";
pal3 = xcosPalAddBlock(pal3,"lkuptb",[],style);

//style.displayedLabel="%Ladder<br>Filter";
//pal5 = xcosPalAddBlock(pal5,"ladder_filter",[],style);

style.fontSize=16;
style.displayedLabel="LPF";
pal5 = xcosPalAddBlock(pal5,"lpfota",[],style);

style.displayedLabel="LPF<br>2nd Order";
pal5 = xcosPalAddBlock(pal5,"lpf_2",[],style);

//style.displayedLabel="LPF";
//pal = xcosPalAddBlock(pal,"lpf",[],style);

style.displayedLabel="<table> <tr><td align=center>Measure<br>Voltage</td></tr></table>";
pal4 = xcosPalAddBlock(pal4,"meas_volt",[],style);

style.fontSize=12;
style.displayedLabel="<table> <tr> <td><b>In<br>S_in<br>S_ref</b></td> <td>MISTMATCH<br>MEAS</td> <td align=left><b>Out</b></td> </tr> </table>";
pal5 = xcosPalAddBlock(pal5,"mismatch_meas",[],style);

//style.displayedLabel="MITE";
//pal = xcosPalAddBlock(pal,"mite",[],style);
//
//style.displayedLabel="MITE2";
//pal = xcosPalAddBlock(pal,"mite2",[],style);
//
//style.displayedLabel="MITE2_OUTPUT";
//pal = xcosPalAddBlock(pal,"mite2_output",[],style);

style.displayedLabel="<table> <tr> <td align=left><b>Vfg0<br>Vfg1<br>Vsource</b></td> <td>mite_FG</td> <td><b>Vdrain</b></td> </tr> </table>";
pal2=xcosPalAddBlock(pal2,"mite_FG",[],style);

style.fontSize=12;
style.displayedLabel="<table> <tr> <td align=left><b>Clk<br>CS<br>D</b></td> <td>Mismatch Map<br>Local swc</td> <td><b>Out0<br>Clk<br>CS<br>Q</b></td> </tr> </table>";
pal5 = xcosPalAddBlock(pal5,"mmap_local_swc",[],style);

style.fontSize=16;
style.displayedLabel="MULT";
pal1 = xcosPalAddBlock(pal1,"mult",[],style);

//style.displayedLabel="%2$s";
//pal5 = xcosPalAddBlock(pal5,"newblock",[],style);

//style.displayedLabel="New Block";
//pal5 = xcosPalAddBlock(pal5,"generic",[],style);

style.fontSize=12;
style.displayedLabel="<table> <tr> <td><b>G<br>D</b></td> <td>NFET</td> <td align=left><b>S</b></td> </tr> </table>";
pal2 = xcosPalAddBlock(pal2,"nfet",[],style);

style.displayedLabel="<table> <tr> <td><b>G<br><br>D</b></td> <td></td> <td></td> <td>NFET</td> <td></td> <td></td> <td align=left><b>S</b></td> </tr> </table>";
pal6 = xcosPalAddBlock(pal6,"nfet",[],style);

style.displayedLabel="<table> <tr> <td><b>G<br><br>D</b></td> <td></td> <td></td> <td>NFET</td> <td></td> <td></td> <td align=left><b>S</b></td> </tr> </table>";
pal2 = xcosPalAddBlock(pal2,"nfet_gldn",[],style);

style.fontSize=12;
style.displayedLabel="<table> <tr> <td><b>In</b></td> <td>nfet_i2v</td> <td align=right><b>Out</b></td> </tr> </table>";
pal5 = xcosPalAddBlock(pal5,"nfet_i2v",[],style);

style.fontSize=12;
style.displayedLabel="<table> <tr> <td><b>In</b></td> <td>NMIR</td> <td align=left><b>Out</b></td> </tr> </table>";
pal2 = xcosPalAddBlock(pal2,"nmirror",[],style);

style.fontSize=16;
style.displayedLabel="<table> <tr> <td align=center><b>+<br><br>-</b></td> <td>OTA</td> <td><b>Vout</b></td> </tr> </table>"
pal1 = xcosPalAddBlock(pal1,"ota",[],style);

style.displayedLabel="<table> <tr> <td align=center><b>+<br><br>-</b></td> <td>OTA</td> <td><b>Vout</b></td> </tr> </table>"
pal6 = xcosPalAddBlock(pal6,"ota",[],style);

style.fontSize=12;
style.displayedLabel="OTA Buffer";
pal1 = xcosPalAddBlock(pal1,"ota_buf",[],style);

//style.displayedLabel="OTA Buffer2";
//pal1 = xcosPalAddBlock(pal1,"ota_3",[],style);

//style.fontSize=14;
//style.displayedLabel="OTA Follower";
//pal = xcosPalAddBlock(pal,"ota_flwr",[],style);

//style.fontSize=16;
//style.displayedLabel="Output:%1$s<br>Ports:%2$s";
//pal = xcosPalAddBlock(pal,"OUT_m",[],style);

style.fontSize=16;
style.displayedLabel="<table><tr><td align=center>Output<br>Port %1$s</td></tr></table>";
pal6 = xcosPalAddBlock(pal6,"out_port",[],style)

style.fontSize=10;
style.displayedLabel="OUTPUT<br>Floated";
pal4 = xcosPalAddBlock(pal4,"output_f",[],style);

style.displayedLabel="<table> <tr> <td align=center><b>+<br>bias</b></td> <td></td> <td></td> <td align=center>Peak<br>Detector</td> <td></td> <td></td> <td><b>Vout</b></td> </tr> </table>";
pal5 = xcosPalAddBlock(pal5,"peak_det",[],style);

//style.displayedLabel="Peak Detector";
//pal = xcosPalAddBlock(pal,"peakdet_block",[],style);

style.fontSize=12;
style.displayedLabel="<table> <tr> <td><b>S<br>G</b></td> <td>PFET</td> <td align=left><b>D</b></td> </tr> </table>";
pal2 = xcosPalAddBlock(pal2,"pfet",[],style);

style.fontSize=12;
style.displayedLabel="<table> <tr> <td><b>S<br>G</b></td> <td>PFET</td> <td align=left><b>D</b></td> </tr> </table>";
pal6 = xcosPalAddBlock(pal6,"pfet",[],style);

style.fontSize=12;
style.displayedLabel="<table> <tr> <td><b>S<br><br>G</b></td> <td></td> <td></td> <td>PFET</td> <td></td> <td></td> <td align=left><b>D</b></td> </tr> </table>";
pal2 = xcosPalAddBlock(pal2,"pfet_gldn",[],style);

style.fontSize=12;
style.displayedLabel="<table> <tr> <td><b>In</b></td> <td>pfet_i2v</td> <td align=right><b>Out</b></td> </tr> </table>";
pal5 = xcosPalAddBlock(pal5,"pfet_i2v",[],style);

style.fontSize=16;
style.displayedLabel="RAMPADC";
pal4 = xcosPalAddBlock(pal4,"Ramp_ADC",[],style);

style.fontSize=16;
style.displayedLabel="SOS";
pal5 = xcosPalAddBlock(pal5,"SOS",[],style);

style.displayedLabel="<table> <tr> <td align=left><b>Line<br><br>D<br><br>Clk<br><br>CS</b></td> <td></td> <td></td> <td>Shift Register</td> <td></td> <td></td> <td><b>Out0<br>Out1<br><br>Out2<br>Out3<br>Clk<br><br>CS<br>Q</b></td> </tr> </table>";
pal5 = xcosPalAddBlock(pal5,"sft_reg",[],style);

//style.displayedLabel="<table> <tr> <td></td> <td></td> <td align=center><b>&phi<sub>IN</sub></b></td> <td align=right><b>C<sub>Sin</sub></b></td> <td></td> <td></td> </tr>  <tr></tr>  <tr></tr>  <tr> <td align=center>B<br>I<br>T</td> <td align=left><sub>1:%1$s</sub></td> <td align=center colspan=2>Shift Register</td> <td align=center>O<br>U<br>T</td> <td align=left><sub>1:%1$s</sub></td> </tr> <tr></tr>  <tr></tr>  <tr> <td>D</td> <td></td> <td align=center><b>&phi<sub>OUT</sub></b></td> <td align=right><b>C<sub>Sout</sub></b></td> <td></td> <td align=right>Q</td> </tr> </table>";
//pal = xcosPalAddBlock(pal,"sftreg",[],style);

style.fontSize=12;
style.displayedLabel="<table> <tr> <td align=left><b>Clk<br><br><br><br>CS<br><br><br><br>D<br><br><br><br>In</b></td> <td>Shift<br>Register<br>1input<br>16output</td><td><b>Clk_out<br>CS_out<br>Q<br>Out1<br>Out2<br>Out3<br>Out4<br>Out5<br>Out6<br>Out7<br>Out8<br>Out9<br>Out10<br>Out11<br>Out12<br>Out13<br>Out14<br>Out15<br>Out16</b></td></tr></table>";
pal5 = xcosPalAddBlock(pal5,"sr_1i_16o_nv",[],style);

style.fontSize=12;
style.displayedLabel="<table> <tr> <td align=left><b>In1<br>In2<br>In3<br>In4<br>In5<br>In6<br>In7<br>In8<br>In9<br>In10<br>In11<br>In12<br>In13<br>In14<br>In15<br>In16<br>Clk<br>CS<br>D</b></td><td>Shift<br>Register<br>16input<br>1output</td><td><b>Out<br><br><br><br>Clk_out<br><br><br><br>CS_out<br><br><br><br>Q</b></td><td></td><td></td></tr></table>";
pal5 = xcosPalAddBlock(pal5,"sr_16i_1o_nv",[],style);

style.fontSize=12;
style.displayedLabel="<table> <tr> <td align=left><b>Clk<br>CS<br>D<br>In</b></td> <td>Shift<br>Register<br>1input<br>16output</td><td align=right><b>Clk_out<br>CS_out<br>Q<br>Out</td></tr></table>";
pal5 = xcosPalAddBlock(pal5,"sr_1i_16o",[],style);

style.fontSize=12;
style.displayedLabel="<table> <tr> <td align=left><b>In<br>Clk<br>CS<br>D</b></td><td>Shift<br>Register<br>4input<br>1output</td><td align=right><b>Out<br>Clk_out<br>CS_out<br>Q</b></td></tr></table>";
pal5 = xcosPalAddBlock(pal5,"sr_4i_1o",[],style);

style.fontSize=12;
style.displayedLabel="<table> <tr> <td align=left><b>In<br>Clk<br>CS<br>D</b></td><td>Shift<br>Register<br>16input<br>1output</td><td align=right><b>Out<br>Clk_out<br>CS_out<br>Q</b></td></tr></table>";
pal5 = xcosPalAddBlock(pal5,"sr_16i_1o",[],style);

style.fontSize=14;
//style.displayedLabel="SIN";
//pal5 = xcosPalAddBlock(pal5,"sin_block",[],style);
//
//style.displayedLabel="SINH";
//pal = xcosPalAddBlock(pal,"sinh_block",[],style);
//
//style.displayedLabel="TANH";
//pal = xcosPalAddBlock(pal,"tanh_block",[],style);
//

style.displayedLabel="<table> <tr> <td align=left><b>Vin<br><br>Vbias<br><br>CLK</b></td> <td></td> <td></td> <td align=center>Sigmadelta<br></td> <td></td> <td></td> <td align=right><b>out0</b></td> </tr> </table>";
pal5 = xcosPalAddBlock(pal5,"sigma_delta",[],style);

style.displayedLabel="<table> <tr> <td align=center><b>bias<br>cap<br>vdd</b></td> <td></td> <td></td> <td align=center>Speech</td> <td></td> <td></td> <td><b>Vout1<br>Vout2</b></td> </tr> </table>";
pal5 = xcosPalAddBlock(pal5,"speech",[],style);

style.fontSize=12;
style.displayedLabel="<table> <tr> <td><b>Sel<br>In</b></td> <td>TGATE</td> <td align=right><b>Out</b></td> </tr> </table>";
pal1 = xcosPalAddBlock(pal1,"tgate",[],style);

style.fontSize=12;
style.displayedLabel="VDD";
pal4 = xcosPalAddBlock(pal4,"vdd_i",[],style);

style.fontSize=12;
style.displayedLabel="VDD";
pal4 = xcosPalAddBlock(pal4,"vdd_o",[],style);

style.fontSize=12;
style.displayedLabel="VDD_dig";
pal4 = xcosPalAddBlock(pal4,"vdd_dig",[],style);

//style.displayedLabel="VMM";
//pal = xcosPalAddBlock(pal,"vmm_4",[],style);
//
style.fontSize=16;
style.displayedLabel="VMM";
pal2 = xcosPalAddBlock(pal2,"vmm_4by4",[],style);

style.displayedLabel="vmm12x1_wowta"
pal2=xcosPalAddBlock(pal2,"vmm12x1_wowta",[],style);

style.displayedLabel="vmm_8by4";
pal2 = xcosPalAddBlock(pal2,"vmm_8by4",[],style);

style.displayedLabel="<table> <tr> <td><b>Vref<br><br>Vin</b></td> <td></td> <td></td> <td align=center>VMM<br>Sense Amp</td> <td></td> <td></td> <td align=left><b>Out</b></td> </tr> </table>";
pal5 = xcosPalAddBlock(pal5,"sen_amp",[],style);

style.fontSize=12;
style.displayedLabel="<table> <tr> <td align=left><b>Clk<br>CS<br>D<br>In</b></td><td>VMM<br>16x16<br>shift<br>register</td><td align=right><b>Clk_out<br>CS_out<br>Q<br>Out</b></td></tr></table>";
pal5 = xcosPalAddBlock(pal5,"vmm16x16_sr",[],style);

style.fontSize=14;
style.displayedLabel="<table> <tr> <td><b>In<br><br>CLK<br><br>EN<br><br>D</b></td> <td></td> <td></td> <td>VMM+SR</td> <td></td> <td></td> <td align=right><b>Out<br><br>CLK O<br><br>EN O<br><br>Q</b></td> </tr> </table>";
pal5 = xcosPalAddBlock(pal5,"vmm_sr",[],style);

style.displayedLabel="<table> <tr> <td><b>In<br><br>nbias</b></td> <td></td> <td></td> <td><b>VMM+WTA</b></td> <td></td> <td></td> <td align=left><b>Out</b></td> </tr> </table>";
pal5 = xcosPalAddBlock(pal5,"vmmwta",[],style);

style.displayedLabel="<table> <tr> <td><b>In<br><br>nbias</b></td> <td></td> <td></td> <td>VMM+WTA</td> <td></td> <td></td> <td align=left><b>Out</b></td> </tr> </table>";
pal5 = xcosPalAddBlock(pal5,"vmm_wta",[],style);

style.displayedLabel="<table> <tr> <td><b>In</b></td> <td>VMM+WTA<br>+nbias</td> <td align=left><b>Out</b></td> </tr> </table>";
pal5 = xcosPalAddBlock(pal5,"vmm_wta_nbias",[],style);

style.fontSize=12;
style.displayedLabel="<table> <tr> <td align=center><b>Vin<br>Vref</b></td> <td align=center>Voltage<br>Divider</td> <td><b>Vout</b></td> </tr> </table>";
pal5 = xcosPalAddBlock(pal5,"vol_div",[],style);

style.fontSize=14;
style.displayedLabel="<table> <tr> <td><b>In<br><br>Com</b></td> <td></td> <td></td> <td>WTA</td> <td></td> <td></td> <td align=left><b>Out</b></td> </tr> </table>";
pal5 = xcosPalAddBlock(pal5,"wta",[],style);

style.displayedLabel="Dendrite_4x4";
pal5 = xcosPalAddBlock(pal5,"Dendrite",[],style);

style.displayedLabel="TIA"
pal5=xcosPalAddBlock(pal5,"TIA",[],style);

style.displayedLabel="CurrentstarvedInverter"
pal5=xcosPalAddBlock(pal5,"CurrentstarvedInverter",[],style);

style.displayedLabel="nmirror_vmm"
pal2=xcosPalAddBlock(pal2,"nmirror_vmm",[],style);


file_list=listfiles("/home/ubuntu/rasp30/sci2blif/rasp_design_added_blocks/*.sce");
size_file_list=size(file_list);
if file_list ~= [] then
    for i=1:size_file_list(1)
            exec(file_list(i),-1);
    end
end

xcosPalAdd(pal1,["FPAA" "Analog Blocks"]);
xcosPalAdd(pal2,["FPAA" "Analog Blocks"]);
xcosPalAdd(pal3,["FPAA"]);
xcosPalAdd(pal4,["FPAA"]);
xcosPalAdd(pal5,["FPAA"]);
xcosPalAdd(pal6,["FPAA"]);
xcosPalAdd(pal7,["FPAA"]);
// Launching the GUI


//Turn the warning messages back on to be displayed in consold
funcprot(previousprot)


//*******************
// Launching the GUI
//*******************
//
exec('/home/ubuntu/rasp30/sci2blif/guicode_v6.sce',-1);
cd('/home/ubuntu/RASP_Workspace');
exec('/home/ubuntu/rasp30/work/examples/variables/allvariables.sce',-1)
exec('/home/ubuntu/RASP_Workspace/block_files/create_palette.sce',-1);
getd('/home/ubuntu/rasp30/sci2blif/blif4blks/')
//getd('/home/ubuntu/RASP_Workspace/block_files/compile_files')
//

//Add modelica files' path to the variable %MODELICA_USER_LIBS

global %MODELICA_USER_LIBS;
%MODELICA_USER_LIBS="/home/ubuntu/rasp30/xcos_blocks";


//style.displayedLabel="LPF_smk";
//pal = xcosPalAddBlock(pal,"lpf_smk",[],style);
//style.displayedLabel="CLSS_smk";
//pal = xcosPalAddBlock(pal,"CLSS_smk",[],style);
//style.displayedLabel="LPF2";
//pal = xcosPalAddBlock(pal,"lpf2",[],style);
//exec(home_dir+'loader_OTA_integrator3.sce',-1);
//style.displayedLabel="OTA_integrator_3b_c";
//pal = xcosPalAddBlock(pal,"OTA_integrator_3b_c",[],style);
//style.displayedLabel="OTA_integrator2";
//pal = xcosPalAddBlock(pal,"OTA_integrator2",[],style);
//style.displayedLabel="IN_f2";
//pal = xcosPalAddBlock(pal,"IN_f2",[],style);
//style.displayedLabel="OUT_f2";
//pal = xcosPalAddBlock(pal,"OUT_f2",[],style);
//Add palette in the top folder Cadsp and subfolder New Blocks
