import os, sys

os.system("sudo tclsh /home/ubuntu/rasp30/prog_assembly/libs/tcl/program.tcl -device /dev/ttyUSB1/ -speed 115200 tunnel_revtun_SWC_CAB.elf")
os.system("sudo tclsh /home/ubuntu/rasp30/prog_assembly/libs/tcl/write_mem2_NoRelease.tcl -device /dev/ttyUSB1/ -start_address 0x7000 -input_file_name switch_info")
os.system("sudo tclsh /home/ubuntu/rasp30/prog_assembly/libs/tcl/program.tcl -device /dev/ttyUSB1/ -speed 115200 switch_program.elf")
os.system("sudo tclsh /home/ubuntu/rasp30/prog_assembly/libs/tcl/read_mem2_NoRelease.tcl -device /dev/ttyUSB1/ -start_address 0x5000 -length 7000 -output_file_name swc_pgm_result.hex")
TL = open('target_list', 'r') # open target_list
n_target_tunnel_revtun=TL.readline(); # store values in variables
n_target_highaboveVt_swc=TL.readline();
n_target_highaboveVt_ota=TL.readline();
n_target_aboveVt_swc=TL.readline();
n_target_aboveVt_ota=TL.readline();
n_target_aboveVt_otaref=TL.readline();
n_target_aboveVt_mite=TL.readline();
n_target_aboveVt_dirswc=TL.readline();
n_target_subVt_swc=TL.readline();
n_target_subVt_ota=TL.readline();
n_target_subVt_otaref=TL.readline();
n_target_subVt_mite=TL.readline();
n_target_subVt_dirswc=TL.readline();
n_target_lowsubVt_swc=TL.readline();
n_target_lowsubVt_ota=TL.readline();
n_target_lowsubVt_otaref=TL.readline();
n_target_lowsubVt_mite=TL.readline();
n_target_lowsubVt_dirswc=TL.readline();
if n_target_highaboveVt_swc != "0.000000000000000 \n":
	os.system("sudo tclsh /home/ubuntu/rasp30/prog_assembly/libs/tcl/write_mem2_NoRelease.tcl -device /dev/ttyUSB1/ -device /dev/ttyUSB1/ -start_address 0x7000 -input_file_name target_info_highaboveVt_swc");
	os.system("sudo tclsh /home/ubuntu/rasp30/prog_assembly/libs/tcl/write_mem2_NoRelease.tcl -device /dev/ttyUSB1/ -device /dev/ttyUSB1/ -start_address 0x6800 -input_file_name pulse_width_table_highaboveVt_swc");
	os.system("sudo tclsh /home/ubuntu/rasp30/prog_assembly/libs/tcl/program.tcl -device /dev/ttyUSB1/ -device /dev/ttyUSB1/ -speed 115200 recover_inject_highaboveVt_SWC.elf");
	os.system("sudo tclsh /home/ubuntu/rasp30/prog_assembly/libs/tcl/read_mem2_NoRelease.tcl -device /dev/ttyUSB1/ -device /dev/ttyUSB1/ -start_address 0x5000 -length 7000 -output_file_name data_highaboveVt_swc_2.hex");
	os.system("sudo tclsh /home/ubuntu/rasp30/prog_assembly/libs/tcl/write_mem2_NoRelease.tcl -device /dev/ttyUSB1/ -device /dev/ttyUSB1/ -start_address 0x7000 -input_file_name target_info_highaboveVt_swc");
	os.system("sudo tclsh /home/ubuntu/rasp30/prog_assembly/libs/tcl/program.tcl -device /dev/ttyUSB1/ -device /dev/ttyUSB1/ -speed 115200 first_coarse_program_highaboveVt_SWC.elf");
	os.system("sudo tclsh /home/ubuntu/rasp30/prog_assembly/libs/tcl/read_mem2_NoRelease.tcl -device /dev/ttyUSB1/ -device /dev/ttyUSB1/ -start_address 0x5000 -length 7000 -output_file_name data_highaboveVt_swc_3.hex");
	os.system("sudo tclsh /home/ubuntu/rasp30/prog_assembly/libs/tcl/write_mem2_NoRelease.tcl -device /dev/ttyUSB1/ -device /dev/ttyUSB1/ -start_address 0x7000 -input_file_name target_info_highaboveVt_swc");
	os.system("sudo tclsh /home/ubuntu/rasp30/prog_assembly/libs/tcl/program.tcl -device /dev/ttyUSB1/ -device /dev/ttyUSB1/ -speed 115200 measured_coarse_program_highaboveVt_SWC.elf");
	os.system("sudo tclsh /home/ubuntu/rasp30/prog_assembly/libs/tcl/read_mem2_NoRelease.tcl -device /dev/ttyUSB1/ -device /dev/ttyUSB1/ -start_address 0x5000 -length 7000 -output_file_name data_highaboveVt_swc_4.hex");
	os.system("sudo tclsh /home/ubuntu/rasp30/prog_assembly/libs/tcl/write_mem2_NoRelease.tcl -device /dev/ttyUSB1/ -device /dev/ttyUSB1/ -start_address 0x7000 -input_file_name target_info_highaboveVt_swc");
	os.system("sudo tclsh /home/ubuntu/rasp30/prog_assembly/libs/tcl/write_mem2_NoRelease.tcl -device /dev/ttyUSB1/ -device /dev/ttyUSB1/ -start_address 0x6800 -input_file_name Vd_table_30mV");
	os.system("sudo tclsh /home/ubuntu/rasp30/prog_assembly/libs/tcl/program.tcl -device /dev/ttyUSB1/ -device /dev/ttyUSB1/ -speed 115200 fine_program_highaboveVt_m_ave_04_SWC.elf");
	os.system("sudo tclsh /home/ubuntu/rasp30/prog_assembly/libs/tcl/read_mem2_NoRelease.tcl -device /dev/ttyUSB1/ -device /dev/ttyUSB1/ -start_address 0x5000 -length 7000 -output_file_name data_highaboveVt_swc_5.hex");
if n_target_aboveVt_swc != "0.000000000000000 \n":
	os.system("sudo tclsh /home/ubuntu/rasp30/prog_assembly/libs/tcl/write_mem2_NoRelease.tcl -device /dev/ttyUSB1/ -device /dev/ttyUSB1/ -start_address 0x7000 -input_file_name target_info_aboveVt_swc");
	os.system("sudo tclsh /home/ubuntu/rasp30/prog_assembly/libs/tcl/write_mem2_NoRelease.tcl -device /dev/ttyUSB1/ -device /dev/ttyUSB1/ -start_address 0x6800 -input_file_name pulse_width_table_swc");
	os.system("sudo tclsh /home/ubuntu/rasp30/prog_assembly/libs/tcl/program.tcl -device /dev/ttyUSB1/ -device /dev/ttyUSB1/ -speed 115200 recover_inject_aboveVt_SWC.elf");
	os.system("sudo tclsh /home/ubuntu/rasp30/prog_assembly/libs/tcl/read_mem2_NoRelease.tcl -device /dev/ttyUSB1/ -device /dev/ttyUSB1/ -start_address 0x5000 -length 7000 -output_file_name data_aboveVt_swc_2.hex");
	os.system("sudo tclsh /home/ubuntu/rasp30/prog_assembly/libs/tcl/write_mem2_NoRelease.tcl -device /dev/ttyUSB1/ -device /dev/ttyUSB1/ -start_address 0x7000 -input_file_name target_info_aboveVt_swc");
	os.system("sudo tclsh /home/ubuntu/rasp30/prog_assembly/libs/tcl/program.tcl -device /dev/ttyUSB1/ -device /dev/ttyUSB1/ -speed 115200 first_coarse_program_aboveVt_SWC.elf");
	os.system("sudo tclsh /home/ubuntu/rasp30/prog_assembly/libs/tcl/read_mem2_NoRelease.tcl -device /dev/ttyUSB1/ -device /dev/ttyUSB1/ -start_address 0x5000 -length 7000 -output_file_name data_aboveVt_swc_3.hex");
	os.system("sudo tclsh /home/ubuntu/rasp30/prog_assembly/libs/tcl/write_mem2_NoRelease.tcl -device /dev/ttyUSB1/ -device /dev/ttyUSB1/ -start_address 0x7000 -input_file_name target_info_aboveVt_swc");
	os.system("sudo tclsh /home/ubuntu/rasp30/prog_assembly/libs/tcl/program.tcl -device /dev/ttyUSB1/ -device /dev/ttyUSB1/ -speed 115200 measured_coarse_program_aboveVt_SWC.elf");
	os.system("sudo tclsh /home/ubuntu/rasp30/prog_assembly/libs/tcl/read_mem2_NoRelease.tcl -device /dev/ttyUSB1/ -device /dev/ttyUSB1/ -start_address 0x5000 -length 7000 -output_file_name data_aboveVt_swc_4.hex");
	os.system("sudo tclsh /home/ubuntu/rasp30/prog_assembly/libs/tcl/write_mem2_NoRelease.tcl -device /dev/ttyUSB1/ -device /dev/ttyUSB1/ -start_address 0x7000 -input_file_name target_info_aboveVt_swc");
	os.system("sudo tclsh /home/ubuntu/rasp30/prog_assembly/libs/tcl/write_mem2_NoRelease.tcl -device /dev/ttyUSB1/ -device /dev/ttyUSB1/ -start_address 0x6800 -input_file_name Vd_table_30mV");
	os.system("sudo tclsh /home/ubuntu/rasp30/prog_assembly/libs/tcl/program.tcl -device /dev/ttyUSB1/ -device /dev/ttyUSB1/ -speed 115200 fine_program_aboveVt_m_ave_04_SWC.elf");
	os.system("sudo tclsh /home/ubuntu/rasp30/prog_assembly/libs/tcl/read_mem2_NoRelease.tcl -device /dev/ttyUSB1/ -device /dev/ttyUSB1/ -start_address 0x5000 -length 7000 -output_file_name data_aboveVt_swc_5.hex");
