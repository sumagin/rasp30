

ss = unix_w("sudo /home/ubuntu/rasp30/work/assembler_test/1_make_run.sh /home/ubuntu/rasp30/work/assembler_test/main.s43");

ss = unix_w("sudo /home/ubuntu/rasp30/work/assembler_test/2_make_readmem.sh");

fd = mopen('Memory_data.txt','r'); str2 = mgetstr(7,fd);str3 = mgetstr(7,fd);str4 = mgetstr(7,fd);str5 = mgetstr(7,fd);mclose(fd);
vv(1) = msscanf(str2,"%x");
vv(2) = msscanf(str3,"%x");
vv(3) = msscanf(str4,"%x");
vv(4) = msscanf(str5,"%x");

vv
