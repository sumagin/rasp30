global file_name;
//get filename, path and extension
[path,fname,extension] = fileparts(file_name); 
hid_dir = path + '.' + fname;
exec("~/rasp30/prog_assembly/libs/scilab_code/characterization/char_diodeADC.sce",-1);

target_list_info=fscanfMat(hid_dir+'/target_list')
n_target_tunnel_revtun=target_list_info(1,1);
n_target_highaboveVt_swc=target_list_info(2,1);
n_target_highaboveVt_ota=target_list_info(3,1);
n_target_aboveVt_swc=target_list_info(4,1);
n_target_aboveVt_ota=target_list_info(5,1);
n_target_aboveVt_otaref=target_list_info(6,1);
n_target_aboveVt_mite=target_list_info(7,1);
n_target_aboveVt_dirswc=target_list_info(8,1);
n_target_subVt_swc=target_list_info(9,1);
n_target_subVt_ota=target_list_info(10,1);
n_target_subVt_otaref=target_list_info(11,1);
n_target_subVt_mite=target_list_info(12,1);
n_target_subVt_dirswc=target_list_info(13,1);
n_target_lowsubVt_swc=target_list_info(14,1);
n_target_lowsubVt_ota=target_list_info(15,1);
n_target_lowsubVt_otaref=target_list_info(16,1);
n_target_lowsubVt_mite=target_list_info(17,1);
n_target_lowsubVt_dirswc=target_list_info(18,1);
kappa_constant=target_list_info(19,1);

// Execute Assembly codes
//if n_target_tunnel_revtun ~= 0 then
//    unix_w("sudo tclsh ~/rasp30/prog_assembly/libs/tcl/write_mem2_NoRelease.tcl -start_address 0x7000 -input_file_name "+hid_dir+"/target_info_tunnel_revtun");
//    unix_w("sudo tclsh ~/rasp30/prog_assembly/libs/tcl/program.tcl -device /dev/ttyUSB1/ -speed 115200 "+hid_dir+"/tunnel_revtun_CAB.elf");
//    unix_w("sudo tclsh ~/rasp30/prog_assembly/libs/tcl/read_mem2_NoRelease.tcl -device /dev/ttyUSB1/ -start_address 0x5000 -length 7000 -output_file_name data_tunnel_revtun.hex");
//    disp("tun, rev tun");
//end

if n_target_highaboveVt_swc ~= 0 then
    unix_w("sudo tclsh ~/rasp30/prog_assembly/libs/tcl/write_mem2_NoRelease.tcl -start_address 0x7000 -input_file_name "+hid_dir+"/target_info_highaboveVt_swc");
    unix_w("sudo tclsh ~/rasp30/prog_assembly/libs/tcl/write_mem2_NoRelease.tcl -start_address 0x6800 -input_file_name "+hid_dir+"/pulse_width_table_swc");
//    unix_w("sudo tclsh ~/rasp30/prog_assembly/libs/tcl/program.tcl -device /dev/ttyUSB1/ -speed 115200 "+hid_dir+"/recover_inject_highaboveVt_SWC.elf");
//    unix_w("sudo tclsh ~/rasp30/prog_assembly/libs/tcl/read_mem2_NoRelease.tcl -start_address 0x5000 -length 7000 -output_file_name data_highaboveVt_swc_2.hex");
//    disp("recover inj");
//    unix_w("sudo tclsh ~/rasp30/prog_assembly/libs/tcl/write_mem2_NoRelease.tcl -start_address 0x7000 -input_file_name "+hid_dir+"/target_info_highaboveVt_swc");
//    unix_w("sudo tclsh ~/rasp30/prog_assembly/libs/tcl/program.tcl -device /dev/ttyUSB1/ -speed 115200 "+hid_dir+"/first_coarse_program_highaboveVt_SWC.elf");
//    unix_w("sudo tclsh ~/rasp30/prog_assembly/libs/tcl/read_mem2_NoRelease.tcl -start_address 0x5000 -length 7000 -output_file_name data_highaboveVt_swc_3.hex");
//    disp("first coarse inj");
//    unix_w("sudo tclsh ~/rasp30/prog_assembly/libs/tcl/write_mem2_NoRelease.tcl -start_address 0x7000 -input_file_name "+hid_dir+"/target_info_highaboveVt_swc");
//    unix_w("sudo tclsh ~/rasp30/prog_assembly/libs/tcl/program.tcl -device /dev/ttyUSB1/ -speed 115200 "+hid_dir+"/measured_coarse_program_highaboveVt_SWC.elf");
//    unix_w("sudo tclsh ~/rasp30/prog_assembly/libs/tcl/read_mem2_NoRelease.tcl -start_address 0x5000 -length 7000 -output_file_name data_highaboveVt_swc_4.hex");
//    disp("measured coarse inj");
//    unix_w("sudo tclsh ~/rasp30/prog_assembly/libs/tcl/write_mem2_NoRelease.tcl -start_address 0x7000 -input_file_name "+hid_dir+"/target_info_highaboveVt_swc");
    unix_w("sudo tclsh ~/rasp30/prog_assembly/libs/tcl/write_mem2_NoRelease.tcl -start_address 0x6800 -input_file_name "+hid_dir+"/Vd_table_30mV");
    unix_w("sudo tclsh ~/rasp30/prog_assembly/libs/tcl/program.tcl -speed 115200 "+hid_dir+"/fine_program_highaboveVt_m_ave_04_SWC.elf");
    unix_w("sudo tclsh ~/rasp30/prog_assembly/libs/tcl/read_mem2_NoRelease.tcl -start_address 0x5000 -length 7000 -output_file_name data_highaboveVt_swc_5.hex");
    //unix_w("sudo tclsh ~/rasp30/prog_assembly/libs/tcl/read_mem2_NoRelease.tcl -start_address 0x7002 -length 220 -output_file_name temp_1.txt");
    //unix_w("sudo tclsh ~/rasp30/prog_assembly/libs/tcl/read_mem2_NoRelease.tcl -start_address 0x6800 -length 220 -output_file_name temp_2.txt");
    disp("fine inj");
    target_l_highaboveVt_swc=fscanfMat(hid_dir+'/target_list_highaboveVt_swc');
    info_name = "_highaboveVt_swc_"; info_win_num1 = 60; info_win_num2 = 61; info_win_num3 = 62; n_graph=n_target_highaboveVt_swc; m_graph=n_graph+2;
    clear target_list; target_list = target_l_highaboveVt_swc;kapa_constant_or_not=1/kappa_constant;
    exec("~/rasp30/prog_assembly/libs/scilab_code/finetune_program_graph.sce",-1);
end

if n_target_aboveVt_swc ~= 0 then
    unix_w("sudo tclsh ~/rasp30/prog_assembly/libs/tcl/write_mem2_NoRelease.tcl -start_address 0x7000 -input_file_name "+hid_dir+"/target_info_aboveVt_swc");
    unix_w("sudo tclsh ~/rasp30/prog_assembly/libs/tcl/write_mem2_NoRelease.tcl -start_address 0x6800 -input_file_name "+hid_dir+"/pulse_width_table_swc");
//    unix_w("sudo tclsh ~/rasp30/prog_assembly/libs/tcl/program.tcl -device /dev/ttyUSB1/ -speed 115200 "+hid_dir+"/recover_inject_aboveVt_SWC.elf");
//    unix_w("sudo tclsh ~/rasp30/prog_assembly/libs/tcl/read_mem2_NoRelease.tcl -start_address 0x5000 -length 7000 -output_file_name data_aboveVt_swc_2.hex");
//    disp("recover inj");
//    unix_w("sudo tclsh ~/rasp30/prog_assembly/libs/tcl/write_mem2_NoRelease.tcl -start_address 0x7000 -input_file_name "+hid_dir+"/target_info_aboveVt_swc");
//    unix_w("sudo tclsh ~/rasp30/prog_assembly/libs/tcl/program.tcl -device /dev/ttyUSB1/ -speed 115200 "+hid_dir+"/first_coarse_program_aboveVt_SWC.elf");
//    unix_w("sudo tclsh ~/rasp30/prog_assembly/libs/tcl/read_mem2_NoRelease.tcl -start_address 0x5000 -length 7000 -output_file_name data_aboveVt_swc_3.hex");
//    disp("first coarse inj");
//    unix_w("sudo tclsh ~/rasp30/prog_assembly/libs/tcl/write_mem2_NoRelease.tcl -start_address 0x7000 -input_file_name "+hid_dir+"/target_info_aboveVt_swc");
//    unix_w("sudo tclsh ~/rasp30/prog_assembly/libs/tcl/program.tcl -device /dev/ttyUSB1/ -speed 115200 "+hid_dir+"/measured_coarse_program_aboveVt_SWC.elf");
//    unix_w("sudo tclsh ~/rasp30/prog_assembly/libs/tcl/read_mem2_NoRelease.tcl -start_address 0x5000 -length 7000 -output_file_name data_aboveVt_swc_4.hex");
//    disp("measured coarse inj");
//    unix_w("sudo tclsh ~/rasp30/prog_assembly/libs/tcl/write_mem2_NoRelease.tcl -start_address 0x7000 -input_file_name "+hid_dir+"/target_info_aboveVt_swc");
    unix_w("sudo tclsh ~/rasp30/prog_assembly/libs/tcl/write_mem2_NoRelease.tcl -start_address 0x6800 -input_file_name "+hid_dir+"/Vd_table_30mV");
    unix_w("sudo tclsh ~/rasp30/prog_assembly/libs/tcl/program.tcl -speed 115200 "+hid_dir+"/fine_program_aboveVt_m_ave_04_SWC.elf");
    unix_w("sudo tclsh ~/rasp30/prog_assembly/libs/tcl/read_mem2_NoRelease.tcl -start_address 0x5000 -length 7000 -output_file_name data_aboveVt_swc_5.hex");
    //unix_w("sudo tclsh ~/rasp30/prog_assembly/libs/tcl/read_mem2_NoRelease.tcl -start_address 0x7002 -length 220 -output_file_name temp_1.txt");
    //unix_w("sudo tclsh ~/rasp30/prog_assembly/libs/tcl/read_mem2_NoRelease.tcl -start_address 0x6800 -length 220 -output_file_name temp_2.txt");
    disp("fine inj");
    target_l_aboveVt_swc=fscanfMat(hid_dir+'/target_list_aboveVt_swc');
    info_name = "_aboveVt_swc_"; info_win_num1 = 10; info_win_num2 = 11; info_win_num3 = 12; n_graph=n_target_aboveVt_swc; m_graph=n_graph+2;
    clear target_list; target_list = target_l_aboveVt_swc;kapa_constant_or_not=1;
    exec("~/rasp30/prog_assembly/libs/scilab_code/finetune_program_graph.sce",-1);