if n_target_subVt_swc != "0.000000000000000 \n":
	os.system("sudo tclsh /home/ubuntu/rasp30/prog_assembly/libs/tcl/write_mem2_NoRelease.tcl -device /dev/ttyUSB1/ -start_address 0x7000 -input_file_name target_info_subVt_swc");
	os.system("sudo tclsh /home/ubuntu/rasp30/prog_assembly/libs/tcl/write_mem2_NoRelease.tcl -device /dev/ttyUSB1/ -start_address 0x6800 -input_file_name pulse_width_table_swc");
	os.system("sudo tclsh /home/ubuntu/rasp30/prog_assembly/libs/tcl/program.tcl -device /dev/ttyUSB1/ -speed 115200 recover_inject_subVt_SWC.elf");
	os.system("sudo tclsh /home/ubuntu/rasp30/prog_assembly/libs/tcl/read_mem2_NoRelease.tcl -device /dev/ttyUSB1/ -start_address 0x5000 -length 7000 -output_file_name data_subVt_swc_2.hex");
	os.system("sudo tclsh /home/ubuntu/rasp30/prog_assembly/libs/tcl/write_mem2_NoRelease.tcl -device /dev/ttyUSB1/ -start_address 0x7000 -input_file_name target_info_subVt_swc");
	os.system("sudo tclsh /home/ubuntu/rasp30/prog_assembly/libs/tcl/program.tcl -device /dev/ttyUSB1/ -speed 115200 first_coarse_program_subVt_SWC.elf");
	os.system("sudo tclsh /home/ubuntu/rasp30/prog_assembly/libs/tcl/read_mem2_NoRelease.tcl -device /dev/ttyUSB1/ -start_address 0x5000 -length 7000 -output_file_name data_subVt_swc_3.hex");
	os.system("sudo tclsh /home/ubuntu/rasp30/prog_assembly/libs/tcl/write_mem2_NoRelease.tcl -device /dev/ttyUSB1/ -start_address 0x7000 -input_file_name target_info_subVt_swc");
	os.system("sudo tclsh /home/ubuntu/rasp30/prog_assembly/libs/tcl/program.tcl -device /dev/ttyUSB1/ -speed 115200 measured_coarse_program_subVt_SWC.elf");
	os.system("sudo tclsh /home/ubuntu/rasp30/prog_assembly/libs/tcl/read_mem2_NoRelease.tcl -device /dev/ttyUSB1/ -start_address 0x5000 -length 7000 -output_file_name data_subVt_swc_4.hex");
	os.system("sudo tclsh /home/ubuntu/rasp30/prog_assembly/libs/tcl/write_mem2_NoRelease.tcl -device /dev/ttyUSB1/ -start_address 0x7000 -input_file_name target_info_subVt_swc");
	os.system("sudo tclsh /home/ubuntu/rasp30/prog_assembly/libs/tcl/write_mem2_NoRelease.tcl -device /dev/ttyUSB1/ -start_address 0x6800 -input_file_name Vd_table_30mV");
	os.system("sudo tclsh /home/ubuntu/rasp30/prog_assembly/libs/tcl/program.tcl -device /dev/ttyUSB1/ -speed 115200 fine_program_subVt_m_ave_04_SWC.elf");
	os.system("sudo tclsh /home/ubuntu/rasp30/prog_assembly/libs/tcl/read_mem2_NoRelease.tcl -device /dev/ttyUSB1/ -start_address 0x5000 -length 7000 -output_file_name data_subVt_swc_5.hex");
if n_target_lowsubVt_swc != "0.000000000000000 \n":
	os.system("sudo tclsh /home/ubuntu/rasp30/prog_assembly/libs/tcl/write_mem2_NoRelease.tcl -device /dev/ttyUSB1/ -start_address 0x7000 -input_file_name target_info_lowsubVt_swc");
	os.system("sudo tclsh /home/ubuntu/rasp30/prog_assembly/libs/tcl/write_mem2_NoRelease.tcl -device /dev/ttyUSB1/ -start_address 0x6800 -input_file_name pulse_width_table_lowsubVt_swc");
	os.system("sudo tclsh /home/ubuntu/rasp30/prog_assembly/libs/tcl/program.tcl -device /dev/ttyUSB1/ -speed 115200 recover_inject_lowsubVt_SWC.elf");
	os.system("sudo tclsh /home/ubuntu/rasp30/prog_assembly/libs/tcl/read_mem2_NoRelease.tcl -device /dev/ttyUSB1/ -start_address 0x5000 -length 7000 -output_file_name data_lowsubVt_swc_2.hex");
	os.system("sudo tclsh /home/ubuntu/rasp30/prog_assembly/libs/tcl/write_mem2_NoRelease.tcl -device /dev/ttyUSB1/ -start_address 0x7000 -input_file_name target_info_lowsubVt_swc");
	os.system("sudo tclsh /home/ubuntu/rasp30/prog_assembly/libs/tcl/program.tcl -device /dev/ttyUSB1/ -speed 115200 first_coarse_program_lowsubVt_SWC.elf");
	os.system("sudo tclsh /home/ubuntu/rasp30/prog_assembly/libs/tcl/read_mem2_NoRelease.tcl -device /dev/ttyUSB1/ -start_address 0x5000 -length 7000 -output_file_name data_lowsubVt_swc_3.hex");
	os.system("sudo tclsh /home/ubuntu/rasp30/prog_assembly/libs/tcl/write_mem2_NoRelease.tcl -device /dev/ttyUSB1/ -start_address 0x7000 -input_file_name target_info_lowsubVt_swc");
	os.system("sudo tclsh /home/ubuntu/rasp30/prog_assembly/libs/tcl/program.tcl -device /dev/ttyUSB1/ -speed 115200 measured_coarse_program_lowsubVt_SWC.elf");
	os.system("sudo tclsh /home/ubuntu/rasp30/prog_assembly/libs/tcl/read_mem2_NoRelease.tcl -device /dev/ttyUSB1/ -start_address 0x5000 -length 7000 -output_file_name data_lowsubVt_swc_4.hex");
	os.system("sudo tclsh /home/ubuntu/rasp30/prog_assembly/libs/tcl/write_mem2_NoRelease.tcl -device /dev/ttyUSB1/ -start_address 0x7000 -input_file_name target_info_lowsubVt_swc");
	os.system("sudo tclsh /home/ubuntu/rasp30/prog_assembly/libs/tcl/write_mem2_NoRelease.tcl -device /dev/ttyUSB1/ -start_address 0x6800 -input_file_name Vd_table_30mV");
	os.system("sudo tclsh /home/ubuntu/rasp30/prog_assembly/libs/tcl/program.tcl -device /dev/ttyUSB1/ -speed 115200 fine_program_lowsubVt_m_ave_04_SWC.elf");
	os.system("sudo tclsh /home/ubuntu/rasp30/prog_assembly/libs/tcl/read_mem2_NoRelease.tcl -device /dev/ttyUSB1/ -start_address 0x5000 -length 7000 -output_file_name data_lowsubVt_swc_5.hex");
