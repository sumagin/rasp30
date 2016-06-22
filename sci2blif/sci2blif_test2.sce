//***********************************
//SCRIPT TO READ FROM XCOS MODEL FILE
//***********************************

//path needed for digital blocks
vpr_path='/home/ubuntu/rasp30/vtr_release/vtr_flow/'

clear blk blk_objs jlist cat_num loctmp loctmp2;
global file_name jlist cat_num board_num addvmm plcvpr;

importXcosDiagram(file_name);
disp("Compiling...");

select board_num 
case 2 then arch = 'rasp3'; brdtype = ''; loc_num=1;
case 3 then arch = 'rasp3a'; brdtype = ' -'+arch; loc_num=2;
case 4 then arch = 'rasp3n'; brdtype = ' -'+arch; loc_num=3;
case 5 arch = 'rasp3h'; brdtype = ' -'+arch; loc_num=4;
else messagebox('Please select the FPAA board that you are using.', "No Selected FPAA Board", "error"); abort; end

if chip_num == [] then messagebox('Please enter the FPAA board number that you are using.', "No FPAA Board Number Entered", "error"); abort; end
//get filename, path and extension
[path,fname,extension]=fileparts(file_name);
cd(path);
deletefile(fname+'.blif') ;
deletefile(fname+'.blk') ;
hid_dir=path+'.'+fname;
unix_s('mkdir -p '+hid_dir);
deletefile('info.txt') ;

deletefile(hid_dir + '/' + fname + '.pads'); 
//exec('/home/ubuntu/rasp30/sci2blif/cat_junc.sce',-1);

//Loading array vectors
//CHECK FOR SCICOS LINK OBJECTS
//global variable to store
global dac_array dac_array_map number_samples period;
dac_array = [0]; 
dac_array_map = ""; 
blname = "";
number_samples = 0;
period = "0x03e8";
numofip=0;
numofop=0;
numofblk=0;
numoflink=0;
inps=0;
accblk=1;
blk_name=cell([1,1]);
link_blk=cell([1,1]);
spl_blk=cell([1 1]);
//dac_net=cell([16 1]); //artifact of info.txt
cat_num =cell([1 1]);
junc_unq = cell([1 1]);
arb_gen = cell([1 1]);
ga_idx = cell();
no=length(scs_m.objs);
link_name=zeros(1,no);
numipsofblk=zeros(no,2);
j=1;
net=1;
objnum=1;
ip_count=1;//primary input count
op_count=1;//primary output count
prime_ips=[];
prime_ops=[];
blk_objs=[];
vmm_ct=0;
split = %f;
ga_blk_num= 0;
//add_gnd1=%f;
//add_gnd2=%f;
genarb_dac=[];
dc_dac=[];
fix_gnd=0;
fix_vdd=0;
sftreg_check=0;
ramp_adc=0;
mite_adc=0;
global RAMP_ADC_check sftreg_check; 
RAMP_ADC_check=0;
sftreg_check=0;
sftreg_count=0
add_clk=[];
dig_blk=0;
netout=[];
addvmm = %f;
//addvcc = %f;
plcvpr = %f;
plcloc = [];
nfetloc = 1;
pfetloc = 1;
chgnet = [0,0,0,0,0,0]; //gnd_i gnd gnd_dig vdd vdd_o vdd_dig
chgnet_dict= [];
chgnet_tf= %f;
makeblk = %f;
spl_fix = [];
spl_fix_chg= %f;
blk_in=[];
blk_out=[];
internal_number = 1; // sihwan added this to name internal lines 
add_tgates4logic = 0; // Sihwan added
number_tgates = 0; // Sihwan added

dac_loc_idx=0;
dac_buf_loc_idx=0;
adc_loc_idx=0;


// declare vpr locations of dac, adc, io pad west, and io pad east

dac_loc= cell();
//**********
//3.0
//**********
dac_loc(1,1).entries(1)= '9 0 1 #int[1]'; //DAC2
dac_loc(1,1).entries(2)= '2';
dac_loc(1,2).entries(1)= '9 0 2 #int[2]'; //DAC3
dac_loc(1,2).entries(2)= '3';
dac_loc(1,3).entries(1)= '8 0 5 #int[5]'; //DAC0
dac_loc(1,3).entries(2)= '0';
dac_loc(1,4).entries(1)= '9 0 3 #int[3]'; //DAC4
dac_loc(1,4).entries(2)= '4';
dac_loc(1,5).entries(1)= '9 0 4 #int[4]'; //DAC5
dac_loc(1,5).entries(2)= '5';
dac_loc(1,6).entries(1)= '9 0 5 #int[5]'; //DAC6
dac_loc(1,6).entries(2)= '6';
dac_loc(1,7).entries(1)= '10 0 0 #int[0]'; //DAC7
dac_loc(1,7).entries(2)= '7';
dac_loc(1,8).entries(1)= '10 0 1 #int[1]'; //DAC8
dac_loc(1,8).entries(2)= '8';
dac_loc(1,9).entries(1)= '10 0 2 #int[2]'; //DAC9
dac_loc(1,9).entries(2)= '9';
dac_loc(1,10).entries(1)= '9 0 0 #int[0]'; //DAC1 
dac_loc(1,10).entries(2)= '1';
dac_loc(1,11).entries(1)= '10 0 3 #int[3]'; //DAC10
dac_loc(1,11).entries(2)= '10';
dac_loc(1,12).entries(1)= '10 0 4 #int[4]'; //DAC11
dac_loc(1,12).entries(2)= '11';
//**********
//3.0a
//**********
dac_loc(2,1).entries(1)= '0 8 3 #int[3]'; //DAC0
dac_loc(2,1).entries(2)= '0';
dac_loc(2,2).entries(1)= '0 8 4 #int[4]'; //DAC1
dac_loc(2,2).entries(2)= '1';
dac_loc(2,3).entries(1)= '0 8 5 #int[5]'; //DAC2
dac_loc(2,3).entries(2)= '2';
dac_loc(2,4).entries(1)= '0 9 0 #int[0]'; //DAC3
dac_loc(2,4).entries(2)= '3';
dac_loc(2,5).entries(1)= '0 9 1 #int[1]'; //DAC4
dac_loc(2,5).entries(2)= '4';
dac_loc(2,6).entries(1)= '0 9 2 #int[2]'; //DAC5
dac_loc(2,6).entries(2)= '5';
dac_loc(2,7).entries(1)= '0 9 3 #int[3]'; //DAC6
dac_loc(2,7).entries(2)= '6';
dac_loc(2,8).entries(1)= '0 9 4 #int[4]'; //DAC7
dac_loc(2,8).entries(2)= '7';
dac_loc(2,9).entries(1)= '0 9 5 #int[5]'; //DAC8
dac_loc(2,9).entries(2)= '8';
dac_loc(2,10).entries(1)= '0 10 0 #int[0]'; //DAC9 
dac_loc(2,10).entries(2)= '9';
dac_loc(2,11).entries(1)= '0 10 1 #int[1]'; //DAC10
dac_loc(2,10).entries(2)= '10';
dac_loc(2,11).entries(1)= '0 10 2 #int[2]'; //DAC11
dac_loc(2,11).entries(2)= '11';

dac_buf_loc= cell();
//**********
//3.0
//**********
dac_buf_loc(1,1).entries='10 0 5 #int[5]';
dac_buf_loc(1,2).entries='11 0 0 #int[0]';
dac_buf_loc(1,3).entries='11 0 1 #int[1]';
dac_buf_loc(1,4).entries='11 0 2 #int[2]';
//**********
//3.0a
//**********
dac_buf_loc(2,1).entries='0 10 3 #int[3]';
dac_buf_loc(2,2).entries='0 10 4 #int[4]';
dac_buf_loc(2,3).entries='0 10 5 #int[5]';
dac_buf_loc(2,4).entries='0 11 0 #int[0]';

adc_locin= cell();
//**********
//3.0
//**********
adc_locin(1,1).entries='5 0 5 #int[5]'; //adc in 0
adc_locin(1,2).entries='6 0 0 #int[0]'; //adc in 1
//**********
//3.0a
//**********
adc_locin(1,1).entries='0 5 3 #int[3]'; //adc in 0
adc_locin(1,2).entries='0 5 4 #int[4]'; //adc in 1

adc_loc= cell();
//**********
//3.0
//**********
adc_loc(1,1).entries='7 0 2 #int[2]'; //adc out0 0
adc_loc(1,2).entries='7 0 1 #int[1]'; //adc out0 1 
adc_loc(1,3).entries='7 0 0 #int[0]'; //adc out0 2
adc_loc(1,4).entries='6 0 5 #int[5]'; //adc out0 3
adc_loc(1,5).entries='6 0 4 #int[4]'; //adc out0 4
adc_loc(1,6).entries='6 0 3 #int[3]'; //adc out0 5
adc_loc(1,7).entries='6 0 2 #int[2]'; //adc out0 6
adc_loc(1,8).entries='6 0 1 #int[1]'; //adc out0 7
adc_loc(1,9).entries='8 0 4 #int[4]'; //adc out1 0
adc_loc(1,10).entries='8 0 3 #int[3]'; //adc out1 1
adc_loc(1,11).entries='8 0 2 #int[2]'; //adc out1 2
adc_loc(1,12).entries='8 0 1 #int[1]'; //adc out1 3
adc_loc(1,13).entries='8 0 0 #int[0]'; //adc out1 4
adc_loc(1,14).entries='7 0 5 #int[5]'; //adc out1 5
adc_loc(1,15).entries='7 0 4 #int[4]'; //adc out1 6
adc_loc(1,16).entries='7 0 3 #int[3]'; //adc out1 7
//**********
//3.0a
//**********
adc_loc(2,1).entries='0 7 0 #int[0]'; //adc out0 0
adc_loc(2,2).entries='0 6 5 #int[5]'; //adc out0 1 
adc_loc(2,3).entries='0 6 4 #int[4]'; //adc out0 2
adc_loc(2,4).entries='0 6 3 #int[3]'; //adc out0 3
adc_loc(2,5).entries='0 6 2 #int[2]'; //adc out0 4
adc_loc(2,6).entries='0 6 1 #int[1]'; //adc out0 5
adc_loc(2,7).entries='0 6 0 #int[0]'; //adc out0 6
adc_loc(2,8).entries='0 5 5 #int[5]'; //adc out0 7
adc_loc(2,9).entries='0 8 2 #int[2]'; //adc out1 0
adc_loc(2,10).entries='0 8 1 #int[1]'; //adc out1 1
adc_loc(2,11).entries='0 8 0 #int[0]'; //adc out1 2
adc_loc(2,12).entries='0 7 5 #int[5]'; //adc out1 3
adc_loc(2,13).entries='0 7 4 #int[4]'; //adc out1 4
adc_loc(2,14).entries='0 7 3 #int[3]'; //adc out1 5
adc_loc(2,15).entries='0 7 2 #int[2]'; //adc out1 6
adc_loc(2,16).entries='0 7 1 #int[1]'; //adc out1 7

iopad_loc= cell();
//**********
//3.0
//**********
iopad_loc(1,13).entries='1 0 3 #'; //west
iopad_loc(1,14).entries='2 0 3 #'; //west
iopad_loc(1,9).entries='3 0 0 #'; //west
iopad_loc(1,10).entries='3 0 3 #'; //west
iopad_loc(1,11).entries='4 0 0 #'; //west
iopad_loc(1,12).entries='4 0 3 #'; //west
iopad_loc(1,1).entries='9 0 0 #'; //west
iopad_loc(1,2).entries='11 0 0 #'; //west
iopad_loc(1,3).entries='12 0 0 #'; //west
iopad_loc(1,4).entries='12 0 3 #'; //west
iopad_loc(1,5).entries='13 0 0 #'; //west
iopad_loc(1,6).entries='13 0 3 #'; //west
iopad_loc(1,7).entries='14 0 0 #'; //west
iopad_loc(1,8).entries='14 0 3 #'; //west
iopad_loc(1,15).entries='1 15 0 #'; //east
iopad_loc(1,16).entries='1 15 3 #'; //east
iopad_loc(1,17).entries='2 15 0 #'; //east
iopad_loc(1,18).entries='2 15 3 #'; //east
iopad_loc(1,19).entries='3 15 0 #'; //east
iopad_loc(1,20).entries='9 15 3 #'; //east
iopad_loc(1,21).entries='9 15 0 #'; //east
iopad_loc(1,22).entries='10 15 3 #'; //east
iopad_loc(1,23).entries='10 15 0 #'; //east
iopad_loc(1,24).entries='11 15 3 #'; //east
iopad_loc(1,25).entries='11 15 0 #'; //east
iopad_loc(1,26).entries='12 15 0 #'; //east
iopad_loc(1,27).entries='15 1 5 #'; //south
iopad_loc(1,28).entries='15 1 2 #'; //south
iopad_loc(1,29).entries='15 2 5 #'; //south
iopad_loc(1,30).entries='15 2 2 #'; //south
iopad_loc(1,31).entries='15 3 5 #'; //south
iopad_loc(1,32).entries='15 4 2 #'; //south
iopad_loc(1,33).entries='15 11 5 #'; //south
iopad_loc(1,34).entries='15 12 2 #'; //south
iopad_loc(1,35).entries='15 12 5 #'; //south
iopad_loc(1,36).entries='15 13 2 #'; //south
iopad_loc(1,37).entries='15 13 5 #'; //south
iopad_loc(1,38).entries='15 14 2 #'; //south
iopad_loc(1,39).entries='15 14 5 #'; //south
iopad_loc(1,40).entries='13 0 1 #int[1]'; //west GPIO proc to arrat
iopad_loc(1,41).entries='13 0 2 #int[2]'; //west
iopad_loc(1,42).entries='13 0 3 #int[3]'; //west
iopad_loc(1,43).entries='13 0 4 #int[4]'; //west
iopad_loc(1,44).entries='13 0 5 #int[5]'; //west
iopad_loc(1,45).entries='14 0 0 #int[0]'; //west
iopad_loc(1,46).entries='14 0 1 #int[1]'; //west
iopad_loc(1,47).entries='14 0 2 #int[2]'; //west
iopad_loc(1,48).entries='14 0 3 #int[3]'; //west
iopad_loc(1,49).entries='14 0 4 #int[4]'; //west
iopad_loc(1,50).entries='14 0 5 #int[5]'; //west
iopad_loc(1,51).entries='15 1 0 #int[0]'; //west
iopad_loc(1,52).entries='15 1 1 #int[1]'; //west
iopad_loc(1,53).entries='15 1 2 #int[2]'; //west
iopad_loc(1,54).entries='15 1 3 #int[3]'; //west
iopad_loc(1,55).entries='15 1 4 #int[4]'; //west
iopad_loc(1,56).entries='15 1 5 #int[5]'; //west GPIO array to proc
iopad_loc(1,57).entries='15 2 0 #int[0]'; //west
iopad_loc(1,58).entries='15 2 1 #int[1]'; //west
iopad_loc(1,59).entries='15 2 2 #int[2]'; //west
iopad_loc(1,60).entries='15 2 3 #int[3]'; //west
iopad_loc(1,61).entries='15 2 4 #int[4]'; //west
iopad_loc(1,62).entries='15 2 5 #int[5]'; //west
iopad_loc(1,63).entries='15 3 0 #int[0]'; //west
iopad_loc(1,64).entries='15 3 1 #int[1]'; //west
iopad_loc(1,65).entries='15 3 2 #int[2]'; //west
iopad_loc(1,66).entries='15 3 3 #int[3]'; //west
iopad_loc(1,67).entries='15 3 4 #int[4]'; //west
iopad_loc(1,68).entries='15 3 5 #int[5]'; //west
iopad_loc(1,69).entries='15 4 0 #int[0]'; //west
iopad_loc(1,70).entries='15 4 1 #int[1]'; //west
iopad_loc(1,71).entries='15 4 2 #int[2]'; //west


//**********
//3.0a
//**********
iopad_loc(2,1).entries='8 1 5 #'; //south
//iopad_loc(2,13).entries='8 1 2 #'; //south   CHANGED 11-10-15
iopad_loc(2,2).entries='8 2 5 #'; //south
//iopad_loc(2,4).entries='8 2 2 #'; //south
iopad_loc(2,3).entries='8 3 5 #'; //south
//iopad_loc(2,6).entries='8 3 2 #'; //south
iopad_loc(2,4).entries='8 4 5 #'; //south
//iopad_loc(2,8).entries='8 4 2 #'; //south
iopad_loc(2,5).entries='8 5 5 #'; //south
//iopad_loc(2,10).entries='8 5 2 #'; //south
iopad_loc(2,6).entries='8 6 5 #'; //south
//iopad_loc(2,12).entries='8 6 2 #'; //south
iopad_loc(2,7).entries='8 7 5 #'; //south
//iopad_loc(2,14).entries='8 7 2 #'; //south
iopad_loc(2,8).entries='8 8 5 #'; //south
//iopad_loc(2,16).entries='8 8 2 #'; //south
iopad_loc(2,9).entries='8 9 5 #'; //south
//iopad_loc(2,18).entries='8 9 2 #'; //south
iopad_loc(2,10).entries='8 10 5 #'; //south
//iopad_loc(2,20).entries='8 10 2 #'; //south
iopad_loc(2,11).entries='8 11 5 #'; //south
//iopad_loc(2,22).entries='8 11 2 #'; //south
iopad_loc(2,12).entries='8 12 5 #'; //south
//iopad_loc(2,24).entries='8 12 2 #'; //south
//iopad_loc(2,21).entries='8 13 5 #'; //south common source amplifier
//iopad_loc(2,22).entries='8 13 2 #'; //south common source amplifier
//iopad_loc(2,23).entries='8 14 5 #'; //south common source amplifier
//iopad_loc(2,24).entries='8 14 2 #'; //south common source amplifier
iopad_loc(2,13).entries='1 15 0 #'; //east
//iopad_loc(2,26).entries='1 15 3 #'; //east
iopad_loc(2,14).entries='2 15 0 #'; //east
//iopad_loc(2,28).entries='2 15 3 #'; //east
iopad_loc(2,15).entries='3 15 0 #'; //east
//iopad_loc(2,30).entries='3 15 3 #'; //east
iopad_loc(2,16).entries='4 15 0 #'; //east
//iopad_loc(2,32).entries='4 15 3 #'; //east
iopad_loc(2,17).entries='5 15 0 #'; //east
//iopad_loc(2,34).entries='5 15 3 #'; //east
//iopad_loc(2,13).entries='1 0 3 #'; //west
iopad_loc(2,40).entries='0 12 5 #int[5]'; // GPIO proc to arrat
iopad_loc(2,41).entries='0 13 0 #int[0]'; //GPin
iopad_loc(2,42).entries='0 13 1 #int[1]'; //GPin
iopad_loc(2,43).entries='0 13 2 #int[2]'; //GPin
iopad_loc(2,44).entries='0 13 3 #int[3]'; //GPin
iopad_loc(2,45).entries='0 13 4 #int[4]'; //GPin
iopad_loc(2,46).entries='0 13 5 #int[5]'; //GPin
iopad_loc(2,47).entries='0 14 0 #int[0]'; //GPin
iopad_loc(2,48).entries='0 14 1 #int[1]'; //GPin
iopad_loc(2,49).entries='0 14 2 #int[2]'; //GPin
iopad_loc(2,50).entries='0 14 3 #int[3]'; //GPin
iopad_loc(2,51).entries='0 14 4 #int[4]'; //GPin
iopad_loc(2,52).entries='0 14 5 #int[5]'; //GPin
iopad_loc(2,53).entries='1 15 0 #int[0]'; //GPin
iopad_loc(2,54).entries='1 15 1 #int[1]'; //GPin
iopad_loc(2,55).entries='1 15 2 #int[2]'; //GPin
iopad_loc(2,56).entries='1 15 3 #int[3]'; //GPin GPIO array to proc
iopad_loc(2,57).entries='1 15 4 #int[4]'; //GPin
iopad_loc(2,58).entries='1 15 5 #int[5]'; //GPin
iopad_loc(2,59).entries='2 15 0 #int[0]'; //
iopad_loc(2,60).entries='2 15 1 #int[1]'; //
iopad_loc(2,61).entries='2 15 2 #int[2]'; //
iopad_loc(2,62).entries='2 15 3 #int[3]'; //
iopad_loc(2,63).entries='2 15 4 #int[4]'; //
iopad_loc(2,64).entries='2 15 5 #int[5]'; //
iopad_loc(2,65).entries='3 15 0 #int[0]'; //
iopad_loc(2,66).entries='3 15 1 #int[1]'; //
iopad_loc(2,67).entries='3 15 2 #int[2]'; //
iopad_loc(2,68).entries='3 15 3 #int[3]'; //
iopad_loc(2,69).entries='3 15 4 #int[4]'; //
iopad_loc(2,70).entries='3 15 5 #int[5]'; //
iopad_loc(2,71).entries='4 15 0 #int[0]'; //