end

if n_target_subVt_swc ~= 0 then
    unix_w("sudo tclsh ~/rasp30/prog_assembly/libs/tcl/write_mem2_NoRelease.tcl -start_address 0x7000 -input_file_name "+hid_dir+"/target_info_subVt_swc");
    unix_w("sudo tclsh ~/rasp30/prog_assembly/libs/tcl/write_mem2_NoRelease.tcl -start_address 0x6800 -input_file_name "+hid_dir+"/pulse_width_table_swc");
//    unix_w("sudo tclsh ~/rasp30/prog_assembly/libs/tcl/program.tcl -device /dev/ttyUSB1/ -speed 115200 "+hid_dir+"/recover_inject_subVt_SWC.elf");
//    unix_w("sudo tclsh ~/rasp30/prog_assembly/libs/tcl/read_mem2_NoRelease.tcl -start_address 0x5000 -length 7000 -output_file_name data_subVt_swc_2.hex");
//    disp("recover inj");
//    unix_w("sudo tclsh ~/rasp30/prog_assembly/libs/tcl/write_mem2_NoRelease.tcl -start_address 0x7000 -input_file_name "+hid_dir+"/target_info_subVt_swc");
//    unix_w("sudo tclsh ~/rasp30/prog_assembly/libs/tcl/program.tcl -device /dev/ttyUSB1/ -speed 115200 "+hid_dir+"/first_coarse_program_subVt_SWC.elf");
//    unix_w("sudo tclsh ~/rasp30/prog_assembly/libs/tcl/read_mem2_NoRelease.tcl -start_address 0x5000 -length 7000 -output_file_name data_subVt_swc_3.hex");
//    disp("first coarse inj");
//    unix_w("sudo tclsh ~/rasp30/prog_assembly/libs/tcl/write_mem2_NoRelease.tcl -start_address 0x7000 -input_file_name "+hid_dir+"/target_info_subVt_swc");
//    unix_w("sudo tclsh ~/rasp30/prog_assembly/libs/tcl/program.tcl -device /dev/ttyUSB1/ -speed 115200 "+hid_dir+"/measured_coarse_program_subVt_SWC.elf");
//    unix_w("sudo tclsh ~/rasp30/prog_assembly/libs/tcl/read_mem2_NoRelease.tcl -start_address 0x5000 -length 7000 -output_file_name data_subVt_swc_4.hex");
//    disp("measured coarse inj");
//    unix_w("sudo tclsh ~/rasp30/prog_assembly/libs/tcl/write_mem2_NoRelease.tcl -start_address 0x7000 -input_file_name "+hid_dir+"/target_info_subVt_swc");
    unix_w("sudo tclsh ~/rasp30/prog_assembly/libs/tcl/write_mem2_NoRelease.tcl -start_address 0x6800 -input_file_name "+hid_dir+"/Vd_table_30mV");
    unix_w("sudo tclsh ~/rasp30/prog_assembly/libs/tcl/program.tcl -speed 115200 "+hid_dir+"/fine_program_subVt_m_ave_04_SWC.elf");
    unix_w("sudo tclsh ~/rasp30/prog_assembly/libs/tcl/read_mem2_NoRelease.tcl -start_address 0x5000 -length 7000 -output_file_name data_subVt_swc_5.hex");
    //unix_w("sudo tclsh ~/rasp30/prog_assembly/libs/tcl/read_mem2_NoRelease.tcl -start_address 0x7002 -length 220 -output_file_name temp_1.txt");
    //unix_w("sudo tclsh ~/rasp30/prog_assembly/libs/tcl/read_mem2_NoRelease.tcl -start_address 0x6800 -length 220 -output_file_name temp_2.txt");
    disp("fine inj");
    target_l_subVt_swc=fscanfMat(hid_dir+'/target_list_subVt_swc');
    info_name = "_subVt_swc_"; info_win_num1 = 13; info_win_num2 = 14; info_win_num3 = 15; n_graph=n_target_subVt_swc; m_graph=n_graph+2;
    clear target_list; target_list = target_l_subVt_swc;kapa_constant_or_not=1;
    exec("~/rasp30/prog_assembly/libs/scilab_code/finetune_program_graph.sce",-1);
end

if n_target_lowsubVt_swc ~= 0 then
    unix_w("sudo tclsh ~/rasp30/prog_assembly/libs/tcl/write_mem2_NoRelease.tcl -start_address 0x7000 -input_file_name "+hid_dir+"/target_info_lowsubVt_swc");
    unix_w("sudo tclsh ~/rasp30/prog_assembly/libs/tcl/write_mem2_NoRelease.tcl -start_address 0x6800 -input_file_name "+hid_dir+"/pulse_width_table_lowsubVt_swc");
//    unix_w("sudo tclsh ~/rasp30/prog_assembly/libs/tcl/program.tcl -device /dev/ttyUSB1/ -speed 115200 "+hid_dir+"/recover_inject_lowsubVt_SWC.elf");
//    unix_w("sudo tclsh ~/rasp30/prog_assembly/libs/tcl/read_mem2_NoRelease.tcl -start_address 0x5000 -length 7000 -output_file_name data_lowsubVt_swc_2.hex");
//    disp("recover inj");
//    unix_w("sudo tclsh ~/rasp30/prog_assembly/libs/tcl/write_mem2_NoRelease.tcl -start_address 0x7000 -input_file_name "+hid_dir+"/target_info_lowsubVt_swc");
//    unix_w("sudo tclsh ~/rasp30/prog_assembly/libs/tcl/program.tcl -device /dev/ttyUSB1/ -speed 115200 "+hid_dir+"/first_coarse_program_lowsubVt_SWC.elf");
//    unix_w("sudo tclsh ~/rasp30/prog_assembly/libs/tcl/read_mem2_NoRelease.tcl -start_address 0x5000 -length 7000 -output_file_name data_lowsubVt_swc_3.hex");
//    disp("first coarse inj");
//    unix_w("sudo tclsh ~/rasp30/prog_assembly/libs/tcl/write_mem2_NoRelease.tcl -start_address 0x7000 -input_file_name "+hid_dir+"/target_info_lowsubVt_swc");
//    unix_w("sudo tclsh ~/rasp30/prog_assembly/libs/tcl/program.tcl -device /dev/ttyUSB1/ -speed 115200 "+hid_dir+"/measured_coarse_program_lowsubVt_SWC.elf");
//    unix_w("sudo tclsh ~/rasp30/prog_assembly/libs/tcl/read_mem2_NoRelease.tcl -start_address 0x5000 -length 7000 -output_file_name data_lowsubVt_swc_4.hex");
//    disp("measured coarse inj");
//    unix_w("sudo tclsh ~/rasp30/prog_assembly/libs/tcl/write_mem2_NoRelease.tcl -start_address 0x7000 -input_file_name "+hid_dir+"/target_info_lowsubVt_swc");
    unix_w("sudo tclsh ~/rasp30/prog_assembly/libs/tcl/write_mem2_NoRelease.tcl -start_address 0x6800 -input_file_name "+hid_dir+"/Vd_table_30mV");
    unix_w("sudo tclsh ~/rasp30/prog_assembly/libs/tcl/program.tcl -speed 115200 "+hid_dir+"/fine_program_lowsubVt_m_ave_04_SWC.elf");
    unix_w("sudo tclsh ~/rasp30/prog_assembly/libs/tcl/read_mem2_NoRelease.tcl -start_address 0x5000 -length 7000 -output_file_name data_lowsubVt_swc_5.hex");
    //unix_w("sudo tclsh ~/rasp30/prog_assembly/libs/tcl/read_mem2_NoRelease.tcl -start_address 0x7002 -length 220 -output_file_name temp_1.txt");
    //unix_w("sudo tclsh ~/rasp30/prog_assembly/libs/tcl/read_mem2_NoRelease.tcl -start_address 0x6800 -length 220 -output_file_name temp_2.txt");
    disp("fine inj");
    target_l_lowsubVt_swc=fscanfMat(hid_dir+'/target_list_lowsubVt_swc');
    info_name = "_lowsubVt_swc_"; info_win_num1 = 16; info_win_num2 = 17; info_win_num3 = 18; n_graph=n_target_lowsubVt_swc; m_graph=n_graph+2;
    clear target_list; target_list = target_l_lowsubVt_swc;kapa_constant_or_not = kappa_constant;
    exec("~/rasp30/prog_assembly/libs/scilab_code/finetune_program_graph.sce",-1);