if n_target_highaboveVt_ota != "0.000000000000000 \n":
	os.system("sudo tclsh /home/ubuntu/rasp30/prog_assembly/libs/tcl/write_mem2_NoRelease.tcl -device /dev/ttyUSB1/ -start_address 0x7000 -input_file_name target_info_highaboveVt_ota");
	os.system("sudo tclsh /home/ubuntu/rasp30/prog_assembly/libs/tcl/write_mem2_NoRelease.tcl -device /dev/ttyUSB1/ -start_address 0x6800 -input_file_name pulse_width_table_highaboveVt_ota");
	os.system("sudo tclsh /home/ubuntu/rasp30/prog_assembly/libs/tcl/program.tcl -device /dev/ttyUSB1/ -speed 115200 recover_inject_highaboveVt_CAB_ota.elf");
	os.system("sudo tclsh /home/ubuntu/rasp30/prog_assembly/libs/tcl/read_mem2_NoRelease.tcl -device /dev/ttyUSB1/ -start_address 0x5000 -length 7000 -output_file_name data_highaboveVt_ota_2.hex");
	os.system("sudo tclsh /home/ubuntu/rasp30/prog_assembly/libs/tcl/write_mem2_NoRelease.tcl -device /dev/ttyUSB1/ -start_address 0x7000 -input_file_name target_info_highaboveVt_ota");
	os.system("sudo tclsh /home/ubuntu/rasp30/prog_assembly/libs/tcl/program.tcl -device /dev/ttyUSB1/ -speed 115200 first_coarse_program_highaboveVt_CAB_ota.elf");
	os.system("sudo tclsh /home/ubuntu/rasp30/prog_assembly/libs/tcl/read_mem2_NoRelease.tcl -device /dev/ttyUSB1/ -start_address 0x5000 -length 7000 -output_file_name data_highaboveVt_ota_3.hex");
	os.system("sudo tclsh /home/ubuntu/rasp30/prog_assembly/libs/tcl/write_mem2_NoRelease.tcl -device /dev/ttyUSB1/ -start_address 0x7000 -input_file_name target_info_highaboveVt_ota");
	os.system("sudo tclsh /home/ubuntu/rasp30/prog_assembly/libs/tcl/program.tcl -device /dev/ttyUSB1/ -speed 115200 measured_coarse_program_highaboveVt_CAB_ota.elf");
	os.system("sudo tclsh /home/ubuntu/rasp30/prog_assembly/libs/tcl/read_mem2_NoRelease.tcl -device /dev/ttyUSB1/ -start_address 0x5000 -length 7000 -output_file_name data_highaboveVt_ota_4.hex");
	os.system("sudo tclsh /home/ubuntu/rasp30/prog_assembly/libs/tcl/write_mem2_NoRelease.tcl -device /dev/ttyUSB1/ -start_address 0x7000 -input_file_name target_info_highaboveVt_ota");
	os.system("sudo tclsh /home/ubuntu/rasp30/prog_assembly/libs/tcl/write_mem2_NoRelease.tcl -device /dev/ttyUSB1/ -start_address 0x6800 -input_file_name Vd_table_30mV");
	os.system("sudo tclsh /home/ubuntu/rasp30/prog_assembly/libs/tcl/program.tcl -device /dev/ttyUSB1/ -speed 115200 fine_program_highaboveVt_m_ave_04_CAB_ota.elf");
	os.system("sudo tclsh /home/ubuntu/rasp30/prog_assembly/libs/tcl/read_mem2_NoRelease.tcl -device /dev/ttyUSB1/ -start_address 0x5000 -length 7000 -output_file_name data_highaboveVt_ota_5.hex");
if n_target_aboveVt_ota != "0.000000000000000 \n":
	os.system("sudo tclsh /home/ubuntu/rasp30/prog_assembly/libs/tcl/write_mem2_NoRelease.tcl -device /dev/ttyUSB1/ -start_address 0x7000 -input_file_name target_info_aboveVt_ota");
	os.system("sudo tclsh /home/ubuntu/rasp30/prog_assembly/libs/tcl/write_mem2_NoRelease.tcl -device /dev/ttyUSB1/ -start_address 0x6800 -input_file_name pulse_width_table_ota");
	os.system("sudo tclsh /home/ubuntu/rasp30/prog_assembly/libs/tcl/program.tcl -device /dev/ttyUSB1/ -speed 115200 recover_inject_aboveVt_CAB_ota.elf");
	os.system("sudo tclsh /home/ubuntu/rasp30/prog_assembly/libs/tcl/read_mem2_NoRelease.tcl -device /dev/ttyUSB1/ -start_address 0x5000 -length 7000 -output_file_name data_aboveVt_ota_2.hex");
	os.system("sudo tclsh /home/ubuntu/rasp30/prog_assembly/libs/tcl/write_mem2_NoRelease.tcl -device /dev/ttyUSB1/ -start_address 0x7000 -input_file_name target_info_aboveVt_ota");
	os.system("sudo tclsh /home/ubuntu/rasp30/prog_assembly/libs/tcl/program.tcl -device /dev/ttyUSB1/ -speed 115200 first_coarse_program_aboveVt_CAB_ota.elf");
	os.system("sudo tclsh /home/ubuntu/rasp30/prog_assembly/libs/tcl/read_mem2_NoRelease.tcl -device /dev/ttyUSB1/ -start_address 0x5000 -length 7000 -output_file_name data_aboveVt_ota_3.hex");
	os.system("sudo tclsh /home/ubuntu/rasp30/prog_assembly/libs/tcl/write_mem2_NoRelease.tcl -device /dev/ttyUSB1/ -start_address 0x7000 -input_file_name target_info_aboveVt_ota");
	os.system("sudo tclsh /home/ubuntu/rasp30/prog_assembly/libs/tcl/program.tcl -device /dev/ttyUSB1/ -speed 115200 measured_coarse_program_aboveVt_CAB_ota.elf");
	os.system("sudo tclsh /home/ubuntu/rasp30/prog_assembly/libs/tcl/read_mem2_NoRelease.tcl -device /dev/ttyUSB1/ -start_address 0x5000 -length 7000 -output_file_name data_aboveVt_ota_4.hex");
	os.system("sudo tclsh /home/ubuntu/rasp30/prog_assembly/libs/tcl/write_mem2_NoRelease.tcl -device /dev/ttyUSB1/ -start_address 0x7000 -input_file_name target_info_aboveVt_ota");
	os.system("sudo tclsh /home/ubuntu/rasp30/prog_assembly/libs/tcl/write_mem2_NoRelease.tcl -device /dev/ttyUSB1/ -start_address 0x6800 -input_file_name Vd_table_30mV");
	os.system("sudo tclsh /home/ubuntu/rasp30/prog_assembly/libs/tcl/program.tcl -device /dev/ttyUSB1/ -speed 115200 fine_program_aboveVt_m_ave_04_CAB_ota.elf");
	os.system("sudo tclsh /home/ubuntu/rasp30/prog_assembly/libs/tcl/read_mem2_NoRelease.tcl -device /dev/ttyUSB1/ -start_address 0x5000 -length 7000 -output_file_name data_aboveVt_ota_5.hex");