for i =1:no
    if(length(scs_m.objs(i) )==8)  then 
        numoflink=numoflink+1;
        link_name(1,numoflink)=i;
    elseif ( length(scs_m.objs(i) )==1) then //disp("deleted block",i);
    else
        blk(j,1)=i;
        if(scs_m.objs(i).gui== "dac") then
            prime_ips(ip_count)=j;
            ip_count=ip_count+1;//primary ip count
            blk_name.entries(j)= scs_m.objs(i).gui
            blk_objs(objnum)=j; //BLOCK NUMBER actually stored
            objnum=objnum+1;
        elseif   (scs_m.objs(i).gui== "dc_out1") then
            prime_ops(op_count)=j;
            op_count=op_count+1;
            blk_name.entries(j)=  scs_m.objs(i).gui
            blk_objs(objnum)=j; //BLOCK NUMBER actually stored
            objnum=objnum+1;
        elseif   (scs_m.objs(i).gui== "dac_o") then
            prime_ops(op_count)=j;
            op_count=op_count+1;
            blk_name.entries(j)=  scs_m.objs(i).gui
            blk_objs(objnum)=j; //BLOCK NUMBER actually stored
            objnum=objnum+1;
        elseif   (scs_m.objs(i).gui== "adc") then
            prime_ops(op_count)=j;
            op_count=op_count+1;
            blk_name.entries(j)=  scs_m.objs(i).gui
            blk_objs(objnum)=j; //BLOCK NUMBER actually stored
            objnum=objnum+1;
        elseif(scs_m.objs(i).gui== "pad_in") then
            prime_ips(ip_count)=j;
            ip_count=ip_count+1;//primary ip count
            blk_name.entries(j)=  scs_m.objs(i).gui
            blk_objs(objnum)=j; //BLOCK NUMBER actually stored
            objnum=objnum+1;
        elseif(scs_m.objs(i).gui== "pad_ina") then
            prime_ips(ip_count)=j;
            ip_count=ip_count+1;//primary ip count
            blk_name.entries(j)=  scs_m.objs(i).gui
            blk_objs(objnum)=j; //BLOCK NUMBER actually stored
            objnum=objnum+1;
        elseif(scs_m.objs(i).gui== "pad_ind") then
            prime_ips(ip_count)=j;
            ip_count=ip_count+1;//primary ip count
            blk_name.entries(j)=  scs_m.objs(i).gui
            blk_objs(objnum)=j; //BLOCK NUMBER actually stored
            objnum=objnum+1;
        elseif   (scs_m.objs(i).gui== "pad_out") then
            prime_ops(op_count)=j;
            op_count=op_count+1;
            blk_name.entries(j)=  scs_m.objs(i).gui
            blk_objs(objnum)=j; //BLOCK NUMBER actually stored
            objnum=objnum+1;
        elseif   (scs_m.objs(i).gui== "pad_outa") then
            prime_ops(op_count)=j;
            op_count=op_count+1;
            blk_name.entries(j)=  scs_m.objs(i).gui
            blk_objs(objnum)=j; //BLOCK NUMBER actually stored
            objnum=objnum+1;
        elseif   (scs_m.objs(i).gui== "pad_outd") then
            prime_ops(op_count)=j;
            op_count=op_count+1;
            blk_name.entries(j)=  scs_m.objs(i).gui
            blk_objs(objnum)=j; //BLOCK NUMBER actually stored
            objnum=objnum+1;
        else    
            blk_name.entries(j)=scs_m.objs(i).gui;
            blk_objs(objnum)=j; //BLOCK NUMBER actually stored
            objnum=objnum+1;
            //end

            //counting extra primary inputs for references of output otas of vmm
            if (scs_m.objs(i).gui =='vmm_4') then 
                vmm_ct= vmm_ct+8;
            elseif (scs_m.objs(i).gui =='meas_volt') then
                mite_adc = 1;                //add_gnd1=%t;
      elseif (scs_m.objs(i).gui =='TIA') then
                mite_adc = 1;                //add_gnd1=%t;
            elseif (scs_m.objs(i).gui =='GENARB_f')  then
                ga_blk_num = ga_blk_num+1;
                ga_idx(ga_blk_num,1).entries(1,1)=i;
                ga_idx(ga_blk_num,1).entries(1,2)=size(evstr(scs_m.objs(i).model.opar(1)), "r");
            elseif (scs_m.objs(i).gui== "vdd_i") then
                fix_vdd = 1;
            //elseif (scs_m.objs(i).gui== "vdd_o") then                 //fix_vdd = 2
            //elseif (scs_m.objs(i).gui== "gnd_o") then                 //fix_gnd = 2
            elseif (scs_m.objs(i).gui== "gnd_i") then
                fix_gnd = 1;
            elseif (scs_m.objs(i).gui== "lkuptb") then // Sihwan added
                if scs_m.objs(i).model.ipar(1) ~= 4 then
                    fix_gnd = 1;
                    fix_vdd = 1;
                    add_tgates4logic = 1;
                    number_tgates = max(4-scs_m.objs(i).model.ipar(1),number_tgates);
                end
            elseif (scs_m.objs(i).gui== "dff") then // Sihwan added
                fix_gnd = 1;
                fix_vdd = 1;
                add_tgates4logic = 1;
                number_tgates = max(3,number_tgates);
            elseif (scs_m.objs(i).gui== "gnd_dig") then // Sihwan added
                fix_gnd = 1;
                fix_vdd = 1;
            elseif (scs_m.objs(i).gui== "vdd_dig") then // Sihwan added
                fix_vdd = 1;
            elseif (scs_m.objs(i).gui== "dc_in") then // Sihwan added
                fix_vdd = 1;
            elseif (scs_m.objs(i).gui== "generic_dig") then //suma added
                dig_blk = 1;
            elseif (scs_m.objs(i).gui== "nfet_gldn") | (scs_m.objs(i).gui== "pfet_gldn") | (scs_m.objs(i).gui== "speech") | (scs_m.objs(i).gui== "sr_16i_1o") then 
                plcvpr = %t;
            elseif (scs_m.objs(i).gui== "vmm_wta") then
               fix_gnd = 1;
            elseif (scs_m.objs(i).gui== "Ramp_ADC") then
                ramp_adc = 1;  
            elseif (scs_m.objs(i).gui== "mux4_1") then
                mux4_1 = 1; 
            elseif (scs_m.objs(i).gui== "vmmwta") then
                plcvpr = %t;
               // fix_gnd = 1;
            elseif (scs_m.objs(i).gui== "in_port") then
                makeblk = %t;
            elseif (scs_m.objs(i).gui== "hystdiff") then // Sihwan added
                fix_gnd = 1;
                fix_vdd = 1;
            end
        end

        j=j+1;
        numofblk=numofblk+1;

        //save the number of inputs for each block
        if((length(scs_m.objs(i).model.in2)==1)&(scs_m.objs(i).model.in2 ~= -1)) then
            numipsofblk(i,2)= scs_m.objs(i).model.in*scs_m.objs(i).model.in2;
        elseif((length(scs_m.objs(i).model.in2)==1)&(scs_m.objs(i).model.in2 == -1)) then
            numipsofblk(i,2)=1; 
        else
            numipsofblk(i,2)=length(scs_m.objs(i).model.in);  
        end

        if(length(scs_m.objs(i).model.in)>numofip) then
            numofip=length(scs_m.objs(i).model.in);
        end;

        if(length(scs_m.objs(i).model.out)>numofop) then
            numofop=length(scs_m.objs(i).model.out);
        end; 
    end;
end;

file_list=listfiles("/home/ubuntu/rasp30/sci2blif/sci2pads_added_blocks/*.sce");
size_file_list=size(file_list);
if file_list ~= [] then
    for bl=1:length(blk_objs)
        for i=1:size_file_list(1)
            exec(file_list(i),-1);
        end
    end         // for loop for user defined Level 1 block
end
disp(fix_vdd)
numofio=numofip+numofop;//blknumber+ip+op

blk=[blk,zeros(numofblk,numofio)];
link_blk=link_name(1, 1:numoflink);

for m=1:numoflink
    curblk=scs_m.objs(link_blk(1,m)).from(1,1);
    for r=1:numofblk
        if(blk(r,1)==curblk) then
            outofblk=scs_m.objs(link_blk(1,m)).from(1,2);
            idx=1+numofip+outofblk;
            if(scs_m.objs(curblk).gui=='SPLIT_f') then
                spl_net=spl_blk(curblk,1).entries;
                blk(r,idx)=spl_net;
                split = %t;
            else
                blk(r,idx)=net;
            end
            break;
        end
    end
    curblk=scs_m.objs(link_blk(1,m)).to(1,1);
    for r=1:numofblk
        if(blk(r,1)==curblk) then
            inofblk=scs_m.objs(link_blk(1,m)).to(1,2);
            idx=1+inofblk;
            if(scs_m.objs(curblk).gui=='SPLIT_f') then
                spl_blk(curblk,1).entries=net;
            end
            if(split == %t) then
                blk(r,idx)=spl_net;
                split = %f;
            else
                blk(r,idx)=net;
                net=net+1;
            end
            break;
        end
    end
end
// primary input string
if dig_blk==1 then //suma added
    prime_ip_string= '.inputs rst';
    fd_io= mopen(fname+'.pads','wt');
    mputl('rst 8 0 0  #tgate[0]',fd_io);
    mclose(fd_io);
//elseif addvcc then //add vcc
//    prime_ip_string= '.inputs vcc';
else
    prime_ip_string= '.inputs';
end
//prime_ipnet=string(blk(prime_ips(1),2+numofip)); 
if ga_blk_num ~= 0 then
    for ga = 1:ga_blk_num
        ga_blk_num2 =ga_idx(ga,1).entries(1,2);
        for ga2 = 1:ga_blk_num2
            prime_ip_string=strcat([prime_ip_string," net",string(blk(ga_idx(ga,1).entries(1,1),2+numofip)), "_",string(ga2) ]);
        end
    end
end
for s=1: length(prime_ips)    
    for ss=1:scs_m.objs(prime_ips(s)).model.ipar(1)
        prime_ip_string=strcat([prime_ip_string," net",string(blk(prime_ips(s),2+numofip)),"_",string(ss) ]);
    end
    //prime_ipnet=prime_ipnet+' '+string(blk(prime_ips(s),2+numofip));
end

orignet = net;
//extra primary inputs for vmm output ota
for s=1: vmm_ct
    prime_ip_string=strcat([prime_ip_string," net",string(net)]);
    net = net+1;
end

// adding gnd/vdd as an input
if fix_vdd == 1 then
    prime_ip_string=strcat([prime_ip_string," vcc"]);
end
if fix_gnd == 1 then
    prime_ip_string=strcat([prime_ip_string," gnd"]);
end
if mux4_1==1 then
    prime_ip_string=strcat([prime_ip_string," sel1 sel2 sel3 sel4"]);
end

//primary o/p string
prime_op_string= '.outputs';
//prime_opnet= string(blk(prime_ops(1),2));

for s=1: length(prime_ops)
    if blk_name(prime_ops(s)).entries == 'dc_out1' then
        for ss=1:scs_m.objs(prime_ops(s)).model.ipar(1)
            prime_op_string= prime_op_string + ' net'+ string(blk(prime_ops(s),2+numofip))+ "_" + string(ss);
        end
    elseif blk_name(prime_ops(s)).entries == 'pad_in' then
        for ss=1:scs_m.objs(prime_ops(s)).model.ipar(1)
            prime_op_string= prime_op_string + ' net'+ string(blk(prime_ops(s),2+numofip))+ "_" + string(ss);
        end
    else
        for ss=1:scs_m.objs(prime_ops(s)).model.ipar(1)
            prime_op_string= prime_op_string + ' net'+ string(blk(prime_ops(s),2)) + "_" + string(ss);
        end
    end
    //assuming need to account for a dac for the voltage measurement and net is the next wire number

    //prime_opnet= prime_opnet+' '+string(blk(prime_ops(s),2));
end

// adding gnd/vdd as an output
//if fix_gnd == 2 then prime_op_string=strcat([prime_op_string," gnd"]); end
//if fix_vdd == 2 then prime_op_string=strcat([prime_op_string," vdd"]); end
if mite_adc == 1 then prime_op_string=strcat([prime_op_string," out_mite_adc"]); end
if ramp_adc == 1 then prime_op_string=strcat([prime_op_string," out_ramp_adc"]); end


//Writing output to blif file and make pads file
if makeblk == %f then
    fd_w= mopen (fname+'.blif','wt')
    //filename= basename('./expt2.cos')
    mputl(strcat([".model"," ",fname])  ,fd_w);
    mputl(prime_ip_string,fd_w);
    mputl(prime_op_string,fd_w);
    mputl("  ",fd_w)
    mclose(fd_w);

    // restrict the one digital component (ex. inverter) that vpr needs to work
    fd_io= mopen(fname+'.pads','wt')
    mclose(fd_io);

//    if fix_gnd == 2 then
//        fd_io= mopen (fname+'.pads','a+')
//        mputl('out:gnd 7 0 2',fd_io); 
//        mclose(fd_io);
//        add_gnd1=%f
//    end

    if fix_gnd == 1 then
        fd_io= mopen (fname+'.pads','a+')
        mputl('gnd 7 0 4 #int[4]',fd_io); 
        mclose(fd_io);
    end

    if fix_vdd == 1 then
        fd_io= mopen (fname+'.pads','a+')
        //mputl('vcc 12 0 3',fd_io);
        mputl('vcc 7 0 5 #int[5]',fd_io);
        mclose(fd_io);
        //add_gnd2=%f
    end

//    if fix_vdd == 2 then
//        fd_io= mopen (fname+'.pads','a+')
//        mputl('out: vcc 12 0 3',fd_io);
//        mclose(fd_io);
//    end

//    if addvcc then
//        fd_io= mopen (fname+'.pads','a+')
//        mputl('vcc 0 10 3',fd_io);
//        mclose(fd_io);
//    end

end


if makeblk then
    // tgates for logics <- Sihwan added #1
    fl_name= basename(file_name)+'.blk';
    fd_w= mopen (fl_name,'a');
    if add_tgates4logic == 1 then
        mputl("# tgates for logic",fd_w);
        for i=1:number_tgates
            tg4logic_str=".subckt tgate in[0]=vcc in[1]=gnd out=tg4logic_"+string(i);mputl(tg4logic_str,fd_w);mputl("  ",fd_w);
        end
    end
else
    // tgates for logics <- Sihwan added #2
    fl_name= basename(file_name)+'.blif';
    fd_w= mopen (fl_name,'a');
    if add_tgates4logic == 1 then
        mputl("# tgates for logic",fd_w);
        for i=1:number_tgates
            tg4logic_str=".subckt tgate in[0]=vcc in[1]=gnd out=tg4logic_"+string(i);mputl(tg4logic_str,fd_w);mputl("  ",fd_w);
        end
    end
end

for bl=1:length(blk_objs)
    //****************************** ADC **********************************
    if(blk_name.entries(bl)=='adc')  then
        adc_loc_idx = adc_loc_idx +1;
        fd_io= mopen (fname+'.pads','a+');  // DEDICATED PADS code
        mputl('out:net'+ string(blk(blk_objs(bl),2)) + ' ' + adc_loc(adc_loc_idx).entries,fd_io);
        mclose(fd_io);

        //****************************** Arb Gen *******************************
    elseif (blk_name.entries(bl) =='GENARB_f') then
        arb_gen.entries=[]
        ga_idx2=size(evstr(scs_m.objs(bl).model.opar(1)), "r")
        fd_io= mopen (fname+'.pads','a+');  // DEDICATED PADS code
        for ii = 1:ga_idx2
            dac_loc_idx = dac_loc_idx +1;
            arb_gen(1,1).entries(1,ii)= strtod(dac_loc(loc_num,dac_loc_idx).entries(2))
            mputl('net'+ string(blk(blk_objs(bl),2+numofip)) + "_"+ string(ii) +' ' + dac_loc(loc_num,dac_loc_idx).entries(1),fd_io);
        end
        mclose(fd_io);
        genarb_dac = arb_gen(1,1).entries(1,:);
        exec("~/rasp30/prog_assembly/libs/scilab_code/genarb_compile.sce",-1);
        genarb_compile(scs_m.objs(bl).model.opar(1),scs_m.objs(bl).model.rpar(1),genarb_dac,0); // regen = 0

        //**************************** BUF DAC *********************************
    elseif(blk_name.entries(bl)=='dac_buf')  then
        dac_buf_loc_idx = dac_buf_loc_idx +1;
        fd_io= mopen (fname+'.pads','a+');  // DEDICATED PADS code
        mputl('net'+ string(blk(blk_objs(bl),2+numofip)) + ' ' + dac_buf_loc(loc_num,dac_buf_loc_idx).entries(1),fd_io);
        mclose(fd_io);

	//************************* TIA ******************************
    elseif (blk_name.entries(bl) =='TIA') then
        mputl("# TIA",fd_w);
       tia_str= ".subckt TIA_blk in[0]=net"+string(blk(blk_objs(bl),2))+'_'+ string(ss)+" out[0]=out_tia #TIA_fgota_bias[0] =10e-6&TIA_ota_p_bias[0] =50e-9&TIA_ota_n_bias[0] =10e-9&TIA_fgota_bias[1] =10e-6&TIA_ota_p_bias[1] =50e-9&TIA_ota_n_bias[1] =2e-9&TIA_ota_bias[0] =1e-6&TIA_ota_buf_out[0] =2e-6&TIA_fg[0] =0";
            mputl(tia_str,fd_w);
            mputl("  ",fd_w);
      mputl("# MITE_ADC*",fd_w);
            mputl(".subckt meas_volt_mite in[0]=out_tia"+' out[0]=out_mite_adc #meas_fg =0.00001',fd_w);
            mputl("  ",fd_w);
	MITE_ADC_check=1;