end

if n_target_highaboveVt_ota ~= 0 then
    unix_w("sudo tclsh ~/rasp30/prog_assembly/libs/tcl/write_mem2_NoRelease.tcl -start_address 0x7000 -input_file_name "+hid_dir+"/target_info_highaboveVt_ota");
    unix_w("sudo tclsh ~/rasp30/prog_assembly/libs/tcl/write_mem2_NoRelease.tcl -start_address 0x6800 -input_file_name "+hid_dir+"/pulse_width_table_ota");
//    unix_w("sudo tclsh ~/rasp30/prog_assembly/libs/tcl/program.tcl -device /dev/ttyUSB1/ -speed 115200 "+hid_dir+"/recover_inject_highaboveVt_CAB_ota.elf");
//    unix_w("sudo tclsh ~/rasp30/prog_assembly/libs/tcl/read_mem2_NoRelease.tcl -start_address 0x5000 -length 7000 -output_file_name data_highaboveVt_ota_2.hex");
//    disp("recover inj");
//    unix_w("sudo tclsh ~/rasp30/prog_assembly/libs/tcl/write_mem2_NoRelease.tcl -start_address 0x7000 -input_file_name "+hid_dir+"/target_info_highaboveVt_ota");
//    unix_w("sudo tclsh ~/rasp30/prog_assembly/libs/tcl/program.tcl -device /dev/ttyUSB1/ -speed 115200 "+hid_dir+"/first_coarse_program_highaboveVt_CAB_ota.elf");
//    unix_w("sudo tclsh ~/rasp30/prog_assembly/libs/tcl/read_mem2_NoRelease.tcl -start_address 0x5000 -length 7000 -output_file_name data_highaboveVt_ota_3.hex");
//    disp("first coarse inj");
//    unix_w("sudo tclsh ~/rasp30/prog_assembly/libs/tcl/write_mem2_NoRelease.tcl -start_address 0x7000 -input_file_name "+hid_dir+"/target_info_highaboveVt_ota");
//    unix_w("sudo tclsh ~/rasp30/prog_assembly/libs/tcl/program.tcl -device /dev/ttyUSB1/ -speed 115200 "+hid_dir+"/measured_coarse_program_highaboveVt_CAB_ota.elf");
//    unix_w("sudo tclsh ~/rasp30/prog_assembly/libs/tcl/read_mem2_NoRelease.tcl -start_address 0x5000 -length 7000 -output_file_name data_highaboveVt_ota_4.hex");
//    disp("measured coarse inj");
//    unix_w("sudo tclsh ~/rasp30/prog_assembly/libs/tcl/write_mem2_NoRelease.tcl -start_address 0x7000 -input_file_name "+hid_dir+"/target_info_highaboveVt_ota");
    unix_w("sudo tclsh ~/rasp30/prog_assembly/libs/tcl/write_mem2_NoRelease.tcl -start_address 0x6800 -input_file_name "+hid_dir+"/Vd_table_30mV");
    unix_w("sudo tclsh ~/rasp30/prog_assembly/libs/tcl/program.tcl -speed 115200 "+hid_dir+"/fine_program_highaboveVt_m_ave_04_CAB_ota.elf");
    unix_w("sudo tclsh ~/rasp30/prog_assembly/libs/tcl/read_mem2_NoRelease.tcl -start_address 0x5000 -length 7000 -output_file_name data_highaboveVt_ota_5.hex");
    //unix_w("sudo tclsh ~/rasp30/prog_assembly/libs/tcl/read_mem2_NoRelease.tcl -start_address 0x7002 -length 220 -output_file_name temp_1.txt");
    //unix_w("sudo tclsh ~/rasp30/prog_assembly/libs/tcl/read_mem2_NoRelease.tcl -start_address 0x6800 -length 220 -output_file_name temp_2.txt");
    disp("fine inj");
    target_l_highaboveVt_ota=fscanfMat(hid_dir+'/target_list_highaboveVt_ota');
    info_name = "_highaboveVt_ota_"; info_win_num1 = 70; info_win_num2 = 71; info_win_num3 = 72; n_graph=n_target_highaboveVt_ota; m_graph=n_graph+2;
    clear target_list; target_list = target_l_highaboveVt_ota;kapa_constant_or_not = 1/kappa_constant;
    exec("~/rasp30/prog_assembly/libs/scilab_code/finetune_program_graph.sce",-1);
end

if n_target_aboveVt_ota ~= 0 then
    unix_w("sudo tclsh ~/rasp30/prog_assembly/libs/tcl/write_mem2_NoRelease.tcl -start_address 0x7000 -input_file_name "+hid_dir+"/target_info_aboveVt_ota");
    unix_w("sudo tclsh ~/rasp30/prog_assembly/libs/tcl/write_mem2_NoRelease.tcl -start_address 0x6800 -input_file_name "+hid_dir+"/pulse_width_table_ota");
//    unix_w("sudo tclsh ~/rasp30/prog_assembly/libs/tcl/program.tcl -device /dev/ttyUSB1/ -speed 115200 "+hid_dir+"/recover_inject_aboveVt_CAB_ota.elf");
//    unix_w("sudo tclsh ~/rasp30/prog_assembly/libs/tcl/read_mem2_NoRelease.tcl -start_address 0x5000 -length 7000 -output_file_name data_aboveVt_ota_2.hex");
//    disp("recover inj");
//    unix_w("sudo tclsh ~/rasp30/prog_assembly/libs/tcl/write_mem2_NoRelease.tcl -start_address 0x7000 -input_file_name "+hid_dir+"/target_info_aboveVt_ota");
//    unix_w("sudo tclsh ~/rasp30/prog_assembly/libs/tcl/program.tcl -device /dev/ttyUSB1/ -speed 115200 "+hid_dir+"/first_coarse_program_aboveVt_CAB_ota.elf");
//    unix_w("sudo tclsh ~/rasp30/prog_assembly/libs/tcl/read_mem2_NoRelease.tcl -start_address 0x5000 -length 7000 -output_file_name data_aboveVt_ota_3.hex");
//    disp("first coarse inj");
//    unix_w("sudo tclsh ~/rasp30/prog_assembly/libs/tcl/write_mem2_NoRelease.tcl -start_address 0x7000 -input_file_name "+hid_dir+"/target_info_aboveVt_ota");
//    unix_w("sudo tclsh ~/rasp30/prog_assembly/libs/tcl/program.tcl -device /dev/ttyUSB1/ -speed 115200 "+hid_dir+"/measured_coarse_program_aboveVt_CAB_ota.elf");
//    unix_w("sudo tclsh ~/rasp30/prog_assembly/libs/tcl/read_mem2_NoRelease.tcl -start_address 0x5000 -length 7000 -output_file_name data_aboveVt_ota_4.hex");
//    disp("measured coarse inj");
//    unix_w("sudo tclsh ~/rasp30/prog_assembly/libs/tcl/write_mem2_NoRelease.tcl -start_address 0x7000 -input_file_name "+hid_dir+"/target_info_aboveVt_ota");
    unix_w("sudo tclsh ~/rasp30/prog_assembly/libs/tcl/write_mem2_NoRelease.tcl -start_address 0x6800 -input_file_name "+hid_dir+"/Vd_table_30mV");
    unix_w("sudo tclsh ~/rasp30/prog_assembly/libs/tcl/program.tcl -speed 115200 "+hid_dir+"/fine_program_aboveVt_m_ave_04_CAB_ota.elf");
    unix_w("sudo tclsh ~/rasp30/prog_assembly/libs/tcl/read_mem2_NoRelease.tcl -start_address 0x5000 -length 7000 -output_file_name data_aboveVt_ota_5.hex");
    //unix_w("sudo tclsh ~/rasp30/prog_assembly/libs/tcl/read_mem2_NoRelease.tcl -start_address 0x7002 -length 220 -output_file_name temp_1.txt");
    //unix_w("sudo tclsh ~/rasp30/prog_assembly/libs/tcl/read_mem2_NoRelease.tcl -start_address 0x6800 -length 220 -output_file_name temp_2.txt");
    disp("fine inj");
    target_l_aboveVt_ota=fscanfMat(hid_dir+'/target_list_aboveVt_ota');
    info_name = "_aboveVt_ota_"; info_win_num1 = 20; info_win_num2 = 21; info_win_num3 = 22; n_graph=n_target_aboveVt_ota; m_graph=n_graph+2;
    clear target_list; target_list = target_l_aboveVt_ota;kapa_constant_or_not=1;
    exec("~/rasp30/prog_assembly/libs/scilab_code/finetune_program_graph.sce",-1);
end

if n_target_subVt_ota ~= 0 then
    unix_w("sudo tclsh ~/rasp30/prog_assembly/libs/tcl/write_mem2_NoRelease.tcl -start_address 0x7000 -input_file_name "+hid_dir+"/target_info_subVt_ota");
    unix_w("sudo tclsh ~/rasp30/prog_assembly/libs/tcl/write_mem2_NoRelease.tcl -start_address 0x6800 -input_file_name "+hid_dir+"/pulse_width_table_ota");