if n_target_subVt_ota != "0.000000000000000 \n":
	os.system("sudo tclsh /home/ubuntu/rasp30/prog_assembly/libs/tcl/write_mem2_NoRelease.tcl -device /dev/ttyUSB1/ -start_address 0x7000 -input_file_name target_info_subVt_ota");
	os.system("sudo tclsh /home/ubuntu/rasp30/prog_assembly/libs/tcl/write_mem2_NoRelease.tcl -device /dev/ttyUSB1/ -start_address 0x6800 -input_file_name pulse_width_table_ota");
	os.system("sudo tclsh /home/ubuntu/rasp30/prog_assembly/libs/tcl/program.tcl -device /dev/ttyUSB1/ -speed 115200 recover_inject_subVt_CAB_ota.elf");
	os.system("sudo tclsh /home/ubuntu/rasp30/prog_assembly/libs/tcl/read_mem2_NoRelease.tcl -device /dev/ttyUSB1/ -start_address 0x5000 -length 7000 -output_file_name data_subVt_ota_2.hex");
	os.system("sudo tclsh /home/ubuntu/rasp30/prog_assembly/libs/tcl/write_mem2_NoRelease.tcl -device /dev/ttyUSB1/ -start_address 0x7000 -input_file_name target_info_subVt_ota");
	os.system("sudo tclsh /home/ubuntu/rasp30/prog_assembly/libs/tcl/program.tcl -device /dev/ttyUSB1/ -speed 115200 first_coarse_program_subVt_CAB_ota.elf");
	os.system("sudo tclsh /home/ubuntu/rasp30/prog_assembly/libs/tcl/read_mem2_NoRelease.tcl -device /dev/ttyUSB1/ -start_address 0x5000 -length 7000 -output_file_name data_subVt_ota_3.hex");
	os.system("sudo tclsh /home/ubuntu/rasp30/prog_assembly/libs/tcl/write_mem2_NoRelease.tcl -device /dev/ttyUSB1/ -start_address 0x7000 -input_file_name target_info_subVt_ota");
	os.system("sudo tclsh /home/ubuntu/rasp30/prog_assembly/libs/tcl/program.tcl -device /dev/ttyUSB1/ -speed 115200 measured_coarse_program_subVt_CAB_ota.elf");
	os.system("sudo tclsh /home/ubuntu/rasp30/prog_assembly/libs/tcl/read_mem2_NoRelease.tcl -device /dev/ttyUSB1/ -start_address 0x5000 -length 7000 -output_file_name data_subVt_ota_4.hex");
	os.system("sudo tclsh /home/ubuntu/rasp30/prog_assembly/libs/tcl/write_mem2_NoRelease.tcl -device /dev/ttyUSB1/ -start_address 0x7000 -input_file_name target_info_subVt_ota");
	os.system("sudo tclsh /home/ubuntu/rasp30/prog_assembly/libs/tcl/write_mem2_NoRelease.tcl -device /dev/ttyUSB1/ -start_address 0x6800 -input_file_name Vd_table_30mV");
	os.system("sudo tclsh /home/ubuntu/rasp30/prog_assembly/libs/tcl/program.tcl -device /dev/ttyUSB1/ -speed 115200 fine_program_subVt_m_ave_04_CAB_ota.elf");
	os.system("sudo tclsh /home/ubuntu/rasp30/prog_assembly/libs/tcl/read_mem2_NoRelease.tcl -device /dev/ttyUSB1/ -start_address 0x5000 -length 7000 -output_file_name data_subVt_ota_5.hex");
if n_target_lowsubVt_ota != "0.000000000000000 \n":
	os.system("sudo tclsh /home/ubuntu/rasp30/prog_assembly/libs/tcl/write_mem2_NoRelease.tcl -device /dev/ttyUSB1/ -start_address 0x7000 -input_file_name target_info_lowsubVt_ota");
	os.system("sudo tclsh /home/ubuntu/rasp30/prog_assembly/libs/tcl/write_mem2_NoRelease.tcl -device /dev/ttyUSB1/ -start_address 0x6800 -input_file_name pulse_width_table_lowsubVt_ota");
	os.system("sudo tclsh /home/ubuntu/rasp30/prog_assembly/libs/tcl/program.tcl -device /dev/ttyUSB1/ -speed 115200 recover_inject_lowsubVt_CAB_ota.elf");
	os.system("sudo tclsh /home/ubuntu/rasp30/prog_assembly/libs/tcl/read_mem2_NoRelease.tcl -device /dev/ttyUSB1/ -start_address 0x5000 -length 7000 -output_file_name data_lowsubVt_ota_2.hex");
	os.system("sudo tclsh /home/ubuntu/rasp30/prog_assembly/libs/tcl/write_mem2_NoRelease.tcl -device /dev/ttyUSB1/ -start_address 0x7000 -input_file_name target_info_lowsubVt_ota");
	os.system("sudo tclsh /home/ubuntu/rasp30/prog_assembly/libs/tcl/program.tcl -device /dev/ttyUSB1/ -speed 115200 first_coarse_program_lowsubVt_CAB_ota.elf");
	os.system("sudo tclsh /home/ubuntu/rasp30/prog_assembly/libs/tcl/read_mem2_NoRelease.tcl -device /dev/ttyUSB1/ -start_address 0x5000 -length 7000 -output_file_name data_lowsubVt_ota_3.hex");
	os.system("sudo tclsh /home/ubuntu/rasp30/prog_assembly/libs/tcl/write_mem2_NoRelease.tcl -device /dev/ttyUSB1/ -start_address 0x7000 -input_file_name target_info_lowsubVt_ota");
	os.system("sudo tclsh /home/ubuntu/rasp30/prog_assembly/libs/tcl/program.tcl -device /dev/ttyUSB1/ -speed 115200 measured_coarse_program_lowsubVt_CAB_ota.elf");
	os.system("sudo tclsh /home/ubuntu/rasp30/prog_assembly/libs/tcl/read_mem2_NoRelease.tcl -device /dev/ttyUSB1/ -start_address 0x5000 -length 7000 -output_file_name data_lowsubVt_ota_4.hex");
	os.system("sudo tclsh /home/ubuntu/rasp30/prog_assembly/libs/tcl/write_mem2_NoRelease.tcl -device /dev/ttyUSB1/ -start_address 0x7000 -input_file_name target_info_lowsubVt_ota");
	os.system("sudo tclsh /home/ubuntu/rasp30/prog_assembly/libs/tcl/write_mem2_NoRelease.tcl -device /dev/ttyUSB1/ -start_address 0x6800 -input_file_name Vd_table_30mV");
	os.system("sudo tclsh /home/ubuntu/rasp30/prog_assembly/libs/tcl/program.tcl -device /dev/ttyUSB1/ -speed 115200 fine_program_lowsubVt_m_ave_04_CAB_ota.elf");
	os.system("sudo tclsh /home/ubuntu/rasp30/prog_assembly/libs/tcl/read_mem2_NoRelease.tcl -device /dev/ttyUSB1/ -start_address 0x5000 -length 7000 -output_file_name data_lowsubVt_ota_5.hex");