mite_adc=1;
        fd_io= mopen (fname+'.pads','a+')
        select board_num
        case 2 then mputl("out:out_mite_adc 7 0 0 #tgate[0]",fd_io);
        case 3 then mputl("out:out_mite_adc 8 1 0 #int[0]",fd_io);
        end
        mclose(fd_io); 
       
                //**************************** C4 **************************************
    elseif (blk_name.entries(bl) =='c4_sp') then
        mputl("# C4",fd_w);
        for ss=1:scs_m.objs(bl).model.ipar(1)
            c4sp_str= '.subckt c4_blk in[0]=net' + string(blk(blk_objs(bl),2))+"_1 in[1]=net"+string(blk(blk_objs(bl),3))+"_1 out[0]=net"+ string(blk(blk_objs(bl),2+numofip))+"_" + string(ss)+" #c4_ota_bias[0] =" +string(sprintf('%1.3e',scs_m.objs(blk_objs(bl)).model.rpar(7*ss-6)))+"&c4_ota_bias[1] =" +string(sprintf('%1.3e',scs_m.objs(blk_objs(bl)).model.rpar(7*ss-3)));
            c4sp_str= c4sp_str +"&c4_fg[0] =0&speech_peakotabias[1] =10e-6&c4_ota_small_cap[0] =0&c4_ota_small_cap[1] =0&c4_ota_p_bias[0] =" +string(sprintf('%1.3e',scs_m.objs(blk_objs(bl)).model.rpar(7*ss-4)))+"&c4_ota_n_bias[0] =" +string(sprintf('%1.3e',scs_m.objs(blk_objs(bl)).model.rpar(7*ss-5)))+"&c4_ota_p_bias[1] =" +string(sprintf('%1.3e',scs_m.objs(blk_objs(bl)).model.rpar(7*ss-1)))+"&c4_ota_n_bias[1] =" +string(sprintf('%1.3e',scs_m.objs(blk_objs(bl)).model.rpar(7*ss-2)));
            capcap = scs_m.objs(blk_objs(bl)).model.rpar(ss*7);
            select capcap
            case 1 then c4sp_str= c4sp_str +"&c4_cap_1x[0] =0";
            case 2 then c4sp_str= c4sp_str +"&c4_cap_2x[0] =0";
            case 3 then c4sp_str= c4sp_str +"&c4_cap_3x[0] =0";
            case 4 then c4sp_str= c4sp_str +"&c4_cap_3x[0] =0"+"&c4_cap_1x[0] =0";
            case 5 then c4sp_str= c4sp_str +"&c4_cap_3x[0] =0"+"&c4_cap_2x[0] =0";
            case 6 then c4sp_str= c4sp_str +"&c4_cap_3x[0] =0"+"&c4_cap_2x[0] =0"+"&c4_cap_1x[0] =0";
            else error("Capacitor cannot be compiled.");
            end
            mputl(c4sp_str,fd_w);
            mputl("  ",fd_w);
        end

        //**************************** C4 N:N **********************************
    elseif (blk_name.entries(bl) =='c4_block') then
        mputl("# C4",fd_w);
        for ss=1:scs_m.objs(bl).model.ipar(1)
            c4_str= ".subckt c4_blk in[0]=net"+string(blk(blk_objs(bl),2))+"_"+string(ss)+ " in[1]=net"+string(blk(blk_objs(bl),3))+"_"+string(ss)+" out[0]=net"+ string(blk(blk_objs(bl),2+numofip))+"_" + string(ss)+" #c4_ota_bias[1] =" +string(sprintf('%1.12f',scs_m.objs(blk_objs(bl)).model.rpar(3))) + "&c4_ota_bias[0] =" +string(sprintf('%1.12f',scs_m.objs(blk_objs(bl)).model.rpar(4)))+"&c4_fg[0] =0";
            for ii=1:2
                c4cap = scs_m.objs(blk_objs(bl)).model.rpar(ii+4)
                select c4cap
                case 1 then c4_str= c4_str +"&c4_cap_1x[" + string(ii-1) +"] =0";
                case 2 then c4_str= c4_str +"&c4_cap_2x[" + string(ii-1) +"] =0";
                case 3 then c4_str= c4_str +"&c4_cap_3x[" + string(ii-1) +"] =0";
                case 4 then c4_str= c4_str +"&c4_cap_3x[" + string(ii-1) +"] =0"+"&c4_cap_1x[" + string(ii-1) +"] =0";
                case 5 then c4_str= c4_str +"&c4_cap_3x[" + string(ii-1) +"] =0"+"&c4_cap_2x[" + string(ii-1) +"] =0";
                case 6 then c4_str= c4_str +"&c4_cap_3x[" + string(ii-1) +"] =0"+"&c4_cap_2x[" + string(ii-1) +"] =0"+"&c4_cap_1x[" + string(ii-1) +"] =0";
                case 18 then c4_str= c4_str +"&c4_cap_3x[0] =0"+"&c4_cap_2x[0] =0"+"&c4_cap_1x[0] =0"+"&c4_cap_3x[2] =0"+"&c4_cap_2x[2] =0"+"&c4_cap_1x[2] =0" +"&c4_cap_3x[3] =0"+"&c4_cap_2x[3] =0"+"&c4_cap_1x[3] =0";
                else error("C4 capacitor cannot be compiled.");
                end
            end
            mputl(c4_str,fd_w); 
            mputl("  ",fd_w);
        end

        //****************************** CAP ***********************************
    elseif (blk_name.entries(bl) =='cap') then
        mputl("#CAP "+string(bl),fd_w);
        for ss=1:scs_m.objs(bl).model.ipar(1)
            cap_str = ".subckt cap in[0]=net"+string(blk(blk_objs(bl),2))+"_"+string(ss)+" out[0]=net"+ string(blk(blk_objs(bl),2+numofip))+"_" + string(ss);
            capcap = scs_m.objs(blk_objs(bl)).model.rpar(1)
            select capcap
            case 1 then cap_str= cap_str +" #cap_1x =0";
            case 2 then cap_str= cap_str +" #cap_2x =0";
            case 3 then cap_str= cap_str +" #cap_3x =0";
            case 4 then cap_str= cap_str +" #cap_3x =0"+"&cap_1x =0";
            case 5 then cap_str= cap_str +" #cap_3x =0"+"&cap_2x =0";
            case 6 then cap_str= cap_str +" #cap_3x =0"+"&cap_2x =0"+"&cap_1x =0";
            else error("Capacitor cannot be compiled.");
            end
            mputl(cap_str,fd_w);
            mputl("  ",fd_w);
        end
        
        //************************* Common Source ******************************
    elseif (blk_name.entries(bl) =='common_source') then
        mputl("# Common Source",fd_w);
        for ss=1:scs_m.objs(bl).model.ipar(1)
            cap_str= ".subckt common_source1 in[0]=net"+string(blk(blk_objs(bl),2))+'_'+ string(ss)+" out=net"+ string(blk(blk_objs(bl),2+numofip))+'_'...
            + string(ss) + " #common_source1_fg =0&cs_bias =" +string(sprintf('%1.12f',scs_m.objs(blk_objs(bl)).model.rpar(ss)));
            mputl(cap_str,fd_w);
            mputl("  ",fd_w);
        end
        
  //************************* Common Drain ******************************
    elseif (blk_name.entries(bl) =='common_drain') then
        mputl("# Common Drain",fd_w);
        for ss=1:scs_m.objs(bl).model.ipar(1)
            cap_str= ".subckt common_drain in[0]=net"+string(blk(blk_objs(bl),2))+'_'+ string(ss)+" in[1]=net"+string(blk(blk_objs(bl),3))+'_'+ string(ss)+" out=net"+ string(blk(blk_objs(bl),2+numofip))+'_'...
            + string(ss) + " #common_drain_fg =0";
            mputl(cap_str,fd_w);
            mputl("  ",fd_w);
        end
        
        //**************************** Counter 8 ******************************
    elseif (blk_name.entries(bl) =='counter8') then
        mputl("# counter8",fd_w);
        for ss=1:scs_m.objs(bl).model.ipar(1)
            counter8_str= ".subckt counter8 clk=net"+string(blk(blk_objs(bl),2))+"_"+string(ss)+" reset=net"+string(blk(blk_objs(bl),3))+"_"+string(ss); 
            for ss_out=1:8 
                counter8_str=counter8_str+" out["+string(ss_out-1)+"]=net"+string(blk(blk_objs(bl),ss_out+1+numofip))+"_"+string(ss);
            end
            mputl(counter8_str,fd_w);
            mputl("  ",fd_w);
        end
        
  //************************* Current Starved Inverter ******************************
    elseif (blk_name.entries(bl) =='CurrentstarvedInverter') then
       addvmm = %t;
        mputl("# CurrentstarvedInverter",fd_w);
        for ss=1:scs_m.objs(bl).model.ipar(1)
            cap_str= ".subckt INV_cs in[0]=net"+string(blk(blk_objs(bl),2))+'_'+ string(ss)+" in[1]=net"+string(blk(blk_objs(bl),3))+'_'+ string(ss)+" out=net"+ string(blk(blk_objs(bl),2+numofip))+'_'+ string(ss) + " #INV_cs_fg =0&INV_cs_NBIAS ="+string(sprintf('%1.12f',scs_m.objs(blk_objs(bl)).model.rpar(2*ss-1)))+"&INV_cs_PBIAS ="+string(sprintf('%1.12f',scs_m.objs(blk_objs(bl)).model.rpar(2*ss)));
            mputl(cap_str,fd_w);
            mputl("  ",fd_w);
        end
        //**************************** DC_in ***********************************
    elseif (blk_name.entries(bl) =='dc_in') then
        mputl("# dc_in",fd_w);
        DC_in_char = [3.0e-06 2.4462;2.5e-06 2.4163;2.0e-06 2.2968;1.5e-06 2.0720;1.0e-06 1.7760;0.9e-06 1.7016;0.8e-06 1.6102;0.7e-06 1.5330;0.6e-06 1.4284;
        0.5e-06 1.3176;0.4e-06 1.1920;0.3e-06 1.0064;0.2e-06 0.7770;0.15e-06 0.6270;0.10e-06 0.4000;0.08e-06 0.3044;0.05e-06 0.1250];
        [p_DC_in,S_DC_in]=polyfit(DC_in_char(:,2),log(DC_in_char(:,1)),1);
        for ss=1:scs_m.objs(bl).model.ipar(1)
            dc_in_str= ".subckt fgota in[0]=vcc in[1]=net"+string(blk(blk_objs(bl),2+numofip))+"_"+string(ss)+" out[0]=net"+string(blk(blk_objs(bl),2+numofip))+"_"+string(ss)+" #ota_bias =2e-06&ota_p_bias =2e-06&ota_n_bias ="+string(sprintf('%1.2e',exp(polyval(p_DC_in,scs_m.objs(blk_objs(bl)).model.rpar(ss),S_DC_in))))+"&ota_small_cap =0";
            mputl(dc_in_str,fd_w);
            mputl("  ",fd_w);
        end

        //****************************** DC IN ************************************
    elseif(blk_name.entries(bl)=='dac')  then
        dc.entries=[]
        // DEDICATED PADS code
        fd_io= mopen(fname+'.pads','a+')
        for ss=1:scs_m.objs(bl).model.ipar(1)
            dac_loc_idx = dac_loc_idx +1;
            dc(1,1).entries(1,ss)= strtod(dac_loc(loc_num,dac_loc_idx).entries(2));
            //dac_net(blk(blk_objs(bl),2+numofip),1).entries=dac_loc(dac_loc_idx,3).entries;
            mputl('net'+ string(blk(blk_objs(bl),2+numofip)) + "_"+ string(ss)+' ' + dac_loc(loc_num,dac_loc_idx).entries(1),fd_io);
        end
        mclose(fd_io);
        dc_dac = dc(1,1).entries(1,:);
        exec("~/rasp30/prog_assembly/libs/scilab_code/dc_compile.sce",-1);
        dc_compile(scs_m.objs(bl).model.opar(1),scs_m.objs(bl).model.rpar(1)',dc_dac);

        //***************************** DC OUT **********************************
    elseif(blk_name.entries(bl)=='dac_o')  then
        dc.entries=[]
        // DEDICATED PADS code
        fd_io= mopen(fname+'.pads','a+')
        for ss=1:scs_m.objs(bl).model.ipar(1)
            dac_loc_idx = dac_loc_idx +1;
            dc(1,1).entries(1,ss)= strtod(dac_loc(loc_num,dac_loc_idx).entries(2))
            mputl('out:net'+ string(blk(blk_objs(bl),2)) + "_"+ string(ss)+' ' + dac_loc(loc_num,dac_loc_idx).entries(1),fd_io);
        end
        mclose(fd_io);
        dc_dac = dc(1,1).entries(1,:)
        exec("~/rasp30/prog_assembly/libs/scilab_code/dc_compile.sce",-1);
        dc_compile(scs_m.objs(bl).model.opar(1),scs_m.objs(bl).model.rpar(1)',dc_dac)

        //***************************** DC OUT *********************************
    elseif(blk_name.entries(bl)=='dc_out1')  then
        dac_loc_idx = dac_loc_idx +1;
        // DEDICATED PADS code
        fd_io= mopen(fname+'.pads','a+')
        mputl('out:net'+ string(blk(blk_objs(bl),2+numofip)) + ' ' + dac_loc(loc_num,dac_loc_idx).entries(1),fd_io);
        mclose(fd_io);

        //************************** Dendritic Diffuser **********************************
    elseif (blk_name.entries(bl) =='dendiff') then
        mputl("# Dendritic Diffuser",fd_w);
        for ss=1:1 //scs_m.objs(bl).model.ipar(1)
            den_str= '.subckt dendiff in[0]=net' + string(blk(blk_objs(bl),2)) +"_" + string(ss)+ " in[1]=net' + string(blk(blk_objs(bl),3)) +"_" + string(ss)+' in[2]=net' + string(blk(blk_objs(bl),4)) +"_" + string(ss)+' in[3]=net' + string(blk(blk_objs(bl),5)) +"_" + string(ss)+ " in[4]=net' + string(blk(blk_objs(bl),6)) +"_" + string(ss)+' in[5]=net' + string(blk(blk_objs(bl),7)) +"_" + string(ss)+' out[0]=net'+ string(blk(blk_objs(bl),2+numofip))+ "_" + string(ss)+' #dendiff_synapse ='+scs_m.objs(blk_objs(bl)).model.opar(2)+'&dendiff_axial ='+scs_m.objs(blk_objs(bl)).model.opar(3)+'&dendiff_leak ='+scs_m.objs(blk_objs(bl)).model.opar(4)+'&dendiff_vmem ='+scs_m.objs(blk_objs(bl)).model.opar(5);
            mputl(den_str,fd_w);
            mputl("  ",fd_w)
        end
//************************** Dendritic Diffuser new **********************************
    elseif (blk_name.entries(bl) =='Dendrite') then
             addvmm = %t;
        k =scs_m.objs(blk_objs(bl)).model.opar(1);
        tar1=[];
        tar2=[];
        for i=1:size(k,1) 
            for j=1:size(k,2)
                if (j == size(k,2)) & (i == size(k,1)) then tar1=tar1+'%1.2e';
                else tar1=tar1+'%1.2e,';
                end
            end
            tar2=tar2+'k('+string(i)+',:) ';
        end
        tar2= evstr(tar2);
     
        mputl("# Dendrite Diffuser",fd_w);
        for ss=1:1
            den_str1= '.subckt dendrite_4x4 in[0]=net' + string(blk(blk_objs(bl),2)) +"_" + string(ss)+ " in[1]=net' + string(blk(blk_objs(bl),3)) +"_" + string(ss)+' in[2]=net' + string(blk(blk_objs(bl),4)) +"_" + string(ss)+' in[3]=net' + string(blk(blk_objs(bl),5)) +"_" + string(ss)+ " out[0]=net'+ string(blk(blk_objs(bl),2+numofip))+ "_" + string(ss)+' out[1]=net'+ string(blk(blk_objs(bl),3+numofip))+ "_" + string(ss)+' out[2]=net'+ string(blk(blk_objs(bl),4+numofip))+ "_" + string(ss)+' out[3]=net'+ string(blk(blk_objs(bl),5+numofip))+ "_" + string(ss)+' #dendrite_4x4_fg =0&dendrite_4x4_target =' +string(sprintf(tar1,tar2));
            mputl(den_str1,fd_w);
            mputl("  ",fd_w)
        end
        //**************************** D flip Flop ********************************
    elseif(blk_name.entries(bl)=='dff')  then
        mputl("# D Flip Flop ",fd_w);
        for ss=1:scs_m.objs(bl).model.ipar(1)
            dff_str='.names'+' net' + string(blk(blk_objs(bl),2))+"_"+string(ss)+' tg4logic_1 tg4logic_2 tg4logic_3'+' internal_'+ string(internal_number)+"_"+string(ss);
            mputl(dff_str,fd_w);
            mputl('1--- 1',fd_w);
            mputl("  ",fd_w);
            dff_str='.subckt latch_custom'+' D[0]=internal_'+string(internal_number)+"_"+string(ss)+' clk[0]=net'+string(blk(blk_objs(bl),3))+"_" +string(1)+' reset[0]=net'+string(blk(blk_objs(bl),4))+"_" +string(1)+' Q[0]=net'+string(blk(blk_objs(bl),2+numofip))+"_" +string(ss);
            mputl(dff_str,fd_w);
            mputl("  ",fd_w);
            internal_number=internal_number+1;
        end
        if scs_m.objs(bl).model.rpar(1) == 1 then
            plcvpr = %t;
            //            plcloc=[plcloc;'net'+string(blk(blk_objs(bl),2+numofip))+'_1',' '+string(scs_m.objs(bl).model.rpar(2))+' '+string(scs_m.objs(bl).model.rpar(3))+' 0'];
            plcloc=[plcloc;'internal_'+ string(internal_number-1)+'_1',' '+string(scs_m.objs(bl).model.rpar(2))+' '+string(scs_m.objs(bl).model.rpar(3))+' 0'];
        end

        //************************** Div BY 2 **********************************
    elseif (blk_name.entries(bl) =='div2') then
        disp(scs_m.objs(bl).model.opar(1))
        cd(vpr_path);
        //**********************************
        //Writing supporting list file
        //**********************************
        blname = blk_name.entries(bl);
        blkin = length(scs_m.objs(blk(bl,1)).model.in);
        blkout = length(scs_m.objs(blk(bl,1)).model.out);
        prime_ipnet='inputs'; 
        for s=2:(1+blkin)
            prime_ipnet=prime_ipnet+' '+string(blk(bl,s))+'_1';
        end

        prime_opnet='outputs' 
        for s=(2+numofip): (1+numofip+blkout)
            prime_opnet=prime_opnet+' '+string(blk(bl,s))+'_1';
        end

        fd_w2= mopen (blname+'_list.txt','wt')

        mputl(strcat(["obj"," ",fname])  ,fd_w2);
        mputl('numips '+string(blkin),fd_w2);
        mputl('numops '+string(blkout),fd_w2);
        mputl(prime_ipnet,fd_w2);
        mputl(prime_opnet,fd_w2);
        mclose(fd_w2);

        unix_w(' perl /home/ubuntu/rasp30/vtr_release/vtr_flow/scripts/run_vtr_flow.pl '+ scs_m.objs(bl).model.opar(1) +' /home/ubuntu/rasp30/vtr_release/vpr/ARCH/arch.xml -ending_stage scripts -no_mem'); ///home/ubuntu/rasp30/vpr2swcs/arch/rasp3_arch.xml
        unix_w('pwd ') ;
        unix_w('cp temp/'+blname+'.pre-vpr.blif  ./'+blname+ '.blif -rf'); 
        unix_g('pwd ') ;
        unix_g('bash genblif.sh '+ blname) ;
        unix_g('cp '+ blname +'.blif '+path)
        cd(path)

        fext=fname+'.blif'
        unix_g('cat '+blname +'.blif >> '+fext);
        //end;//elseif div2

        //*************************** DIV_BY_N *********************************
    elseif (blk_name.entries(bl) =='div_by_n') then
        cd(vpr_path);
        //**********************************
        //Writing supporting list file
        //**********************************
        digifl='div_by_n'+ string(bl) +'.blif';
        digi='div_by_n'+string(bl);
        diginame='div_by_n'+string(bl);

        prime_ipnet='inputs'; 
        for s=2:(numofip+1)
            prime_ipnet=prime_ipnet+' '+string(blk(bl,s));
        end

        prime_opnet='outputs' 
        for s=(2+numofip): (1+numofip+numofop)
            prime_opnet=prime_opnet+' '+string(blk(bl,s));
        end

        fd_w2= mopen (digi+'_list.txt','wt')

        mputl(strcat(["obj"," ",fname])  ,fd_w2);
        mputl('numips '+string(length(scs_m.objs(blk(bl,1)).model.in)),fd_w2);
        mputl('numops '+string(length(scs_m.objs(blk(bl,1)).model.out)),fd_w2);
        mputl(prime_ipnet,fd_w2);
        mputl(prime_opnet,fd_w2);
        mclose(fd_w2);
        unix_w(' perl /home/ubuntu/rasp30/vtr_release/vtr_flow/scripts/run_vtr_flow.pl /home/ubuntu/rasp30/sci2blif/benchmarks/verilog/div_by_n.v /home/ubuntu/rasp30/vtr_release/vpr_rasp3/rasp3_arch.xml -ending_stage scripts -no_mem');
        unix_w('pwd ') ;
        unix_w('cp temp/div_by_n.pre-vpr.blif  ./'+digifl+' -rf'); 
        //unix_w('cp /home/ubuntu/rasp30/vtr_release/vtr_flow/temp/div2.pre-vpr.blif  /home/ubuntu/rasp30/vtr_release/vtr_flow/div2.blif -rf'); 
        unix_w('pwd ') ;
        //disp("Copied files");
        unix_w('bash genblif.sh '+diginame) ;
        unix_w('cp '+digifl+' '+path);
        cd(path)
        //unix_g('cp '+vpr_path+digifl+' . -rf');

        fext=fname+'.blif'
        unix_w('cat '+digifl+' >> '+fext);

        //**************************** FG OTA **********************************
    elseif(blk_name.entries(bl)=='fgota')  then
    //plcvpr = %t; //Michelle
        mputl("#FGOTA "+string(bl),fd_w);
        fgibias = strsplit(scs_m.objs(blk_objs(bl)).model.rpar(1)," ");
        fgpibias = strsplit(scs_m.objs(blk_objs(bl)).model.rpar(2)," ");
        fgnibias = strsplit(scs_m.objs(blk_objs(bl)).model.rpar(3)," ");
        for ss=1:scs_m.objs(bl).model.ipar(1)
            ota_str= '.subckt fgota in[0]=net' + string(blk(blk_objs(bl),2)) +"_" + string(ss)+' in[1]=net'+ string(blk(blk_objs(bl),3)) +"_" + string(ss)+ ' out[0]=net'+ string(blk(blk_objs(bl),2+numofip))+ "_" + string(ss);
            //feedback configuration
            if ((blk(blk_objs(bl),2) == blk(blk_objs(bl),2+numofip)) | (blk(blk_objs(bl),3) == blk(blk_objs(bl),2+numofip))) then
                ota_str= ota_str +" #fgota_biasfb =" + fgibias(ss)+ "&ota_p_bias =" + fgpibias(ss)+"&ota_n_bias =" + fgnibias(ss);
            else //non-feedback configuration
                ota_str= ota_str +" #ota_bias =" +fgibias(ss) + "&ota_p_bias =" +fgpibias(ss)+"&ota_n_bias =" + fgnibias(ss);
            end
            if scs_m.objs(blk_objs(bl)).model.ipar(1+ss) == 1 then
                ota_str= ota_str +"&ota_small_cap =0";
            end
            mputl(ota_str,fd_w);
            mputl("  ",fd_w);
            //plcloc=[plcloc;'net'+string(blk(blk_objs(bl),2+numofip))+'_'+ string(ss),' 1 14 0']; //Michelle
        end

        //****************************Comparator FG OTA **********************************
    elseif(blk_name.entries(bl)=='comparator_fgota')  then
    plcvpr = %t;
        mputl("#FGOTA "+string(bl),fd_w);
        fgibias = strsplit(scs_m.objs(blk_objs(bl)).model.rpar(1)," ");
        fgpibias = strsplit(scs_m.objs(blk_objs(bl)).model.rpar(2)," ");
        fgnibias = strsplit(scs_m.objs(blk_objs(bl)).model.rpar(3)," ");
        for ss=1:scs_m.objs(bl).model.ipar(1)
            ota_str= '.subckt fgota in[0]=net' + string(blk(blk_objs(bl),2)) +"_1 in[1]=net'+ string(blk(blk_objs(bl),3)) +"_" + string(ss)+ ' out[0]=net'+ string(blk(blk_objs(bl),2+numofip))+ "_" + string(ss);
                ota_str= ota_str +" #ota_bias =" +fgibias(ss) + "&ota_p_bias =" +fgpibias(ss)+"&ota_n_bias =" + fgnibias(ss);
           
            if scs_m.objs(blk_objs(bl)).model.ipar(1+ss) == 1 then
                ota_str= ota_str +"&ota_small_cap =0";
            end
            mputl(ota_str,fd_w);
            mputl("  ",fd_w);
            
            plcloc=[plcloc;'net'+string(blk(blk_objs(bl),2+numofip))+'_'+ string(ss),' 6 '+string(ss)+' 0']; 
            end

        //**************************** FG Switch **********************************
    elseif(blk_name.entries(bl)=='fgswitch')  then
        addvmm = %t;
        mputl("# fg_io",fd_w);
        for ss=1:scs_m.objs(bl).model.ipar(1)
            fg_str= '.subckt fg_io in[0]=net' + string(blk(blk_objs(bl),2)) +"_" + string(ss)+' out[0]=net'+ string(blk(blk_objs(bl),2+numofip))+ "_" + string(ss)+ ' #fg_io_fg ='+ string(sprintf('%1.2e',scs_m.objs(blk_objs(bl)).model.rpar(ss)));
            mputl(fg_str,fd_w);
            mputl("  ",fd_w);
        end
    end
end         // for loop was divided by Sihwan because the big for loop generated a error when we compiled.

for bl=1:length(blk_objs)
    //************************** Generic Digital ***************************
    if (blk_name.entries(bl) =='generic_dig') then
        //elseif (blk_name.entries(bl) =='generic_dig') then
        //disp(scs_m.objs(bl).model.opar(1))
        cd(vpr_path);
        //**********************************
        //Writing supporting list file
        //**********************************
        blname = fileparts(scs_m.objs(bl).model.opar(1),'fname');
        blkin = length(scs_m.objs(blk(bl,1)).model.in);
        blkout = length(scs_m.objs(blk(bl,1)).model.out);
        prime_ipnet='inputs'; 
        for s=2:(1+blkin)
            prime_ipnet=prime_ipnet+' '+string(blk(bl,s))+'_1';
        end

        prime_opnet='outputs' 
        for s=(2+numofip): (1+numofip+blkout)
            prime_opnet=prime_opnet+' '+string(blk(bl,s))+'_1';
        end

        fd_w2= mopen (blname+'_list.txt','wt')

        mputl(strcat(["obj"," ",fname])  ,fd_w2);
        mputl('numips '+string(blkin),fd_w2);
        mputl('numops '+string(blkout),fd_w2);
        mputl(prime_ipnet,fd_w2);
        mputl(prime_opnet,fd_w2);
        mclose(fd_w2);
        //disp(blname, scs_m.objs(bl).model.opar(1))

        unix_w('perl /home/ubuntu/rasp30/vtr_release/vtr_flow/scripts/run_vtr_flow.pl '+ scs_m.objs(bl).model.opar(1) +' /home/ubuntu/rasp30/vpr2swcs/arch/rasp3_arch.xml -ending_stage scripts -no_mem'); // /home/ubuntu/rasp30/vtr_release/vpr/ARCH/arch.xml
        unix_w('pwd ') ;
        unix_w('cp temp/'+blname+'.pre-vpr.blif  ./'+blname+ '.blif -rf'); 
        unix_g('pwd ') ;
        unix_g('bash genblif.sh '+ blname) ;
        unix_g('cp '+ blname +'.blif '+path)
        cd(path)

        fext=fname+'.blif'
        unix_g('cat '+blname +'.blif >> '+fext);
        //end;//elseif div2

        //************************** GND IN Analog ********************************
    elseif(blk_name.entries(bl)=='gnd_i')  then
        chgnet_dict=[chgnet_dict;'net'+ string(blk(blk_objs(bl),2+numofip))+"_.",'gnd']
        chgnet_tf=%t;

        //************************** GND out (Macro block) ********************************
    elseif(blk_name.entries(bl)=='gnd_o')  then
        for ss=1:scs_m.objs(bl).model.ipar(1)
            mputl("#GND_OUT "+string(bl),fd_w);
            mputl(".subckt gnd_out in[0]=fb_gndout_net"+string(blk(blk_objs(bl),2))+"_"+string(ss)+" in[1]=net"+string(blk(blk_objs(bl),2))+"_"+string(ss)+" out[0]=fb_gndout_net"+string(blk(blk_objs(bl),2))+"_"+string(ss)+"  #gnd_out_c =0",fd_w);
            mputl(' ',fd_w);
        end

        //************************** GND IN Digital (Macro block) ****************************
    elseif (blk_name.entries(bl) =='gnd_dig') then
        if chgnet(3) == 0 then
            mputl("#GND_DIG "+string(bl),fd_w)
            gnd_dig_str= ".subckt tgate in[0]=vcc in[1]=gnd out=gnd_dig";
            mputl(gnd_dig_str,fd_w);
            mputl("  ",fd_w);
            chgnet(3)=1;
        end
        chgnet_dict=[chgnet_dict;'net'+ string(blk(blk_objs(bl),2+numofip))+"_.",'gnd_dig'];
        chgnet_tf=%t;

        //************************* Half Wave Rectifier ******************************
    elseif (blk_name.entries(bl) =='h_rect') then
        mputl("# h_rect",fd_w);
        for ss=1:scs_m.objs(bl).model.ipar(1)
            //.subckt h_rect in[0]=in1 in[1]=in2 out=out #h_rect_bias[0] =1e-6  &  h_rect_fg[0] =0
            cap_str= ".subckt h_rect in[0]=net" + string(blk(blk_objs(bl),2)) + "_" + string(2*ss-1) + " in[1]=net" + string(blk(blk_objs(bl),3)) + "_" + string(2*ss-1) + " out=net"+ string(blk(blk_objs(bl),2+numofip)) + "_" + string(2*ss-1) + " #h_rect_bias[0] =" + string(sprintf('%1.12f',scs_m.objs(blk_objs(bl)).model.rpar(ss))) + "&h_rect_fg[0] =0";
            mputl(cap_str,fd_w);
            mputl("  ",fd_w);
        end

        //**************************** HH Neuron  ******************************
    elseif (blk_name.entries(bl) =='hhneuron') then 
        mputl("# HH Neuron",fd_w);
        for ss = 1:scs_m.objs(bl).model.ipar(1)
            mputl(".subckt hhneuron in[0]=net"+string(blk(blk_objs(bl),2))+ "_" + string(ss)+" in[1]=net"+string(blk(blk_objs(bl),3))+ "_" + string(ss)+" in[2]=net"+string(blk(blk_objs(bl),4))+ "_" + string(ss)+" in[3]=net"+string(blk(blk_objs(bl),5))+ "_" + string(ss)+" out[0]=net"+ string(blk(blk_objs(bl),2+numofip))+ "_" + string(ss)+" out[1]=net"+ string(blk(blk_objs(bl),3+numofip))+ "_" + string(ss)+" out[2]=net"+ string(blk(blk_objs(bl),4+numofip))+ "_" + string(ss)+ " #hhneuron_fg[0] =0&hh_leak =" +string(sprintf('%1.2e',scs_m.objs(blk_objs(bl)).model.rpar(9*ss-8)))+"&hh_vinbias =" +string(sprintf('%1.2e',scs_m.objs(blk_objs(bl)).model.rpar(9*ss-7)))+"&hh_nabias =" +string(sprintf('%1.2e',scs_m.objs(blk_objs(bl)).model.rpar(9*ss-6)))+"&hh_kbias =" +string(sprintf('%1.2e',scs_m.objs(blk_objs(bl)).model.rpar(9*ss-5)))+"&hh_fbpfetbias =" +string(sprintf('%1.2e',scs_m.objs(blk_objs(bl)).model.rpar(9*ss-4)))+"&hh_ota_p_bias[0] =" +string(sprintf('%1.2e',scs_m.objs(blk_objs(bl)).model.rpar(9*ss-3)))+"&hh_ota_n_bias[0] =" +string(sprintf('%1.2e',scs_m.objs(blk_objs(bl)).model.rpar(9*ss-2)))+"&hh_ota_p_bias[1] =" +string(sprintf('%1.2e',scs_m.objs(blk_objs(bl)).model.rpar(9*ss-1)))+"&hh_ota_n_bias[1] =" +string(sprintf('%1.2e',scs_m.objs(blk_objs(bl)).model.rpar(9*ss))),fd_w);
            mputl("  ",fd_w)
        end

        //*************** HH neuron b debug **********************
    elseif (blk_name.entries(bl) =='hh_neuron_b_debug') then
        mputl("# HH neuron b debug",fd_w);
        hh_neuron_b_debug_str= ".subckt hh_neuron_b_debug"
        for ss=1:scs_m.objs(bl).model.ipar(1)
            hh_neuron_b_debug_str=hh_neuron_b_debug_str+" in[0]=net"+string(blk(blk_objs(bl),2))+"_"+string(ss)+" in[1]=net"+string(blk(blk_objs(bl),3))+"_1"+" in[2]=net"+string(blk(blk_objs(bl),4))+"_1"+" in[3]=net"+string(blk(blk_objs(bl),5))+"_1"+" out[0]=net"+string(blk(blk_objs(bl),2+numofip))+"_"+string(ss)+" out[1]=net"+string(blk(blk_objs(bl),3+numofip))+"_1"+" out[2]=net"+string(blk(blk_objs(bl),4+numofip))+"_1"+" #hh_neuron_b_local[0] =0&hh_neuron_b_bias_1[0] ="+string(sprintf('%1.2e',scs_m.objs(bl).model.rpar(1)))+"&hh_neuron_b_bias_2[0] ="+string(sprintf('%1.2e',scs_m.objs(bl).model.rpar(2)))+"&hh_neuron_b_bias_3[0] ="+string(sprintf('%1.2e',scs_m.objs(bl).model.rpar(3)))+"&hh_neuron_b_bias_4[0] =2.0e-06";
        end
        mputl(hh_neuron_b_debug_str,fd_w);
        mputl("  ",fd_w);
        if scs_m.objs(bl).model.ipar(2) == 1 then
            plcvpr = %t;
            plcloc=[plcloc;'net'+string(blk(blk_objs(bl),2+numofip))+'_1',' '+string(scs_m.objs(bl).model.ipar(3))+' '+string(scs_m.objs(bl).model.ipar(4))+' 0'];
        end
        string(sprintf('%1.2e',scs_m.objs(blk_objs(bl)).model.rpar(ss*3)))

        //**************************** Hysteretic Differentiator  ******************************
    elseif (blk_name.entries(bl) =='hystdiff') then 
        mputl("# histdiff",fd_w);
        for ss = 1:scs_m.objs(bl).model.ipar(1)
            mputl(".subckt ota in[0]=net"+string(blk(blk_objs(bl),2))+ "_" + string(ss)+" in[1]=hystdiff"+ string(ss)+" out[0]=net"+ string(blk(blk_objs(bl),2+numofip))+ "_" + string(ss)+ " #ota_biasfb =" +string(sprintf('%1.12f',scs_m.objs(blk_objs(bl)).model.rpar(1))),fd_w);
            mputl("  ",fd_w);
            mputl(".subckt pfet in[0]=net"+ string(blk(blk_objs(bl),2+numofip))+ "_" + string(ss)+" in[1]=hystdiff"+ string(ss)+" out=gnd",fd_w);
            mputl("  ",fd_w);
            mputl(".subckt nfet in[0]=net"+ string(blk(blk_objs(bl),2+numofip))+ "_" + string(ss)+" in[1]=vcc"+" out[0]=hystdiff"+ string(ss),fd_w);
            mputl("  ",fd_w);
        end
        
        //**************************** i2v pfet gatefgota  ******************************
    elseif (blk_name.entries(bl) =='i2v_pfet_gatefgota') then
        //addvmm = %t;
        mputl("#I2V_pfet_gatefgota",fd_w);
        DC_in_char = [3.0e-06 2.4462;2.5e-06 2.4163;2.0e-06 2.2968;1.5e-06 2.0720;1.0e-06 1.7760;0.9e-06 1.7016;0.8e-06 1.6102;0.7e-06 1.5330;0.6e-06 1.4284;0.5e-06 1.3176;0.4e-06 1.1920;0.3e-06 1.0064;0.2e-06 0.7770;0.15e-06 0.6270;0.10e-06 0.4000;0.08e-06 0.3044;0.05e-06 0.1250];
        [p_DC_in,S_DC_in]=polyfit(DC_in_char(:,2),log(DC_in_char(:,1)),1);
        for ss=1:scs_m.objs(bl).model.ipar(1)
            dc_in_str= ".subckt i2v_pfet_gatefgota in[0]=net"+string(blk(blk_objs(bl),2))+ "_" + string(ss)+" out[0]=net"+string(blk(blk_objs(bl),2+numofip))+"_"+string(ss)+" #i2v_pfet_gatefgota_fg =0&i2v_pfet_gatefgota_ota0bias =2e-06&i2v_pfet_gatefgota_fgotabias =2e-06&i2v_pfet_gatefgota_fgotapbias =2e-06&i2v_pfet_gatefgota_fgotanbias ="+string(sprintf('%1.2e',exp(polyval(p_DC_in,scs_m.objs(blk_objs(bl)).model.rpar(ss),S_DC_in))));
            mputl(dc_in_str,fd_w);
            mputl("  ",fd_w);
        end

        //************************ In Port *Make Block* ******************************
    elseif (scs_m.objs(bl).gui== "in_port") then
        disp('in_port');

        //************************ Input2Input x1 ******************************
    elseif (blk_name.entries(bl) =='in2in_x1') then
        //addvmm = %t;
        mputl("# Input 2 Input x1",fd_w);
        for ss=1:scs_m.objs(bl).model.ipar(1)
            in2in_x1_str= ".subckt in2in_x1 in[0]=fbout_"+string(internal_number)+"_"+string(ss)+" in[1]=net"+string(blk(blk_objs(bl),2))+"_"+string(ss)+" in[2]=net"+string(blk(blk_objs(bl),3))+"_"+string(ss)+" out[0]=fbout_"+string(internal_number)+"_"+string(ss);
            mputl(in2in_x1_str,fd_w);
            mputl("  ",fd_w);
            internal_number=internal_number+1;
        end

        //************************ Input2Input x6 ******************************
    elseif (blk_name.entries(bl) =='in2in_x6') then
        //addvmm = %t;
        mputl("# Input 2 Input x6",fd_w);
        for ss=1:scs_m.objs(bl).model.ipar(1)
            in2in_x6_str= ".subckt in2in_x6 in[0]=fbout_"+string(internal_number)+"_"+string(ss)+" in[1]=net"+string(blk(blk_objs(bl),2))+"_"+string(ss)+" in[2]=net"+string(blk(blk_objs(bl),3))+"_"+string(ss)+" in[3]=net"+string(blk(blk_objs(bl),4))+"_"+string(ss)+" in[4]=net"+string(blk(blk_objs(bl),5))+"_"+string(ss)+" in[5]=net"+string(blk(blk_objs(bl),6))+"_"+string(ss)+" in[6]=net"+string(blk(blk_objs(bl),7))+"_"+string(ss)+" in[7]=net"+string(blk(blk_objs(bl),8))+"_"+string(ss)+" in[8]=net"+string(blk(blk_objs(bl),9))+"_"+string(ss)+" in[9]=net"+string(blk(blk_objs(bl),10))+"_"+string(ss)+" in[10]=net"+string(blk(blk_objs(bl),11))+"_"+string(ss)+" in[11]=net"+string(blk(blk_objs(bl),12))+"_"+string(ss)+" in[12]=net"+string(blk(blk_objs(bl),13))+"_"+string(ss)+" out[0]=fbout_"+string(internal_number)+"_"+string(ss);
            mputl(in2in_x6_str,fd_w);
            mputl("  ",fd_w);
            internal_number=internal_number+1;
        end

        //************************** INF Neuron ********************************
    elseif (blk_name.entries(bl) =='infneuron') then  //FIX For Multiple blocks 
        mputl("# INF Neuron",fd_w);
        mputl(".subckt INFneuron in[0]=net"+string(blk(blk_objs(bl),2))+"_1"+ " in[1]=net"+string(blk(blk_objs(bl),3))+"_1"+ " in[2]=net"+string(blk(blk_objs(bl),4))+"_1"+ " out[0]=net"+ string(blk(blk_objs(bl),2+numofip))+"_1"+" #c4_ota_bias[1] =" +string(sprintf('%1.12f',scs_m.objs(blk_objs(bl)).model.rpar(1))) + "&c4_ota_bias[0] =" +string(sprintf('%1.12f',scs_m.objs(blk_objs(bl)).model.rpar(2))) + "&INF_bias[0] =" +string(sprintf('%1.12f',scs_m.objs(blk_objs(bl)).model.rpar(3))) +"&INF_fg[0] =0", fd_w);
        mputl("  ",fd_w);

        //**************************** Integrator ******************************
    elseif (blk_name.entries(bl) =='integrator') then
        //addvmm = %t;
        mputl("# INTEGRATOR",fd_w);
        ii= scs_m.objs(bl).model.ipar(1)
        for ss=1:ii
            integrator_str= ".subckt integrator in[0]=net" + string(blk(blk_objs(bl),2))+ "_1"+" in[1]=net" + string(blk(blk_objs(bl),3))+ "_"+string(ss)+" in[2]=net" + string(blk(blk_objs(bl),4))+ "_1"+" out[0]=net"+ string(blk(blk_objs(bl),2+numofip))+"_" + string(ss)+" #integrator_fg =0";

            capcap = scs_m.objs(blk_objs(bl)).model.rpar(3);
            select capcap
            case 1 then integrator_str= integrator_str +"&cap_1x =0";
            case 2 then integrator_str= integrator_str +"&cap_2x =0";
            case 3 then integrator_str= integrator_str +"&cap_3x =0";
            case 4 then integrator_str= integrator_str +"&cap_3x =0" + "&cap_1x =0";
            case 5 then integrator_str= integrator_str +"&cap_3x =0" +"&cap_2x =0";
            case 6 then integrator_str= integrator_str +"&cap_3x =0"+"&cap_2x =0"+"&cap_1x =0";
            else error("Capacitor cannot be compiled.");
            end
            integrator_str= integrator_str +"&integrator_ota0 =" +string(sprintf('%1.2e',scs_m.objs(blk_objs(bl)).model.rpar(1)))+"&integrator_ota1 =" +string(sprintf('%1.2e',scs_m.objs(blk_objs(bl)).model.rpar(2)));
            mputl(integrator_str,fd_w);
            mputl("  ",fd_w);
        end
        if scs_m.objs(bl).model.ipar(1) == 16 then
            plcvpr = %t;
            plcloc=[plcloc;'net'+string(blk(blk_objs(bl),2+numofip))+'_1',' 2 4 0'];
            plcloc=[plcloc;'net'+string(blk(blk_objs(bl),2+numofip))+'_2',' 2 5 0'];
            plcloc=[plcloc;'net'+string(blk(blk_objs(bl),2+numofip))+'_3',' 2 6 0'];
            plcloc=[plcloc;'net'+string(blk(blk_objs(bl),2+numofip))+'_4',' 2 7 0'];
            plcloc=[plcloc;'net'+string(blk(blk_objs(bl),2+numofip))+'_5',' 2 8 0'];
            plcloc=[plcloc;'net'+string(blk(blk_objs(bl),2+numofip))+'_6',' 3 4 0'];
            plcloc=[plcloc;'net'+string(blk(blk_objs(bl),2+numofip))+'_7',' 3 5 0'];
            plcloc=[plcloc;'net'+string(blk(blk_objs(bl),2+numofip))+'_8',' 3 6 0'];
            plcloc=[plcloc;'net'+string(blk(blk_objs(bl),2+numofip))+'_9',' 3 7 0'];
            plcloc=[plcloc;'net'+string(blk(blk_objs(bl),2+numofip))+'_10',' 3 8 0'];
            plcloc=[plcloc;'net'+string(blk(blk_objs(bl),2+numofip))+'_11',' 6 6 0'];
            plcloc=[plcloc;'net'+string(blk(blk_objs(bl),2+numofip))+'_12',' 6 7 0'];
            plcloc=[plcloc;'net'+string(blk(blk_objs(bl),2+numofip))+'_13',' 6 8 0'];
            plcloc=[plcloc;'net'+string(blk(blk_objs(bl),2+numofip))+'_14',' 7 6 0'];
            plcloc=[plcloc;'net'+string(blk(blk_objs(bl),2+numofip))+'_15',' 7 7 0'];
            plcloc=[plcloc;'net'+string(blk(blk_objs(bl),2+numofip))+'_16',' 7 8 0'];
        end

        //**************************** Integrator Compensator ******************************
    elseif (blk_name.entries(bl) =='integrator_nmirror') then
        //addvmm = %t;
        mputl("# INTEGRATOR",fd_w);
        ii= scs_m.objs(bl).model.ipar(1);
        for ss=1:ii
            integrator_str= ".subckt integrator_nmirror in[0]=net" + string(blk(blk_objs(bl),2))+ "_1"+" in[1]=net" + string(blk(blk_objs(bl),3))+ "_"+string(ss)+" in[2]=net" + string(blk(blk_objs(bl),4))+ "_1"+" out[0]=net"+ string(blk(blk_objs(bl),2+numofip))+"_" + string(ss)+" #integrator_nmirror_fg =0";

            capcap = scs_m.objs(blk_objs(bl)).model.rpar(3);
            select capcap
            case 1 then integrator_str= integrator_str +"&cap_1x =0";
            case 2 then integrator_str= integrator_str +"&cap_2x =0";
            case 3 then integrator_str= integrator_str +"&cap_3x =0";
            case 4 then integrator_str= integrator_str +"&cap_3x =0"+"&cap_1x =0";
            case 5 then integrator_str= integrator_str +"&cap_3x =0"+"&cap_2x =0";
            case 6 then integrator_str= integrator_str +"&cap_3x =0"+"&cap_2x =0"+"&cap_1x =0";
            else error("Capacitor cannot be compiled.");
            end
            integrator_str= integrator_str +"&integrator_nmirror_ota0 =" +string(sprintf('%1.2e',scs_m.objs(blk_objs(bl)).model.rpar(1)))+"&integrator_nmirror_ota1 =" +string(sprintf('%1.2e',scs_m.objs(blk_objs(bl)).model.rpar(2))) +"&integrator_nmirror_ota2 =" +string(sprintf('%1.2e',scs_m.objs(blk_objs(bl)).model.rpar(4+ss-1)));
            mputl(integrator_str,fd_w);
            mputl("  ",fd_w);
        end
        if scs_m.objs(bl).model.ipar(1) == 16 then
            plcvpr = %t;
            plcloc=[plcloc;'net'+string(blk(blk_objs(bl),2+numofip))+'_1',' 2 4 0'];
            plcloc=[plcloc;'net'+string(blk(blk_objs(bl),2+numofip))+'_2',' 2 5 0'];
            plcloc=[plcloc;'net'+string(blk(blk_objs(bl),2+numofip))+'_3',' 2 6 0'];
            plcloc=[plcloc;'net'+string(blk(blk_objs(bl),2+numofip))+'_4',' 2 7 0'];
            plcloc=[plcloc;'net'+string(blk(blk_objs(bl),2+numofip))+'_5',' 2 8 0'];
            plcloc=[plcloc;'net'+string(blk(blk_objs(bl),2+numofip))+'_6',' 3 4 0'];
            plcloc=[plcloc;'net'+string(blk(blk_objs(bl),2+numofip))+'_7',' 3 5 0'];
            plcloc=[plcloc;'net'+string(blk(blk_objs(bl),2+numofip))+'_8',' 3 6 0'];
            plcloc=[plcloc;'net'+string(blk(blk_objs(bl),2+numofip))+'_9',' 3 7 0'];
            plcloc=[plcloc;'net'+string(blk(blk_objs(bl),2+numofip))+'_10',' 3 8 0'];
            plcloc=[plcloc;'net'+string(blk(blk_objs(bl),2+numofip))+'_11',' 6 6 0'];
            plcloc=[plcloc;'net'+string(blk(blk_objs(bl),2+numofip))+'_12',' 6 7 0'];
            plcloc=[plcloc;'net'+string(blk(blk_objs(bl),2+numofip))+'_13',' 6 8 0'];
            plcloc=[plcloc;'net'+string(blk(blk_objs(bl),2+numofip))+'_14',' 7 6 0'];
            plcloc=[plcloc;'net'+string(blk(blk_objs(bl),2+numofip))+'_15',' 7 7 0'];
            plcloc=[plcloc;'net'+string(blk(blk_objs(bl),2+numofip))+'_16',' 7 8 0'];
        end

        //*************************** IO PAD IN ********************************
    elseif(blk_name.entries(bl)=='pad_in')  then 
        fd_io= mopen (fname+'.pads','a+');  // DEDICATED PADS code
        for ss=1:scs_m.objs(bl).model.ipar(1)
            tmp_pad = strsplit(iopad_loc(loc_num,scs_m.objs(blk_objs(bl)).model.rpar(1+ss)).entries," ")
            if tmp_pad(3) == '3'  | tmp_pad(3)== '5' then tmp_pad(3) = '1';
            elseif tmp_pad(3) == '2' then tmp_pad(3) = '0';
            end 
            netout = 'net';
            if tmp_pad(4)=='#int[5]'|tmp_pad(4)=='#int[4]'|tmp_pad(4)=='#int[3]'|tmp_pad(4)=='#int[2]'|tmp_pad(4)=='#int[1]'|tmp_pad(4)=='#int[0]' then
                mputl(netout+ string(blk(blk_objs(bl),2+numofip)) + "_" + string(ss) + ' ' + iopad_loc(loc_num,scs_m.objs(blk_objs(bl)).model.rpar(1+ss)).entries,fd_io);
           else 
                mputl(netout+ string(blk(blk_objs(bl),2+numofip)) + "_" + string(ss) + ' ' + iopad_loc(loc_num,scs_m.objs(blk_objs(bl)).model.rpar(1+ss)).entries + 'tgate[' + tmp_pad(3)+ ']',fd_io);
            end
        end
        mclose(fd_io);

        //************************ IO PAD IN Analog ****************************
    elseif(blk_name.entries(bl)=='pad_ina')  then
        fd_io= mopen (fname+'.pads','a+');  // DEDICATED PADS code
        for ss=1:scs_m.objs(bl).model.ipar(1)
            tmp_pad = strsplit(iopad_loc(loc_num,scs_m.objs(blk_objs(bl)).model.rpar(1+ss)).entries," ")
            if tmp_pad(3) == '3' then tmp_pad(3) = '1'; end
            mputl('net'+ string(blk(blk_objs(bl),2+numofip)) + "_" + string(ss) + ' ' + iopad_loc(loc_num,scs_m.objs(blk_objs(bl)).model.rpar(1+ss)).entries + 'ana_buff_in[' + tmp_pad(3)+ ']',fd_io);
        end
        mclose(fd_io);

        //************************ IO PAD IN Digital ***************************
    elseif(blk_name.entries(bl)=='pad_ind')  then
        fd_io= mopen (fname+'.pads','a+');  // DEDICATED PADS code
        for ss=1:scs_m.objs(bl).model.ipar(1)
            tmp_pad = strsplit(iopad_loc(loc_num,scs_m.objs(blk_objs(bl)).model.rpar(1+ss)).entries," ")
            if tmp_pad(3) == '3' then tmp_pad(3) = '1'; end
        mputl('net'+ string(blk(blk_objs(bl),2+numofip)) + "_" + string(ss) + ' ' + iopad_loc(loc_num,scs_m.objs(blk_objs(bl)).model.rpar(1+ss)).entries + 'dig_buff_in[' + tmp_pad(3)+ ']',fd_io);        end
        mclose(fd_io);

        //**************************** IO PAD OUT ******************************
    elseif(blk_name.entries(bl)=='pad_out')  then
        fd_io= mopen (fname+'.pads','a+');  // DEDICATED PADS code
        for ss=1:scs_m.objs(bl).model.ipar(1)
            tmp_pad = strsplit(iopad_loc(loc_num,scs_m.objs(blk_objs(bl)).model.rpar(1+ss)).entries," ")
            if tmp_pad(3) == '3'  | tmp_pad(3)== '5' then tmp_pad(3) = '1';
            elseif tmp_pad(3) == '2' then tmp_pad(3) = '0';
            end
           if tmp_pad(4)=='#int[5]'|tmp_pad(4)=='#int[4]'|tmp_pad(4)=='#int[3]'|tmp_pad(4)=='#int[2]'|tmp_pad(4)=='#int[1]'|tmp_pad(4)=='#int[0]' then
           mputl('out:net'+ string(blk(blk_objs(bl),2)) + "_" + string(ss) + ' ' + iopad_loc(loc_num,scs_m.objs(blk_objs(bl)).model.rpar(1+ss)).entries,fd_io);
           else 
            mputl('out:net'+ string(blk(blk_objs(bl),2)) + "_" + string(ss) + ' ' + iopad_loc(loc_num,scs_m.objs(blk_objs(bl)).model.rpar(1+ss)).entries + 'tgate[' + tmp_pad(3)+ ']',fd_io);
        end
        end
        mclose(fd_io);   

        //************************** IO PAD OUT Analog *************************
    elseif(blk_name.entries(bl)=='pad_outa')  then
        fd_io= mopen (fname+'.pads','a+');  // DEDICATED PADS code
        for ss=1:scs_m.objs(bl).model.ipar(1)
            tmp_pad = strsplit(iopad_loc(loc_num,scs_m.objs(blk_objs(bl)).model.rpar(1+ss)).entries," ")
            if tmp_pad(3) == '3' then tmp_pad(3) = '1'; end
            mputl('out:net'+ string(blk(blk_objs(bl),2)) + "_" + string(ss) + ' ' + iopad_loc(loc_num,scs_m.objs(blk_objs(bl)).model.rpar(1+ss)).entries + 'ana_buff_out[' + tmp_pad(3)+ ']',fd_io);
        end
        mclose(fd_io);   

        //************************** IO PAD OUT Digital **************************
    elseif(blk_name.entries(bl)=='pad_outd')  then
        fd_io= mopen (fname+'.pads','a+');  // DEDICATED PADS code
        for ss=1:scs_m.objs(bl).model.ipar(1)
            tmp_pad = strsplit(iopad_loc(loc_num,scs_m.objs(blk_objs(bl)).model.rpar(1+ss)).entries," ")
            if tmp_pad(3) == '3' then tmp_pad(3) = '1'; end
            mputl('out:net'+ string(blk(blk_objs(bl),2)) + "_" + string(ss) + ' ' + iopad_loc(loc_num,scs_m.objs(blk_objs(bl)).model.rpar(1+ss)).entries + 'dig_buff_out[' + tmp_pad(3)+ ']',fd_io);     
        end
        mclose(fd_io);   

        //**************************** Join ********************************
    elseif(blk_name.entries(bl)=='join')  then
        for ss= 1:scs_m.objs(blk_objs(bl)).model.rpar(1) 
            spl_fix=[spl_fix;'net'+ string(blk(blk_objs(bl),ss+1+numofip))+"_",'net'+string(blk(blk_objs(bl),2))+"_"]
            spl_fix=[spl_fix;'out:net'+ string(blk(blk_objs(bl),ss+1+numofip))+"_",'out:net'+string(blk(blk_objs(bl),2))+"_"]
            spl_fix_chg=%t;
        end

        //**************************** Ladder Filter *********yeahbuddy******
    elseif (blk_name.entries(bl) =='ladder_filter') then
        mputl("# Ladder Filter",fd_w);
        for ss=1:scs_m.objs(bl).model.ipar(1)
            ladder_filter_str= '.subckt ladder_filter in[0]=net' + string(blk(blk_objs(bl),2)) + '_'+string(ss)+' in[1]=net'+string(blk(blk_objs(bl),3))+'_'+string(ss)+' out[0]=net' +string(blk(blk_objs(bl),2+numofip))+'_'+string(ss)+' out[1]=net'+string(blk(blk_objs(bl),3+numofip))+'_'+string(ss)+' out[2]=net' + string(blk(blk_objs(bl),4+numofip))+'_'+string(ss) + ' #c4_ota_bias[0] =" +string(sprintf('%1.3e',scs_m.objs(blk_objs(bl)).model.opar(3*ss-1)))+"&c4_ota_bias[1] =" +string(sprintf('%1.3e',scs_m.objs(blk_objs(bl)).model.opar(3*ss)))+"&ladder_filter_fg[0] =0&c4_ota_p_bias[0] =500e-9&c4_ota_n_bias[0] =500e-9&c4_ota_p_bias[1] =500e-9&c4_ota_n_bias[1] =500e-9&speech_peakotabias[0] =2e-6';
            mputl(ladder_filter_str,fd_w);
            mputl("  ",fd_w);
        end

        //**************************** LOOKUP Table ********************************
    elseif(blk_name.entries(bl)=='lkuptb')  then
        mputl("# LOOKUP Table-> "+scs_m.objs(blk_objs(bl)).model.opar(1),fd_w);
        truecase=strsplit(scs_m.objs(blk_objs(bl)).model.opar(2)," ")
        if scs_m.objs(bl).model.ipar(1) == 1 then
            lkuptb_str='.names'+' net' + string(blk(blk_objs(bl),2))+"_" + string(1)+' tg4logic_1 tg4logic_2 tg4logic_3'+' net'+ string(blk(blk_objs(bl),2+numofip))+"_" + string(1);
        end
        if scs_m.objs(bl).model.ipar(1) == 2 then
            lkuptb_str='.names'+' net' + string(blk(blk_objs(bl),2))+"_" + string(1)+' net'+ string(blk(blk_objs(bl),3))+"_" + string(1)+' tg4logic_1 tg4logic_2'+' net'+ string(blk(blk_objs(bl),2+numofip))+"_" + string(1);
        end
        if scs_m.objs(bl).model.ipar(1) == 3 then
            lkuptb_str='.names'+' net' + string(blk(blk_objs(bl),2))+"_" + string(1)+' net'+ string(blk(blk_objs(bl),3))+"_" + string(1)+' net' + string(blk(blk_objs(bl),4))+"_" + string(1)+' tg4logic_1'+' net'+ string(blk(blk_objs(bl),2+numofip))+"_" + string(1);
        end
        if scs_m.objs(bl).model.ipar(1) == 4 then
            lkuptb_str='.names'+' net' + string(blk(blk_objs(bl),2))+"_" + string(1)+' net'+ string(blk(blk_objs(bl),3))+"_" + string(1)+' net' + string(blk(blk_objs(bl),4))+"_" + string(1)+' net'+ string(blk(blk_objs(bl),5))+"_" + string(1)+' net'+ string(blk(blk_objs(bl),2+numofip))+"_" + string(1);
        end
        mputl(lkuptb_str,fd_w);
        for i=1:size(truecase,1)
            mputl(truecase(i)+' 1',fd_w);
        end
        mputl("  ",fd_w)
        if scs_m.objs(bl).model.rpar(1) == 1 then
            plcvpr = %t;
            plcloc=[plcloc;'net'+string(blk(blk_objs(bl),2+numofip))+'_1',' '+string(scs_m.objs(bl).model.rpar(2))+' '+string(scs_m.objs(bl).model.rpar(3))+' 0'];
        end

        //**************************** LPF *************************************
    elseif (blk_name.entries(bl) =='lpf') then 
        mputl("# lpf",fd_w);
        for otabuf_i = 1:scs_m.objs(bl).model.rpar(1)
            lpf_str=".subckt lpf in[0]=net"+string(blk(blk_objs(bl),2))+ "_" + string(otabuf_i)+" out[0]=net"+ string(blk(blk_objs(bl),2+numofip))+ "_" + string(otabuf_i)+ " #ota_biasfb[0] =" +string(sprintf('%1.12f',scs_m.objs(blk_objs(bl)).model.rpar(2)))+" &lpf_fg[0] =0";
            lpfcap = scs_m.objs(blk_objs(bl)).model.rpar(3)
            select lpfcap
            case 1 then lpf_str= lpf_str +"&lpf_cap_1x[0] =0";
            case 2 then lpf_str= lpf_str +"&lpf_cap_2x[0] =0";
            case 3 then lpf_str= lpf_str +"&lpf_cap_3x[0] =0";
            case 4 then lpf_str= lpf_str +"&lpf_cap_3x[0] =0"+"&lpf_cap_1x[1] =0";
            case 5 then lpf_str= lpf_str +"&lpf_cap_3x[0] =0"+"&lpf_cap_2x[1] =0";
            case 6 then lpf_str= lpf_str +"&lpf_cap_3x[0] =0"+"&lpf_cap_2x[1] =0"+"&lpf_cap_1x[2] =0";
            case 18 then lpf_str= lpf_str +"&lpf_cap_3x[0] =0"+"&lpf_cap_2x[0] =0"+"&lpf_cap_1x[0] =0"+"&lpf_cap_3x[2] =0"+"&lpf_cap_2x[2] =0"+"&lpf_cap_1x[2] =0" +"&lpf_cap_3x[3] =0"+"&lpf_cap_2x[3] =0"+"&lpf_cap_1x[3] =0";
            else error("LPF capacitor cannot be compiled.");
            end
            mputl(lpf_str,fd_w);
            mputl("  ",fd_w);
        end

        //**************************** LPF OTA *********************************
    elseif(blk_name.entries(bl)=='lpfota')  then
        mputl("# LPF",fd_w);
        for ss=1:scs_m.objs(bl).model.ipar(1)
            ota_str= '.subckt ota in[0]=net' + string(blk(blk_objs(bl),2))+"_" + string(ss)+' in[1]=net'+ string(blk(blk_objs(bl),2+numofip))+"_" + string(ss)+' out[0]=net'+ string(blk(blk_objs(bl),2+numofip))+"_" + string(ss)+" #ota_bias =" +string(sprintf('%1.12f',scs_m.objs(blk_objs(bl)).model.rpar(ss)));
            mputl(ota_str,fd_w);
            mputl("  ",fd_w);
        end

        //**************************** LPF 2nd Order *********************************
    elseif(blk_name.entries(bl)=='lpf_2')  then
        mputl("# LPF 2nd Order",fd_w);
        for ss=1:scs_m.objs(bl).model.ipar(1)
            str= '.subckt lpf_2 in[0]=net' + string(blk(blk_objs(bl),2))+"_" + string(ss)+' out[0]=net'+ string(blk(blk_objs(bl),2+numofip))+"_" + string(ss)+" #lpf_2_fg[0] =0&lpf_2_otabias[0] =" +string(sprintf('%1.2e',scs_m.objs(blk_objs(bl)).model.rpar(2*ss-1)))+'&lpf_2_otabias[1] =" +string(sprintf('%1.2e',scs_m.objs(blk_objs(bl)).model.rpar(2*ss)));
            mputl(str,fd_w);
            mputl("  ",fd_w);
        end
    
        //**************************** Measure Volt (mite_adc) ****************************
    elseif (blk_name.entries(bl) =='meas_volt') then
        mputl("# MITE_ADC",fd_w);
        for meas = 1:scs_m.objs(bl).model.rpar(2)
            mputl(".subckt meas_volt_mite in[0]=net"+string(blk(blk_objs(bl),2))+'_'+ string(meas)+' out[0]=out_mite_adc #meas_fg =0.00001',fd_w);
            mputl("  ",fd_w);
        end
        MITE_ADC_check=1;
        fd_io= mopen (fname+'.pads','a+')
        select board_num
        case 2 then mputl("out:out_mite_adc 7 0 0 #tgate[0]",fd_io);
        case 3 then mputl("out:out_mite_adc 8 1 0 #int[0]",fd_io);
        end
        mclose(fd_io); 

        //**************************** Mismatch map (local swc) ***********************************
    elseif (blk_name.entries(bl) =='mmap_local_swc') then
        addvmm = %t;
        mputl("# mmap_local_swc",fd_w);
        for ss=1:scs_m.objs(bl).model.ipar(1)
            mmap_local_swc_str=".subckt mmap_local_swc in[0]=net"+string(blk(blk_objs(bl),2))+'_'+ string(ss)+" in[1]=net"+string(blk(blk_objs(bl),3))+'_'+ string(ss)+" in[2]=net"+string(blk(blk_objs(bl),4))+'_'+ string(ss)+" out[0]=net"+ string(blk(blk_objs(bl),2+numofip))+'_'+ string(ss)+" out[1]=net"+ string(blk(blk_objs(bl),3+numofip))+'_'+ string(ss)+" out[2]=net"+ string(blk(blk_objs(bl),4+numofip))+'_'+ string(ss)+" out[3]=net"+ string(blk(blk_objs(bl),5+numofip))+'_'+ string(ss)+" #mmap_ls_fg =0&mmap_ls_in_r"+string(scs_m.objs(blk_objs(bl)).model.rpar(4))+"_vdd =0&mmap_ls_in_r"+string(scs_m.objs(blk_objs(bl)).model.rpar(4))+" ="+string(sprintf('%1.2e',scs_m.objs(blk_objs(bl)).model.rpar(5)));
            mputl(mmap_local_swc_str,fd_w);
            mputl("  ",fd_w);
        end
        if scs_m.objs(bl).model.rpar(1) == 1 then
            plcvpr = %t;
            plcloc=[plcloc;'net'+string(blk(blk_objs(bl),2+numofip))+'_1',' '+string(scs_m.objs(bl).model.rpar(2))+' '+string(scs_m.objs(bl).model.rpar(3))+' 0'];
        end

        //****************************** Mismatch measure block **********************************
    elseif (blk_name.entries(bl) =='mismatch_meas') then
        addvmm = %t;
        mputl("#MISMATCH_MEAS "+string(bl),fd_w);
        for ss=1:scs_m.objs(bl).model.ipar(1)
            mputl(".subckt mismatch_meas in[0]=net"+string(blk(blk_objs(bl),2))+'_'+ string(ss)+ " in[1]=net" + string(blk(blk_objs(bl),3)) +'_'+ string(ss)+ " in[2]=net" + string(blk(blk_objs(bl),4)) +'_'+ string(ss)+" out[0]=net"+ string(blk(blk_objs(bl),2+numofip))+'_'+ string(ss)+" #mismatch_meas_fg =0&mismatch_meas_pfetg_fgotabias =2e-06&mismatch_meas_pfetg_fgotapbias =3e-06&mismatch_meas_pfetg_fgotanbias =6.92e-08&mismatch_meas_out_fgotabias =2e-06&mismatch_meas_out_fgotapbias =4.12e-07&mismatch_meas_out_fgotanbias =4.43e-08&mismatch_meas_cal_bias =50e-09",fd_w);
            mputl("  ",fd_w);
        end
        
        //****************************** MITE***********************************
    elseif (blk_name.entries(bl) =='mite_FG') then
      for ss=1:scs_m.objs(bl).model.opar(1)
        mputl("# MITE",fd_w);
        mputl(".subckt mite in[0]=net"+string(blk(blk_objs(bl),2))+"_"+string(ss)+" in[1]=net"+string(blk(blk_objs(bl),3))+"_"+string(ss)+" in[2]=net"+string(blk(blk_objs(bl),4))+"_"+string(ss)+" out=net"+ string(blk(blk_objs(bl),2+numofip))+"_"+string(ss)+" #mite_fg0 ="+string(sprintf('%1.3e',scs_m.objs(blk_objs(bl)).model.opar(2*ss))),fd_w);
        mputl("  ",fd_w);
     end
        //***************************** MITE2 **********************************
    elseif (blk_name.entries(bl) =='mite2') then
        mputl("# MITE2",fd_w);
        mputl(".subckt mite2 in[0]=net"+string(blk(blk_objs(bl),2))+ " in[1]=net"+string(blk(blk_objs(bl),3))+ " out[0]=net"+ string(blk(blk_objs(bl),2+numofip))+ " out[1]=net"+ string(blk(blk_objs(bl),3+numofip)),fd_w);
        mputl("  ",fd_w);

        //************************** MITE2_OUTPUT ******************************
    elseif (blk_name.entries(bl) =='mite2_output') then
        mputl("# MITE2_OUTPUT",fd_w);
        mputl(".subckt mite2 in[0]=net"+string(blk(blk_objs(bl),2))+ " in[1]=net"+string(blk(blk_objs(bl),3))+ " out[0]=net"+ string(blk(blk_objs(bl),2+numofip))+ " out[1]=net"+ string(blk(blk_objs(bl),3+numofip)),fd_w);
        mputl("  ",fd_w);
        exec("~/rasp30/prog_assembly/libs/scilab_code/output_compile.sce",-1);
        output_compile(1,1);

        //**************************** MULT ************************************
    elseif (blk_name.entries(bl) =='mult') then
        mputl("# MULT",fd_w);
        mputl(".subckt mult in[0]=net"+string(blk(blk_objs(bl),2))+'_'+ string(1)+ " in[1]=net"+string(blk(blk_objs(bl),3))+'_'+ string(1)+ " in[2]=net"+string(blk(blk_objs(bl),4))+'_'+ string(1)+ " in[3]=net"+string(blk(blk_objs(bl),5))+'_'+ string(1)+" out[0]=net"+ string(blk(blk_objs(bl),2+numofip))+'_'+ string(1)+" out[1]=net"+ string(blk(blk_objs(bl),3+numofip))+'_'+ string(1),fd_w);
        mputl("  ",fd_w);
        
        //************************* Common Drain ******************************
    elseif (blk_name.entries(bl) =='mux4_1') then
        mputl("# MUX4_1",fd_w);
        for ss=1:scs_m.objs(bl).model.ipar(1)
            cap_str= ".subckt mux4_1 in[0]=sel1 in[1]=net"+string(blk(blk_objs(bl),2))+'_'+ string(ss)+" in[2]=sel2 in[3]=net"+string(blk(blk_objs(bl),3))+'_'+ string(ss)+" in[4]=sel3 in[5]=net"+string(blk(blk_objs(bl),4))+'_'+ string(ss)+" in[6]=sel4 in[7]=net"+string(blk(blk_objs(bl),5))+'_'+ string(ss)+" out=net"+ string(blk(blk_objs(bl),2+numofip))+'_'+ string(ss) + " #mux4_1_fg[0] =0";
            mputl(cap_str,fd_w);
            mputl("  ",fd_w);
        end
        fd_io= mopen (fname+'.pads','a+');
        select board_num
        case 2 then
            mputl("sel1 13 0 1 #int[1]",fd_io);
            mputl("sel2 13 0 2 #int[2]",fd_io);
            mputl("sel3 13 0 3 #int[3]",fd_io);
            mputl("sel4 13 0 4 #int[4]",fd_io);
        case 3 then 
            mputl("sel1 0 12 5 #int[5]",fd_io);
            mputl("sel2 0 13 0 #int[0]",fd_io);
            mputl("sel3 0 13 1 #int[1]",fd_io);
            mputl("sel4 0 13 2 #int[2]",fd_io);
        end
        mclose(fd_io); 
        
        //****************************** NFET **********************************
    elseif (blk_name.entries(bl) =='nfet') then
        mputl("#NFET "+string(bl),fd_w);
        for ss=1:scs_m.objs(bl).model.ipar(1)
            mputl(".subckt nfet in[0]=net"+string(blk(blk_objs(bl),2))+'_'+ string(ss)+ " in[1]=net" + string(blk(blk_objs(bl),3)) +'_'+ string(ss)+ " out[0]=net"+ string(blk(blk_objs(bl),2+numofip))+'_'+ string(ss),fd_w);
            mputl("  ",fd_w);
        end
        
        //**************************** NFET GOLDEN *******************************
    elseif (blk_name.entries(bl) =='nfet_gldn') then
        mputl("# NFET GOLDEN",fd_w);
        mputl(".subckt nfet in[0]=net"+string(blk(blk_objs(bl),2))+'_1'+ " in[1]=net" + string(blk(blk_objs(bl),3)) +'_1'+ " out=net"+ string(blk(blk_objs(bl),2+numofip))+'_1',fd_w);
        mputl("  ",fd_w);
        plcloc=[plcloc;'net'+string(blk(blk_objs(bl),2+numofip))+'_1',' 3 '+string(nfetloc)+' 0'];
        nfetloc=2;

        //**************************** nfet i2v ***********************************
    elseif (blk_name.entries(bl) =='nfet_i2v') then
        mputl("# nfet_i2v",fd_w);
        for ss=1:scs_m.objs(bl).model.ipar(1)
            nfet_i2v_str=".subckt nfet_i2v in[0]=net"+string(blk(blk_objs(bl),2))+'_'+ string(ss)+" out=net"+ string(blk(blk_objs(bl),2+numofip))+'_'+ string(ss)+" #nfet_i2v_fg =0&nfet_i2v_otabias ="+string(sprintf('%1.2e',scs_m.objs(blk_objs(bl)).model.rpar(4)));
            mputl(nfet_i2v_str,fd_w);
            mputl("  ",fd_w);
        end
        if scs_m.objs(bl).model.rpar(1) == 1 then
            plcvpr = %t;
            plcloc=[plcloc;'net'+string(blk(blk_objs(bl),2+numofip))+'_1',' '+string(scs_m.objs(bl).model.rpar(2))+' '+string(scs_m.objs(bl).model.rpar(3))+' 0'];
        end

        //**************************** NMIRROR *********************************
    elseif (blk_name.entries(bl) =='nmirror') then
        mputl("#NMIRROR "+string(bl),fd_w);
        for ss=1:scs_m.objs(bl).model.ipar(1)
            nmirror_str= ".subckt nmirror in[0]=net"+string(blk(blk_objs(bl),2))+'_'+ string(ss)+" out=net"+ string(blk(blk_objs(bl),2+numofip))+'_' + string(ss);
            mputl(nmirror_str,fd_w);
            mputl("  ",fd_w);
        end
 //**************************** NMIRROR_vmm *********************************
    elseif (blk_name.entries(bl) =='nmirror_vmm') then
        mputl("#NMIRROR "+string(bl),fd_w);
        for ss=1:scs_m.objs(bl).model.opar(1)
            nmirror_str= ".subckt nmirror_vmm in[0]=vcc out=net"+ string(blk(blk_objs(bl),2+numofip))+'_' + string(ss)+" #nmirror_bias[0] =" +string(sprintf('%1.3e',scs_m.objs(blk_objs(bl)).model.opar(2*ss)));
            mputl(nmirror_str,fd_w);
            mputl("  ",fd_w);
        end

        //***************************** OTA ************************************
    elseif(blk_name.entries(bl)=='ota')  then
        mputl("#OTA "+string(bl),fd_w);
        for ss=1:scs_m.objs(bl).model.ipar(1)
            ota_str= '.subckt ota in[0]=net' + string(blk(blk_objs(bl),2))+"_" + string(ss)+' in[1]=net'+ string(blk(blk_objs(bl),3))+"_" + string(ss)+' out[0]=net'+ string(blk(blk_objs(bl),2+numofip))+"_" + string(ss)+" #ota_bias =" + string(sprintf('%e',scs_m.objs(blk_objs(bl)).model.rpar(1)));
            mputl(ota_str,fd_w);
            mputl("  ",fd_w);
        end

        //**************************** OTA Buffer ******************************
    elseif (blk_name.entries(bl) =='ota_buf') then 
    //plcvpr = %t; //Michelle
        mputl("# ota_buf",fd_w);
        for otabuf_i = 1:scs_m.objs(bl).model.rpar(2)
            mputl(".subckt ota_buf in[0]=net"+string(blk(blk_objs(bl),2))+ "_" + string(otabuf_i)+" out[0]=net"+ string(blk(blk_objs(bl),2+numofip))+ "_" + string(otabuf_i)+ " #ota_biasfb =" +string(sprintf('%1.12f',scs_m.objs(blk_objs(bl)).model.rpar(1))),fd_w);
            mputl("  ",fd_w);
			//plcloc=[plcloc;'net'+string(blk(blk_objs(bl),2+numofip))+'_'+ string(ss),' 1 14 0']; //Michelle
        end
        //**************************** OTA Buffer2 *****************************
    elseif (blk_name.entries(bl) =='ota_3') then 
        mputl("# ota_buffer",fd_w);
        for otabuf_i = 1:scs_m.objs(bl).model.rpar(2)
            mputl(".subckt ota_buffer in[0]=net"+string(blk(blk_objs(bl),2))+ "_" + string(otabuf_i)+" out[0]=net"+ string(blk(blk_objs(bl),2+numofip))+ "_" + string(otabuf_i)+ " #ota_biasfb =" +string(sprintf('%1.12f',scs_m.objs(blk_objs(bl)).model.rpar(1))),fd_w);
            mputl("  ",fd_w);
        end

        //*********************** Output floated *******************************
    elseif (blk_name.entries(bl) =='output_f') then

        //************************* Peak Detector ******************************
    elseif (blk_name.entries(bl) =='peakdet_block') then
        mputl("# PEAK DETECTOR",fd_w);
        for ss=1:scs_m.objs(bl).model.ipar(1)
            cap_str= ".subckt peak_detector in[0]=net"+string(blk(blk_objs(bl),2))+'_'+ string(ss)+" in[1]=net" + string(blk(blk_objs(bl),3))+'_'+ string(ss) + " out=net"+ string(blk(blk_objs(bl),2+numofip))+'_'...
            + string(ss) + " #peak_detector_fg[0] =0&ota_bias[0] =" +string(sprintf('%1.12f',scs_m.objs(blk_objs(bl)).model.rpar(ss)));
            capcap = scs_m.objs(blk_objs(bl)).model.rpar(scs_m.objs(blk_objs(bl)).model.ipar(1)+ss)
            select capcap
            case 1 then cap_str= cap_str +"&c4_cap_1x[0] =0";
            case 2 then cap_str= cap_str +"&c4_cap_2x[0] =0";
            case 3 then cap_str= cap_str +"&c4_cap_3x[0] =0";
            case 4 then cap_str= cap_str +"&c4_cap_3x[0] =0"+"&c4_cap_1x[0] =0";
            case 5 then cap_str= cap_str +"&c4_cap_3x[0] =0"+"&c4_cap_2x[0] =0";
            case 6 then cap_str= cap_str +"&c4_cap_3x[0] =0"+"&c4_cap_2x[0] =0"+"&c4_cap_1x[0] =0";
            else error("Capacitor for Peak Detector cannot be compiled.");
            end
            mputl(cap_str,fd_w);
            mputl("  ",fd_w);
        end

        //************************ Out Port *Make Block* ******************************
    elseif (scs_m.objs(bl).gui== "out_port") then
        disp('out_port');

        //********************** Peak Detector Separate ************************
    elseif (blk_name.entries(bl) =='peak_det') then
        mputl("# PEAK DETECTOR",fd_w);
        for ss=1:scs_m.objs(bl).model.ipar(1)
            peak_str= '.subckt peak_detector in[0]=net" + string(blk(blk_objs(bl),2))+ '_' + string(ss)+' in[1]=net"+ string(blk(blk_objs(bl),3))+'_'+string(1)+' out[0]=net" + string(blk(blk_objs(bl),2+numofip))+ '_' + string(ss)+' #peak_ota_bias[0] =100e-9&peak_detector_fg[0] =0&peak_ota_p_bias[0] =100e-9&peak_ota_n_bias[0] =100e-9&peak_ota_small_cap[0] =0';
            mputl(peak_str,fd_w);
            mputl("  ",fd_w);
        end

        //****************************** PFET **********************************
    elseif (blk_name.entries(bl) =='pfet') then
        mputl("#PFET "+string(bl),fd_w);
        for ss=1:scs_m.objs(bl).model.ipar(1)
            mputl(".subckt pfet in[0]=net"+string(blk(blk_objs(bl),3))+'_'+string(ss)+" in[1]=net" + string(blk(blk_objs(bl),2))+'_'+string(ss)+" out=net"+ string(blk(blk_objs(bl),2+numofip))+'_'+string(ss),fd_w);
            mputl("  ",fd_w);
        end
        fd_info= mopen('info.txt','a+');
        mputl('Pfet gate=net"+string(blk(blk_objs(bl),3))+" source=net" + string(blk(blk_objs(bl),2))',fd_info);
        mclose(fd_info);

        //*************************** PFET GOLDEN *******************************
    elseif (blk_name.entries(bl) =='pfet_gldn') then
        mputl("# PFET GOLDEN",fd_w);
        mputl(".subckt pfet in[0]=net"+string(blk(blk_objs(bl),3))+'_1'+" in[1]=net" + string(blk(blk_objs(bl),2))+'_1' + " out=net"+ string(blk(blk_objs(bl),2+numofip))+'_1',fd_w);
        mputl("  ",fd_w)
        plcloc=[plcloc;'net'+string(blk(blk_objs(bl),2+numofip))+'_1',' 3 '+string(pfetloc)+' 0'];
        pfetloc =2;

        //**************************** pfet i2v ***********************************
    elseif (blk_name.entries(bl) =='pfet_i2v') then
        mputl("# pfet_i2v",fd_w);
        for ss=1:scs_m.objs(bl).model.ipar(1)
            nfet_i2v_str=".subckt pfet_i2v in[0]=net"+string(blk(blk_objs(bl),2))+'_'+ string(ss)+" out=net"+ string(blk(blk_objs(bl),2+numofip))+'_'+ string(ss)+" #pfet_i2v_fg =0&pfet_i2v_otabias ="+string(sprintf('%1.2e',scs_m.objs(blk_objs(bl)).model.rpar(4)));
            mputl(nfet_i2v_str,fd_w);
            mputl("  ",fd_w);
        end
        if scs_m.objs(bl).model.rpar(1) == 1 then
            plcvpr = %t;
            plcloc=[plcloc;'net'+string(blk(blk_objs(bl),2+numofip))+'_1',' '+string(scs_m.objs(bl).model.rpar(2))+' '+string(scs_m.objs(bl).model.rpar(3))+' 0'];
        end

        //**************************** Compiled RAMP ADC ****************************
    elseif (blk_name.entries(bl) =='Ramp_ADC') then
        mputl("# Ramp_ADC*",fd_w);
        mputl(".subckt ramp_fe in[0]=net'+string(blk(blk_objs(bl),2))+'_1 out=out_ramp_adc #ramp_fe_fg[0] =0&ramp_pfetinput[0] =10e-9&c4_ota_bias[0] =2e-6&c4_ota_p_bias[0] =2e-6&c4_ota_n_bias[0] =1.5e-6&speech_peakotabias[0] =2e-6&c4_ota_bias[1] =2e-6&c4_ota_p_bias[1] =500e-9&c4_ota_n_bias[1] =500e-9&ramp_pfetinput[1] =30e-9",fd_w);
        mputl("  ",fd_w)
        RAMP_ADC_check=1;
        fd_io= mopen (fname+'.pads','a+');
        select board_num
        case 2 then mputl("out:out_ramp_adc 15 1 5 #int[5]",fd_io);
        case 3 then mputl("out:out_ramp_adc 1 15 3 #int[3]",fd_io);
        end
         plcvpr = %t;
         select board_num
      case 2 then   plcloc=[plcloc;'out_ramp_adc",' 6	1	0'];
      case 3 then  plcloc=[plcloc;'out_ramp_adc",' 1	 1	0'];
       end
        mclose(fd_io); 

        //************************** Shift Register ****************************
    elseif (blk_name.entries(bl) =='sft_reg') then
        mputl("# 4-bit Shift Register",fd_w);
        mputl(".subckt SR4 in[0]=net"+string(blk(blk_objs(bl),2))+'_1'+" in[1]=net" + string(blk(blk_objs(bl),3))+'_1' + "in[2]=net"+string(blk(blk_objs(bl),4))+'_1'+" in[3]=net" + string(blk(blk_objs(bl),5))+'_1' +" out[0]=net"+ string(blk(blk_objs(bl),2+numofip))+'_1'+" out[1]=net"+ string(blk(blk_objs(bl),3+numofip))+'_1'+" out[2]=net"+ string(blk(blk_objs(bl),4+numofip))+'_1'+" out[3]=net"+ string(blk(blk_objs(bl),5+numofip))+'_1'+" out[4]=net"+ string(blk(blk_objs(bl),6+numofip))+'_1'+" out[5]=net"+ string(blk(blk_objs(bl),7+numofip))+'_1'+" out[6]=net"+ string(blk(blk_objs(bl),8+numofip))+'_1'+"#SR_fg =0&vmm_volatile =0",fd_w);
        mputl("  ",fd_w)

        //************** Shift Register 1input 16outputs ***********************
    elseif (blk_name.entries(bl) =='sr_1i_16o') then
        addvmm = %t;
        mputl("# Shift register 1input 16outputs",fd_w);
        sr_1i_16o_str= ".subckt in2in_x1 in[0]=fbout_"+string(internal_number)+"_1"+" in[1]=net"+string(blk(blk_objs(bl),5))+"_1"+" in[2]=net"+string(blk(blk_objs(bl),5))+"_internal"+" out[0]=fbout_"+string(internal_number)+"_1";
        mputl(sr_1i_16o_str,fd_w);
        mputl("  ",fd_w);
        sr_1i_16o_str= ".subckt sftreg2 in[0]=net"+string(blk(blk_objs(bl),2))+"_1"+" in[1]=net"+string(blk(blk_objs(bl),3))+"_1"+" in[2]=net"+string(blk(blk_objs(bl),4))+"_1"+" out[0]=net"+string(blk(blk_objs(bl),5))+"_internal"+" out[1]=net"+string(blk(blk_objs(bl),2+numofip))+"_1"+" out[2]=net"+string(blk(blk_objs(bl),3+numofip))+"_1"+" out[3]=net"+string(blk(blk_objs(bl),4+numofip))+"_1";
        for ss=1:scs_m.objs(bl).model.ipar(1)
            sr_1i_16o_str=sr_1i_16o_str+" out["+string(ss+3)+"]=net"+string(blk(blk_objs(bl),5+numofip))+"_"+string(ss);
        end
        sr_1i_16o_str=sr_1i_16o_str+" #sftreg2_fg =0";
        mputl(sr_1i_16o_str,fd_w);
        mputl("  ",fd_w);
        if scs_m.objs(bl).model.rpar(1) == 1 then
            plcvpr = %t;
            plcloc=[plcloc;'net'+string(blk(blk_objs(bl),5))+'_internal',' '+string(scs_m.objs(bl).model.rpar(2))+' '+string(scs_m.objs(bl).model.rpar(3))+' 0'];
        end
        internal_number=internal_number+1;

        //***** Shift register 1input 16outputs (non vecterized version) *******
    elseif (blk_name.entries(bl) =='sr_1i_16o_nv') then
        addvmm = %t;
        mputl("# Shift register 1input 16outputs",fd_w);
        for ss=1:scs_m.objs(bl).model.ipar(1)
            sr_1i_16o_nv_str= ".subckt in2in_x1 in[0]=fbout_"+string(internal_number)+"_"+string(ss)+" in[1]=net"+string(blk(blk_objs(bl),5))+"_"+string(ss)+" in[2]=net"+string(blk(blk_objs(bl),5))+"_internal_"+string(ss)+" out[0]=fbout_"+string(internal_number)+"_"+string(ss);
            mputl(sr_1i_16o_nv_str,fd_w);
            mputl("  ",fd_w);
            sr_1i_16o_nv_str= ".subckt sftreg2 in[0]=net"+string(blk(blk_objs(bl),2))+"_1"+" in[1]=net"+string(blk(blk_objs(bl),3))+"_1"+" in[2]=net"+string(blk(blk_objs(bl),4))+"_1"+" out[0]=net"+string(blk(blk_objs(bl),5))+"_internal_"+string(ss)+" out[1]=net"+string(blk(blk_objs(bl),2+numofip))+"_"+string(ss)+" out[2]=net"+string(blk(blk_objs(bl),3+numofip))+"_"+string(ss)+" out[3]=net"+string(blk(blk_objs(bl),4+numofip))+"_"+string(ss)+" out[4]=net"+string(blk(blk_objs(bl),5+numofip))+"_"+string(ss)+" out[5]=net"+string(blk(blk_objs(bl),6+numofip))+"_"+string(ss)+" out[6]=net"+string(blk(blk_objs(bl),7+numofip))+"_"+string(ss)+" out[7]=net"+string(blk(blk_objs(bl),8+numofip))+"_"+string(ss)+" out[8]=net"+string(blk(blk_objs(bl),9+numofip))+"_"+string(ss)+" out[9]=net"+string(blk(blk_objs(bl),10+numofip))+"_"+string(ss)+" out[10]=net"+string(blk(blk_objs(bl),11+numofip))+"_"+string(ss)+" out[11]=net"+string(blk(blk_objs(bl),12+numofip))+"_"+string(ss)+" out[12]=net"+string(blk(blk_objs(bl),13+numofip))+"_"+string(ss)+" out[13]=net"+string(blk(blk_objs(bl),14+numofip))+"_"+string(ss)+" out[14]=net"+string(blk(blk_objs(bl),15+numofip))+"_"+string(ss)+" out[15]=net"+string(blk(blk_objs(bl),16+numofip))+"_"+string(ss)+" out[16]=net"+string(blk(blk_objs(bl),17+numofip))+"_"+string(ss)+" out[17]=net"+string(blk(blk_objs(bl),18+numofip))+"_"+string(ss)+" out[18]=net"+string(blk(blk_objs(bl),19+numofip))+"_"+string(ss)+" out[19]=net"+string(blk(blk_objs(bl),20+numofip))+"_"+string(ss)+" #sftreg2_fg =0";
            mputl(sr_1i_16o_nv_str,fd_w);
            mputl("  ",fd_w);
        end
        internal_number=internal_number+1;
        
        //*************** Shift register 16inputs 1output **********************
    elseif (blk_name.entries(bl) =='sr_4i_1o') then
        addvmm = %t;
        mputl("# Shift register 4inputs 1output",fd_w);
        sr_4i_1o_str= ".subckt sftreg";
        for ss=1:scs_m.objs(bl).model.ipar(1)
            sr_4i_1o_str=sr_4i_1o_str+" in["+string(ss-1)+"]=net"+string(blk(blk_objs(bl),2))+"_"+string(ss);
        end
        for ss=1:scs_m.objs(bl).model.ipar(1)
            sr_4i_1o_str=sr_4i_1o_str+" in["+string(ss+4-1)+"]=net"+string(blk(blk_objs(bl),2))+"_"+string(ss);
        end
        for ss=1:scs_m.objs(bl).model.ipar(1)
            sr_4i_1o_str=sr_4i_1o_str+" in["+string(ss+8-1)+"]=net"+string(blk(blk_objs(bl),2))+"_"+string(ss);
        end
        for ss=1:scs_m.objs(bl).model.ipar(1)
            sr_4i_1o_str=sr_4i_1o_str+" in["+string(ss+12-1)+"]=net"+string(blk(blk_objs(bl),2))+"_"+string(ss);
        end
        sr_4i_1o_str=sr_4i_1o_str+" in[16]=net"+string(blk(blk_objs(bl),3))+"_1"+" in[17]=net"+string(blk(blk_objs(bl),4))+"_1"+" in[18]=net"+string(blk(blk_objs(bl),5))+"_1"+" out[0]=net"+string(blk(blk_objs(bl),2+numofip))+"_1"+" out[1]=net"+string(blk(blk_objs(bl),3+numofip))+"_1"+" out[2]=net"+string(blk(blk_objs(bl),4+numofip))+"_1"+" out[3]=net"+string(blk(blk_objs(bl),5+numofip))+"_1 #sftreg_fg =0";
        mputl(sr_4i_1o_str,fd_w);
        mputl("  ",fd_w);
            select board_num
                case 2 then plcloc=[plcloc;"net"+string(blk(blk_objs(bl),2+numofip))+"_1",' 10 7 0'];
                // case 3 then plcloc=[plcloc;"net"+string(blk(blk_objs(bl),2+numofip))+"_1",' 5	2 0'];  // will be done.
            end
        
        //*************** Shift register 16inputs 1output **********************
    elseif (blk_name.entries(bl) =='sr_16i_1o') then
    sftreg_count=sftreg_count+1;//Sahil added.Cant figure out the best way to handle multiple shift registers which are not vectorized for plcloc
        addvmm = %t;
        mputl("# Shift register 16inputs 1output",fd_w);
        sr_1i_16o_str= ".subckt sftreg";
        if chip_num=='13' then
        for ss=1:scs_m.objs(bl).model.ipar(1)
                sr_1i_16o_str=sr_1i_16o_str+" in["+string(ss-1)+"]=net"+string(blk(blk_objs(bl),2))+"_"+string(ss);
            end
            sr_1i_16o_str=sr_1i_16o_str+" in[16]=net"+string(blk(blk_objs(bl),3))+"_1"+" in[17]=net"+string(blk(blk_objs(bl),4))+"_1"+" in[18]=net"+string(blk(blk_objs(bl),5))+"_1"+" out[0]=net"+string(blk(blk_objs(bl),2+numofip))+"_1 #sftreg_fg =0";
            mputl(sr_1i_16o_str,fd_w);
            mputl("  ",fd_w);
            plcloc=[plcloc;"net"+string(blk(blk_objs(bl),2+numofip))+"_1",' 11 2 0'];
            else
            for ss=1:scs_m.objs(bl).model.ipar(1)
                sr_1i_16o_str=sr_1i_16o_str+" in["+string(ss-1)+"]=net"+string(blk(blk_objs(bl),2))+"_"+string(ss);
            end
                for ss=scs_m.objs(bl).model.ipar(1)+1:16
                sr_1i_16o_str=sr_1i_16o_str+" in["+string(ss-1)+"]=net"+string(blk(blk_objs(bl),4))+"_1";
            end
            
            sr_1i_16o_str=sr_1i_16o_str+" in[16]=net"+string(blk(blk_objs(bl),3))+"_1"+" in[17]=net"+string(blk(blk_objs(bl),4))+"_1"+" in[18]=net"+string(blk(blk_objs(bl),5))+"_1"+" out[0]=net"+string(blk(blk_objs(bl),2+numofip))+"_1 #sftreg_fg =0";
    //out[1]=net"+string(blk(blk_objs(bl),3+numofip))+"_1"+" out[2]=net"+string(blk(blk_objs(bl),4+numofip))+"_1"+" out[3]=net"+string(blk(blk_objs(bl),5+numofip))+"_1"+" 
            select board_num
            case 2 then 
            plcloc=[plcloc;"net"+string(blk(blk_objs(bl),2+numofip))+"_1",' 11 '+string(sftreg_count)+' 0'];
            case 3 then 
            plcloc=[plcloc;"net"+string(blk(blk_objs(bl),2+numofip))+"_1",' 5 '+string(sftreg_count)+' 0'];  
            end
            mputl(sr_1i_16o_str,fd_w)
            mputl("  ",fd_w)
        end
       //global sftreg_check
        sftreg_check=1;
        
        //**** Shift Register 16inputs 1output (non vecterized version) ********
    elseif (blk_name.entries(bl) =='sr_16i_1o_nv') then
        addvmm = %t;
        mputl("# Shift register 16inputs 1output",fd_w);
        for ss=1:scs_m.objs(bl).model.ipar(1)
            sr_1i_16o_nv_str= ".subckt sftreg in[0]=net"+string(blk(blk_objs(bl),2))+"_"+string(ss)+" in[1]=net"+string(blk(blk_objs(bl),3))+"_"+string(ss)+" in[2]=net"+string(blk(blk_objs(bl),4))+"_"+string(ss)+" in[3]=net"+string(blk(blk_objs(bl),5))+"_"+string(ss)+" in[4]=net"+string(blk(blk_objs(bl),6))+"_"+string(ss)+" in[5]=net"+string(blk(blk_objs(bl),7))+"_"+string(ss)+" in[6]=net"+string(blk(blk_objs(bl),8))+"_"+string(ss)+" in[7]=net"+string(blk(blk_objs(bl),9))+"_"+string(ss)+" in[8]=net"+string(blk(blk_objs(bl),10))+"_"+string(ss)+" in[9]=net"+string(blk(blk_objs(bl),11))+"_"+string(ss)+" in[10]=net"+string(blk(blk_objs(bl),12))+"_"+string(ss)+" in[11]=net"+string(blk(blk_objs(bl),13))+"_"+string(ss)+" in[12]=net"+string(blk(blk_objs(bl),14))+"_"+string(ss)+" in[13]=net"+string(blk(blk_objs(bl),15))+"_"+string(ss)+" in[14]=net"+string(blk(blk_objs(bl),16))+"_"+string(ss)+" in[15]=net"+string(blk(blk_objs(bl),17))+"_"+string(ss)+" in[16]=net"+string(blk(blk_objs(bl),18))+"_1"+" in[17]=net"+string(blk(blk_objs(bl),19))+"_1"+" in[18]=net"+string(blk(blk_objs(bl),20))+"_1"+" out[0]=net"+string(blk(blk_objs(bl),2+numofip))+"_"+string(ss)+" out[1]=net"+string(blk(blk_objs(bl),3+numofip))+"_"+string(ss)+" out[2]=net"+string(blk(blk_objs(bl),4+numofip))+"_"+string(ss)+" out[3]=net"+string(blk(blk_objs(bl),5+numofip))+"_"+string(ss)+" #sftreg_fg =0";
            mputl(sr_1i_16o_nv_str,fd_w);
            mputl("  ",fd_w);
        end
        
        //**************************** sigmadelta **************************************
    elseif (blk_name.entries(bl) =='sigma_delta') then
        mputl("# sigmadelta",fd_w);
        for ss=1:scs_m.objs(bl).model.ipar(1)
            sigma_str= '.subckt sigma_delta_fe in[0]=net' + string(blk(blk_objs(bl),2))+"_"+ string(ss) +" in[1]=net"+string(blk(blk_objs(bl),3))+"_1 in[2]=net"+string(blk(blk_objs(bl),4))+"_1 out[0]=net'+ string(blk(blk_objs(bl),2+numofip))+"_" + string(ss)+" #sd_ota_bias[0] =" +string(sprintf('%1.3e',scs_m.objs(blk_objs(bl)).model.rpar(3*ss-2)))+"&sd_ota_bias[1] =" +string(sprintf('%1.3e',scs_m.objs(blk_objs(bl)).model.rpar(3*ss)))+"&sd_ota_bias[2] =" +string(sprintf('%1.3e',scs_m.objs(blk_objs(bl)).model.rpar(3*ss-1)))+"&sigma_delta_fe_fg[0] =0&sd_ota_bias[3] =2e-6&sd_ota_p_bias[0] =500e-9&sd_ota_n_bias[0] =700e-9&sd_ota_p_bias[1] =500e-9&sd_ota_n_bias[1] =700e-9";
            mputl(sigma_str,fd_w);
            mputl("  ",fd_w);
        end

        //**************************** Speech **********************************
    elseif (blk_name.entries(bl) =='speech') then
    addvmm = %t;
        mputl("# speech",fd_w);
        for ss=1:scs_m.objs(bl).model.ipar(1)
            speech_str= '.subckt speech in[0]=net' + string(blk(blk_objs(bl),2))+"_1 in[1]=net"+string(blk(blk_objs(bl),3))+"_1 in[2]=vcc out[0]=net'+ string(blk(blk_objs(bl),2+numofip))+"_" + string(ss)+" out[1]=net'+ string(blk(blk_objs(bl),3+numofip))+"_" + string(ss)+" #c4_ota_bias[0] =" +string(sprintf('%1.3e',scs_m.objs(blk_objs(bl)).model.rpar(2*ss-1)))+"&c4_ota_bias[1] =" +string(sprintf('%1.3e',scs_m.objs(blk_objs(bl)).model.rpar(2*ss)))+"&speech_fg[0] =0&c4_ota_p_bias[0] =105e-9&c4_ota_n_bias[0] =105e-9&c4_ota_p_bias[1] =105e-9&c4_ota_n_bias[1] =105e-9&speech_peakotabias[0] =100e-9&speech_pfetbias[0] =2e-11&speech_peakotabias[1] =2e-9";
            mputl(speech_str,fd_w);
            mputl("  ",fd_w);
             select board_num
             
            case 2 then plcloc=[plcloc;'net'+string(blk(blk_objs(bl),2+numofip))+'_'+ string(ss),' 6 '+string(ss)+' 0'];
            case 3 then plcloc=[plcloc;'net'+string(blk(blk_objs(bl),2+numofip))+'_'+ string(ss),' 1 '+string(ss)+' 0'];   
        end
        end

        //**************************** SOS **********************************
    elseif (blk_name.entries(bl) =='SOS') then
        mputl("# SOS",fd_w);
        for ss=1:scs_m.objs(bl).model.ipar(1)
            SOS_str= '.subckt speech in[0]=net' + string(blk(blk_objs(bl),2))+"_" + string(ss)+" out[0]=net'+ string(blk(blk_objs(bl),2+numofip))+"_" + string(ss)+" #c4_ota_bias[0] =" +string(sprintf('%1.3e',scs_m.objs(blk_objs(bl)).model.rpar(3*ss-1)))+"&c4_ota_bias[1] =" +string(sprintf('%1.3e',scs_m.objs(blk_objs(bl)).model.rpar(3*ss-2)))+"&HOP_bif_fg[0] =0&c4_ota_p_bias[0] =100e-9&c4_ota_n_bias[0] =100e-9&c4_ota_p_bias[1] =100e-9c4_ota_n_bias[1] =100e-9&speech_peakotabias[0] =" +string(sprintf('%1.3e',scs_m.objs(blk_objs(bl)).model.rpar(3*ss)));
            mputl(SOS_str,fd_w)
            mputl("  ",fd_w)
        end

        //**************************** TGATE ***********************************
    elseif (blk_name.entries(bl) =='tgate') then
        mputl("#TGATE "+string(bl),fd_w);
        for ss=1:scs_m.objs(bl).model.ipar(1)
            mputl(".subckt tgate in[0]=net"+string(blk(blk_objs(bl),2))+"_" + string(ss)+" in[1]=net" + string(blk(blk_objs(bl),3))+"_" + string(ss)+" out=net"+ string(blk(blk_objs(bl),2+numofip))+"_" + string(ss),fd_w);
            mputl("  ",fd_w);
        end
        if scs_m.objs(bl).model.rpar(1) == 1 then
            plcvpr = %t;
            plcloc=[plcloc;'net'+string(blk(blk_objs(bl),2+numofip))+'_1',' '+string(scs_m.objs(bl).model.rpar(2))+' '+string(scs_m.objs(bl).model.rpar(3))+' 0'];
        end
        
         //**************************** TGATE ***********************************
    elseif (blk_name.entries(bl) =='tgate_vec') then
        for ss=1:scs_m.objs(bl).model.ipar(1)
            mputl("# TGATE ",fd_w);
             Tgate_str= '.subckt tgate in[0]=net"+string(blk(blk_objs(bl),2))+'_'+string(ss)+" in[1]=net" + string(blk(blk_objs(bl),3)) + '_'+string(ss)+' out=net"+ string(blk(blk_objs(bl),2+numofip))+'_'+string(ss);
            mputl(Tgate_str,fd_w);
            mputl("  ",fd_w);
        end
        
        //************************** VDD IN Analog *****************************
    elseif(blk_name.entries(bl)=='vdd_i')  then
        chgnet_dict=[chgnet_dict;'net'+ string(blk(blk_objs(bl),2+numofip))+"_.",'vcc']
        chgnet_tf=%t;

        //************************** VDD Out (Macro block) *****************************
    elseif(blk_name.entries(bl)=='vdd_o')  then
        for ss=1:scs_m.objs(bl).model.ipar(1)
            mputl("#VDD_OUT "+string(bl),fd_w);
            mputl(".subckt vdd_out in[0]=fb_vddout_net"+string(blk(blk_objs(bl),2))+"_"+string(ss)+" in[1]=net"+string(blk(blk_objs(bl),2))+"_"+string(ss)+" out[0]=fb_vddout_net"+string(blk(blk_objs(bl),2))+"_"+string(ss)+" #vdd_out_c =0",fd_w);
            mputl(' ',fd_w);
        end

        //************************* VDD In Digital *****************************
    elseif (blk_name.entries(bl) =='vdd_dig') then
        if chgnet(6) == 0 then
            mputl("#VDD_DIG "+string(bl),fd_w);
            vdd_dig_str= ".subckt tgate in[0]=vcc in[1]=vcc out=vcc_dig";
            mputl(vdd_dig_str,fd_w);
            mputl("  ",fd_w);
            chgnet(6)=1;
        end
        chgnet_dict=[chgnet_dict;'net'+ string(blk(blk_objs(bl),2+numofip))+"_.",'vcc_dig'];
        chgnet_tf=%t;

        //****************************** VMM ***********************************
    elseif (blk_name.entries(bl) =='vmm_4') then 
        //disp("VMM block");
        mputl("# VMM",fd_w);
        vmm_str= '.subckt vmm_4x4 ';
        vmm_out=' ';
        for pst=0:3
            vmm_str=vmm_str + ' in['+string(pst)+']=net' + string(blk(blk_objs(bl),pst+2)); 
            vmm_out =vmm_out + ' out[' + string(pst)+']=vnet'+ string(blk(blk_objs(bl),pst+2+numofip)) ; //output block  
        end
        vmm_str=vmm_str+vmm_out;
        mputl(vmm_str,fd_w);
        mputl("  ",fd_w)
        vmmota_str1= '.subckt ota ';
        for pst=0:3
            vmmota_str=vmmota_str1 + 'in[0]=vnet' + string(blk(blk_objs(bl),pst+2+numofip)) + ' in[1]=net' + string(orignet) + ' out=net' + string(blk(blk_objs(bl),pst+2+numofip)); 
            mputl(vmmota_str,fd_w);
            vmmota_str=vmmota_str1 + 'in[0]=net' + string(blk(blk_objs(bl),pst+2+numofip)) + ' in[1]=net' + string(orignet+1) + ' out=vnet' + string(blk(blk_objs(bl),pst+2+numofip)); 
            orignet = orignet + 2;
            mputl(vmmota_str,fd_w);
            mputl("  ",fd_w);
        end

        //************************* VMM_4by4 ************************************
    elseif (blk_name.entries(bl) =='vmm_4by4') then 
        addvmm = %t;
        k =scs_m.objs(blk_objs(bl)).model.opar(1);
        tar1=[];
        tar2=[];
        for i=1:size(k,1) 
            for j=1:size(k,2)
                if (j == size(k,2)) & (i == size(k,1)) then tar1=tar1+'%1.2e';
                else tar1=tar1+'%1.2e,';
                end
            end
            tar2=tar2+'k('+string(i)+',:) ';
        end
        tar2= evstr(tar2);
        mputl("# VMM ",fd_w);
        mputl(".subckt vmm4x4 in[0]=net"+string(blk(blk_objs(bl),2))+"_"+string(1)+ " in[1]=net"+string(blk(blk_objs(bl),2))+"_"+string(2)+ " in[2]=net"+string(blk(blk_objs(bl),2))+"_"+string(3)+ " in[3]=net"+string(blk(blk_objs(bl),2))+"_"+string(4)+ " out[0]=net"+string(blk(blk_objs(bl),2+numofip))+"_"+string(1)+ " out[1]=net"+string(blk(blk_objs(bl),2+numofip))+"_"+string(2)+ " out[2]=net"+string(blk(blk_objs(bl),2+numofip))+"_"+string(3)+ " out[3]=net"+string(blk(blk_objs(bl),2+numofip))+"_"+string(4)+" #vmm4x4_target =" +string(sprintf(tar1,tar2)),fd_w)
        mputl("  ",fd_w);

        //************************* VMM_8by4 ************************************
    elseif (blk_name.entries(bl) =='vmm_8by4') then 
        addvmm = %t;
        k =scs_m.objs(blk_objs(bl)).model.opar(1);
        tar1=[];
        tar2=[];
        for i=1:size(k,1) 
            for j=1:size(k,2)
                if (j == size(k,2)) & (i == size(k,1)) then tar1=tar1+'%1.2e';
                else tar1=tar1+'%1.2e,';
                end
            end
            tar2=tar2+'k('+string(i)+',:) ';
        end
        tar2= evstr(tar2);
        mputl("# VMM ",fd_w);
        mputl(".subckt vmm8x4_in in[0]=net"+string(blk(blk_objs(bl),2))+"_"+string(1)+ " in[1]=net"+string(blk(blk_objs(bl),2))+"_"+string(2)+ " in[2]=net"+string(blk(blk_objs(bl),2))+"_"+string(3)+ " in[3]=net"+string(blk(blk_objs(bl),2))+"_"+string(4)+ " in[4]=net"+string(blk(blk_objs(bl),2))+"_"+string(5)+ " in[5]=net"+string(blk(blk_objs(bl),2))+"_"+string(6)+ " in[6]=net"+string(blk(blk_objs(bl),2))+"_"+string(7)+ " in[7]=net"+string(blk(blk_objs(bl),2))+"_"+string(8)+ " in[8]=net"+string(blk(blk_objs(bl),3))+"_"+string(1)+ " in[9]=net"+string(blk(blk_objs(bl),3))+"_"+string(2)+ " in[10]=net"+string(blk(blk_objs(bl),3))+"_"+string(3)+ " in[11]=net"+string(blk(blk_objs(bl),3))+"_"+string(4)+ " in[12]=net"+string(blk(blk_objs(bl),2))+"_out"+ " out[0]=net"+string(blk(blk_objs(bl),2))+"_out"+" #vmm8x4_in_target =" +string(sprintf(tar1,tar2)),fd_w)
        mputl("  ",fd_w);
    end
end         // for loop was divided by Sihwan because the big for loop generated a error when we compiled.


for bl=1:length(blk_objs)
        //************************** VMM Sense Amp******************************
    if (blk_name.entries(bl) =='sen_amp') then
        addvmm = %t;
        mputl("#VMM w/Sense Amp",fd_w);
        for ss=1:scs_m.objs(bl).model.ipar(1)
            vmmsen_str=".subckt vmm_senseamp1 in[0]=net"+string(blk(blk_objs(bl),2))+"_"+string(ss)+ " in[1]=net"+string(blk(blk_objs(bl),3))+"_"+string(ss)+" out[0]=net"+ string(blk(blk_objs(bl),2+numofip))+"_" + string(ss)+" #vmm_senseamp1_fg =0"+"&ota0bias ="+string(sprintf('%1.2e',scs_m.objs(blk_objs(bl)).model.rpar(ss)));
            mputl(vmmsen_str,fd_w);
            mputl("  ",fd_w);
        end

        //******************* VMM 16x16 with Shift Register ********************
    elseif (blk_name.entries(bl) =='vmm16x16_sr') then
        addvmm = %t;
        mputl("# VMM 16x16 with shift register",fd_w);
        a=1;b=1;c=1;
        for j=1:4
            vmm16x16_sr_str= ".subckt vmm8x4_in"
            //for ss=1:scs_m.objs(bl).model.ipar(1)
            for ss=1:8
                vmm16x16_sr_str=vmm16x16_sr_str+" in["+string(ss-1)+"]=net"+string(blk(blk_objs(bl),5))+"_"+string(ss);
            end
            for ss=1:4
                vmm16x16_sr_str=vmm16x16_sr_str+" in["+string(ss+7)+"]=net"+string(blk(blk_objs(bl),5))+"_internal_"+string(a);
                a=a+1;
            end
            vmm16x16_sr_str=vmm16x16_sr_str+" in[12]=net"+string(blk(blk_objs(bl),5))+"_"+string(c)+"_fbout"+" out[0]=net"+string(blk(blk_objs(bl),5))+"_"+string(c)+"_fbout"+" #vmm8x4_in_target =";
            for i=1:32
                vmm16x16_sr_str=vmm16x16_sr_str+string(sprintf('%1.2e',scs_m.objs(blk_objs(bl)).model.rpar(c,i)));
                if i ~= 32 then vmm16x16_sr_str=vmm16x16_sr_str+","; end
            end
            mputl(vmm16x16_sr_str,fd_w);
            mputl("  ",fd_w);
            c=c+1;
            vmm16x16_sr_str= ".subckt vmm8x4_in"
            //for ss=1:scs_m.objs(bl).model.ipar(1)
            for ss=9:16
                vmm16x16_sr_str=vmm16x16_sr_str+" in["+string(ss-9)+"]=net"+string(blk(blk_objs(bl),5))+"_"+string(ss);
            end
            for ss=1:4
                vmm16x16_sr_str=vmm16x16_sr_str+" in["+string(ss+7)+"]=net"+string(blk(blk_objs(bl),5))+"_internal_"+string(b);
                b=b+1;
            end
            vmm16x16_sr_str=vmm16x16_sr_str+" in[12]=net"+string(blk(blk_objs(bl),5))+"_"+string(c)+"_fbout"+" out[0]=net"+string(blk(blk_objs(bl),5))+"_"+string(c)+"_fbout"+" #vmm8x4_in_target =";
            for i=1:32
                vmm16x16_sr_str=vmm16x16_sr_str+string(sprintf('%1.2e',scs_m.objs(blk_objs(bl)).model.rpar(c,i)));
                if i ~= 32 then vmm16x16_sr_str=vmm16x16_sr_str+","; end
            end
            mputl(vmm16x16_sr_str,fd_w);
            mputl("  ",fd_w);
            c=c+1;
        end
        vmm16x16_sr_str= ".subckt sftreg2 in[0]=net"+string(blk(blk_objs(bl),2))+"_1"+" in[1]=net"+string(blk(blk_objs(bl),3))+"_1"+" in[2]=net"+string(blk(blk_objs(bl),4))+"_1"+" out[0]=net"+string(blk(blk_objs(bl),5+numofip))+"_1"+" out[1]=net"+string(blk(blk_objs(bl),2+numofip))+"_1"+" out[2]=net"+string(blk(blk_objs(bl),3+numofip))+"_1"+" out[3]=net"+string(blk(blk_objs(bl),4+numofip))+"_1";
        for ss=1:16
            vmm16x16_sr_str=vmm16x16_sr_str+" out["+string(ss+3)+"]=net"+string(blk(blk_objs(bl),5))+"_internal_"+string(ss);
        end
        vmm16x16_sr_str=vmm16x16_sr_str+" #sftreg2_fg =0";
        mputl(vmm16x16_sr_str,fd_w);
        mputl("  ",fd_w);
        if scs_m.objs(bl).model.ipar(3) == 1 then
            plcvpr = %t;
            plcloc=[plcloc;'net'+string(blk(blk_objs(bl),5+numofip))+"_1",' '+string(scs_m.objs(bl).model.ipar(4))+' '+string(scs_m.objs(bl).model.ipar(5))+' 0'];
        end

        //*********************** VMM Shift Register ***************************
    elseif (blk_name.entries(bl) =='vmm_sr') then 
        addvmm = %t;
        k =scs_m.objs(blk_objs(bl)).model.opar(1);
        tar1=[];
        tar2=[];
        for i=1:size(k,1) 
            for j=1:size(k,2)
                if (j == size(k,2)) & (i == size(k,1)) then tar1=tar1+'%1.2e';
                else tar1=tar1+'%1.2e,';
                end
            end
            tar2=tar2+'k('+string(i)+',:) ';
        end
        tar2= evstr(tar2);
        mputl("# VMM + SR",fd_w);
        mputl(".subckt vmm4x4_SR in[0]=net"+string(blk(blk_objs(bl),2))+"_"+string(1)+ " in[1]=net"+string(blk(blk_objs(bl),2))+"_"+string(2)+ " in[2]=net"+string(blk(blk_objs(bl),2))+"_"+string(3)+ " in[3]=net"+string(blk(blk_objs(bl),2))+"_"+string(4)+ " in[4]=net"+string(blk(blk_objs(bl),3))+"_"+string(1)+ " in[5]=net"+string(blk(blk_objs(bl),4))+"_"+string(1)+ " in[6]=net"+string(blk(blk_objs(bl),5))+"_"+string(1)+ " out[0]=net"+string(blk(blk_objs(bl),2+numofip))+"_"+string(1)+ " out[1]=net"+string(blk(blk_objs(bl),3+numofip))+"_"+string(1)+ " out[2]=net"+string(blk(blk_objs(bl),4+numofip))+"_"+string(1)+ " out[3]=net"+string(blk(blk_objs(bl),5+numofip))+"_"+string(1)+ " #vmm4x4_target =" +string(sprintf(tar1,tar2)) + "&vmm_volatile =0",fd_w)
        mputl("  ",fd_w);

        //************************* VMM_WTA ************************************
    elseif (blk_name.entries(bl) =='vmm_wta') then 
        addvmm = %t;
        k =scs_m.objs(blk_objs(bl)).model.opar(1);
        tar1=[];
        tar2=[];
        for i=1:size(k,1) 
            for j=1:size(k,2)
                if (j == size(k,2)) & (i == size(k,1)) then tar1=tar1+'%1.2e';
                else tar1=tar1+'%1.2e,';
                end
            end
            tar2=tar2+'k('+string(i)+',:) ';
        end
        tar2= evstr(tar2);
        mputl("# VMM + WTA",fd_w);
        mputl(".subckt vmm4x4 in[0]=net"+string(blk(blk_objs(bl),2))+"_"+string(1)+ " in[1]=net"+string(blk(blk_objs(bl),2))+"_"+string(2)+ " in[2]=net"+string(blk(blk_objs(bl),2))+"_"+string(3)+ " in[3]=net"+string(blk(blk_objs(bl),2))+"_"+string(4)+ " out[0]=vmm_out1 out[1]=vmm_out2 out[2]=vmm_out3 out[3]=vmm_out4 #vmm4x4_target =" +string(sprintf(tar1,tar2)),fd_w)
        mputl("  ",fd_w);
        mputl(".subckt wta in[0]=vmm_out1 in[1]=nfet_d out[0]=net"+ string(blk(blk_objs(bl),2+numofip))+"_" + string(1)+" #wta_fg =0&wta_bufbias =" +string(sprintf('%1.1e',scs_m.objs(blk_objs(bl)).model.rpar(6)))+"&wta_pfetbias =" +string(sprintf('%1.2e',scs_m.objs(blk_objs(bl)).model.rpar(7))),fd_w)
        mputl("  ",fd_w);
        mputl(".subckt wta in[0]=vmm_out2 in[1]=nfet_d out[0]=net"+ string(blk(blk_objs(bl),2+numofip))+"_" + string(2)+" #wta_fg =0&wta_bufbias =" +string(sprintf('%1.1e',scs_m.objs(blk_objs(bl)).model.rpar(6)))+"&wta_pfetbias =" +string(sprintf('%1.2e',scs_m.objs(blk_objs(bl)).model.rpar(8))),fd_w)
        mputl("  ",fd_w);
        mputl(".subckt wta in[0]=vmm_out3 in[1]=nfet_d out[0]=net"+ string(blk(blk_objs(bl),2+numofip))+"_" + string(3)+" #wta_fg =0&wta_bufbias =" +string(sprintf('%1.1e',scs_m.objs(blk_objs(bl)).model.rpar(6)))+"&wta_pfetbias =" +string(sprintf('%1.2e',scs_m.objs(blk_objs(bl)).model.rpar(9))),fd_w)
        mputl("  ",fd_w);
        mputl(".subckt wta in[0]=vmm_out4 in[1]=nfet_d out[0]=net"+ string(blk(blk_objs(bl),2+numofip))+"_" + string(4)+" #wta_fg =0&wta_bufbias =" +string(sprintf('%1.1e',scs_m.objs(blk_objs(bl)).model.rpar(6)))+"&wta_pfetbias =" +string(sprintf('%1.2e',scs_m.objs(blk_objs(bl)).model.rpar(10))),fd_w)
        mputl("  ",fd_w);
        mputl(".subckt nfet in[0]=net"+string(blk(blk_objs(bl),3))+"_"+string(1)+ " in[1]=gnd out=nfet_d",fd_w);
        mputl("  ",fd_w);

        //************************* VMM_WTA nbias ************************************
    elseif (blk_name.entries(bl) =='vmm_wta_nbias') then 
        addvmm = %t;
        k =scs_m.objs(blk_objs(bl)).model.opar(1);
        tar1=[];
        tar2=[];
        for i=1:size(k,1) 
            for j=1:size(k,2)
                if (j == size(k,2)) & (i == size(k,1)) then tar1=tar1+'%1.2e';
                else tar1=tar1+'%1.2e,';
                end
            end
            tar2=tar2+'k('+string(i)+',:) ';
        end
        tar2= evstr(tar2);
        mputl("#VMM_WTA_NBIAS",fd_w);
        mputl(".subckt vmm4x4 in[0]=net"+string(blk(blk_objs(bl),2))+"_"+string(1)+ " in[1]=net"+string(blk(blk_objs(bl),2))+"_"+string(2)+ " in[2]=net"+string(blk(blk_objs(bl),2))+"_"+string(3)+ " in[3]=net"+string(blk(blk_objs(bl),2))+"_"+string(4)+ " out[0]=vmm_out1 out[1]=vmm_out2 out[2]=vmm_out3 out[3]=vmm_out4 #vmm4x4_target =" +string(sprintf(tar1,tar2)),fd_w)
        mputl("  ",fd_w);
        mputl(".subckt wta in[0]=vmm_out1 in[1]=nfet_d out[0]=net"+ string(blk(blk_objs(bl),2+numofip))+"_" + string(1)+" #wta_fg =0&wta_bufbias =" +string(sprintf('%1.1e',scs_m.objs(blk_objs(bl)).model.rpar(1)))+"&wta_pfetbias =" +string(sprintf('%1.2e',scs_m.objs(blk_objs(bl)).model.rpar(2))),fd_w)
        mputl("  ",fd_w);
        mputl(".subckt wta in[0]=vmm_out2 in[1]=nfet_d out[0]=net"+ string(blk(blk_objs(bl),2+numofip))+"_" + string(2)+" #wta_fg =0&wta_bufbias =" +string(sprintf('%1.1e',scs_m.objs(blk_objs(bl)).model.rpar(1)))+"&wta_pfetbias =" +string(sprintf('%1.2e',scs_m.objs(blk_objs(bl)).model.rpar(3))),fd_w)
        mputl("  ",fd_w);
        mputl(".subckt wta in[0]=vmm_out3 in[1]=nfet_d out[0]=net"+ string(blk(blk_objs(bl),2+numofip))+"_" + string(3)+" #wta_fg =0&wta_bufbias =" +string(sprintf('%1.1e',scs_m.objs(blk_objs(bl)).model.rpar(1)))+"&wta_pfetbias =" +string(sprintf('%1.2e',scs_m.objs(blk_objs(bl)).model.rpar(4))),fd_w)
        mputl("  ",fd_w);
        mputl(".subckt wta in[0]=vmm_out4 in[1]=nfet_d out[0]=net"+ string(blk(blk_objs(bl),2+numofip))+"_" + string(4)+" #wta_fg =0&wta_bufbias =" +string(sprintf('%1.1e',scs_m.objs(blk_objs(bl)).model.rpar(1)))+"&wta_pfetbias =" +string(sprintf('%1.2e',scs_m.objs(blk_objs(bl)).model.rpar(5))),fd_w)
        mputl("  ",fd_w);
        mputl(".subckt nmirror_vmm in[0]=nfet_d out=nfet_d #nmirror_bias[0] ="+string(sprintf('%1.2e',scs_m.objs(blk_objs(bl)).model.rpar(6))),fd_w);
        mputl("  ",fd_w);
        
        //************************* VMM_WTA ************************************
    elseif (blk_name.entries(bl) =='vmmwta') then 
        addvmm = %t;
        
        k =scs_m.objs(blk_objs(bl)).model.opar(1);
        
       
        tar1=[];
        tar2=[];
        tar3=[];
        for j=1:12
            if j == 12 then tar1=tar1+'%1.2e';
            else tar1=tar1+'%1.2e,';
            end
        end
        j = size(k,2)+1;
        for i=1:size(k,1) 
            tar3='k('+string(i)+',:) ';
            for n = j:12
                tar3=tar3+'50e-12 ';
            end
            tar2(i,:)=evstr(tar3);          
        end
         
         
        mputl("# VMM+WTA",fd_w);
        vmm12_1 =".subckt vmm12x1";
        for i = 1:size(k,2)
            vmm12_1 = vmm12_1 + " in["+ string(i-1)+"]=net"+string(blk(blk_objs(bl),2))+"_"+string(i);
        end
        if j < 13 then
            for i = j:12
                vmm12_1 = vmm12_1 + " in["+ string(i-1)+"]=net"+string(blk(blk_objs(bl),2))+"_"+string(1);
            end
        end
        for i = 1:size(k,1)
            vmm12_1o = vmm12_1 + " in[12]=vw_nfetd" +" out[0]=net"+ string(blk(blk_objs(bl),2+numofip))+"_" + string(i)+" #vmm12x1_fg =0&vmm12x1_pfetbias ="+string(sprintf('%1.2e',scs_m.objs(blk_objs(bl)).model.rpar(6+i)))+ "&nmirror_bias =2.5e-9&vmm12x1_offsetbias =3e-9&vmm12x1_otabias ="+string(sprintf('%1.2e',scs_m.objs(blk_objs(bl)).model.rpar(6)));
            vmm12_1target="&vmm12x1_target =" +string(sprintf(tar1,tar2(i,:)));
            mputl(vmm12_1o+vmm12_1target,fd_w);
            mputl("  ",fd_w);
            vmm12_1target=[];
            vmm12_1o=[];
             select board_num
            case 2 then
            if sftreg_count >0
             plcloc=[plcloc;'net'+string(blk(blk_objs(bl),2+numofip))+"_" + string(i),' 10 '+string(sftreg_count+i)+' 0'];
            else
             plcloc=[plcloc;'net'+string(blk(blk_objs(bl),2+numofip))+"_" + string(i),' 10 '+string(i)+' 0'];
            end
            case 3 then
           if sftreg_count >0
              plcloc=[plcloc;'net'+string(blk(blk_objs(bl),2+numofip))+"_" + string(i),' 5 '+string(sftreg_count+i)+' 0'];
           else
                plcloc=[plcloc;'net'+string(blk(blk_objs(bl),2+numofip))+"_" + string(i),' 5 '+string(i)+' 0'];         
           end
           end
        end

      // mputl(".subckt nfet in[0]=net"+string(blk(blk_objs(bl),3))+'_1'+ " in[1]=gnd" + " out[0]=vw_nfetd",fd_w);
        mputl(".subckt nmirror_vmm in[0]=net"+string(blk(blk_objs(bl),3))+'_1 out=vw_nfetd #nmirror_bias[0] =12e-9",fd_w);
       select board_num
          case 2 then
         
            plcloc=[plcloc;'vw_nfetd',' 11 2 0'];
        case 3 then
             plcloc=[plcloc;'vw_nfetd',' 5 2 0'];
          end
 mputl("  ",fd_w);

        //************************* VMM_WTA ************************************
    elseif (blk_name.entries(bl) =='vmm12x1_wowta') then 
        addvmm = %t;
        
        k =scs_m.objs(blk_objs(bl)).model.opar(1);


        tar1=[];
        tar2=[];
        tar3=[];
        for j=1:12
            if j == 12 then tar1=tar1+'%1.2e';
            else tar1=tar1+'%1.2e,';
            end
        end
        j = size(k,2)+1;
        for i=1:size(k,1) 
            tar3='k('+string(i)+',:) ';
            for n = j:12
                tar3=tar3+'50e-12 ';
            end
            tar2(i,:)=evstr(tar3);          
        end

        mputl("# VMM12x1",fd_w);
        vmm12_1 =".subckt vmm12x1_wowta";
        for i = 1:size(k,2)
            vmm12_1 = vmm12_1 + " in["+ string(i-1)+"]=net"+string(blk(blk_objs(bl),2))+"_"+string(i);
        end
        if j < 13 then
            for i = j:12
                vmm12_1 = vmm12_1 + " in["+ string(i-1)+"]=net"+string(blk(blk_objs(bl),2))+"_"+string(1);
            end
        end
        for i = 1:size(k,1)
            vmm12_1o = vmm12_1 + " out[0]=net"+ string(blk(blk_objs(bl),2+numofip))+"_" + string(i)+" #vmm12x1_wowta_fg =0";
            vmm12_1target="&vmm12x1_target =" +string(sprintf(tar1,tar2(i,:)));
            mputl(vmm12_1o+vmm12_1target,fd_w);
            mputl("  ",fd_w);
            vmm12_1target=[];
            vmm12_1o=[];
             select board_num
            case 2 then
            if sftreg_count >0
             plcloc=[plcloc;'net'+string(blk(blk_objs(bl),2+numofip))+"_" + string(i),' 10 '+string(sftreg_count+i)+' 0'];
            else
             plcloc=[plcloc;'net'+string(blk(blk_objs(bl),2+numofip))+"_" + string(i),' 10 '+string(i)+' 0'];
            end
            case 3 then
           if sftreg_count >0
              plcloc=[plcloc;'net'+string(blk(blk_objs(bl),2+numofip))+"_" + string(i),' 5 '+string(sftreg_count+i)+' 0'];
           else
                plcloc=[plcloc;'net'+string(blk(blk_objs(bl),2+numofip))+"_" + string(i),' 5 '+string(i)+' 0'];         
           end
           end
        end
        mputl("  ",fd_w);


        //************************ Voltage Divider ****************************
    elseif (blk_name.entries(bl) =='vol_div') then
        mputl("# Voltage Divider",fd_w);
        for ss=1:scs_m.objs(bl).model.ipar(1)
            vol_div_str= ".subckt volt_div in[0]=net"+string(blk(blk_objs(bl),2))+"_"+string(ss)+ " in[1]=net"+string(blk(blk_objs(bl),3))+"_1"+" out[0]=net"+ string(blk(blk_objs(bl),2+numofip))+"_" + string(ss)+" #volt_div_fg =0&fgota_biasfb =" +string(sprintf('%1.2e',scs_m.objs(blk_objs(bl)).model.rpar(ss*1))) + "&ota_p_bias =" +string(sprintf('%1.2e',scs_m.objs(blk_objs(bl)).model.rpar(ss*2)))+"&ota_n_bias ="+string(sprintf('%1.2e',scs_m.objs(blk_objs(bl)).model.rpar(ss*3)))+"&fgota_small_cap =0&cap_1x_vd =0&vd_target ="+string(sprintf('%1.2e',scs_m.objs(blk_objs(bl)).model.rpar(ss*4)));
            mputl(vol_div_str,fd_w);
            mputl("  ",fd_w);
        end

        //***************************** WTA ************************************
    elseif (blk_name.entries(bl) =='wta') then
        addvmm = %t;
        mputl("#WTA",fd_w);
        for ss=1:scs_m.objs(bl).model.ipar(1)
            mputl(".subckt wta in[0]=net"+string(blk(blk_objs(bl),2))+"_"+string(ss)+ " in[1]=net"+string(blk(blk_objs(bl),3))+"_"+string(ss)+" out[0]=net"+ string(blk(blk_objs(bl),2+numofip))+"_" + string(ss)+" #wta_fg =0",fd_w);
            mputl("  ",fd_w);
             plcvpr = %t;
             //need a better way to handle the plcloc
             if grep(plcloc,'10 1 0')>0 then
            plcloc=[plcloc;'net'+string(blk(blk_objs(bl),2+numofip))+'_'+ string(ss),' 10 '+string(ss+1)+' 0'];
            else
             plcloc=[plcloc;'net'+string(blk(blk_objs(bl),2+numofip))+'_'+ string(ss),' 10 '+string(ss)+' 0'];
             end
           //  disp(plcloc)
          end
    end
end

file_list=listfiles("/home/ubuntu/rasp30/sci2blif/sci2blif_added_blocks/*.sce");
size_file_list=size(file_list);
if file_list ~= [] then
    for bl=1:length(blk_objs)
        for i=1:size_file_list(1)
            exec(file_list(i),-1);
        end
    end         // for loop for user defined Level 1 block
end

if makeblk == %f then
    mputl(".end",fd_w) 

end
mclose(fd_w);


////check for user placement error
//tmploc = unique(plcloc(:,2),'r')
//if size(tmploc,'r') ~= size(plcloc,'r') then
//        messagebox(['Please recheck the location values that you have entered.' ' There is atleast one location that is being used more than once.'], "Same User Specified Location", "error");
//    abort
//end
//tmploc = [];

if makeblk then ext = '.blk ';
else ext = '.blif ';
end

exec('~/rasp30/sci2blif/retool.sce',-1)

if chgnet_tf == %t then retool(chgnet_dict,path,fname,ext); end


if spl_fix_chg == %t then
    retool(spl_fix,path,fname,ext);
    retool(spl_fix,path,fname,'.pads ');
end

exec("~/rasp30/prog_assembly/libs/scilab_code/make_input_vector_file.sce",-1);
make_input_vector_file();

//VTR
if(makeblk)  then
    exec('~/rasp30/sci2blif/blif4blk.sce',-1)
    mkblk(fd_w,blk,blk_objs)
    // mclose(fd_w);
    //getd('/home/ubuntu/RASP_Workspace/block_files/compile_files')
    disp('Done!')
    //abort
else
    if plcvpr then
        if addvmm then
            unix_s('/home/ubuntu/rasp30/vtr_release/vpr/vpr /home/ubuntu/rasp30/vpr2swcs/./arch/'+arch+'_vmm_arch.xml ' + path + fname + '  -route_chan_width 17 -timing_analysis off -fix_pins ' + path + fname + '.pads -nodisp')
        else
            unix_s('/home/ubuntu/rasp30/vtr_release/vpr/vpr /home/ubuntu/rasp30/vpr2swcs/./arch/'+arch+'_arch.xml ' + path + fname + '  -route_chan_width 17 -timing_analysis off -fix_pins ' + path + fname + '.pads -nodisp')
        end

        plcfile=mopen(path + fname + '.place','r')
        tmpplc=mgetl(plcfile)
        mclose(plcfile)

        for plcidx=6:size(tmpplc,'r') 

            if size(strsplit(tmpplc(plcidx),"/\s\s/")','c') == 1 then
                loctmp(plcidx-5,:)=strsplit(tmpplc(plcidx),"/\s/")'; //has net names
                loctmp2(plcidx-5) = strcat(loctmp(plcidx-5,2:4), ' ');
            else
                loctmp(plcidx-5,:)=[strsplit(tmpplc(plcidx),"/\s\s/")' ' ' ' ' ' ']; //has net names
                tmploc =strsplit(loctmp(plcidx-5,2), '/\t/');
                tmploc = strcat(tmploc, ' ');
                tmploc = strsubst(tmploc,"/#.*/",'','r');
                loctmp2(plcidx-5) = stripblanks(tmploc)
            end
        end

        [plcd,plce,plcf]=intersect(loctmp2,stripblanks(plcloc(:,2)),"r"); //used locations


        plcwhile = 0
        while plcd ~= []

            //reuse plcd - used locations names
            plcd=[];
            for plcidx=1:length(plcf)
                plcd=[plcd;plcloc(plcf(plcidx),1)]
            end

            [plca,plcb,plcc]=intersect(plcd(:,1),loctmp(:,1),"r"); //position of free location

            for plcidx=1:length(plcc)
                for plcidx2 = 1:length(plcc) //use plcf -> plcb(1:n) to find plcc that corresponds to plce
                    if  plcb(plcidx2) == plcidx then
                        if loctmp(plcc(plcidx2),5) == ' ' then
                            tmpplc(plce(plcidx)+5)=msprintf('%s\t\t%s',loctmp(plce(plcidx),1),loctmp(plcc(plcidx2),2)) //used location name and free location
                        else
                            tmploc = strcat(loctmp(plcc(plcidx2),2:5), ' ')
                            tmpplc(plce(plcidx)+5)=msprintf('%s\t\t%s',loctmp(plce(plcidx),1),tmploc) //used location name and free location
                        end
                    end
                end
            end
            //check case
            for plcidx=6:size(tmpplc,'r') 

                if size(strsplit(tmpplc(plcidx),"/\s\s/")','c') == 1 then
                    loctmp(plcidx-5,:)=strsplit(tmpplc(plcidx),"/\s/")'; //has net names
                    loctmp2(plcidx-5) = strcat(loctmp(plcidx-5,2:4), ' ');
                else
                    loctmp(plcidx-5,:)=[strsplit(tmpplc(plcidx),"/\s\s/")' ' ' ' ' ' ']; //has net names
                    tmploc =strsplit(loctmp(plcidx-5,2), '/\t/');
                    tmploc = strcat(tmploc, ' ');
                    tmploc = strsubst(tmploc,"/#.*/",'','r');
                    loctmp2(plcidx-5) = stripblanks(tmploc)
                end
            end

            [plcd,plce,plcf]=intersect(loctmp2,stripblanks(plcloc(:,2)),"r"); //used locations

            if plcwhile > 3 then
                plcd= [];
            end
            plcwhile = plcwhile+1;
        end

        [plca,plcb,plcc]=intersect(plcloc(:,1),loctmp(:,1),"r");
        //reuse plca
        plca=strcat(plcloc(plcb,:),'','c') //concatinated string for place file each row

        for plcidx=1:length(plcc)
            tmpplc(plcc(plcidx)+5)= plca(plcidx);
        end

        plcfile=mopen(path + fname + '.place','wt')
        mputl(tmpplc,plcfile)
        mclose(plcfile)

        // generate switches
        if addvmm then // add -vmm option for some blocks
            unix_s('python /home/ubuntu/rasp30/vpr2swcs/genswcs.py -c ' + path + fname + ' -d '+ path + ' -vmm -route' + brdtype);
        else
            unix_s('python /home/ubuntu/rasp30/vpr2swcs/genswcs.py -c ' + path + fname + ' -d '+ path+ ' -route' + brdtype);
        end
    else

        if addvmm then // add -vmm option for some blocks
        //disp('python /home/ubuntu/rasp30/vpr2swcs/genswcs.py -c ' + path + fname + ' -d '+ path + ' -vmm' + brdtype)
            unix_s('python /home/ubuntu/rasp30/vpr2swcs/genswcs.py -c ' + path + fname + ' -d '+ path + ' -vmm' + brdtype);
        else
        //disp('python /home/ubuntu/rasp30/vpr2swcs/genswcs.py -c ' + path + fname + ' -d '+ path + brdtype)
            unix_s('python /home/ubuntu/rasp30/vpr2swcs/genswcs.py -c ' + path + fname + ' -d '+ path + brdtype);
        end
    end

    unix_s('mv ' + fname' + '.pads ' + fname + '.place ' + fname + '.net ' + fname + '.route ' +hid_dir);
    exec("~/rasp30/prog_assembly/libs/scilab_code/MakeProgramlilst_CompileAssembly.sce",-1);

    disp("Compilation Completed. Ready to Program.");
end


//
//fd_info= mopen('info.txt','a+')
//for idxn= 1:16
//    if(dac_net(idxn,1).entries ~= []) then
//        mputl('net' + string(idxn) + ' is DAC' + string(dac_net(idxn,1).entries),fd_info);
//    end
//end
//mclose(fd_info);
//scinotes info.txt