//    unix_w("sudo tclsh ~/rasp30/prog_assembly/libs/tcl/program.tcl -device /dev/ttyUSB1/ -speed 115200 "+hid_dir+"/recover_inject_subVt_CAB_ota.elf");
//    unix_w("sudo tclsh ~/rasp30/prog_assembly/libs/tcl/read_mem2_NoRelease.tcl -start_address 0x5000 -length 7000 -output_file_name data_subVt_ota_2.hex");
//    disp("recover inj");
//    unix_w("sudo tclsh ~/rasp30/prog_assembly/libs/tcl/write_mem2_NoRelease.tcl -start_address 0x7000 -input_file_name "+hid_dir+"/target_info_subVt_ota");
//    unix_w("sudo tclsh ~/rasp30/prog_assembly/libs/tcl/program.tcl -device /dev/ttyUSB1/ -speed 115200 "+hid_dir+"/first_coarse_program_subVt_CAB_ota.elf");
//    unix_w("sudo tclsh ~/rasp30/prog_assembly/libs/tcl/read_mem2_NoRelease.tcl -start_address 0x5000 -length 7000 -output_file_name data_subVt_ota_3.hex");
//    disp("first coarse inj");
//    unix_w("sudo tclsh ~/rasp30/prog_assembly/libs/tcl/write_mem2_NoRelease.tcl -start_address 0x7000 -input_file_name "+hid_dir+"/target_info_subVt_ota");
//    unix_w("sudo tclsh ~/rasp30/prog_assembly/libs/tcl/program.tcl -device /dev/ttyUSB1/ -speed 115200 "+hid_dir+"/measured_coarse_program_subVt_CAB_ota.elf");
//    unix_w("sudo tclsh ~/rasp30/prog_assembly/libs/tcl/read_mem2_NoRelease.tcl -start_address 0x5000 -length 7000 -output_file_name data_subVt_ota_4.hex");
//    disp("measured coarse inj");
//    unix_w("sudo tclsh ~/rasp30/prog_assembly/libs/tcl/write_mem2_NoRelease.tcl -start_address 0x7000 -input_file_name "+hid_dir+"/target_info_subVt_ota");
    unix_w("sudo tclsh ~/rasp30/prog_assembly/libs/tcl/write_mem2_NoRelease.tcl -start_address 0x6800 -input_file_name "+hid_dir+"/Vd_table_30mV");
    unix_w("sudo tclsh ~/rasp30/prog_assembly/libs/tcl/program.tcl -speed 115200 "+hid_dir+"/fine_program_subVt_m_ave_04_CAB_ota.elf");
    unix_w("sudo tclsh ~/rasp30/prog_assembly/libs/tcl/read_mem2_NoRelease.tcl -start_address 0x5000 -length 7000 -output_file_name data_subVt_ota_5.hex");
    //unix_w("sudo tclsh ~/rasp30/prog_assembly/libs/tcl/read_mem2_NoRelease.tcl -start_address 0x7002 -length 220 -output_file_name temp_1.txt");
    //unix_w("sudo tclsh ~/rasp30/prog_assembly/libs/tcl/read_mem2_NoRelease.tcl -start_address 0x6800 -length 220 -output_file_name temp_2.txt");
    disp("fine inj");
    target_l_subVt_ota=fscanfMat(hid_dir+'/target_list_subVt_ota');
    info_name = "_subVt_ota_"; info_win_num1 = 23; info_win_num2 = 24; info_win_num3 = 25; n_graph=n_target_subVt_ota; m_graph=n_graph+2;
    clear target_list; target_list = target_l_subVt_ota;kapa_constant_or_not=1;
    exec("~/rasp30/prog_assembly/libs/scilab_code/finetune_program_graph.sce",-1);
end

if n_target_lowsubVt_ota ~= 0 then
    unix_w("sudo tclsh ~/rasp30/prog_assembly/libs/tcl/write_mem2_NoRelease.tcl -start_address 0x7000 -input_file_name "+hid_dir+"/target_info_lowsubVt_ota");
    unix_w("sudo tclsh ~/rasp30/prog_assembly/libs/tcl/write_mem2_NoRelease.tcl -start_address 0x6800 -input_file_name "+hid_dir+"/pulse_width_table_lowsubVt_ota");
//    unix_w("sudo tclsh ~/rasp30/prog_assembly/libs/tcl/program.tcl -device /dev/ttyUSB1/ -speed 115200 "+hid_dir+"/recover_inject_lowsubVt_CAB_ota.elf");
//    unix_w("sudo tclsh ~/rasp30/prog_assembly/libs/tcl/read_mem2_NoRelease.tcl -start_address 0x5000 -length 7000 -output_file_name data_lowsubVt_ota_2.hex");
//    disp("recover inj");
//    unix_w("sudo tclsh ~/rasp30/prog_assembly/libs/tcl/write_mem2_NoRelease.tcl -start_address 0x7000 -input_file_name "+hid_dir+"/target_info_lowsubVt_ota");
//    unix_w("sudo tclsh ~/rasp30/prog_assembly/libs/tcl/program.tcl -device /dev/ttyUSB1/ -speed 115200 "+hid_dir+"/first_coarse_program_lowsubVt_CAB_ota.elf");
//    unix_w("sudo tclsh ~/rasp30/prog_assembly/libs/tcl/read_mem2_NoRelease.tcl -start_address 0x5000 -length 7000 -output_file_name data_lowsubVt_ota_3.hex");
//    disp("first coarse inj");
//    unix_w("sudo tclsh ~/rasp30/prog_assembly/libs/tcl/write_mem2_NoRelease.tcl -start_address 0x7000 -input_file_name "+hid_dir+"/target_info_lowsubVt_ota");
//    unix_w("sudo tclsh ~/rasp30/prog_assembly/libs/tcl/program.tcl -device /dev/ttyUSB1/ -speed 115200 "+hid_dir+"/measured_coarse_program_lowsubVt_CAB_ota.elf");
//    unix_w("sudo tclsh ~/rasp30/prog_assembly/libs/tcl/read_mem2_NoRelease.tcl -start_address 0x5000 -length 7000 -output_file_name data_lowsubVt_ota_4.hex");
//    disp("measured coarse inj");
//    unix_w("sudo tclsh ~/rasp30/prog_assembly/libs/tcl/write_mem2_NoRelease.tcl -start_address 0x7000 -input_file_name "+hid_dir+"/target_info_lowsubVt_ota");
    unix_w("sudo tclsh ~/rasp30/prog_assembly/libs/tcl/write_mem2_NoRelease.tcl -start_address 0x6800 -input_file_name "+hid_dir+"/Vd_table_30mV");
    unix_w("sudo tclsh ~/rasp30/prog_assembly/libs/tcl/program.tcl -speed 115200 "+hid_dir+"/fine_program_lowsubVt_m_ave_04_CAB_ota.elf");
    unix_w("sudo tclsh ~/rasp30/prog_assembly/libs/tcl/read_mem2_NoRelease.tcl -start_address 0x5000 -length 7000 -output_file_name data_lowsubVt_ota_5.hex");
    //unix_w("sudo tclsh ~/rasp30/prog_assembly/libs/tcl/read_mem2_NoRelease.tcl -start_address 0x7002 -length 220 -output_file_name temp_1.txt");
    //unix_w("sudo tclsh ~/rasp30/prog_assembly/libs/tcl/read_mem2_NoRelease.tcl -start_address 0x6800 -length 220 -output_file_name temp_2.txt");
    disp("fine inj");
    target_l_lowsubVt_ota=fscanfMat(hid_dir+'/target_list_lowsubVt_ota');
    info_name = "_lowsubVt_ota_"; info_win_num1 = 26; info_win_num2 = 27; info_win_num3 = 28; n_graph=n_target_lowsubVt_ota; m_graph=n_graph+2;
    clear target_list; target_list = target_l_lowsubVt_ota;kapa_constant_or_not = kappa_constant;
    exec("~/rasp30/prog_assembly/libs/scilab_code/finetune_program_graph.sce",-1);
end

if n_target_aboveVt_otaref ~= 0 then
    unix_w("sudo tclsh ~/rasp30/prog_assembly/libs/tcl/write_mem2_NoRelease.tcl -start_address 0x7000 -input_file_name "+hid_dir+"/target_info_aboveVt_otaref");
    unix_w("sudo tclsh ~/rasp30/prog_assembly/libs/tcl/write_mem2_NoRelease.tcl -start_address 0x6800 -input_file_name "+hid_dir+"/pulse_width_table_otaref");