if n_target_aboveVt_otaref != "0.000000000000000 \n":
	os.system("sudo tclsh /home/ubuntu/rasp30/prog_assembly/libs/tcl/write_mem2_NoRelease.tcl -device /dev/ttyUSB1/ -start_address 0x7000 -input_file_name target_info_aboveVt_otaref");
	os.system("sudo tclsh /home/ubuntu/rasp30/prog_assembly/libs/tcl/write_mem2_NoRelease.tcl -device /dev/ttyUSB1/ -start_address 0x6800 -input_file_name pulse_width_table_otaref");
	os.system("sudo tclsh /home/ubuntu/rasp30/prog_assembly/libs/tcl/program.tcl -device /dev/ttyUSB1/ -speed 115200 recover_inject_aboveVt_CAB_ota_ref.elf");
	os.system("sudo tclsh /home/ubuntu/rasp30/prog_assembly/libs/tcl/read_mem2_NoRelease.tcl -device /dev/ttyUSB1/ -start_address 0x5000 -length 7000 -output_file_name data_aboveVt_otaref_2.hex");
	os.system("sudo tclsh /home/ubuntu/rasp30/prog_assembly/libs/tcl/write_mem2_NoRelease.tcl -device /dev/ttyUSB1/ -start_address 0x7000 -input_file_name target_info_aboveVt_otaref");
	os.system("sudo tclsh /home/ubuntu/rasp30/prog_assembly/libs/tcl/program.tcl -device /dev/ttyUSB1/ -speed 115200 first_coarse_program_aboveVt_CAB_ota_ref.elf");
	os.system("sudo tclsh /home/ubuntu/rasp30/prog_assembly/libs/tcl/read_mem2_NoRelease.tcl -device /dev/ttyUSB1/ -start_address 0x5000 -length 7000 -output_file_name data_aboveVt_otaref_3.hex");
	os.system("sudo tclsh /home/ubuntu/rasp30/prog_assembly/libs/tcl/write_mem2_NoRelease.tcl -device /dev/ttyUSB1/ -start_address 0x7000 -input_file_name target_info_aboveVt_otaref");
	os.system("sudo tclsh /home/ubuntu/rasp30/prog_assembly/libs/tcl/program.tcl -device /dev/ttyUSB1/ -speed 115200 measured_coarse_program_aboveVt_CAB_ota_ref.elf");
	os.system("sudo tclsh /home/ubuntu/rasp30/prog_assembly/libs/tcl/read_mem2_NoRelease.tcl -device /dev/ttyUSB1/ -start_address 0x5000 -length 7000 -output_file_name data_aboveVt_otaref_4.hex");
	os.system("sudo tclsh /home/ubuntu/rasp30/prog_assembly/libs/tcl/write_mem2_NoRelease.tcl -device /dev/ttyUSB1/ -start_address 0x7000 -input_file_name target_info_aboveVt_otaref");
	os.system("sudo tclsh /home/ubuntu/rasp30/prog_assembly/libs/tcl/write_mem2_NoRelease.tcl -device /dev/ttyUSB1/ -start_address 0x6800 -input_file_name Vd_table_30mV");
	os.system("sudo tclsh /home/ubuntu/rasp30/prog_assembly/libs/tcl/program.tcl -device /dev/ttyUSB1/ -speed 115200 fine_program_aboveVt_m_ave_04_CAB_ota_ref.elf");
	os.system("sudo tclsh /home/ubuntu/rasp30/prog_assembly/libs/tcl/read_mem2_NoRelease.tcl -device /dev/ttyUSB1/ -start_address 0x5000 -length 7000 -output_file_name data_aboveVt_otaref_5.hex");
if n_target_subVt_otaref != "0.000000000000000 \n":
	os.system("sudo tclsh /home/ubuntu/rasp30/prog_assembly/libs/tcl/write_mem2_NoRelease.tcl -device /dev/ttyUSB1/ -start_address 0x7000 -input_file_name target_info_subVt_otaref");
	os.system("sudo tclsh /home/ubuntu/rasp30/prog_assembly/libs/tcl/write_mem2_NoRelease.tcl -device /dev/ttyUSB1/ -start_address 0x6800 -input_file_name pulse_width_table_otaref");
	os.system("sudo tclsh /home/ubuntu/rasp30/prog_assembly/libs/tcl/program.tcl -device /dev/ttyUSB1/ -speed 115200 recover_inject_subVt_CAB_ota_ref.elf");
	os.system("sudo tclsh /home/ubuntu/rasp30/prog_assembly/libs/tcl/read_mem2_NoRelease.tcl -device /dev/ttyUSB1/ -start_address 0x5000 -length 7000 -output_file_name data_subVt_otaref_2.hex");
	os.system("sudo tclsh /home/ubuntu/rasp30/prog_assembly/libs/tcl/write_mem2_NoRelease.tcl -device /dev/ttyUSB1/ -start_address 0x7000 -input_file_name target_info_subVt_otaref");
	os.system("sudo tclsh /home/ubuntu/rasp30/prog_assembly/libs/tcl/program.tcl -device /dev/ttyUSB1/ -speed 115200 first_coarse_program_subVt_CAB_ota_ref.elf");
	os.system("sudo tclsh /home/ubuntu/rasp30/prog_assembly/libs/tcl/read_mem2_NoRelease.tcl -device /dev/ttyUSB1/ -start_address 0x5000 -length 7000 -output_file_name data_subVt_otaref_3.hex");
	os.system("sudo tclsh /home/ubuntu/rasp30/prog_assembly/libs/tcl/write_mem2_NoRelease.tcl -device /dev/ttyUSB1/ -start_address 0x7000 -input_file_name target_info_subVt_otaref");
	os.system("sudo tclsh /home/ubuntu/rasp30/prog_assembly/libs/tcl/program.tcl -device /dev/ttyUSB1/ -speed 115200 measured_coarse_program_subVt_CAB_ota_ref.elf");
	os.system("sudo tclsh /home/ubuntu/rasp30/prog_assembly/libs/tcl/read_mem2_NoRelease.tcl -device /dev/ttyUSB1/ -start_address 0x5000 -length 7000 -output_file_name data_subVt_otaref_4.hex");
	os.system("sudo tclsh /home/ubuntu/rasp30/prog_assembly/libs/tcl/write_mem2_NoRelease.tcl -device /dev/ttyUSB1/ -start_address 0x7000 -input_file_name target_info_subVt_otaref");
	os.system("sudo tclsh /home/ubuntu/rasp30/prog_assembly/libs/tcl/write_mem2_NoRelease.tcl -device /dev/ttyUSB1/ -start_address 0x6800 -input_file_name Vd_table_30mV");
	os.system("sudo tclsh /home/ubuntu/rasp30/prog_assembly/libs/tcl/program.tcl -device /dev/ttyUSB1/ -speed 115200 fine_program_subVt_m_ave_04_CAB_ota_ref.elf");
	os.system("sudo tclsh /home/ubuntu/rasp30/prog_assembly/libs/tcl/read_mem2_NoRelease.tcl -device /dev/ttyUSB1/ -start_address 0x5000 -length 7000 -output_file_name data_subVt_otaref_5.hex");
