global file_name path fname extension chip_num board_num brdtype L1_name;

function dir_callback()
    disp("   ");
endfunction

function possible_elements()
    messagebox('pad_in pad_out gnd_i gnd_o gnd_dig vdd_i vdd_o vdd_dig ota fgota nfet pfet tgate nmirror cap',"Possible elements list", "info", ["OK"], "modal"); // <--- Define elements
endfunction

function L1_block_name_callback()
    global L1_name;
    L1_block_name_obj = findobj('tag','L1_block_name');
    L1_name = L1_block_name_obj.string;
endfunction

function Generate_L1_callback()
    global L1_name;
        
    //////////////////////////////////////////////
    // Read Blif file and get/modify net names
    //////////////////////////////////////////////
    clear model model_name inputs outputs;
    fd_r = mopen(fname+'.blif','r');
    model=mfscanf(1, fd_r, '%s');
    model_name=mfscanf(1, fd_r, '%s');
    mgetl(fd_r, 1);
    inputs_temp=mgetl(fd_r, 1); inputs_temp=strsplit(inputs_temp,' ',100); No_inputs_temp=size(inputs_temp);
    j=1; vcc_flag=0; gnd_flag=0;
    for i=1:No_inputs_temp(1)  // Check i/o including vcc/gnd
        if inputs_temp(i) == "vcc" then vcc_flag=1; end
        if inputs_temp(i) == "gnd" then gnd_flag=1; end
        if inputs_temp(i) ~= "vcc" & inputs_temp(i) ~= "gnd" then inputs(j)=inputs_temp(i); j=j+1; end
    end
    if vcc_flag == 1 | gnd_flag == 1 then
        fd_w= mopen ("/home/ubuntu/rasp30/sci2blif/sci2pads_added_blocks/"+L1_name+".sce",'wt');
        mputl("if (blk_name.entries(bl) == """+L1_name+""") then",fd_w);
        if vcc_flag then mputl("    fix_vdd = 1;",fd_w); end
        if gnd_flag then mputl("    fix_gnd = 1;",fd_w); end
        mputl("end",fd_w);
        mclose(fd_w);
    end
    No_inputs=size(inputs);

    outputs=mgetl(fd_r, 1); outputs=strsplit(outputs,' ',100); No_outputs=size(outputs);
    inout_string=[inputs(2:No_inputs(1))' outputs(2:No_outputs(1))'];
    for i=2:No_inputs(1)
        inout_string(2,i-1)="net"""+"+string(blk(blk_objs(bl),"+string(i)+"))"+"+""_""+string(ss)";
    end
    for i=2:No_outputs(1)
        inout_string(2,i-1+No_inputs(1)-1)="net"""+"+string(blk(blk_objs(bl),"+string(i)+"+numofip))"+"+""_""+string(ss)";
    end
    size_inout_string=size(inout_string);
    mgetl(fd_r, 1);
    No_ota=0;No_fgota=0;No_nfet=0;No_pfet=0;No_tgate=0;No_nmirror=0;No_cap=0;No_vdd_out=0;No_gnd_out=0;No_vdd_dig=0;No_gnd_dig=0; // <---
    match_ota=[0];match_fgota=[0];match_nfet=[0];match_pfet=[0];match_tgate=[0];match_nmirror=[0];match_cap=[0];match_vdd_out=[0];match_gnd_out=[0];match_vdd_dig=[0];match_gnd_dig=[0]; // <---
    clear string_ota string_fgota string_nfet string_pfet string_tgate string_nmirror string_cap string_vdd_out string_gnd_out string_vdd_dig string_gnd_dig;  // <---
    ele_index=mgetl(fd_r, 1); ele_index=strsplit(ele_index,' ',100);
    while ele_index(1) ~= ".end",
        str_temp=mgetl(fd_r, 1); str_temp=strsplit(str_temp,[" ";"=";"&"],100);
        if ele_index(1) == "#OTA" then // <---
            No_ota=No_ota+1; match_ota(No_ota)=strtod(ele_index(2)); string_ota(No_ota,:)=str_temp'; string_ota_temp=string_ota;
            if string_ota(No_ota,4) ~= "vcc" & string_ota(No_ota,4) ~= "gnd" then string_ota(No_ota,4)=string_ota(No_ota,4)+"_"+L1_name+"_"""+"+string(bl)"; end
            if string_ota(No_ota,4) == "vcc" | string_ota(No_ota,4) == "gnd" then string_ota(No_ota,4)=string_ota(No_ota,4)+""""; end
            if string_ota(No_ota,6) ~= "vcc" & string_ota(No_ota,6) ~= "gnd" then string_ota(No_ota,6)=string_ota(No_ota,6)+"_"+L1_name+"_"""+"+string(bl)"; end
            if string_ota(No_ota,6) == "vcc" | string_ota(No_ota,6) == "gnd" then string_ota(No_ota,6)=string_ota(No_ota,6)+""""; end
            if string_ota(No_ota,8) ~= "vcc" & string_ota(No_ota,8) ~= "gnd" then string_ota(No_ota,8)=string_ota(No_ota,8)+"_"+L1_name+"_"""+"+string(bl)"; end
            if string_ota(No_ota,8) == "vcc" | string_ota(No_ota,8) == "gnd" then string_ota(No_ota,8)=string_ota(No_ota,8)+""""; end
            for i=1:size_inout_string(2)
                if string_ota_temp(No_ota,4) == inout_string(1,i) then string_ota(No_ota,4) = inout_string(2,i); end
                if string_ota_temp(No_ota,6) == inout_string(1,i) then string_ota(No_ota,6) = inout_string(2,i); end
                if string_ota_temp(No_ota,8) == inout_string(1,i) then string_ota(No_ota,8) = inout_string(2,i); end
            end
            disp("OTA_"+string(match_ota(No_ota))+"_Ibias Default value="+string(string_ota(No_ota,11)));
        end
        if ele_index(1) == "#FGOTA" then // <---
            No_fgota=No_fgota+1; match_fgota(No_fgota)=strtod(ele_index(2)); string_fgota(No_fgota,:)=str_temp'; string_fgota_temp=string_fgota;
            if string_fgota(No_fgota,4) ~= "vcc" & string_fgota(No_fgota,4) ~= "gnd" then string_fgota(No_fgota,4)=string_fgota(No_fgota,4)+"_"+L1_name+"_"""+"+string(bl)"; end
            if string_fgota(No_fgota,4) == "vcc" | string_fgota(No_fgota,4) == "gnd" then string_fgota(No_fgota,4)=string_fgota(No_fgota,4)+""""; end
            if string_fgota(No_fgota,6) ~= "vcc" & string_fgota(No_fgota,6) ~= "gnd" then string_fgota(No_fgota,6)=string_fgota(No_fgota,6)+"_"+L1_name+"_"""+"+string(bl)"; end
            if string_fgota(No_fgota,6) == "vcc" | string_fgota(No_fgota,6) == "gnd" then string_fgota(No_fgota,6)=string_fgota(No_fgota,6)+""""; end
            if string_fgota(No_fgota,8) ~= "vcc" & string_fgota(No_fgota,8) ~= "gnd" then string_fgota(No_fgota,8)=string_fgota(No_fgota,8)+"_"+L1_name+"_"""+"+string(bl)"; end
            if string_fgota(No_fgota,8) == "vcc" | string_fgota(No_fgota,8) == "gnd" then string_fgota(No_fgota,8)=string_fgota(No_fgota,8)+""""; end
            for i=1:size_inout_string(2)
                if string_fgota_temp(No_fgota,4) == inout_string(1,i) then string_fgota(No_fgota,4) = inout_string(2,i); end
                if string_fgota_temp(No_fgota,6) == inout_string(1,i) then string_fgota(No_fgota,6) = inout_string(2,i); end
                if string_fgota_temp(No_fgota,8) == inout_string(1,i) then string_fgota(No_fgota,8) = inout_string(2,i); end
            end
            disp("FGOTA_"+string(match_fgota(No_fgota))+"_Ibias Default value="+string(string_fgota(No_fgota,11)));
            disp("FGOTA_"+string(match_fgota(No_fgota))+"_Ibias_p Default value="+string(string_fgota(No_fgota,14)));
            disp("FGOTA_"+string(match_fgota(No_fgota))+"_Ibias_n Default value="+string(string_fgota(No_fgota,17)));
        end
        if ele_index(1) == "#NFET" then // <---
            No_nfet=No_nfet+1; match_nfet(No_nfet)=strtod(ele_index(2)); string_nfet(No_nfet,:)=str_temp'; string_nfet_temp=string_nfet;
            if string_nfet(No_nfet,4) ~= "vcc" & string_nfet(No_nfet,4) ~= "gnd" then string_nfet(No_nfet,4)=string_nfet(No_nfet,4)+"_"+L1_name+"_"""+"+string(bl)"; end
            if string_nfet(No_nfet,4) == "vcc" | string_nfet(No_nfet,4) == "gnd" then string_nfet(No_nfet,4)=string_nfet(No_nfet,4)+""""; end
            if string_nfet(No_nfet,6) ~= "vcc" & string_nfet(No_nfet,6) ~= "gnd" then string_nfet(No_nfet,6)=string_nfet(No_nfet,6)+"_"+L1_name+"_"""+"+string(bl)"; end
            if string_nfet(No_nfet,6) == "vcc" | string_nfet(No_nfet,6) == "gnd" then string_nfet(No_nfet,6)=string_nfet(No_nfet,6)+""""; end
            if string_nfet(No_nfet,8) ~= "vcc" & string_nfet(No_nfet,8) ~= "gnd" then string_nfet(No_nfet,8)=string_nfet(No_nfet,8)+"_"+L1_name+"_"""+"+string(bl)"; end
            if string_nfet(No_nfet,8) == "vcc" | string_nfet(No_nfet,8) == "gnd" then string_nfet(No_nfet,8)=string_nfet(No_nfet,8)+""""; end
            for i=1:size_inout_string(2)
                if string_nfet_temp(No_nfet,4) == inout_string(1,i) then string_nfet(No_nfet,4) = inout_string(2,i); end
                if string_nfet_temp(No_nfet,6) == inout_string(1,i) then string_nfet(No_nfet,6) = inout_string(2,i); end
                if string_nfet_temp(No_nfet,8) == inout_string(1,i) then string_nfet(No_nfet,8) = inout_string(2,i); end
            end
        end
        if ele_index(1) == "#PFET" then // <---
            No_pfet=No_pfet+1; match_pfet(No_pfet)=strtod(ele_index(2)); string_pfet(No_pfet,:)=str_temp'; string_pfet_temp=string_pfet;
            if string_pfet(No_pfet,4) ~= "vcc" & string_pfet(No_pfet,4) ~= "gnd" then string_pfet(No_pfet,4)=string_pfet(No_pfet,4)+"_"+L1_name+"_"""+"+string(bl)"; end
            if string_pfet(No_pfet,4) == "vcc" | string_pfet(No_pfet,4) == "gnd" then string_pfet(No_pfet,4)=string_pfet(No_pfet,4)+""""; end
            if string_pfet(No_pfet,6) ~= "vcc" & string_pfet(No_pfet,6) ~= "gnd" then string_pfet(No_pfet,6)=string_pfet(No_pfet,6)+"_"+L1_name+"_"""+"+string(bl)"; end
            if string_pfet(No_pfet,6) == "vcc" | string_pfet(No_pfet,6) == "gnd" then string_pfet(No_pfet,6)=string_pfet(No_pfet,6)+""""; end
            if string_pfet(No_pfet,8) ~= "vcc" & string_pfet(No_pfet,8) ~= "gnd" then string_pfet(No_pfet,8)=string_pfet(No_pfet,8)+"_"+L1_name+"_"""+"+string(bl)"; end
            if string_pfet(No_pfet,8) == "vcc" | string_pfet(No_pfet,8) == "gnd" then string_pfet(No_pfet,8)=string_pfet(No_pfet,8)+""""; end
            for i=1:size_inout_string(2)
                if string_pfet_temp(No_pfet,4) == inout_string(1,i) then string_pfet(No_pfet,4) = inout_string(2,i); end
                if string_pfet_temp(No_pfet,6) == inout_string(1,i) then string_pfet(No_pfet,6) = inout_string(2,i); end
                if string_pfet_temp(No_pfet,8) == inout_string(1,i) then string_pfet(No_pfet,8) = inout_string(2,i); end
            end
        end
        if ele_index(1) == "#TGATE" then // <---
            No_tgate=No_tgate+1; match_tgate(No_tgate)=strtod(ele_index(2)); string_tgate(No_tgate,:)=str_temp'; string_tgate_temp=string_tgate;
            if string_tgate(No_tgate,4) ~= "vcc" & string_tgate(No_tgate,4) ~= "gnd" then string_tgate(No_tgate,4)=string_tgate(No_tgate,4)+"_"+L1_name+"_"""+"+string(bl)"; end
            if string_tgate(No_tgate,4) == "vcc" | string_tgate(No_tgate,4) == "gnd" then string_tgate(No_tgate,4)=string_tgate(No_tgate,4)+""""; end
            if string_tgate(No_tgate,6) ~= "vcc" & string_tgate(No_tgate,6) ~= "gnd" then string_tgate(No_tgate,6)=string_tgate(No_tgate,6)+"_"+L1_name+"_"""+"+string(bl)"; end
            if string_tgate(No_tgate,6) == "vcc" | string_tgate(No_tgate,6) == "gnd" then string_tgate(No_tgate,6)=string_tgate(No_tgate,6)+""""; end
            if string_tgate(No_tgate,8) ~= "vcc" & string_tgate(No_tgate,8) ~= "gnd" then string_tgate(No_tgate,8)=string_tgate(No_tgate,8)+"_"+L1_name+"_"""+"+string(bl)"; end
            if string_tgate(No_tgate,8) == "vcc" | string_tgate(No_tgate,8) == "gnd" then string_tgate(No_tgate,8)=string_tgate(No_tgate,8)+""""; end
            for i=1:size_inout_string(2)
                if string_tgate_temp(No_tgate,4) == inout_string(1,i) then string_tgate(No_tgate,4) = inout_string(2,i); end
                if string_tgate_temp(No_tgate,6) == inout_string(1,i) then string_tgate(No_tgate,6) = inout_string(2,i); end
                if string_tgate_temp(No_tgate,8) == inout_string(1,i) then string_tgate(No_tgate,8) = inout_string(2,i); end
            end
        end
        if ele_index(1) == "#NMIRROR" then // <---
            No_nmirror=No_nmirror+1; match_nmirror(No_nmirror)=strtod(ele_index(2)); string_nmirror(No_nmirror,:)=str_temp'; string_nmirror_temp=string_nmirror;
            if string_nmirror(No_nmirror,4) ~= "vcc" & string_nmirror(No_nmirror,4) ~= "gnd" then string_nmirror(No_nmirror,4)=string_nmirror(No_nmirror,4)+"_"+L1_name+"_"""+"+string(bl)"; end
            if string_nmirror(No_nmirror,4) == "vcc" | string_nmirror(No_nmirror,4) == "gnd" then string_nmirror(No_nmirror,4)=string_nmirror(No_nmirror,4)+""""; end
            if string_nmirror(No_nmirror,6) ~= "vcc" & string_nmirror(No_nmirror,6) ~= "gnd" then string_nmirror(No_nmirror,6)=string_nmirror(No_nmirror,6)+"_"+L1_name+"_"""+"+string(bl)"; end
            if string_nmirror(No_nmirror,6) == "vcc" | string_nmirror(No_nmirror,6) == "gnd" then string_nmirror(No_nmirror,6)=string_nmirror(No_nmirror,6)+""""; end
            for i=1:size_inout_string(2)
                if string_nmirror_temp(No_nmirror,4) == inout_string(1,i) then string_nmirror(No_nmirror,4) = inout_string(2,i); end
                if string_nmirror_temp(No_nmirror,6) == inout_string(1,i) then string_nmirror(No_nmirror,6) = inout_string(2,i); end
            end
        end
        if ele_index(1) == "#CAP" then // <---
            No_cap=No_cap+1; match_cap(No_cap)=strtod(ele_index(2)); string_cap(No_cap,:)=str_temp'; string_cap_temp=string_cap;cap_size_num(No_cap)=0;
            if string_cap(No_cap,4) ~= "vcc" & string_cap(No_cap,4) ~= "gnd" then string_cap(No_cap,4)=string_cap(No_cap,4)+"_"+L1_name+"_"""+"+string(bl)"; end
            if string_cap(No_cap,4) == "vcc" | string_cap(No_cap,4) == "gnd" then string_cap(No_cap,4)=string_cap(No_vdd_out,4)+""""; end
            if string_cap(No_cap,6) ~= "vcc" & string_cap(No_cap,6) ~= "gnd" then string_cap(No_cap,6)=string_cap(No_cap,6)+"_"+L1_name+"_"""+"+string(bl)"; end
            if string_cap(No_cap,6) == "vcc" | string_cap(No_cap,6) == "gnd" then string_cap(No_cap,6)=string_cap(No_cap,6)+""""; end
            for i=1:size_inout_string(2)
                if string_cap_temp(No_cap,4) == inout_string(1,i) then string_cap(No_cap,4) = inout_string(2,i); end
                if string_cap_temp(No_cap,6) == inout_string(1,i) then string_cap(No_cap,6) = inout_string(2,i); end
            end
            cap_size_string=string(string_cap(No_cap,7))+" ="+string(string_cap(No_cap,9));
            size_string_cap=size(string_cap);
            if size_string_cap(2) >= 12 then cap_size_string=cap_size_string+"&"+string(string_cap(No_cap,10))+" ="+string(string_cap(No_cap,12)); end
            if size_string_cap(2) >= 15 then cap_size_string=cap_size_string+"&"+string(string_cap(No_cap,13))+" ="+string(string_cap(No_cap,15)); end
            if cap_size_string == "#cap_1x =0" then cap_size_num(No_cap)=1;
            elseif cap_size_string =="#cap_2x =0" then cap_size_num(No_cap)=2;
            elseif cap_size_string =="#cap_3x =0" then cap_size_num(No_cap)=3;
            elseif cap_size_string =="#cap_3x =0&cap_1x =0" then cap_size_num(No_cap)=4;
            elseif cap_size_string =="#cap_3x =0&cap_2x =0" then cap_size_num(No_cap)=5;
            elseif cap_size_string =="#cap_3x =0&cap_2x =0&cap_1x =0" then cap_size_num(No_cap)=6;
            end
            disp("CAP_"+string(match_cap(No_cap))+"_Size Default value(64fF)[1-6x]="+string(cap_size_num(No_cap)));
        end
        if ele_index(1) == "#VDD_OUT" then // <---
            No_vdd_out=No_vdd_out+1; match_vdd_out(No_vdd_out)=strtod(ele_index(2)); string_vdd_out(No_vdd_out,:)=str_temp'; string_vdd_out_temp=string_vdd_out;
            if string_vdd_out(No_vdd_out,4) ~= "vcc" & string_vdd_out(No_vdd_out,4) ~= "gnd" then string_vdd_out(No_vdd_out,4)=string_vdd_out(No_vdd_out,4)+"_"+L1_name+"_"""+"+string(bl)"; end
            if string_vdd_out(No_vdd_out,4) == "vcc" | string_vdd_out(No_vdd_out,4) == "gnd" then string_vdd_out(No_vdd_out,4)=string_vdd_out(No_vdd_out,4)+""""; end
            if string_vdd_out(No_vdd_out,6) ~= "vcc" & string_vdd_out(No_vdd_out,6) ~= "gnd" then string_vdd_out(No_vdd_out,6)=string_vdd_out(No_vdd_out,6)+"_"+L1_name+"_"""+"+string(bl)"; end
            if string_vdd_out(No_vdd_out,6) == "vcc" | string_vdd_out(No_vdd_out,6) == "gnd" then string_vdd_out(No_vdd_out,6)=string_vdd_out(No_vdd_out,6)+""""; end
            if string_vdd_out(No_vdd_out,8) ~= "vcc" & string_vdd_out(No_vdd_out,8) ~= "gnd" then string_vdd_out(No_vdd_out,8)=string_vdd_out(No_vdd_out,8)+"_"+L1_name+"_"""+"+string(bl)"; end
            if string_vdd_out(No_vdd_out,8) == "vcc" | string_vdd_out(No_vdd_out,8) == "gnd" then string_vdd_out(No_vdd_out,8)=string_vdd_out(No_vdd_out,8)+""""; end
            for i=1:size_inout_string(2)
                if string_vdd_out_temp(No_vdd_out,4) == inout_string(1,i) then string_vdd_out(No_vdd_out,4) = inout_string(2,i); end
                if string_vdd_out_temp(No_vdd_out,6) == inout_string(1,i) then string_vdd_out(No_vdd_out,6) = inout_string(2,i); end
                if string_vdd_out_temp(No_vdd_out,8) == inout_string(1,i) then string_vdd_out(No_vdd_out,8) = inout_string(2,i); end
            end
        end
        if ele_index(1) == "#GND_OUT" then // <---
            No_gnd_out=No_gnd_out+1; match_gnd_out(No_gnd_out)=strtod(ele_index(2)); string_gnd_out(No_gnd_out,:)=str_temp'; string_gnd_out_temp=string_gnd_out;
            if string_gnd_out(No_gnd_out,4) ~= "vcc" & string_gnd_out(No_gnd_out,4) ~= "gnd" then string_gnd_out(No_gnd_out,4)=string_gnd_out(No_gnd_out,4)+"_"+L1_name+"_"""+"+string(bl)"; end
            if string_gnd_out(No_gnd_out,4) == "vcc" | string_gnd_out(No_gnd_out,4) == "gnd" then string_gnd_out(No_gnd_out,4)=string_gnd_out(No_vdd_dig,4)+""""; end
            if string_gnd_out(No_gnd_out,6) ~= "vcc" & string_gnd_out(No_gnd_out,6) ~= "gnd" then string_gnd_out(No_gnd_out,6)=string_gnd_out(No_gnd_out,6)+"_"+L1_name+"_"""+"+string(bl)"; end
            if string_gnd_out(No_gnd_out,6) == "vcc" | string_gnd_out(No_gnd_out,6) == "gnd" then string_gnd_out(No_gnd_out,6)=string_gnd_out(No_gnd_out,6)+""""; end
            if string_gnd_out(No_gnd_out,8) ~= "vcc" & string_gnd_out(No_gnd_out,8) ~= "gnd" then string_gnd_out(No_gnd_out,8)=string_gnd_out(No_gnd_out,8)+"_"+L1_name+"_"""+"+string(bl)"; end
            if string_gnd_out(No_gnd_out,8) == "vcc" | string_gnd_out(No_gnd_out,8) == "gnd" then string_gnd_out(No_gnd_out,8)=string_gnd_out(No_gnd_out,8)+""""; end
            for i=1:size_inout_string(2)
                if string_gnd_out_temp(No_gnd_out,4) == inout_string(1,i) then string_gnd_out(No_gnd_out,4) = inout_string(2,i); end
                if string_gnd_out_temp(No_gnd_out,6) == inout_string(1,i) then string_gnd_out(No_gnd_out,6) = inout_string(2,i); end
                if string_gnd_out_temp(No_gnd_out,8) == inout_string(1,i) then string_gnd_out(No_gnd_out,8) = inout_string(2,i); end
            end
        end
        if ele_index(1) == "#VDD_DIG" then // <---
            No_vdd_dig=No_vdd_dig+1; match_vdd_dig(No_vdd_dig)=strtod(ele_index(2)); string_vdd_dig(No_vdd_dig,:)=str_temp'; string_vdd_dig_temp=string_vdd_dig;
            if string_vdd_dig(No_vdd_dig,4) ~= "vcc" & string_vdd_dig(No_vdd_dig,4) ~= "gnd" then string_vdd_dig(No_vdd_dig,4)=string_vdd_dig(No_vdd_dig,4)+"_"+L1_name+"_"""+"+string(bl)"; end
            if string_vdd_dig(No_vdd_dig,4) == "vcc" | string_vdd_dig(No_vdd_dig,4) == "gnd" then string_vdd_dig(No_vdd_dig,4)=string_vdd_dig(No_gnd_dig,4)+""""; end
            if string_vdd_dig(No_vdd_dig,6) ~= "vcc" & string_vdd_dig(No_vdd_dig,6) ~= "gnd" then string_vdd_dig(No_vdd_dig,6)=string_vdd_dig(No_vdd_dig,6)+"_"+L1_name+"_"""+"+string(bl)"; end
            if string_vdd_dig(No_vdd_dig,6) == "vcc" | string_vdd_dig(No_vdd_dig,6) == "gnd" then string_vdd_dig(No_vdd_dig,6)=string_vdd_dig(No_vdd_dig,6)+""""; end
            if string_vdd_dig(No_vdd_dig,8) ~= "vcc" & string_vdd_dig(No_vdd_dig,8) ~= "gnd" then string_vdd_dig(No_vdd_dig,8)=string_vdd_dig(No_vdd_dig,8)+"_"+L1_name+"_"""+"+string(bl)"; end
            if string_vdd_dig(No_vdd_dig,8) == "vcc" | string_vdd_dig(No_vdd_dig,8) == "gnd" then string_vdd_dig(No_vdd_dig,8)=string_vdd_dig(No_vdd_dig,8)+""""; end
            for i=1:size_inout_string(2)
                if string_vdd_dig_temp(No_vdd_dig,4) == inout_string(1,i) then string_vdd_dig(No_vdd_dig,4) = inout_string(2,i); end
                if string_vdd_dig_temp(No_vdd_dig,6) == inout_string(1,i) then string_vdd_dig(No_vdd_dig,6) = inout_string(2,i); end
                if string_vdd_dig_temp(No_vdd_dig,8) == inout_string(1,i) then string_vdd_dig(No_gnd_dig,8) = inout_string(2,i); end
            end
        end
        if ele_index(1) == "#GND_DIG" then // <---
            No_gnd_dig=No_gnd_dig+1; match_gnd_dig(No_gnd_dig)=strtod(ele_index(2)); string_gnd_dig(No_gnd_dig,:)=str_temp'; string_gnd_dig_temp=string_gnd_dig;
            if string_gnd_dig(No_gnd_dig,4) ~= "vcc" & string_gnd_dig(No_gnd_dig,4) ~= "gnd" then string_gnd_dig(No_gnd_dig,4)=string_gnd_dig(No_gnd_dig,4)+"_"+L1_name+"_"""+"+string(bl)"; end
            if string_gnd_dig(No_gnd_dig,4) == "vcc" | string_gnd_dig(No_gnd_dig,4) == "gnd" then string_gnd_dig(No_gnd_dig,4)=string_gnd_dig(No_gnd_dig,4)+""""; end
            if string_gnd_dig(No_gnd_dig,6) ~= "vcc" & string_gnd_dig(No_gnd_dig,6) ~= "gnd" then string_gnd_dig(No_gnd_dig,6)=string_gnd_dig(No_gnd_dig,6)+"_"+L1_name+"_"""+"+string(bl)"; end
            if string_gnd_dig(No_gnd_dig,6) == "vcc" | string_gnd_dig(No_gnd_dig,6) == "gnd" then string_gnd_dig(No_gnd_dig,6)=string_gnd_dig(No_gnd_dig,6)+""""; end
            if string_gnd_dig(No_gnd_dig,8) ~= "vcc" & string_gnd_dig(No_gnd_dig,8) ~= "gnd" then string_gnd_dig(No_gnd_dig,8)=string_gnd_dig(No_gnd_dig,8)+"_"+L1_name+"_"""+"+string(bl)"; end
            if string_gnd_dig(No_gnd_dig,8) == "vcc" | string_gnd_dig(No_gnd_dig,8) == "gnd" then string_gnd_dig(No_gnd_dig,8)=string_gnd_dig(No_gnd_dig,8)+""""; end
            for i=1:size_inout_string(2)
                if string_gnd_dig_temp(No_gnd_dig,4) == inout_string(1,i) then string_gnd_dig(No_gnd_dig,4) = inout_string(2,i); end
                if string_gnd_dig_temp(No_gnd_dig,6) == inout_string(1,i) then string_gnd_dig(No_gnd_dig,6) = inout_string(2,i); end
                if string_gnd_dig_temp(No_gnd_dig,8) == inout_string(1,i) then string_gnd_dig(No_gnd_dig,8) = inout_string(2,i); end
            end
        end
        mgetl(fd_r, 1);
        ele_index=mgetl(fd_r, 1); ele_index=strsplit(ele_index,' ',100);
    end
    mclose(fd_r);
   
    
    //////////////////////////////////////////////
    // Make Xcos block
    //////////////////////////////////////////////
    input_num=No_inputs(1)-1;
    model_in="["; model_in2="["; model_intyp="[";
    for i=1:input_num
        model_in=model_in+"-1;"; model_in2=model_in2+"-1;"; model_intyp=model_intyp+"-1;";
    end
    model_in=model_in+"]"; model_in2=model_in2+"]"; model_intyp=model_intyp+"]";
    output_num=No_outputs(1)-1;
    model_out="["; model_out2="["; model_outtyp="[";
    for i=1:output_num
        model_out=model_out+"-1;"; model_out2=model_out2+"-1;"; model_outtyp=model_outtyp+"-1;";
    end
    model_out=model_out+"]"; model_out2=model_out2+"]"; model_outtyp=model_outtyp+"]";
    
    // Parameter order (Important): 1.ota 2.fgota
    No_of_para_xcos=0; define_str=[""]; set_str1=""; set_str2=""; set_str3=""; set_rpar=""; exprs_str="";
    if No_ota ~= 0 then // <---
        for i=1:No_ota
            // Ibias
            No_of_para_xcos=No_of_para_xcos+1;
            variable_name="OTA_"+string(match_ota(i))+"_Ibias";
            define_str(No_of_para_xcos)=variable_name+"="+string(string_ota(i,11));
            set_str1=set_str1+variable_name+", ";
            set_str2=set_str2+"; ''"+variable_name+"''";
            set_str3=set_str3+", ''vec'', -1";
            set_rpar=set_rpar+variable_name+" ";
            exprs_str=exprs_str+";sci2exp("+variable_name+")";
        end
    end
    if No_fgota ~= 0 then // <---
        for i=1:No_fgota
            // Ibias
            No_of_para_xcos=No_of_para_xcos+1;
            variable_name="FGOTA_"+string(match_fgota(i))+"_Ibias";
            define_str(No_of_para_xcos)=variable_name+"="+string(string_fgota(i,11));
            set_str1=set_str1+variable_name+", ";
            set_str2=set_str2+"; ''"+variable_name+"''";
            set_str3=set_str3+", ''vec'', -1";
            set_rpar=set_rpar+variable_name+" ";
            exprs_str=exprs_str+";sci2exp("+variable_name+")";
            // Ibias_p
            No_of_para_xcos=No_of_para_xcos+1;
            variable_name="FGOTA_"+string(match_fgota(i))+"_Ibias_p";
            define_str(No_of_para_xcos)=variable_name+"="+string(string_fgota(i,14));
            set_str1=set_str1+variable_name+", ";
            set_str2=set_str2+"; ''"+variable_name+"''";
            set_str3=set_str3+", ''vec'', -1";
            set_rpar=set_rpar+variable_name+" ";
            exprs_str=exprs_str+";sci2exp("+variable_name+")";
            // Ibias_n
            No_of_para_xcos=No_of_para_xcos+1;
            variable_name="FGOTA_"+string(match_fgota(i))+"_Ibias_n";
            define_str(No_of_para_xcos)=variable_name+"="+string(string_fgota(i,17));
            set_str1=set_str1+variable_name+", ";
            set_str2=set_str2+"; ''"+variable_name+"''";
            set_str3=set_str3+", ''vec'', -1";
            set_rpar=set_rpar+variable_name+" ";
            exprs_str=exprs_str+";sci2exp("+variable_name+")";
        end
    end
    if No_cap ~= 0 then // <---
        for i=1:No_cap
            // Cap size
            No_of_para_xcos=No_of_para_xcos+1;
            variable_name="CAP_"+string(match_cap(i))+"_size_1to6x";
            define_str(No_of_para_xcos)=variable_name+"="+string(cap_size_num(i));
            set_str1=set_str1+variable_name+", ";
            set_str2=set_str2+"; ''"+variable_name+"''";
            set_str3=set_str3+", ''vec'', -1";
            set_rpar=set_rpar+variable_name+" ";
            exprs_str=exprs_str+";sci2exp("+variable_name+")";
        end
    end
    
    fd_w= mopen ("/home/ubuntu/rasp30/xcos_blocks/"+L1_name+".sci",'wt');
    mputl("function [x,y,typ]="+L1_name+"(job,arg1,arg2)",fd_w);
    mputl("    x=[];y=[];typ=[];",fd_w);
    mputl("    select job",fd_w);
    mputl("    case ''plot'' then",fd_w);
    mputl("        standard_draw(arg1)",fd_w);
    mputl("    case ''getinputs'' then //** GET INPUTS ",fd_w);
    mputl("        [x,y,typ]=standard_inputs(arg1)",fd_w);
    mputl("    case ''getoutputs'' then",fd_w);
    mputl("        [x,y,typ]=standard_outputs(arg1)",fd_w);
    mputl("    case ''getorigin'' then",fd_w);
    mputl("        [x,y]=standard_origin(arg1)",fd_w);
    mputl("    case ''set'' then",fd_w);
    mputl("        x=arg1;",fd_w);
    mputl("        graphics=arg1.graphics",fd_w);
    mputl("        model=arg1.model",fd_w);
    mputl("        exprs=graphics.exprs",fd_w);
    mputl("        while %t do",fd_w);
    mputl("            [ok, in_out_num, "+set_str1+"exprs]=scicos_getvalue(''New Block Parameter'',[''number of blocks''"+set_str2+"],list(''vec'',-1"+set_str3+"),exprs)",fd_w);
    mputl("            ",fd_w);
    mputl("            if ~ok then break,end",fd_w);
    mputl("            if ok then",fd_w);
    mputl("                model.ipar=in_out_num",fd_w);
    mputl("                model.rpar=["+set_rpar+"]",fd_w);
    mputl("                graphics.exprs=exprs;",fd_w);
    mputl("                x.graphics=graphics;",fd_w);
    mputl("                x.model=model",fd_w);
    mputl("                break;",fd_w);
    mputl("            end",fd_w);
    mputl("        end",fd_w);
    mputl("    case ''define'' then",fd_w);
    mputl("        in_out_num=1",fd_w);
    if No_of_para_xcos ~= 0 then
        for i=1:No_of_para_xcos
                mputl("        "+define_str(i),fd_w);
        end
    end
    mputl("        model=scicos_model()",fd_w);
    mputl("        model.sim=list(''"+L1_name+"_c'',5)",fd_w);
    mputl("        model.in="+model_in,fd_w);
    mputl("        model.in2="+model_in2,fd_w);
    mputl("        model.intyp="+model_intyp,fd_w);
    mputl("        model.out="+model_out,fd_w);
    mputl("        model.out2="+model_out2,fd_w);
    mputl("        model.outtyp="++model_outtyp,fd_w);
    mputl("        model.ipar=in_out_num",fd_w);
    mputl("        //model.state=zeros(1,1)",fd_w);
    mputl("        model.rpar=["+set_rpar+"]",fd_w);
    mputl("        model.blocktype=''d''",fd_w);
    mputl("        model.dep_ut=[%f %t] //[block input has direct feedthrough to output w/o ODE   block always active]",fd_w);
    mputl("        ",fd_w);
    mputl("        exprs=[sci2exp(in_out_num)"+exprs_str+"]",fd_w);
    mputl("        gr_i=[''txt=[''''"+L1_name+"''''];'';''xstringb(orig(1),orig(2),txt,sz(1),sz(2),''''fill'''');'']",fd_w);
    mputl("        x=standard_define([5 2],model, exprs,gr_i) //Numbers define the width and height of block",fd_w);
    mputl("    end",fd_w);
    mputl("endfunction",fd_w);
    mclose(fd_w);
    
    
    //////////////////////////////////////////////
    // Generate rasp_design function 
    //////////////////////////////////////////////
    fd_w= mopen ("/home/ubuntu/rasp30/sci2blif/rasp_design_added_blocks/"+L1_name+".sce",'wt');
    mputl("style.displayedLabel="""+L1_name+"""",fd_w);
    mputl("pal5=xcosPalAddBlock(pal5,"""+L1_name+""",[],style);",fd_w);
    mclose(fd_w);
    
    
    //////////////////////////////////////////////
    // Generate sci2blif function
    //////////////////////////////////////////////
    No_of_para_sci2blif=0;
    fd_w= mopen ("/home/ubuntu/rasp30/sci2blif/sci2blif_added_blocks/"+L1_name+".sce",'wt');
    mputl("//**************************** "+L1_name+" **********************************",fd_w);
    mputl("if (blk_name.entries(bl) == """+L1_name+""") then",fd_w);
    mputl("    mputl(""#"+L1_name+""",fd_w);",fd_w);
    mputl("    for ss=1:scs_m.objs(bl).model.ipar(1)",fd_w);
    if No_ota ~= 0 then //<---
        for i=1:No_ota
            No_of_para_sci2blif=No_of_para_sci2blif+1;
            mputl("        l1_str= """+strcat(string_ota(i,1:3),' ')+"="+string_ota(i,4)+"+"" "+string_ota(i,5)+"="+string_ota(i,6)+"+"" "+string_ota(i,7)+"="+string_ota(i,8)+"+"" "+string_ota(i,9)+" =""+string(sprintf(''%e'',scs_m.objs(bl).model.rpar("+string(No_of_para_sci2blif)+")));",fd_w);
            mputl("        mputl(l1_str,fd_w);",fd_w);
            mputl("        mputl(""  "",fd_w);",fd_w);
        end
    end
    if No_fgota ~= 0 then //<---
        for i=1:No_fgota
            No_of_para_sci2blif=No_of_para_sci2blif+3;
            mputl("        l1_str= """+strcat(string_fgota(i,1:3),' ')+"="+string_fgota(i,4)+"+"" "+string_fgota(i,5)+"="+string_fgota(i,6)+"+"" "+string_fgota(i,7)+"="+string_fgota(i,8)+"+"" "+string_fgota(i,9)+" =""+string(sprintf(''%e'',scs_m.objs(bl).model.rpar("+string(No_of_para_sci2blif-2)+")))"+"+""&"+string_fgota(i,12)+" =""+string(sprintf(''%e'',scs_m.objs(bl).model.rpar("+string(No_of_para_sci2blif-1)+")))" +"+""&"+string_fgota(i,15)+" =""+string(sprintf(''%e'',scs_m.objs(bl).model.rpar("+string(No_of_para_sci2blif)+")));",fd_w);
            mputl("        mputl(l1_str,fd_w);",fd_w);
            mputl("        mputl(""  "",fd_w);",fd_w);
        end
    end
    if No_nfet ~= 0 then //<---
        for i=1:No_nfet
            mputl("        l1_str= """+strcat(string_nfet(i,1:3),' ')+"="+string_nfet(i,4)+"+"" "+string_nfet(i,5)+"="+string_nfet(i,6)+"+"" "+string_nfet(i,7)+"="+string_nfet(i,8)+";",fd_w);
            mputl("        mputl(l1_str,fd_w);",fd_w);
            mputl("        mputl(""  "",fd_w);",fd_w);
        end
    end
    if No_pfet ~= 0 then //<---
        for i=1:No_pfet
            mputl("        l1_str= """+strcat(string_pfet(i,1:3),' ')+"="+string_pfet(i,4)+"+"" "+string_pfet(i,5)+"="+string_pfet(i,6)+"+"" "+string_pfet(i,7)+"="+string_pfet(i,8)+";",fd_w);
            mputl("        mputl(l1_str,fd_w);",fd_w);
            mputl("        mputl(""  "",fd_w);",fd_w);
        end
    end
    if No_tgate ~= 0 then //<---
        for i=1:No_tgate
            mputl("        l1_str= """+strcat(string_tgate(i,1:3),' ')+"="+string_tgate(i,4)+"+"" "+string_tgate(i,5)+"="+string_tgate(i,6)+"+"" "+string_tgate(i,7)+"="+string_tgate(i,8)+";",fd_w);
            mputl("        mputl(l1_str,fd_w);",fd_w);
            mputl("        mputl(""  "",fd_w);",fd_w);
        end
    end
    if No_nmirror ~= 0 then //<---
        for i=1:No_nmirror
            mputl("        l1_str= """+strcat(string_nmirror(i,1:3),' ')+"="+string_nmirror(i,4)+"+"" "+string_nmirror(i,5)+"="+string_nmirror(i,6)+";",fd_w);
            mputl("        mputl(l1_str,fd_w);",fd_w);
            mputl("        mputl(""  "",fd_w);",fd_w);
        end
    end
    if No_cap ~= 0 then //<---
        for i=1:No_cap
            No_of_para_sci2blif=No_of_para_sci2blif+1;
            mputl("        if scs_m.objs(bl).model.rpar("+string(No_of_para_sci2blif)+") == 1 then cap_size_string=""#cap_1x =0""; end",fd_w);
            mputl("        if scs_m.objs(bl).model.rpar("+string(No_of_para_sci2blif)+") == 2 then cap_size_string=""#cap_2x =0""; end",fd_w);
            mputl("        if scs_m.objs(bl).model.rpar("+string(No_of_para_sci2blif)+") == 3 then cap_size_string=""#cap_3x =0""; end",fd_w);
            mputl("        if scs_m.objs(bl).model.rpar("+string(No_of_para_sci2blif)+") == 4 then cap_size_string=""#cap_3x =0&cap_1x =0""; end",fd_w);
            mputl("        if scs_m.objs(bl).model.rpar("+string(No_of_para_sci2blif)+") == 5 then cap_size_string=""#cap_3x =0&cap_2x =0""; end",fd_w);
            mputl("        if scs_m.objs(bl).model.rpar("+string(No_of_para_sci2blif)+") == 6 then cap_size_string=""#cap_3x =0#cap_2x =0&cap_1x =0""; end",fd_w);
            mputl("        l1_str= """+strcat(string_cap(i,1:3),' ')+"="+string_cap(i,4)+"+"" "+string_cap(i,5)+"="+string_cap(i,6)+"+"" ""+cap_size_string;",fd_w);
            mputl("        mputl(l1_str,fd_w);",fd_w);
            mputl("        mputl(""  "",fd_w);",fd_w);
        end
    end
    if No_vdd_out ~= 0 then //<---
        for i=1:No_vdd_out
            mputl("        l1_str= """+strcat(string_vdd_out(i,1:3),' ')+"="+string_vdd_out(i,4)+"+"" "+string_vdd_out(i,5)+"="+string_vdd_out(i,6)+"+"" "+string_vdd_out(i,7)+"="+string_vdd_out(i,8)+"+"" "+string_vdd_out(i,9)+string_vdd_out(i,10)+" ="+string_vdd_out(i,11)+""";",fd_w);
            mputl("        mputl(l1_str,fd_w);",fd_w);
            mputl("        mputl(""  "",fd_w);",fd_w);
        end
    end
    if No_gnd_out ~= 0 then //<---
        for i=1:No_gnd_out
            mputl("        l1_str= """+strcat(string_gnd_out(i,1:3),' ')+"="+string_gnd_out(i,4)+"+"" "+string_gnd_out(i,5)+"="+string_gnd_out(i,6)+"+"" "+string_gnd_out(i,7)+"="+string_gnd_out(i,8)+"+"" "+string_gnd_out(i,9)+string_gnd_out(i,10)+" ="+string_gnd_out(i,11)+""";",fd_w);
            mputl("        mputl(l1_str,fd_w);",fd_w);
            mputl("        mputl(""  "",fd_w);",fd_w);
        end
    end
    if No_vdd_dig ~= 0 then //<---
        for i=1:No_vdd_dig
            mputl("        l1_str= """+strcat(string_vdd_dig(i,1:3),' ')+"="+string_vdd_dig(i,4)+" "+string_vdd_dig(i,5)+"="+string_vdd_dig(i,6)+" "+string_vdd_dig(i,7)+"="+string_vdd_dig(i,8)+";",fd_w);
            mputl("        mputl(l1_str,fd_w);",fd_w);
            mputl("        mputl(""  "",fd_w);",fd_w);
        end
    end
    if No_gnd_dig ~= 0 then //<---
        for i=1:No_gnd_dig
            mputl("        l1_str= """+strcat(string_gnd_dig(i,1:3),' ')+"="+string_gnd_dig(i,4)+" "+string_gnd_dig(i,5)+"="+string_gnd_dig(i,6)+" "+string_gnd_dig(i,7)+"="+string_gnd_dig(i,8)+";",fd_w);
            mputl("        mputl(l1_str,fd_w);",fd_w);
            mputl("        mputl(""  "",fd_w);",fd_w);
        end
    end
    mputl("    end",fd_w);
    mputl("    mputl("""",fd_w);",fd_w);
    mputl("end",fd_w);
    mclose(fd_w);
    
    //disp(string(No_of_para_sci2blif)+"="+string(No_of_para_xcos)+"? (should be same.)")
    filebrowser();
    
endfunction