//    unix_w("sudo tclsh ~/rasp30/prog_assembly/libs/tcl/program.tcl -device /dev/ttyUSB1/ -speed 115200 "+hid_dir+"/recover_inject_aboveVt_CAB_ota_ref.elf");
//    unix_w("sudo tclsh ~/rasp30/prog_assembly/libs/tcl/read_mem2_NoRelease.tcl -start_address 0x5000 -length 7000 -output_file_name data_aboveVt_otaref_2.hex");
//    disp("recover inj");
//    unix_w("sudo tclsh ~/rasp30/prog_assembly/libs/tcl/write_mem2_NoRelease.tcl -start_address 0x7000 -input_file_name "+hid_dir+"/target_info_aboveVt_otaref");
//    unix_w("sudo tclsh ~/rasp30/prog_assembly/libs/tcl/program.tcl -device /dev/ttyUSB1/ -speed 115200 "+hid_dir+"/first_coarse_program_aboveVt_CAB_ota_ref.elf");
//    unix_w("sudo tclsh ~/rasp30/prog_assembly/libs/tcl/read_mem2_NoRelease.tcl -start_address 0x5000 -length 7000 -output_file_name data_aboveVt_otaref_3.hex");
//    disp("first coarse inj");
//    unix_w("sudo tclsh ~/rasp30/prog_assembly/libs/tcl/write_mem2_NoRelease.tcl -start_address 0x7000 -input_file_name "+hid_dir+"/target_info_aboveVt_otaref");
//    unix_w("sudo tclsh ~/rasp30/prog_assembly/libs/tcl/program.tcl -device /dev/ttyUSB1/ -speed 115200 "+hid_dir+"/measured_coarse_program_aboveVt_CAB_ota_ref.elf");
//    unix_w("sudo tclsh ~/rasp30/prog_assembly/libs/tcl/read_mem2_NoRelease.tcl -start_address 0x5000 -length 7000 -output_file_name data_aboveVt_otaref_4.hex");
//    disp("measured coarse inj");
//    unix_w("sudo tclsh ~/rasp30/prog_assembly/libs/tcl/write_mem2_NoRelease.tcl -start_address 0x7000 -input_file_name "+hid_dir+"/target_info_aboveVt_otaref");
    unix_w("sudo tclsh ~/rasp30/prog_assembly/libs/tcl/write_mem2_NoRelease.tcl -start_address 0x6800 -input_file_name "+hid_dir+"/Vd_table_30mV");
    unix_w("sudo tclsh ~/rasp30/prog_assembly/libs/tcl/program.tcl -speed 115200 "+hid_dir+"/fine_program_aboveVt_m_ave_04_CAB_ota_ref.elf");
    unix_w("sudo tclsh ~/rasp30/prog_assembly/libs/tcl/read_mem2_NoRelease.tcl -start_address 0x5000 -length 7000 -output_file_name data_aboveVt_otaref_5.hex");
    //unix_w("sudo tclsh ~/rasp30/prog_assembly/libs/tcl/read_mem2_NoRelease.tcl -start_address 0x7002 -length 220 -output_file_name temp_1.txt");
    //unix_w("sudo tclsh ~/rasp30/prog_assembly/libs/tcl/read_mem2_NoRelease.tcl -start_address 0x6800 -length 220 -output_file_name temp_2.txt");
    disp("fine inj");
    target_l_aboveVt_otaref=fscanfMat(hid_dir+'/target_list_aboveVt_otaref');
    info_name = "_aboveVt_otaref_"; info_win_num1 = 30; info_win_num2 = 31; info_win_num3 = 32; n_graph=n_target_aboveVt_otaref; m_graph=n_graph+2;
    clear target_list; target_list = target_l_aboveVt_otaref;kapa_constant_or_not=1;
    exec("~/rasp30/prog_assembly/libs/scilab_code/finetune_program_graph.sce",-1);
end

if n_target_subVt_otaref ~= 0 then
    unix_w("sudo tclsh ~/rasp30/prog_assembly/libs/tcl/write_mem2_NoRelease.tcl -start_address 0x7000 -input_file_name "+hid_dir+"/target_info_subVt_otaref");
    unix_w("sudo tclsh ~/rasp30/prog_assembly/libs/tcl/write_mem2_NoRelease.tcl -start_address 0x6800 -input_file_name "+hid_dir+"/pulse_width_table_otaref");
//    unix_w("sudo tclsh ~/rasp30/prog_assembly/libs/tcl/program.tcl -device /dev/ttyUSB1/ -speed 115200 "+hid_dir+"/recover_inject_subVt_CAB_ota_ref.elf");
//    unix_w("sudo tclsh ~/rasp30/prog_assembly/libs/tcl/read_mem2_NoRelease.tcl -start_address 0x5000 -length 7000 -output_file_name data_subVt_otaref_2.hex");
//    disp("recover inj");
//    unix_w("sudo tclsh ~/rasp30/prog_assembly/libs/tcl/write_mem2_NoRelease.tcl -start_address 0x7000 -input_file_name "+hid_dir+"/target_info_subVt_otaref");
//    unix_w("sudo tclsh ~/rasp30/prog_assembly/libs/tcl/program.tcl -device /dev/ttyUSB1/ -speed 115200 "+hid_dir+"/first_coarse_program_subVt_CAB_ota_ref.elf");
//    unix_w("sudo tclsh ~/rasp30/prog_assembly/libs/tcl/read_mem2_NoRelease.tcl -start_address 0x5000 -length 7000 -output_file_name data_subVt_otaref_3.hex");
//    disp("first coarse inj");
//    unix_w("sudo tclsh ~/rasp30/prog_assembly/libs/tcl/write_mem2_NoRelease.tcl -start_address 0x7000 -input_file_name "+hid_dir+"/target_info_subVt_otaref");
//    unix_w("sudo tclsh ~/rasp30/prog_assembly/libs/tcl/program.tcl -device /dev/ttyUSB1/ -speed 115200 "+hid_dir+"/measured_coarse_program_subVt_CAB_ota_ref.elf");
//    unix_w("sudo tclsh ~/rasp30/prog_assembly/libs/tcl/read_mem2_NoRelease.tcl -start_address 0x5000 -length 7000 -output_file_name data_subVt_otaref_4.hex");
//    disp("measured coarse inj");
//    unix_w("sudo tclsh ~/rasp30/prog_assembly/libs/tcl/write_mem2_NoRelease.tcl -start_address 0x7000 -input_file_name "+hid_dir+"/target_info_subVt_otaref");
    unix_w("sudo tclsh ~/rasp30/prog_assembly/libs/tcl/write_mem2_NoRelease.tcl -start_address 0x6800 -input_file_name "+hid_dir+"/Vd_table_30mV");
    unix_w("sudo tclsh ~/rasp30/prog_assembly/libs/tcl/program.tcl -speed 115200 "+hid_dir+"/fine_program_subVt_m_ave_04_CAB_ota_ref.elf");
    unix_w("sudo tclsh ~/rasp30/prog_assembly/libs/tcl/read_mem2_NoRelease.tcl -start_address 0x5000 -length 7000 -output_file_name data_subVt_otaref_5.hex");
    //unix_w("sudo tclsh ~/rasp30/prog_assembly/libs/tcl/read_mem2_NoRelease.tcl -start_address 0x7002 -length 220 -output_file_name temp_1.txt");
    //unix_w("sudo tclsh ~/rasp30/prog_assembly/libs/tcl/read_mem2_NoRelease.tcl -start_address 0x6800 -length 220 -output_file_name temp_2.txt");
    disp("fine inj");
    target_l_subVt_otaref=fscanfMat(hid_dir+'/target_list_subVt_otaref');
    info_name = "_subVt_otaref_"; info_win_num1 = 33; info_win_num2 = 34; info_win_num3 = 35; n_graph=n_target_subVt_otaref; m_graph=n_graph+2;
    clear target_list; target_list = target_l_subVt_otaref;kapa_constant_or_not=1;
    exec("~/rasp30/prog_assembly/libs/scilab_code/finetune_program_graph.sce",-1);
end

if n_target_lowsubVt_otaref ~= 0 then
    unix_w("sudo tclsh ~/rasp30/prog_assembly/libs/tcl/write_mem2_NoRelease.tcl -start_address 0x7000 -input_file_name "+hid_dir+"/target_info_lowsubVt_otaref");
    unix_w("sudo tclsh ~/rasp30/prog_assembly/libs/tcl/write_mem2_NoRelease.tcl -start_address 0x6800 -input_file_name "+hid_dir+"/pulse_width_table_lowsubVt_otaref");