if n_target_lowsubVt_otaref != "0.000000000000000 \n":
	os.system("sudo tclsh /home/ubuntu/rasp30/prog_assembly/libs/tcl/write_mem2_NoRelease.tcl -device /dev/ttyUSB1/ -start_address 0x7000 -input_file_name target_info_lowsubVt_otaref");
	os.system("sudo tclsh /home/ubuntu/rasp30/prog_assembly/libs/tcl/write_mem2_NoRelease.tcl -device /dev/ttyUSB1/ -start_address 0x6800 -input_file_name pulse_width_table_lowsubVt_otaref");
	os.system("sudo tclsh /home/ubuntu/rasp30/prog_assembly/libs/tcl/program.tcl -device /dev/ttyUSB1/ -speed 115200 recover_inject_lowsubVt_CAB_ota_ref.elf");
	os.system("sudo tclsh /home/ubuntu/rasp30/prog_assembly/libs/tcl/read_mem2_NoRelease.tcl -device /dev/ttyUSB1/ -start_address 0x5000 -length 7000 -output_file_name data_lowsubVt_otaref_2.hex");
	os.system("sudo tclsh /home/ubuntu/rasp30/prog_assembly/libs/tcl/write_mem2_NoRelease.tcl -device /dev/ttyUSB1/ -start_address 0x7000 -input_file_name target_info_lowsubVt_otaref");
	os.system("sudo tclsh /home/ubuntu/rasp30/prog_assembly/libs/tcl/program.tcl -device /dev/ttyUSB1/ -speed 115200 first_coarse_program_lowsubVt_CAB_ota_ref.elf");
	os.system("sudo tclsh /home/ubuntu/rasp30/prog_assembly/libs/tcl/read_mem2_NoRelease.tcl -device /dev/ttyUSB1/ -start_address 0x5000 -length 7000 -output_file_name data_lowsubVt_otaref_3.hex");
	os.system("sudo tclsh /home/ubuntu/rasp30/prog_assembly/libs/tcl/write_mem2_NoRelease.tcl -device /dev/ttyUSB1/ -start_address 0x7000 -input_file_name target_info_lowsubVt_otaref");
	os.system("sudo tclsh /home/ubuntu/rasp30/prog_assembly/libs/tcl/program.tcl -device /dev/ttyUSB1/ -speed 115200 measured_coarse_program_lowsubVt_CAB_ota_ref.elf");
	os.system("sudo tclsh /home/ubuntu/rasp30/prog_assembly/libs/tcl/read_mem2_NoRelease.tcl -device /dev/ttyUSB1/ -start_address 0x5000 -length 7000 -output_file_name data_lowsubVt_otaref_4.hex");
	os.system("sudo tclsh /home/ubuntu/rasp30/prog_assembly/libs/tcl/write_mem2_NoRelease.tcl -device /dev/ttyUSB1/ -start_address 0x7000 -input_file_name target_info_lowsubVt_otaref");
	os.system("sudo tclsh /home/ubuntu/rasp30/prog_assembly/libs/tcl/write_mem2_NoRelease.tcl -device /dev/ttyUSB1/ -start_address 0x6800 -input_file_name Vd_table_30mV");
	os.system("sudo tclsh /home/ubuntu/rasp30/prog_assembly/libs/tcl/program.tcl -device /dev/ttyUSB1/ -speed 115200 fine_program_lowsubVt_m_ave_04_CAB_ota_ref.elf");
	os.system("sudo tclsh /home/ubuntu/rasp30/prog_assembly/libs/tcl/read_mem2_NoRelease.tcl -device /dev/ttyUSB1/ -start_address 0x5000 -length 7000 -output_file_name data_lowsubVt_otaref_5.hex");
if n_target_aboveVt_mite != "0.000000000000000 \n":
	os.system("sudo tclsh /home/ubuntu/rasp30/prog_assembly/libs/tcl/write_mem2_NoRelease.tcl -device /dev/ttyUSB1/ -start_address 0x7000 -input_file_name target_info_aboveVt_mite");
	os.system("sudo tclsh /home/ubuntu/rasp30/prog_assembly/libs/tcl/write_mem2_NoRelease.tcl -device /dev/ttyUSB1/ -start_address 0x6800 -input_file_name pulse_width_table_mite");
	os.system("sudo tclsh /home/ubuntu/rasp30/prog_assembly/libs/tcl/program.tcl -device /dev/ttyUSB1/ -speed 115200 recover_inject_aboveVt_CAB_mite.elf");
	os.system("sudo tclsh /home/ubuntu/rasp30/prog_assembly/libs/tcl/read_mem2_NoRelease.tcl -device /dev/ttyUSB1/ -start_address 0x5000 -length 7000 -output_file_name data_aboveVt_mite_2.hex");
	os.system("sudo tclsh /home/ubuntu/rasp30/prog_assembly/libs/tcl/write_mem2_NoRelease.tcl -device /dev/ttyUSB1/ -start_address 0x7000 -input_file_name target_info_aboveVt_mite");
	os.system("sudo tclsh /home/ubuntu/rasp30/prog_assembly/libs/tcl/program.tcl -device /dev/ttyUSB1/ -speed 115200 first_coarse_program_aboveVt_CAB_mite.elf");
	os.system("sudo tclsh /home/ubuntu/rasp30/prog_assembly/libs/tcl/read_mem2_NoRelease.tcl -device /dev/ttyUSB1/ -start_address 0x5000 -length 7000 -output_file_name data_aboveVt_mite_3.hex");
	os.system("sudo tclsh /home/ubuntu/rasp30/prog_assembly/libs/tcl/write_mem2_NoRelease.tcl -device /dev/ttyUSB1/ -start_address 0x7000 -input_file_name target_info_aboveVt_mite");
	os.system("sudo tclsh /home/ubuntu/rasp30/prog_assembly/libs/tcl/program.tcl -device /dev/ttyUSB1/ -speed 115200 measured_coarse_program_aboveVt_CAB_mite.elf");
	os.system("sudo tclsh /home/ubuntu/rasp30/prog_assembly/libs/tcl/read_mem2_NoRelease.tcl -device /dev/ttyUSB1/ -start_address 0x5000 -length 7000 -output_file_name data_aboveVt_mite_4.hex");
	os.system("sudo tclsh /home/ubuntu/rasp30/prog_assembly/libs/tcl/write_mem2_NoRelease.tcl -device /dev/ttyUSB1/ -start_address 0x7000 -input_file_name target_info_aboveVt_mite");
	os.system("sudo tclsh /home/ubuntu/rasp30/prog_assembly/libs/tcl/write_mem2_NoRelease.tcl -device /dev/ttyUSB1/ -start_address 0x6800 -input_file_name Vd_table_30mV");
	os.system("sudo tclsh /home/ubuntu/rasp30/prog_assembly/libs/tcl/program.tcl -device /dev/ttyUSB1/ -speed 115200 fine_program_aboveVt_m_ave_04_CAB_mite.elf");
	os.system("sudo tclsh /home/ubuntu/rasp30/prog_assembly/libs/tcl/read_mem2_NoRelease.tcl -device /dev/ttyUSB1/ -start_address 0x5000 -length 7000 -output_file_name data_aboveVt_mite_5.hex");
if n_target_subVt_mite != "0.000000000000000 \n":
	os.system("sudo tclsh /home/ubuntu/rasp30/prog_assembly/libs/tcl/write_mem2_NoRelease.tcl -device /dev/ttyUSB1/ -start_address 0x7000 -input_file_name target_info_subVt_mite");
	os.system("sudo tclsh /home/ubuntu/rasp30/prog_assembly/libs/tcl/write_mem2_NoRelease.tcl -device /dev/ttyUSB1/ -start_address 0x6800 -input_file_name pulse_width_table_mite");
	os.system("sudo tclsh /home/ubuntu/rasp30/prog_assembly/libs/tcl/program.tcl -device /dev/ttyUSB1/ -speed 115200 recover_inject_subVt_CAB_mite.elf");
	os.system("sudo tclsh /home/ubuntu/rasp30/prog_assembly/libs/tcl/read_mem2_NoRelease.tcl -device /dev/ttyUSB1/ -start_address 0x5000 -length 7000 -output_file_name data_subVt_mite_2.hex");
	os.system("sudo tclsh /home/ubuntu/rasp30/prog_assembly/libs/tcl/write_mem2_NoRelease.tcl -device /dev/ttyUSB1/ -start_address 0x7000 -input_file_name target_info_subVt_mite");
	os.system("sudo tclsh /home/ubuntu/rasp30/prog_assembly/libs/tcl/program.tcl -device /dev/ttyUSB1/ -speed 115200 first_coarse_program_subVt_CAB_mite.elf");
	os.system("sudo tclsh /home/ubuntu/rasp30/prog_assembly/libs/tcl/read_mem2_NoRelease.tcl -device /dev/ttyUSB1/ -start_address 0x5000 -length 7000 -output_file_name data_subVt_mite_3.hex");
	os.system("sudo tclsh /home/ubuntu/rasp30/prog_assembly/libs/tcl/write_mem2_NoRelease.tcl -device /dev/ttyUSB1/ -start_address 0x7000 -input_file_name target_info_subVt_mite");
	os.system("sudo tclsh /home/ubuntu/rasp30/prog_assembly/libs/tcl/program.tcl -device /dev/ttyUSB1/ -speed 115200 measured_coarse_program_subVt_CAB_mite.elf");
	os.system("sudo tclsh /home/ubuntu/rasp30/prog_assembly/libs/tcl/read_mem2_NoRelease.tcl -device /dev/ttyUSB1/ -start_address 0x5000 -length 7000 -output_file_name data_subVt_mite_4.hex");
	os.system("sudo tclsh /home/ubuntu/rasp30/prog_assembly/libs/tcl/write_mem2_NoRelease.tcl -device /dev/ttyUSB1/ -start_address 0x7000 -input_file_name target_info_subVt_mite");
	os.system("sudo tclsh /home/ubuntu/rasp30/prog_assembly/libs/tcl/write_mem2_NoRelease.tcl -device /dev/ttyUSB1/ -start_address 0x6800 -input_file_name Vd_table_30mV");
	os.system("sudo tclsh /home/ubuntu/rasp30/prog_assembly/libs/tcl/program.tcl -device /dev/ttyUSB1/ -speed 115200 fine_program_subVt_m_ave_04_CAB_mite.elf");
	os.system("sudo tclsh /home/ubuntu/rasp30/prog_assembly/libs/tcl/read_mem2_NoRelease.tcl -device /dev/ttyUSB1/ -start_address 0x5000 -length 7000 -output_file_name data_subVt_mite_5.hex");