//    unix_w("sudo tclsh ~/rasp30/prog_assembly/libs/tcl/program.tcl -device /dev/ttyUSB1/ -speed 115200 "+hid_dir+"/recover_inject_lowsubVt_CAB_ota_ref.elf");
//    unix_w("sudo tclsh ~/rasp30/prog_assembly/libs/tcl/read_mem2_NoRelease.tcl -start_address 0x5000 -length 7000 -output_file_name data_lowsubVt_otaref_2.hex");
//    disp("recover inj");
//    unix_w("sudo tclsh ~/rasp30/prog_assembly/libs/tcl/write_mem2_NoRelease.tcl -start_address 0x7000 -input_file_name "+hid_dir+"/target_info_lowsubVt_otaref");
//    unix_w("sudo tclsh ~/rasp30/prog_assembly/libs/tcl/program.tcl -device /dev/ttyUSB1/ -speed 115200 "+hid_dir+"/first_coarse_program_lowsubVt_CAB_ota_ref.elf");
//    unix_w("sudo tclsh ~/rasp30/prog_assembly/libs/tcl/read_mem2_NoRelease.tcl -start_address 0x5000 -length 7000 -output_file_name data_lowsubVt_otaref_3.hex");
//    disp("first coarse inj");
//    unix_w("sudo tclsh ~/rasp30/prog_assembly/libs/tcl/write_mem2_NoRelease.tcl -start_address 0x7000 -input_file_name "+hid_dir+"/target_info_lowsubVt_otaref");
//    unix_w("sudo tclsh ~/rasp30/prog_assembly/libs/tcl/program.tcl -device /dev/ttyUSB1/ -speed 115200 "+hid_dir+"/measured_coarse_program_lowsubVt_CAB_ota_ref.elf");
//    unix_w("sudo tclsh ~/rasp30/prog_assembly/libs/tcl/read_mem2_NoRelease.tcl -start_address 0x5000 -length 7000 -output_file_name data_lowsubVt_otaref_4.hex");
//    disp("measured coarse inj");
//    unix_w("sudo tclsh ~/rasp30/prog_assembly/libs/tcl/write_mem2_NoRelease.tcl -start_address 0x7000 -input_file_name "+hid_dir+"/target_info_lowsubVt_otaref");
    unix_w("sudo tclsh ~/rasp30/prog_assembly/libs/tcl/write_mem2_NoRelease.tcl -start_address 0x6800 -input_file_name "+hid_dir+"/Vd_table_30mV");
    unix_w("sudo tclsh ~/rasp30/prog_assembly/libs/tcl/program.tcl -speed 115200 "+hid_dir+"/fine_program_lowsubVt_m_ave_04_CAB_ota_ref.elf");
    unix_w("sudo tclsh ~/rasp30/prog_assembly/libs/tcl/read_mem2_NoRelease.tcl -start_address 0x5000 -length 7000 -output_file_name data_lowsubVt_otaref_5.hex");
    //unix_w("sudo tclsh ~/rasp30/prog_assembly/libs/tcl/read_mem2_NoRelease.tcl -start_address 0x7002 -length 220 -output_file_name temp_1.txt");
    //unix_w("sudo tclsh ~/rasp30/prog_assembly/libs/tcl/read_mem2_NoRelease.tcl -start_address 0x6800 -length 220 -output_file_name temp_2.txt");
    disp("fine inj");
    target_l_lowsubVt_otaref=fscanfMat(hid_dir+'/target_list_lowsubVt_otaref');
    info_name = "_lowsubVt_otaref_"; info_win_num1 = 36; info_win_num2 = 37; info_win_num3 = 38; n_graph=n_target_lowsubVt_otaref; m_graph=n_graph+2;
    clear target_list; target_list = target_l_lowsubVt_otaref; kapa_constant_or_not = kappa_constant;
    exec("~/rasp30/prog_assembly/libs/scilab_code/finetune_program_graph.sce",-1);
end

if n_target_aboveVt_mite ~= 0 then
    unix_w("sudo tclsh ~/rasp30/prog_assembly/libs/tcl/write_mem2_NoRelease.tcl -start_address 0x7000 -input_file_name "+hid_dir+"/target_info_aboveVt_mite");
    unix_w("sudo tclsh ~/rasp30/prog_assembly/libs/tcl/write_mem2_NoRelease.tcl -start_address 0x6800 -input_file_name "+hid_dir+"/pulse_width_table_mite");
//    unix_w("sudo tclsh ~/rasp30/prog_assembly/libs/tcl/program.tcl -device /dev/ttyUSB1/ -speed 115200 "+hid_dir+"/recover_inject_aboveVt_CAB_mite.elf");
//    unix_w("sudo tclsh ~/rasp30/prog_assembly/libs/tcl/read_mem2_NoRelease.tcl -device /dev/ttyUSB1/ -start_address 0x5000 -length 7000 -output_file_name data_aboveVt_mite_2.hex");
//    disp("recover inj");
//    unix_w("sudo tclsh ~/rasp30/prog_assembly/libs/tcl/write_mem2_NoRelease.tcl -device /dev/ttyUSB1/ -start_address 0x7000 -input_file_name "+hid_dir+"/target_info_aboveVt_mite");
//    unix_w("sudo tclsh ~/rasp30/prog_assembly/libs/tcl/program.tcl -device /dev/ttyUSB1/ -speed 115200 "+hid_dir+"/first_coarse_program_aboveVt_CAB_mite.elf");
//    unix_w("sudo tclsh ~/rasp30/prog_assembly/libs/tcl/read_mem2_NoRelease.tcl -device /dev/ttyUSB1/ -start_address 0x5000 -length 7000 -output_file_name data_aboveVt_mite_3.hex");
//    disp("first coarse inj");
//    unix_w("sudo tclsh ~/rasp30/prog_assembly/libs/tcl/write_mem2_NoRelease.tcl -device /dev/ttyUSB1/ -start_address 0x7000 -input_file_name "+hid_dir+"/target_info_aboveVt_mite");
//    unix_w("sudo tclsh ~/rasp30/prog_assembly/libs/tcl/program.tcl -device /dev/ttyUSB1/ -speed 115200 "+hid_dir+"/measured_coarse_program_aboveVt_CAB_mite.elf");
//    unix_w("sudo tclsh ~/rasp30/prog_assembly/libs/tcl/read_mem2_NoRelease.tcl -device /dev/ttyUSB1/ -start_address 0x5000 -length 7000 -output_file_name data_aboveVt_mite_4.hex");
//    disp("measured coarse inj");
//    unix_w("sudo tclsh ~/rasp30/prog_assembly/libs/tcl/write_mem2_NoRelease.tcl -device /dev/ttyUSB1/ -start_address 0x7000 -input_file_name "+hid_dir+"/target_info_aboveVt_mite");
    unix_w("sudo tclsh ~/rasp30/prog_assembly/libs/tcl/write_mem2_NoRelease.tcl -start_address 0x6800 -input_file_name "+hid_dir+"/Vd_table_30mV");
    unix_w("sudo tclsh ~/rasp30/prog_assembly/libs/tcl/program.tcl -speed 115200 "+hid_dir+"/fine_program_aboveVt_m_ave_04_CAB_mite.elf");
    unix_w("sudo tclsh ~/rasp30/prog_assembly/libs/tcl/read_mem2_NoRelease.tcl -start_address 0x5000 -length 7000 -output_file_name data_aboveVt_mite_5.hex");
    //unix_w("sudo tclsh ~/rasp30/prog_assembly/libs/tcl/read_mem2_NoRelease.tcl -device /dev/ttyUSB1/ -start_address 0x7002 -length 220 -output_file_name temp_1.txt");
    //unix_w("sudo tclsh ~/rasp30/prog_assembly/libs/tcl/read_mem2_NoRelease.tcl -start_address 0x6800 -length 220 -output_file_name temp_2.txt");
    disp("fine inj");
    target_l_aboveVt_mite=fscanfMat(hid_dir+'/target_list_aboveVt_mite');
    info_name = "_aboveVt_mite_"; info_win_num1 = 40; info_win_num2 = 41; info_win_num3 = 42; n_graph=n_target_aboveVt_mite; m_graph=n_graph+2;
    clear target_list; target_list = target_l_aboveVt_mite;kapa_constant_or_not=1;
    exec("~/rasp30/prog_assembly/libs/scilab_code/finetune_program_graph.sce",-1);
end

if n_target_subVt_mite ~= 0 then
    unix_w("sudo tclsh ~/rasp30/prog_assembly/libs/tcl/write_mem2_NoRelease.tcl -start_address 0x7000 -input_file_name "+hid_dir+"/target_info_subVt_mite");
    unix_w("sudo tclsh ~/rasp30/prog_assembly/libs/tcl/write_mem2_NoRelease.tcl -start_address 0x6800 -input_file_name "+hid_dir+"/pulse_width_table_mite");
//    unix_w("sudo tclsh ~/rasp30/prog_assembly/libs/tcl/program.tcl -device /dev/ttyUSB1/ -speed 115200 "+hid_dir+"/recover_inject_subVt_CAB_mite.elf");
//    unix_w("sudo tclsh ~/rasp30/prog_assembly/libs/tcl/read_mem2_NoRelease.tcl -start_address 0x5000 -length 7000 -output_file_name data_subVt_mite_2.hex");
//    disp("recover inj");
//    unix_w("sudo tclsh ~/rasp30/prog_assembly/libs/tcl/write_mem2_NoRelease.tcl -start_address 0x7000 -input_file_name "+hid_dir+"/target_info_subVt_mite");
//    unix_w("sudo tclsh ~/rasp30/prog_assembly/libs/tcl/program.tcl -device /dev/ttyUSB1/ -speed 115200 "+hid_dir+"/first_coarse_program_subVt_CAB_mite.elf");
//    unix_w("sudo tclsh ~/rasp30/prog_assembly/libs/tcl/read_mem2_NoRelease.tcl -start_address 0x5000 -length 7000 -output_file_name data_subVt_mite_3.hex");
//    disp("first coarse inj");
//    unix_w("sudo tclsh ~/rasp30/prog_assembly/libs/tcl/write_mem2_NoRelease.tcl -start_address 0x7000 -input_file_name "+hid_dir+"/target_info_subVt_mite");
//    unix_w("sudo tclsh ~/rasp30/prog_assembly/libs/tcl/program.tcl -device /dev/ttyUSB1/ -speed 115200 "+hid_dir+"/measured_coarse_program_subVt_CAB_mite.elf");
//    unix_w("sudo tclsh ~/rasp30/prog_assembly/libs/tcl/read_mem2_NoRelease.tcl -start_address 0x5000 -length 7000 -output_file_name data_subVt_mite_4.hex");
//    disp("measured coarse inj");
//    unix_w("sudo tclsh ~/rasp30/prog_assembly/libs/tcl/write_mem2_NoRelease.tcl -start_address 0x7000 -input_file_name "+hid_dir+"/target_info_subVt_mite");
    unix_w("sudo tclsh ~/rasp30/prog_assembly/libs/tcl/write_mem2_NoRelease.tcl -start_address 0x6800 -input_file_name "+hid_dir+"/Vd_table_30mV");
    unix_w("sudo tclsh ~/rasp30/prog_assembly/libs/tcl/program.tcl -speed 115200 "+hid_dir+"/fine_program_subVt_m_ave_04_CAB_mite.elf");
    unix_w("sudo tclsh ~/rasp30/prog_assembly/libs/tcl/read_mem2_NoRelease.tcl -start_address 0x5000 -length 7000 -output_file_name data_subVt_mite_5.hex");
    //unix_w("sudo tclsh ~/rasp30/prog_assembly/libs/tcl/read_mem2_NoRelease.tcl -start_address 0x7002 -length 220 -output_file_name temp_1.txt");
    //unix_w("sudo tclsh ~/rasp30/prog_assembly/libs/tcl/read_mem2_NoRelease.tcl -start_address 0x6800 -length 220 -output_file_name temp_2.txt");
    disp("fine inj");
    target_l_subVt_mite=fscanfMat(hid_dir+'/target_list_subVt_mite');
    info_name = "_subVt_mite_"; info_win_num1 = 43; info_win_num2 = 44; info_win_num3 = 45; n_graph=n_target_subVt_mite; m_graph=n_graph+2;
    clear target_list; target_list = target_l_subVt_mite;kapa_constant_or_not=1;
    exec("~/rasp30/prog_assembly/libs/scilab_code/finetune_program_graph.sce",-1);
end

if n_target_lowsubVt_mite ~= 0 then
    unix_w("sudo tclsh ~/rasp30/prog_assembly/libs/tcl/write_mem2_NoRelease.tcl -start_address 0x7000 -input_file_name "+hid_dir+"/target_info_lowsubVt_mite");
    unix_w("sudo tclsh ~/rasp30/prog_assembly/libs/tcl/write_mem2_NoRelease.tcl -start_address 0x6800 -input_file_name "+hid_dir+"/pulse_width_table_lowsubVt_mite");
//    unix_w("sudo tclsh ~/rasp30/prog_assembly/libs/tcl/program.tcl -device /dev/ttyUSB1/ -speed 115200 "+hid_dir+"/recover_inject_lowsubVt_CAB_mite.elf");
//    unix_w("sudo tclsh ~/rasp30/prog_assembly/libs/tcl/read_mem2_NoRelease.tcl -start_address 0x5000 -length 7000 -output_file_name data_lowsubVt_mite_2.hex");
//    disp("recover inj");
//    unix_w("sudo tclsh ~/rasp30/prog_assembly/libs/tcl/write_mem2_NoRelease.tcl -start_address 0x7000 -input_file_name "+hid_dir+"/target_info_lowsubVt_mite");
//    unix_w("sudo tclsh ~/rasp30/prog_assembly/libs/tcl/program.tcl -device /dev/ttyUSB1/ -speed 115200 "+hid_dir+"/first_coarse_program_lowsubVt_CAB_mite.elf");
//    unix_w("sudo tclsh ~/rasp30/prog_assembly/libs/tcl/read_mem2_NoRelease.tcl -start_address 0x5000 -length 7000 -output_file_name data_lowsubVt_mite_3.hex");
//    disp("first coarse inj");
//    unix_w("sudo tclsh ~/rasp30/prog_assembly/libs/tcl/write_mem2_NoRelease.tcl -start_address 0x7000 -input_file_name "+hid_dir+"/target_info_lowsubVt_mite");
//    unix_w("sudo tclsh ~/rasp30/prog_assembly/libs/tcl/program.tcl -device /dev/ttyUSB1/ -speed 115200 "+hid_dir+"/measured_coarse_program_lowsubVt_CAB_mite.elf");
//    unix_w("sudo tclsh ~/rasp30/prog_assembly/libs/tcl/read_mem2_NoRelease.tcl -start_address 0x5000 -length 7000 -output_file_name data_lowsubVt_mite_4.hex");
//    disp("measured coarse inj");
//    unix_w("sudo tclsh ~/rasp30/prog_assembly/libs/tcl/write_mem2_NoRelease.tcl -start_address 0x7000 -input_file_name "+hid_dir+"/target_info_lowsubVt_mite");
    unix_w("sudo tclsh ~/rasp30/prog_assembly/libs/tcl/write_mem2_NoRelease.tcl -start_address 0x6800 -input_file_name "+hid_dir+"/Vd_table_30mV");
    unix_w("sudo tclsh ~/rasp30/prog_assembly/libs/tcl/program.tcl -speed 115200 "+hid_dir+"/fine_program_lowsubVt_m_ave_04_CAB_mite.elf");
    unix_w("sudo tclsh ~/rasp30/prog_assembly/libs/tcl/read_mem2_NoRelease.tcl -start_address 0x5000 -length 7000 -output_file_name data_lowsubVt_mite_5.hex");
    //unix_w("sudo tclsh ~/rasp30/prog_assembly/libs/tcl/read_mem2_NoRelease.tcl -start_address 0x7002 -length 220 -output_file_name temp_1.txt");
    //unix_w("sudo tclsh ~/rasp30/prog_assembly/libs/tcl/read_mem2_NoRelease.tcl -start_address 0x6800 -length 220 -output_file_name temp_2.txt");
    disp("fine inj");
    target_l_lowsubVt_mite=fscanfMat(hid_dir+'/target_list_lowsubVt_mite');
    info_name = "_lowsubVt_mite_"; info_win_num1 = 46; info_win_num2 = 47; info_win_num3 = 48; n_graph=n_target_lowsubVt_mite; m_graph=n_graph+2;
    clear target_list; target_list = target_l_lowsubVt_mite;kapa_constant_or_not = kappa_constant;
    exec("~/rasp30/prog_assembly/libs/scilab_code/finetune_program_graph.sce",-1);
end

if n_target_aboveVt_dirswc ~= 0 then
    unix_w("sudo tclsh ~/rasp30/prog_assembly/libs/tcl/write_mem2_NoRelease.tcl -start_address 0x7000 -input_file_name "+hid_dir+"/target_info_aboveVt_dirswc");
    unix_w("sudo tclsh ~/rasp30/prog_assembly/libs/tcl/write_mem2_NoRelease.tcl -start_address 0x6800 -input_file_name "+hid_dir+"/pulse_width_table_dirswc");
//    unix_w("sudo tclsh ~/rasp30/prog_assembly/libs/tcl/program.tcl -device /dev/ttyUSB1/ -speed 115200 "+hid_dir+"/recover_inject_aboveVt_DIRSWC.elf");
//    unix_w("sudo tclsh ~/rasp30/prog_assembly/libs/tcl/read_mem2_NoRelease.tcl -start_address 0x5000 -length 7000 -output_file_name data_aboveVt_dirswc_2.hex");
//    disp("recover inj");
//    unix_w("sudo tclsh ~/rasp30/prog_assembly/libs/tcl/write_mem2_NoRelease.tcl -start_address 0x7000 -input_file_name "+hid_dir+"/target_info_aboveVt_dirswc");
//    unix_w("sudo tclsh ~/rasp30/prog_assembly/libs/tcl/program.tcl -device /dev/ttyUSB1/ -speed 115200 "+hid_dir+"/first_coarse_program_aboveVt_DIRSWC.elf");
//    unix_w("sudo tclsh ~/rasp30/prog_assembly/libs/tcl/read_mem2_NoRelease.tcl -start_address 0x5000 -length 7000 -output_file_name data_aboveVt_dirswc_3.hex");
//    disp("first coarse inj");
//    unix_w("sudo tclsh ~/rasp30/prog_assembly/libs/tcl/write_mem2_NoRelease.tcl -start_address 0x7000 -input_file_name "+hid_dir+"/target_info_aboveVt_dirswc");
//    unix_w("sudo tclsh ~/rasp30/prog_assembly/libs/tcl/program.tcl -device /dev/ttyUSB1/ -speed 115200 "+hid_dir+"/measured_coarse_program_aboveVt_DIRSWC.elf");
//    unix_w("sudo tclsh ~/rasp30/prog_assembly/libs/tcl/read_mem2_NoRelease.tcl -start_address 0x5000 -length 7000 -output_file_name data_aboveVt_dirswc_4.hex");
//    disp("measured coarse inj");
//    unix_w("sudo tclsh ~/rasp30/prog_assembly/libs/tcl/write_mem2_NoRelease.tcl -start_address 0x7000 -input_file_name "+hid_dir+"/target_info_aboveVt_dirswc");
    unix_w("sudo tclsh ~/rasp30/prog_assembly/libs/tcl/write_mem2_NoRelease.tcl -start_address 0x6800 -input_file_name "+hid_dir+"/Vd_table_30mV");
    unix_w("sudo tclsh ~/rasp30/prog_assembly/libs/tcl/program.tcl -speed 115200 "+hid_dir+"/fine_program_aboveVt_m_ave_04_DIRSWC.elf");
    unix_w("sudo tclsh ~/rasp30/prog_assembly/libs/tcl/read_mem2_NoRelease.tcl -start_address 0x5000 -length 7000 -output_file_name data_aboveVt_dirswc_5.hex");
    //unix_w("sudo tclsh ~/rasp30/prog_assembly/libs/tcl/read_mem2_NoRelease.tcl -start_address 0x7002 -length 220 -output_file_name temp_1.txt");
    //unix_w("sudo tclsh ~/rasp30/prog_assembly/libs/tcl/read_mem2_NoRelease.tcl -start_address 0x6800 -length 220 -output_file_name temp_2.txt");
    disp("fine inj");
    target_l_aboveVt_dirswc=fscanfMat(hid_dir+'/target_list_aboveVt_dirswc');
    info_name = "_aboveVt_dirswc_"; info_win_num1 = 50; info_win_num2 = 51; info_win_num3 = 52; n_graph=n_target_aboveVt_dirswc; m_graph=n_graph+2;
    clear target_list; target_list = target_l_aboveVt_dirswc;kapa_constant_or_not=1;
    exec("~/rasp30/prog_assembly/libs/scilab_code/finetune_program_graph.sce",-1);