if n_target_lowsubVt_mite != "0.000000000000000 \n":
	os.system("sudo tclsh /home/ubuntu/rasp30/prog_assembly/libs/tcl/write_mem2_NoRelease.tcl -device /dev/ttyUSB1/ -start_address 0x7000 -input_file_name target_info_lowsubVt_mite");
	os.system("sudo tclsh /home/ubuntu/rasp30/prog_assembly/libs/tcl/write_mem2_NoRelease.tcl -device /dev/ttyUSB1/ -start_address 0x6800 -input_file_name pulse_width_table_lowsubVt_mite");
	os.system("sudo tclsh /home/ubuntu/rasp30/prog_assembly/libs/tcl/program.tcl -device /dev/ttyUSB1/ -speed 115200 recover_inject_lowsubVt_CAB_mite.elf");
	os.system("sudo tclsh /home/ubuntu/rasp30/prog_assembly/libs/tcl/read_mem2_NoRelease.tcl -device /dev/ttyUSB1/ -start_address 0x5000 -length 7000 -output_file_name data_lowsubVt_mite_2.hex");
	os.system("sudo tclsh /home/ubuntu/rasp30/prog_assembly/libs/tcl/write_mem2_NoRelease.tcl -device /dev/ttyUSB1/ -start_address 0x7000 -input_file_name target_info_lowsubVt_mite");
	os.system("sudo tclsh /home/ubuntu/rasp30/prog_assembly/libs/tcl/program.tcl -device /dev/ttyUSB1/ -speed 115200 first_coarse_program_lowsubVt_CAB_mite.elf");
	os.system("sudo tclsh /home/ubuntu/rasp30/prog_assembly/libs/tcl/read_mem2_NoRelease.tcl -device /dev/ttyUSB1/ -start_address 0x5000 -length 7000 -output_file_name data_lowsubVt_mite_3.hex");
	os.system("sudo tclsh /home/ubuntu/rasp30/prog_assembly/libs/tcl/write_mem2_NoRelease.tcl -device /dev/ttyUSB1/ -start_address 0x7000 -input_file_name target_info_lowsubVt_mite");
	os.system("sudo tclsh /home/ubuntu/rasp30/prog_assembly/libs/tcl/program.tcl -device /dev/ttyUSB1/ -speed 115200 measured_coarse_program_lowsubVt_CAB_mite.elf");
	os.system("sudo tclsh /home/ubuntu/rasp30/prog_assembly/libs/tcl/read_mem2_NoRelease.tcl -device /dev/ttyUSB1/ -start_address 0x5000 -length 7000 -output_file_name data_lowsubVt_mite_4.hex");
	os.system("sudo tclsh /home/ubuntu/rasp30/prog_assembly/libs/tcl/write_mem2_NoRelease.tcl -device /dev/ttyUSB1/ -start_address 0x7000 -input_file_name target_info_lowsubVt_mite");
	os.system("sudo tclsh /home/ubuntu/rasp30/prog_assembly/libs/tcl/write_mem2_NoRelease.tcl -device /dev/ttyUSB1/ -start_address 0x6800 -input_file_name Vd_table_30mV");
	os.system("sudo tclsh /home/ubuntu/rasp30/prog_assembly/libs/tcl/program.tcl -device /dev/ttyUSB1/ -speed 115200 fine_program_lowsubVt_m_ave_04_CAB_mite.elf");
	os.system("sudo tclsh /home/ubuntu/rasp30/prog_assembly/libs/tcl/read_mem2_NoRelease.tcl -device /dev/ttyUSB1/ -start_address 0x5000 -length 7000 -output_file_name data_lowsubVt_mite_5.hex");
if n_target_aboveVt_dirswc != "0.000000000000000 \n":
	os.system("sudo tclsh /home/ubuntu/rasp30/prog_assembly/libs/tcl/write_mem2_NoRelease.tcl -device /dev/ttyUSB1/ -start_address 0x7000 -input_file_name target_info_aboveVt_dirswc");
	os.system("sudo tclsh /home/ubuntu/rasp30/prog_assembly/libs/tcl/write_mem2_NoRelease.tcl -device /dev/ttyUSB1/ -start_address 0x6800 -input_file_name pulse_width_table_dirswc");
	os.system("sudo tclsh /home/ubuntu/rasp30/prog_assembly/libs/tcl/program.tcl -device /dev/ttyUSB1/ -speed 115200 recover_inject_aboveVt_DIRSWC.elf");
	os.system("sudo tclsh /home/ubuntu/rasp30/prog_assembly/libs/tcl/read_mem2_NoRelease.tcl -device /dev/ttyUSB1/ -start_address 0x5000 -length 7000 -output_file_name data_aboveVt_dirswc_2.hex");
	os.system("sudo tclsh /home/ubuntu/rasp30/prog_assembly/libs/tcl/write_mem2_NoRelease.tcl -device /dev/ttyUSB1/ -start_address 0x7000 -input_file_name target_info_aboveVt_dirswc");
	os.system("sudo tclsh /home/ubuntu/rasp30/prog_assembly/libs/tcl/program.tcl -device /dev/ttyUSB1/ -speed 115200 first_coarse_program_aboveVt_DIRSWC.elf");
	os.system("sudo tclsh /home/ubuntu/rasp30/prog_assembly/libs/tcl/read_mem2_NoRelease.tcl -device /dev/ttyUSB1/ -start_address 0x5000 -length 7000 -output_file_name data_aboveVt_dirswc_3.hex");
	os.system("sudo tclsh /home/ubuntu/rasp30/prog_assembly/libs/tcl/write_mem2_NoRelease.tcl -device /dev/ttyUSB1/ -start_address 0x7000 -input_file_name target_info_aboveVt_dirswc");
	os.system("sudo tclsh /home/ubuntu/rasp30/prog_assembly/libs/tcl/program.tcl -device /dev/ttyUSB1/ -speed 115200 measured_coarse_program_aboveVt_DIRSWC.elf");
	os.system("sudo tclsh /home/ubuntu/rasp30/prog_assembly/libs/tcl/read_mem2_NoRelease.tcl -device /dev/ttyUSB1/ -start_address 0x5000 -length 7000 -output_file_name data_aboveVt_dirswc_4.hex");
	os.system("sudo tclsh /home/ubuntu/rasp30/prog_assembly/libs/tcl/write_mem2_NoRelease.tcl -device /dev/ttyUSB1/ -start_address 0x7000 -input_file_name target_info_aboveVt_dirswc");
	os.system("sudo tclsh /home/ubuntu/rasp30/prog_assembly/libs/tcl/write_mem2_NoRelease.tcl -device /dev/ttyUSB1/ -start_address 0x6800 -input_file_name Vd_table_30mV");
	os.system("sudo tclsh /home/ubuntu/rasp30/prog_assembly/libs/tcl/program.tcl -device /dev/ttyUSB1/ -speed 115200 fine_program_aboveVt_m_ave_04_DIRSWC.elf");
	os.system("sudo tclsh /home/ubuntu/rasp30/prog_assembly/libs/tcl/read_mem2_NoRelease.tcl -device /dev/ttyUSB1/ -start_address 0x5000 -length 7000 -output_file_name data_aboveVt_dirswc_5.hex");