end

if n_target_subVt_dirswc ~= 0 then
    unix_w("sudo tclsh ~/rasp30/prog_assembly/libs/tcl/write_mem2_NoRelease.tcl -start_address 0x7000 -input_file_name "+hid_dir+"/target_info_subVt_dirswc");
    unix_w("sudo tclsh ~/rasp30/prog_assembly/libs/tcl/write_mem2_NoRelease.tcl -start_address 0x6800 -input_file_name "+hid_dir+"/pulse_width_table_dirswc");
//    unix_w("sudo tclsh ~/rasp30/prog_assembly/libs/tcl/program.tcl -device /dev/ttyUSB1/ -speed 115200 "+hid_dir+"/recover_inject_subVt_DIRSWC.elf");
//    unix_w("sudo tclsh ~/rasp30/prog_assembly/libs/tcl/read_mem2_NoRelease.tcl -start_address 0x5000 -length 7000 -output_file_name data_subVt_dirswc_2.hex");
//    disp("recover inj");
//    unix_w("sudo tclsh ~/rasp30/prog_assembly/libs/tcl/write_mem2_NoRelease.tcl -start_address 0x7000 -input_file_name "+hid_dir+"/target_info_subVt_dirswc");
//    unix_w("sudo tclsh ~/rasp30/prog_assembly/libs/tcl/program.tcl -device /dev/ttyUSB1/ -speed 115200 "+hid_dir+"/first_coarse_program_subVt_DIRSWC.elf");
//    unix_w("sudo tclsh ~/rasp30/prog_assembly/libs/tcl/read_mem2_NoRelease.tcl -start_address 0x5000 -length 7000 -output_file_name data_subVt_dirswc_3.hex");
//    disp("first coarse inj");
//    unix_w("sudo tclsh ~/rasp30/prog_assembly/libs/tcl/write_mem2_NoRelease.tcl -start_address 0x7000 -input_file_name "+hid_dir+"/target_info_subVt_dirswc");
//    unix_w("sudo tclsh ~/rasp30/prog_assembly/libs/tcl/program.tcl -device /dev/ttyUSB1/ -speed 115200 "+hid_dir+"/measured_coarse_program_subVt_DIRSWC.elf");
//    unix_w("sudo tclsh ~/rasp30/prog_assembly/libs/tcl/read_mem2_NoRelease.tcl -start_address 0x5000 -length 7000 -output_file_name data_subVt_dirswc_4.hex");
//    disp("measured coarse inj");
//    unix_w("sudo tclsh ~/rasp30/prog_assembly/libs/tcl/write_mem2_NoRelease.tcl -start_address 0x7000 -input_file_name "+hid_dir+"/target_info_subVt_dirswc");
    unix_w("sudo tclsh ~/rasp30/prog_assembly/libs/tcl/write_mem2_NoRelease.tcl -start_address 0x6800 -input_file_name "+hid_dir+"/Vd_table_30mV");
    unix_w("sudo tclsh ~/rasp30/prog_assembly/libs/tcl/program.tcl -speed 115200 "+hid_dir+"/fine_program_subVt_m_ave_04_DIRSWC.elf");
    unix_w("sudo tclsh ~/rasp30/prog_assembly/libs/tcl/read_mem2_NoRelease.tcl -start_address 0x5000 -length 7000 -output_file_name data_subVt_dirswc_5.hex");
    //unix_w("sudo tclsh ~/rasp30/prog_assembly/libs/tcl/read_mem2_NoRelease.tcl -start_address 0x7002 -length 220 -output_file_name temp_1.txt");
    //unix_w("sudo tclsh ~/rasp30/prog_assembly/libs/tcl/read_mem2_NoRelease.tcl -start_address 0x6800 -length 220 -output_file_name temp_2.txt");
    disp("fine inj");
    target_l_subVt_dirswc=fscanfMat(hid_dir+'/target_list_subVt_dirswc');
    info_name = "_subVt_dirswc_"; info_win_num1 = 53; info_win_num2 = 54; info_win_num3 = 55; n_graph=n_target_subVt_dirswc; m_graph=n_graph+2;
    clear target_list; target_list = target_l_subVt_dirswc;kapa_constant_or_not=1;
    exec("~/rasp30/prog_assembly/libs/scilab_code/finetune_program_graph.sce",-1);
end

if n_target_lowsubVt_dirswc ~= 0 then
    unix_w("sudo tclsh ~/rasp30/prog_assembly/libs/tcl/write_mem2_NoRelease.tcl -start_address 0x7000 -input_file_name "+hid_dir+"/target_info_lowsubVt_dirswc");
    unix_w("sudo tclsh ~/rasp30/prog_assembly/libs/tcl/write_mem2_NoRelease.tcl -start_address 0x6800 -input_file_name "+hid_dir+"/pulse_width_table_lowsubVt_dirswc");
//    unix_w("sudo tclsh ~/rasp30/prog_assembly/libs/tcl/program.tcl -speed 115200 "+hid_dir+"/recover_inject_lowsubVt_DIRSWC.elf");
//    unix_w("sudo tclsh ~/rasp30/prog_assembly/libs/tcl/read_mem2_NoRelease.tcl -start_address 0x5000 -length 7000 -output_file_name data_lowsubVt_dirswc_2.hex");
//    disp("recover inj");
//    unix_w("sudo tclsh ~/rasp30/prog_assembly/libs/tcl/write_mem2_NoRelease.tcl -start_address 0x7000 -input_file_name "+hid_dir+"/target_info_lowsubVt_dirswc");
//    unix_w("sudo tclsh ~/rasp30/prog_assembly/libs/tcl/program.tcl -speed 115200 "+hid_dir+"/first_coarse_program_lowsubVt_DIRSWC.elf");
//    unix_w("sudo tclsh ~/rasp30/prog_assembly/libs/tcl/read_mem2_NoRelease.tcl -start_address 0x5000 -length 7000 -output_file_name data_lowsubVt_dirswc_3.hex");
//    disp("first coarse inj");
//    unix_w("sudo tclsh ~/rasp30/prog_assembly/libs/tcl/write_mem2_NoRelease.tcl -start_address 0x7000 -input_file_name "+hid_dir+"/target_info_lowsubVt_dirswc");
//    unix_w("sudo tclsh ~/rasp30/prog_assembly/libs/tcl/program.tcl -speed 115200 "+hid_dir+"/measured_coarse_program_lowsubVt_DIRSWC.elf");
//    unix_w("sudo tclsh ~/rasp30/prog_assembly/libs/tcl/read_mem2_NoRelease.tcl -start_address 0x5000 -length 7000 -output_file_name data_lowsubVt_dirswc_4.hex");
//    disp("measured coarse inj");
//    unix_w("sudo tclsh ~/rasp30/prog_assembly/libs/tcl/write_mem2_NoRelease.tcl -start_address 0x7000 -input_file_name "+hid_dir+"/target_info_lowsubVt_dirswc");
    unix_w("sudo tclsh ~/rasp30/prog_assembly/libs/tcl/write_mem2_NoRelease.tcl -start_address 0x6800 -input_file_name "+hid_dir+"/Vd_table_30mV");
    unix_w("sudo tclsh ~/rasp30/prog_assembly/libs/tcl/program.tcl -speed 115200 "+hid_dir+"/fine_program_lowsubVt_m_ave_04_DIRSWC.elf");
    unix_w("sudo tclsh ~/rasp30/prog_assembly/libs/tcl/read_mem2_NoRelease.tcl -start_address 0x5000 -length 7000 -output_file_name data_lowsubVt_dirswc_5.hex");
    //unix_w("sudo tclsh ~/rasp30/prog_assembly/libs/tcl/read_mem2_NoRelease.tcl -start_address 0x7002 -length 220 -output_file_name temp_1.txt");
    //unix_w("sudo tclsh ~/rasp30/prog_assembly/libs/tcl/read_mem2_NoRelease.tcl -start_address 0x6800 -length 220 -output_file_name temp_2.txt");
    disp("fine inj");
    target_l_lowsubVt_dirswc=fscanfMat(hid_dir+'/target_list_lowsubVt_dirswc');
    info_name = "_lowsubVt_dirswc_"; info_win_num1 = 56; info_win_num2 = 57; info_win_num3 = 58; n_graph=n_target_lowsubVt_dirswc; m_graph=n_graph+2;
    clear target_list; target_list = target_l_lowsubVt_dirswc;kapa_constant_or_not = kappa_constant;
    exec("~/rasp30/prog_assembly/libs/scilab_code/finetune_program_graph.sce",-1);
end

unix_g('sudo mv *.hex *.data ' + hid_dir);