if n_target_subVt_dirswc != "0.000000000000000 \n":
	os.system("sudo tclsh /home/ubuntu/rasp30/prog_assembly/libs/tcl/write_mem2_NoRelease.tcl -device /dev/ttyUSB1/ -start_address 0x7000 -input_file_name target_info_subVt_dirswc");
	os.system("sudo tclsh /home/ubuntu/rasp30/prog_assembly/libs/tcl/write_mem2_NoRelease.tcl -device /dev/ttyUSB1/ -start_address 0x6800 -input_file_name pulse_width_table_dirswc");
	os.system("sudo tclsh /home/ubuntu/rasp30/prog_assembly/libs/tcl/program.tcl -device /dev/ttyUSB1/ -speed 115200 recover_inject_subVt_DIRSWC.elf");
	os.system("sudo tclsh /home/ubuntu/rasp30/prog_assembly/libs/tcl/read_mem2_NoRelease.tcl -device /dev/ttyUSB1/ -start_address 0x5000 -length 7000 -output_file_name data_subVt_dirswc_2.hex");
	os.system("sudo tclsh /home/ubuntu/rasp30/prog_assembly/libs/tcl/write_mem2_NoRelease.tcl -device /dev/ttyUSB1/ -start_address 0x7000 -input_file_name target_info_subVt_dirswc");
	os.system("sudo tclsh /home/ubuntu/rasp30/prog_assembly/libs/tcl/program.tcl -device /dev/ttyUSB1/ -speed 115200 first_coarse_program_subVt_DIRSWC.elf");
	os.system("sudo tclsh /home/ubuntu/rasp30/prog_assembly/libs/tcl/read_mem2_NoRelease.tcl -device /dev/ttyUSB1/ -start_address 0x5000 -length 7000 -output_file_name data_subVt_dirswc_3.hex");
	os.system("sudo tclsh /home/ubuntu/rasp30/prog_assembly/libs/tcl/write_mem2_NoRelease.tcl -device /dev/ttyUSB1/ -start_address 0x7000 -input_file_name target_info_subVt_dirswc");
	os.system("sudo tclsh /home/ubuntu/rasp30/prog_assembly/libs/tcl/program.tcl -device /dev/ttyUSB1/ -speed 115200 measured_coarse_program_subVt_DIRSWC.elf");
	os.system("sudo tclsh /home/ubuntu/rasp30/prog_assembly/libs/tcl/read_mem2_NoRelease.tcl -device /dev/ttyUSB1/ -start_address 0x5000 -length 7000 -output_file_name data_subVt_dirswc_4.hex");
	os.system("sudo tclsh /home/ubuntu/rasp30/prog_assembly/libs/tcl/write_mem2_NoRelease.tcl -device /dev/ttyUSB1/ -start_address 0x7000 -input_file_name target_info_subVt_dirswc");
	os.system("sudo tclsh /home/ubuntu/rasp30/prog_assembly/libs/tcl/write_mem2_NoRelease.tcl -device /dev/ttyUSB1/ -start_address 0x6800 -input_file_name Vd_table_30mV");
	os.system("sudo tclsh /home/ubuntu/rasp30/prog_assembly/libs/tcl/program.tcl -device /dev/ttyUSB1/ -speed 115200 fine_program_subVt_m_ave_04_DIRSWC.elf");
	os.system("sudo tclsh /home/ubuntu/rasp30/prog_assembly/libs/tcl/read_mem2_NoRelease.tcl -device /dev/ttyUSB1/ -start_address 0x5000 -length 7000 -output_file_name data_subVt_dirswc_5.hex");
if n_target_lowsubVt_dirswc != "0.000000000000000 \n":
	os.system("sudo tclsh /home/ubuntu/rasp30/prog_assembly/libs/tcl/write_mem2_NoRelease.tcl -device /dev/ttyUSB1/ -start_address 0x7000 -input_file_name target_info_lowsubVt_dirswc");
	os.system("sudo tclsh /home/ubuntu/rasp30/prog_assembly/libs/tcl/write_mem2_NoRelease.tcl -device /dev/ttyUSB1/ -start_address 0x6800 -input_file_name pulse_width_table_lowsubVt_dirswc");
	os.system("sudo tclsh /home/ubuntu/rasp30/prog_assembly/libs/tcl/program.tcl -device /dev/ttyUSB1/ -speed 115200 recover_inject_lowsubVt_DIRSWC.elf");
	os.system("sudo tclsh /home/ubuntu/rasp30/prog_assembly/libs/tcl/read_mem2_NoRelease.tcl -device /dev/ttyUSB1/ -start_address 0x5000 -length 7000 -output_file_name data_lowsubVt_dirswc_2.hex");
	os.system("sudo tclsh /home/ubuntu/rasp30/prog_assembly/libs/tcl/write_mem2_NoRelease.tcl -device /dev/ttyUSB1/ -start_address 0x7000 -input_file_name target_info_lowsubVt_dirswc");
	os.system("sudo tclsh /home/ubuntu/rasp30/prog_assembly/libs/tcl/program.tcl -device /dev/ttyUSB1/ -speed 115200 first_coarse_program_lowsubVt_DIRSWC.elf");
	os.system("sudo tclsh /home/ubuntu/rasp30/prog_assembly/libs/tcl/read_mem2_NoRelease.tcl -device /dev/ttyUSB1/ -start_address 0x5000 -length 7000 -output_file_name data_lowsubVt_dirswc_3.hex");
	os.system("sudo tclsh /home/ubuntu/rasp30/prog_assembly/libs/tcl/write_mem2_NoRelease.tcl -device /dev/ttyUSB1/ -start_address 0x7000 -input_file_name target_info_lowsubVt_dirswc");
	os.system("sudo tclsh /home/ubuntu/rasp30/prog_assembly/libs/tcl/program.tcl -device /dev/ttyUSB1/ -speed 115200 measured_coarse_program_lowsubVt_DIRSWC.elf");
	os.system("sudo tclsh /home/ubuntu/rasp30/prog_assembly/libs/tcl/read_mem2_NoRelease.tcl -device /dev/ttyUSB1/ -start_address 0x5000 -length 7000 -output_file_name data_lowsubVt_dirswc_4.hex");
	os.system("sudo tclsh /home/ubuntu/rasp30/prog_assembly/libs/tcl/write_mem2_NoRelease.tcl -device /dev/ttyUSB1/ -start_address 0x7000 -input_file_name target_info_lowsubVt_dirswc");
	os.system("sudo tclsh /home/ubuntu/rasp30/prog_assembly/libs/tcl/write_mem2_NoRelease.tcl -device /dev/ttyUSB1/ -start_address 0x6800 -input_file_name Vd_table_30mV");
	os.system("sudo tclsh /home/ubuntu/rasp30/prog_assembly/libs/tcl/program.tcl -device /dev/ttyUSB1/ -speed 115200 fine_program_lowsubVt_m_ave_04_DIRSWC.elf");
	os.system("sudo tclsh /home/ubuntu/rasp30/prog_assembly/libs/tcl/read_mem2_NoRelease.tcl -device /dev/ttyUSB1/ -start_address 0x5000 -length 7000 -output_file_name data_lowsubVt_dirswc_5.hex");
TL.close();
os.system("sudo tclsh /home/ubuntu/rasp30/prog_assembly/libs/tcl/write_mem2_NoRelease.tcl -device /dev/ttyUSB1/ -start_address 0x4300 -input_file_name input_vector")
os.system("sudo tclsh /home/ubuntu/rasp30/prog_assembly/libs/tcl/write_mem2_NoRelease.tcl -device /dev/ttyUSB1/ -start_address 0x4200 -input_file_name output_info")
os.system("sudo tclsh /home/ubuntu/rasp30/prog_assembly/libs/tcl/program.tcl -device /dev/ttyUSB1/ -speed 115200 voltage_meas.elf")
os.system("sudo tclsh /home/ubuntu/rasp30/prog_assembly/libs/tcl/read_mem2_NoRelease.tcl -device /dev/ttyUSB1/ -start_address 0x6000 -length 1000 -output_file_name output_vector")

