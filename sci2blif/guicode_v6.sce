//Turn off the warning messages in the console
previousprot = funcprot(1) //integer with possible values 0, 1, 2 returns previous value
funcprot(0) //allows the user to specify what scilab do when such variables are redefined. 0=nothing, 1=warning, 2=error

gui=figure('figure_position',[750,200],'figure_size',[300,560],'auto_resize','on','background',[14],'figure_name','Rasp Design');
gui.color_map =  wintercolormap(32);

delmenu(gui.figure_id,gettext('File'))
delmenu(gui.figure_id,gettext('?'))
delmenu(gui.figure_id,gettext('Tools'))
delmenu(gui.figure_id,gettext('Edit'))
toolbar(gui.figure_id,'off')
handles.dummy = 0;
handles.email_box=uicontrol(gui,'unit','normalized','BackgroundColor',[0.9,0.9,0.9],'Enable','on','FontAngle','normal','FontName','mukti narrow','FontSize',[13],'FontUnits','points','FontWeight','normal','ForegroundColor',[0,0,0],'HorizontalAlignment','center','ListboxTop',[],'Max',[1],'Min',[0],'Position',[0.065,0.937,0.875,0.045],'Relief','sunken','SliderStep',[0.01,0.1],'String','Enter Email Address and Press Enter','Style','edit','Value',[0],'VerticalAlignment','middle','Visible','on','Tag','email_box','Callback','email_box_callback(handles)');
handles.text_box=uicontrol(gui,'unit','normalized','BackgroundColor',[0.9,0.9,0.9],'Enable','on','FontAngle','normal','FontName','mukti narrow','FontSize',[12.5],'FontUnits','points','FontWeight','normal','ForegroundColor',[0,0,0],'HorizontalAlignment','center','ListboxTop',[],'Max',[1],'Min',[0],'Position',[0.065,0.873,0.875,0.045],'Relief','flat','SliderStep',[0.01,0.1],'String','No File Selected','Style','text','Value',[0],'VerticalAlignment','middle','Visible','on','Tag','text_box','Callback','text_box_callback(handles)');
handles.Choose_Board=uicontrol(gui,'unit','normalized','BackgroundColor',[1,1,1],'Enable','on','FontAngle','normal','FontName','mukti narrow','FontSize',[12],'FontUnits','points','FontWeight','normal','ForegroundColor',[0,0,0],'HorizontalAlignment','center','ListboxTop',[],'Max',[1],'Min',[0],'Position',[0.065,0.795,0.4,0.055],'Relief','flat','SliderStep',[0.01,0.1],'String','Choose Board|3.0|3.0 A|3.0 N|3.0 H','Style','popupmenu','Value',[1 2 3 4 5],'VerticalAlignment','middle','Visible','on','Tag','Choose_Board','Callback','Choose_Board_callback(handles)');
handles.Choose_Chip=uicontrol(gui,'unit','normalized','BackgroundColor',[1,1,1],'Enable','on','FontAngle','normal','FontName','mukti narrow','FontSize',[12],'FontUnits','points','FontWeight','normal','ForegroundColor',[0,0,0],'HorizontalAlignment','center','ListboxTop',[],'Max',[1],'Min',[0],'Position',[0.54,0.795,0.4,0.055],'Relief','sunken','SliderStep',[0.01,0.1],'String','Enter Chip Number','Style','edit','Value',[0],'VerticalAlignment','middle','Visible','on','Tag','Choose_Chip','Callback','Choose_Chip_callback(handles)'); 
handles.New_Design=uicontrol(gui,'unit','normalized','BackgroundColor',[0.8,0.8,0.8],'Enable','on','FontAngle','normal','FontName','mukti narrow','FontSize',[12],'FontUnits','points','FontWeight','bold','ForegroundColor',[0,0,0],'HorizontalAlignment','center','ListboxTop',[],'Max',[1],'Min',[0],'Position',[0.065,0.695,0.4,0.08],'Relief','raised','SliderStep',[0.01,0.1],'String','New Design','Style','pushbutton','Value',[0],'VerticalAlignment','middle','Visible','on','Tag','New_Design','Callback','New_Design_callback(handles)');
handles.Choose_Design=uicontrol(gui,'unit','normalized','BackgroundColor',[0.8,0.8,0.8],'Enable','on','FontAngle','normal','FontName','mukti narrow','FontSize',[12],'FontUnits','points','FontWeight','bold','ForegroundColor',[0,0,0],'HorizontalAlignment','center','ListboxTop',[],'Max',[1],'Min',[0],'Position',[0.065,0.592,0.4,0.08],'Relief','raised','SliderStep',[0.01,0.1],'String','Choose Design ','Style','pushbutton','Value',[0],'VerticalAlignment','middle','Visible','on','Tag','Choose_Design','Callback','Choose_Design_callback(handles)');
handles.Open_Design=uicontrol(gui,'unit','normalized','BackgroundColor',[0.8,0.8,0.8],'Enable','on','FontAngle','normal','FontName','mukti narrow','FontSize',[12],'FontUnits','points','FontWeight','bold','ForegroundColor',[0,0,0],'HorizontalAlignment','center','ListboxTop',[],'Max',[1],'Min',[0],'Position',[0.065,0.489,0.4,0.08],'Relief','raised','SliderStep',[0.01,0.1],'String','Open Design','Style','pushbutton','Value',[0],'VerticalAlignment','middle','Visible','on','Tag','Open_Design','Callback','Open_Design_callback(handles)');
handles.Compile_Design=uicontrol(gui,'unit','normalized','BackgroundColor',[0.8,0.8,0.8],'Enable','on','FontAngle','normal','FontName','mukti narrow','FontSize',[12],'FontUnits','points','FontWeight','bold','ForegroundColor',[0,0,0],'HorizontalAlignment','center','ListboxTop',[],'Max',[1],'Min',[0],'Position',[0.065,0.386,0.4,0.08],'Relief','raised','SliderStep',[0.01,0.1],'String','Compile Design','Style','pushbutton','Value',[0],'VerticalAlignment','middle','Visible','on','Tag','Compile_Design','Callback','Compile_Design_callback(handles)');
handles.Program_Design=uicontrol(gui,'unit','normalized','BackgroundColor',[0.8,0.8,0.8],'Enable','on','FontAngle','normal','FontName','mukti narrow','FontSize',[12],'FontUnits','points','FontWeight','bold','ForegroundColor',[0,0,0],'HorizontalAlignment','center','ListboxTop',[],'Max',[1],'Min',[0],'Position',[0.065,0.283,0.4,0.08],'Relief','raised','SliderStep',[0.01,0.1],'String','Program Design','Style','pushbutton','Value',[0],'VerticalAlignment','middle','Visible','on','Tag','Program_Design','Callback','Program_Design_callback()');
handles.View_Routing=uicontrol(gui,'unit','normalized','BackgroundColor',[0.8,0.8,0.8],'Enable','on','FontAngle','normal','FontName','mukti narrow','FontSize',[12],'FontUnits','points','FontWeight','bold','ForegroundColor',[0,0,0],'HorizontalAlignment','center','ListboxTop',[],'Max',[1],'Min',[0],'Position',[0.065,0.18,0.4,0.08],'Relief','raised','SliderStep',[0.01,0.1],'String','View Routing','Style','pushbutton','Value',[0],'VerticalAlignment','middle','Visible','on','Tag','View_Routing','Callback','View_Routing_callback(handles)');
handles.Reset_Com=uicontrol(gui,'unit','normalized','BackgroundColor',[0.8,0.8,0.8],'Enable','on','FontAngle','normal','FontName','mukti narrow','FontSize',[12],'FontUnits','points','FontWeight','bold','ForegroundColor',[0,0,0],'HorizontalAlignment','center','ListboxTop',[],'Max',[1],'Min',[0],'Position',[0.065,0.0787,0.4,0.08],'Relief','raised','SliderStep',[0.01,0.1],'String','Reset Com','Style','pushbutton','Value',[0],'VerticalAlignment','middle','Visible','on','Tag','Reset_Com','Callback','Reset_Com_callback(handles)');
handles.Take_Data=uicontrol(gui,'unit','normalized','BackgroundColor',[0.8,0.8,0.8],'Enable','on','FontAngle','normal','FontName','mukti narrow','FontSize',[12],'FontUnits','points','FontWeight','bold','ForegroundColor',[0,0,0],'HorizontalAlignment','center','ListboxTop',[],'Max',[1],'Min',[0],'Position',[0.54,0.695,0.4,0.08],'Relief','raised','SliderStep',[0.01,0.1],'String','Take Data','Style','pushbutton','Value',[0],'VerticalAlignment','middle','Visible','on','Tag','Take_Data','Callback','Take_Data_callback(handles)');
handles.Send_Email=uicontrol(gui,'unit','normalized','BackgroundColor',[0.8,0.8,0.8],'Enable','on','FontAngle','normal','FontName','mukti narrow','FontSize',[12],'FontUnits','points','FontWeight','bold','ForegroundColor',[0,0,0],'HorizontalAlignment','center','ListboxTop',[],'Max',[1],'Min',[0],'Position',[0.54,0.592,0.4,0.08],'Relief','raised','SliderStep',[0.01,0.1],'String','Send Email','Style','pushbutton','Value',[0],'VerticalAlignment','middle','Visible','on','Tag','Send_Email','Callback','Send_Email_callback(handles)');
handles.Load_Data=uicontrol(gui,'unit','normalized','BackgroundColor',[0.8,0.8,0.8],'Enable','on','FontAngle','normal','FontName','mukti narrow','FontSize',[12],'FontUnits','points','FontWeight','bold','ForegroundColor',[0,0,0],'HorizontalAlignment','center','ListboxTop',[],'Max',[1],'Min',[0],'Position',[0.54,0.489,0.4,0.08],'Relief','raised','SliderStep',[0.01,0.1],'String','Load Remote Data','Style','pushbutton','Value',[0],'VerticalAlignment','middle','Visible','on','Tag','Load_Data','Callback','Load_Data_callback(handles)');
handles.Choose_Netlist=uicontrol(gui,'unit','normalized','BackgroundColor',[0.8,0.8,0.8],'Enable','on','FontAngle','normal','FontName','mukti narrow','FontSize',[12],'FontUnits','points','FontWeight','bold','ForegroundColor',[0,0,0],'HorizontalAlignment','center','ListboxTop',[],'Max',[1],'Min',[0],'Position',[0.54,0.386,0.4,0.08],'Relief','raised','SliderStep',[0.01,0.1],'String','Choose Netlist','Style','pushbutton','Value',[0],'VerticalAlignment','middle','Visible','on','Tag','Choose_Netlist','Callback','Choose_Netlist_callback(handles)');
handles.Program_Netlist=uicontrol(gui,'unit','normalized','BackgroundColor',[0.8,0.8,0.8],'Enable','on','FontAngle','normal','FontName','mukti narrow','FontSize',[12],'FontUnits','points','FontWeight','bold','ForegroundColor',[0,0,0],'HorizontalAlignment','center','ListboxTop',[],'Max',[1],'Min',[0],'Position',[0.54,0.283,0.4,0.08],'Relief','raised','SliderStep',[0.01,0.1],'String','Program Netlist','Style','pushbutton','Value',[0],'VerticalAlignment','middle','Visible','on','Tag','Program_Netlist','Callback','Program_Netlist_callback(handles)');
handles.Choose_Swc_List=uicontrol(gui,'unit','normalized','BackgroundColor',[0.8,0.8,0.8],'Enable','on','FontAngle','normal','FontName','mukti narrow','FontSize',[12],'FontUnits','points','FontWeight','bold','ForegroundColor',[0,0,0],'HorizontalAlignment','center','ListboxTop',[],'Max',[1],'Min',[0],'Position',[0.54,0.18,0.4,0.08],'Relief','raised','SliderStep',[0.01,0.1],'String','Choose Switches','Style','pushbutton','Value',[0],'VerticalAlignment','middle','Visible','on','Tag','Choose_Swc_List','Callback','Choose_Swc_List_callback(handles)');
handles.Program_SwcList=uicontrol(gui,'unit','normalized','BackgroundColor',[0.8,0.8,0.8],'Enable','on','FontAngle','normal','FontName','mukti narrow','FontSize',[12],'FontUnits','points','FontWeight','bold','ForegroundColor',[0,0,0],'HorizontalAlignment','center','ListboxTop',[],'Max',[1],'Min',[0],'Position',[0.54,0.0787,0.4,0.08],'Relief','raised','SliderStep',[0.01,0.1],'String','Program Switches','Style','pushbutton','Value',[0],'VerticalAlignment','middle','Visible','on','Tag','Program_SwcList','Callback','Program_SwcList_callback(handles)');

exec('/home/ubuntu/rasp30/sci2blif/fpaacal_fcn.sce',-1);
//exec('/home/ubuntu/rasp30/sci2blif/curswp_fcn.sce',-1);
//exec('/home/ubuntu/rasp30/sci2blif/dig_gui_fcn.sce',-1);
exec('/home/ubuntu/rasp30/sci2blif/level2to1_fcn.sce',-1);
exec('/home/ubuntu/rasp30/sci2blif/send_email_ip_pw_fcn.sce',-1);

//Add custom menus
file_menu = uimenu("Parent", gui, "Label", gettext("Examples"),'ForegroundColor',[1,1,1]);
file19_menu = uimenu("Parent", file_menu, "Label", gettext("On chip"));
file23_menu = uimenu("Parent", file_menu, "Label", gettext("3.0a IO Pins"));
file1_menu = uimenu("Parent", file_menu, "Label", gettext("Xcos Only"));
file2_menu = uimenu("Parent", file_menu, "Label", gettext("3.0 IO Pins"));
//file6_menu = uimenu("Parent", file1_menu, "Label", gettext("Peak Detector"), "callback", "file6_callback();");
//file3_menu = uimenu("Parent", file1_menu, "Label", gettext("OTA Follower"), "callback", "file3_callback();");
file4_menu = uimenu("Parent", file1_menu, "Label", gettext("LPF"), "callback", "file4_callback()");
file5_menu = uimenu("Parent", file1_menu, "Label", gettext("C4"), "callback", "file5_callback()");
file11_menu = uimenu("Parent", file1_menu, "Label", gettext("VMM+WTA"), "callback", "file11_callback()");
file16_menu = uimenu("Parent", file2_menu, "Label", gettext("Pin2Pin/LPF"), "callback", "file16_callback()");
file14_menu = uimenu("Parent", file2_menu, "Label", gettext("Digital"), "callback", "file14_callback()");
//file7_menu = uimenu("Parent", file2_menu, "Label", gettext("LPF"), "callback", "file7_callback();");
//file9_menu = uimenu("Parent", file2_menu, "Label", gettext("LPF w/pad"), "callback", "file9_callback();");
//file8_menu = uimenu("Parent", file2_menu, "Label", gettext("C4"), "callback", "file8_callback();");
//file10_menu = uimenu("Parent", file2_menu, "Label", gettext("C4 w/pad"), "callback", "file10_callback();"); 
file18_menu = uimenu("Parent", file2_menu, "Label", gettext("C4"), "callback", "file18_callback()"); 
file17_menu = uimenu("Parent", file2_menu, "Label", gettext("C4 + Amplitude Detector"), "callback", "file17_callback()");
//file12_menu = uimenu("Parent", file2_menu, "Label", gettext("VMM+WTA"), "callback", "file12_callback();");
file15_menu = uimenu("Parent", file2_menu, "Label", gettext("Sigma Delta"), "callback", "file15_callback()");
file13_menu = uimenu("Parent", file2_menu, "Label", gettext("VMM+WTA"), "callback", "file13_callback()");//  w/pad
file20_menu = uimenu("Parent", file19_menu, "Label", gettext("DAC to ADC"), "callback", "file20_callback()");
file21_menu = uimenu("Parent", file19_menu, "Label", gettext("LPF"), "callback", "file21_callback()");
file22_menu = uimenu("Parent", file19_menu, "Label", gettext("C4"), "callback", "file22_callback()");
file24_menu = uimenu("Parent", file23_menu, "Label", gettext("Pin2Pin/LPF"), "callback", "file24_callback()");
file25_menu = uimenu("Parent", file23_menu, "Label", gettext("Digital"), "callback", "file25_callback()");
file26_menu = uimenu("Parent", file23_menu, "Label", gettext("C4"), "callback", "file26_callback()"); 
file27_menu = uimenu("Parent", file23_menu, "Label", gettext("C4 + Amplitude Detector"), "callback", "file27_callback()");
file28_menu = uimenu("Parent", file23_menu, "Label", gettext("Sigma Delta"), "callback", "file28_callback()");
file29_menu = uimenu("Parent", file23_menu, "Label", gettext("VMM+WTA"), "callback", "file29_callback()");//  w/pad
file30_menu = uimenu("Parent", file23_menu, "Label", gettext("HH Neuron"), "callback", "file30_callback()");

update_menu = uimenu("Parent", gui, "Label", gettext("Update"),'ForegroundColor',[1,1,1]);
update1_menu = uimenu("Parent", update_menu, "Label", gettext("Update RASP Tools"), "callback", "up1_callback()");
update2_menu = uimenu("Parent", update_menu, "Label", gettext("Reset RASP Tools"), "callback", "up2_callback()");

doc_menu = uimenu("Parent", gui, "Label", gettext("Docs"), 'ForegroundColor',[1,1,1]);
doc1_menu = uimenu("Parent", doc_menu, "Label", gettext("RASP 3.0 Board"), "callback", "doc1_callback()");
doc2_menu = uimenu("Parent", doc_menu, "Label", gettext("RASP 3.0a Board"), "callback", "doc2_callback()");
doc3_menu = uimenu("Parent", doc_menu, "Label", gettext("VM Setup && Remote System Guide"), "callback", "doc3_callback()");
doc4_menu = uimenu("Parent", doc_menu, "Label", gettext("Design Simulation && Programming FPAA Guide"), "callback", "doc4_callback()");
doc5_menu = uimenu("Parent", doc_menu, "Label", gettext("Useful Websites for Blocks"), "callback", "doc5_callback()");
doc6_menu = uimenu("Parent", doc_menu, "Label", gettext("Install Adobe Reader"), "callback", "doc6_callback()");

etc_menu = uimenu("Parent", gui, "Label", gettext("Utilities"), 'ForegroundColor',[1,1,1]);
etc7_menu = uimenu("Parent", etc_menu, "Label", gettext("Initialize Ammeter"), "callback", "etc7_callback()");
etc8_menu = uimenu("Parent", etc_menu, "Label", gettext("Create/Load CSV File"));
etc10_menu = uimenu("Parent", etc8_menu, "Label", gettext("Create .csv File"), "callback", "etc10_callback()");
etc9_menu = uimenu("Parent", etc8_menu, "Label", gettext("Load .csv File"), "callback", "etc9_callback()");
etc4_menu = uimenu("Parent", etc_menu, "Label", gettext("On/Off Programming Graphs"));
etc3_menu = uimenu("Parent", etc_menu, "Label", gettext("Close Programming Graphs"), "callback", "etc3_callback()");
etc2_menu = uimenu("Parent", etc_menu, "Label", gettext("Fine Tune Switches"), "callback", "etc2_callback()");
etc5_menu = uimenu("Parent", etc4_menu, "Label", gettext("Programming Graphs On"), "callback", "etc5_callback()");
etc6_menu = uimenu("Parent", etc4_menu, "Label", gettext("Programming Graphs Off"), "callback", "etc6_callback()");
etc1_menu = uimenu("Parent", etc_menu, "Label", gettext("Delete Hidden Folder"), "callback", "etc1_callback()");

gui_menu = uimenu("Parent", gui, "Label", gettext("GUIs"), 'ForegroundColor',[1,1,1]);
gui1_menu = uimenu("Parent", gui_menu, "Label", gettext("Calibration"), 'ForegroundColor',[0,0,0], "callback", "gui1_callback()");
//gui3_menu = uimenu("Parent", gui_menu, "Label", gettext("Digilent Source/Scope"), 'ForegroundColor',[0,0,0], "callback", "gui3_callback()");
//gui2_menu = uimenu("Parent", gui_menu, "Label", gettext("Current Sweeps"), 'ForegroundColor',[0,0,0], "callback", "gui2_callback()");
gui4_menu = uimenu("Parent", gui_menu, "Label", gettext("Generate Level1"), 'ForegroundColor',[0,0,0], "callback", "gui4_callback()");


//////////
// Callbacks are defined as below.
//////////
clearglobal file_name fname path extension email_name chip_num addvmm rm_results board_num showprog csvdata plcvpr
global file_name fname path extension email_name chip_num addvmm rm_results board_num showprog csvdata plcvpr

showprog = 0;

function email_box_callback(handles)
    global email_name;
    email_name = handles.email_box.string;   
endfunction

function text_box_callback(handles)
    global file_name path fname extension;
    handles.text_box.string=basename(file_name)+extension;   
endfunction

function Choose_Chip_callback(handles)
    global chip_num;
    chip_num = handles.Choose_Chip.string;   
endfunction

function Choose_Board_callback(handles)
    global board_num brdtype;

    if (handles.Choose_Board.value == 1) then board_num=1;
    elseif (handles.Choose_Board.value == 2) then board_num=2; brdtype = ''; disp('You are now using the settings for the 3.0 Board');
    elseif (handles.Choose_Board.value == 3) then board_num=3; brdtype = '_30a'; disp('You are now using the settings for the 3.0 A Board');
    elseif (handles.Choose_Board.value == 4) then board_num=4; brdtype = '_30n'; disp('You are now using the settings for the 3.0 N Board');
    elseif (handles.Choose_Board.value == 5) then board_num=5; brdtype = '_30h'; disp('You are now using the settings for the 3.0 H Board');
    else
    end

endfunction

function New_Design_callback(handles)
    xcos;
endfunction

function Choose_Design_callback(handles)
    clc
    global file_name path fname extension;
    global dirpwd;

    file_name2 = file_name
    path =  pwd();
    dirpwd = pwd()+'/';
    file_name = uigetfile(["*.xcos*"],path, "Choose the Design to be Compiled");
    [path,fname,extension]=fileparts(file_name);
    if(path ~= "") then
        if(path ~= dirpwd) then
            cd(path);
            filebrowser();
        end
        clear scs_m;
        clear blk_objs;
        clear blk; 
        global scs_m;
        text_box_callback(handles)
    else
        if handles.text_box.string ~= 'No File Selected' then
            [path,fname,extension]=fileparts(file_name2);
        else
            handles.text_box.string='No File Selected';
        end
    end
endfunction

function Open_Design_callback(handles)
    global file_name path fname extension;
    if(fname ~= "") then
        if(extension == '.xcos') then 
            xcos(file_name);
        else
            messagebox(["You have not selected a Design (.xcos)" "Please choose one to open."], "No Design Selected", "warning");
        end

    else
        messagebox(["You have not selected a Design (.xcos)" "Please choose one to open."], "No Design Selected", "warning");
    end

endfunction

function Compile_Design_callback(handles)
    global file_name path fname extension
    if(extension == '.xcos') then
        importXcosDiagram(file_name);
        clc
        exec('/home/ubuntu/rasp30/sci2blif/sci2blif_test2.sce', -1);
        filebrowser();
    else
        messagebox(["You have not selected a Design (.xcos)" "Please choose one to compile."], "No File Selected", "warning");
    end
endfunction

function Program_Design_callback(handles)
    global file_name path fname extension
    clc
    x = fileinfo(fname + '.swcs')
    if(x ~= []) then 
        //mm=waitbar("Program Status");
        disp('Programming...')
        [amm_opt, amm_con1] = unix_g('sudo chmod 777 /dev/rasp30');
        if amm_con1 then
            messagebox(["FPAA Board is not connected under the VM Devices tab." "Please select the board and initiate again."],"FPAA Board is not Connected via USB Devices" , "info", "modal");
            //close(mm)
            disp('Programming has stopped.')
        else
            // Count # of switches and target_fgs. 
            swc_fg_list = fscanfMat(path+fname+'.swcs');
            temp_size= size(swc_fg_list); n=temp_size(1,1);
            No_swcs=0; No_swcs_sr=0; No_target_fgs=0;
            tar_prog_offset1=0; tar_prog_offset2=0; tar_prog_offset3=0; tar_prog_offset4=0; tar_prog_offset6=0;
            for i=1:n
                if swc_fg_list(i,4) == 0 & swc_fg_list(i,3) == 0 then No_swcs=No_swcs+1; end
                if swc_fg_list(i,4) == 0 & swc_fg_list(i,3) == 1 then No_swcs_sr=No_swcs_sr+1; end
                if swc_fg_list(i,4) == 1 then No_target_fgs=No_target_fgs+1; tar_prog_offset1=20; end
                if swc_fg_list(i,4) == 2 then No_target_fgs=No_target_fgs+1; tar_prog_offset2=20; end
                if swc_fg_list(i,4) == 3 then No_target_fgs=No_target_fgs+1; tar_prog_offset3=20; end
                if swc_fg_list(i,4) == 4 then No_target_fgs=No_target_fgs+1; tar_prog_offset4=20; end
                if swc_fg_list(i,4) == 6 then No_target_fgs=No_target_fgs+1; tar_prog_offset6=20; end
            end
            tun_revtun_time=7; // Tunnel and Reverse tunnel time (s) (a value measured in scilab execution)
            swc_prog_unit=0.3; swc_prog_offset=9; // Switch program unit time (s) (a value measured in scilab execution)
            swc_prog_time=swc_prog_offset+swc_prog_unit*(No_swcs+10*No_swcs_sr);
            tar_prog_unit=20; // Target program unit time (s) (a value measured in scilab execution)
            tar_prog_time=tar_prog_offset1+tar_prog_offset2+tar_prog_offset3+tar_prog_offset4+tar_prog_offset6+tar_prog_unit*No_target_fgs
            dc_time=5 // DC setup time (s) (a value measured in scilab execution)
            
            string_tun_revtun='Tunnel & Rev. tunnel (../'+string(tun_revtun_time)+'s)';
            string_prog_swc='Program Switches (../'+string(swc_prog_time)+'s)';
            string_prog_tar='Program Target FGs (../'+string(tar_prog_time)+'s)';
            string_dc_setup='DC setup (../'+string(dc_time)+'s)';
            
            winH=progressionbar(['-> '+string_tun_revtun string_prog_swc string_prog_tar string_dc_setup]);
            tic(); realtimeinit(1); realtime(0); realtime(2);
            exec('/home/ubuntu/rasp30/prog_assembly/libs/scilab_code/tunnel_revtun_ver00_gui.sce', -1);
            time1=toc(); string_tun_revtun='Tunnel & Rev. tunnel ('+string(time1)+'/'+string(tun_revtun_time)+'s)';
            disp('tunnel, reverse tunnel done');
            progressionbar(winH,[string_tun_revtun '-> '+string_prog_swc string_prog_tar string_dc_setup]);
            tic(); realtimeinit(1); realtime(0); realtime(2);
            exec('/home/ubuntu/rasp30/prog_assembly/libs/scilab_code/switch_program_ver05_gui.sce', -1);
            time1=toc(); string_prog_swc='Program Switches ('+string(time1)+'/'+string(swc_prog_time)+'s)';
            disp('switch_program done');
            progressionbar(winH,[string_tun_revtun string_prog_swc '-> '+string_prog_tar string_dc_setup]);
            tic(); realtimeinit(1); realtime(0); realtime(2);
            exec('/home/ubuntu/rasp30/prog_assembly/libs/scilab_code/target_program_ver02_gui.sce', -1);
            time1=toc(); string_prog_tar='Program Target FGs ('+string(time1)+'/'+string(tar_prog_time)+'s)';
            disp('target_program done');
            b1=unix("ls "+hid_dir+"/switch_list_ble");
            if (b1==0) then
                progressionbar(winH,[string_tun_revtun string_prog_swc string_prog_tar '-> Program ble switches' string_dc_setup]);
                exec('/home/ubuntu/rasp30/prog_assembly/libs/scilab_code/tunnel_clb_ver00_gui.sce', -1);
                disp('tunnel , reverse tunnel for clb done');
                exec('/home/ubuntu/rasp30/prog_assembly/libs/scilab_code/switch_program_ble_ver00_gui.sce', -1);
                disp('switch_program for ble done');
            end
            progressionbar(winH,[string_tun_revtun string_prog_swc string_prog_tar '-> '+string_dc_setup]);
            tic(); realtimeinit(1); realtime(0); realtime(2);
            exec('/home/ubuntu/rasp30/prog_assembly/libs/scilab_code/dc_setup_gui.sce', -1);
            time1=toc(); string_dc_setup='DC setup ('+string(time1)+'/'+string(dc_time)+'s)';
            disp('DC setup done');
            disp("Programming Completed...Ready to Take Data");
            close(winH);
            filebrowser();
        end

    else
        messagebox(["You do not have a ' + fname+ '.swcs file in the current directory." "Please create one by compiling a design or netlist."], "No Switch List Detected", "warning");
    end
endfunction

function vprinfo()
    global board_num brdtype

    select board_num 
    case 2 then
        arch = 'rasp3';
        brdtype = '';
        loc_num=1;
    case 3 then
        arch = 'rasp3a';
        brdtype = ' -'+arch;
        loc_num=2;
    case 4 then
        arch = 'rasp3n';
        brdtype = ' -'+arch;
        loc_num=3;
    case 5 
        arch = 'rasp3h';
        brdtype = ' -'+arch;
        loc_num=4;
    else
        messagebox('Please select the FPAA board that you are using.', "No Selected FPAA Board", "error");
        abort
    end
endfunction

function View_Routing_callback(handles)
    global file_name path fname extension addvmm plcvpr 
    x = fileinfo(fname + '.blif')
    if(x ~= []) then 
        hid_dir=path+'.'+fname;
        unix_s('mkdir -p '+hid_dir);
        x = fileinfo(hid_dir+'/' +fname' + '.pads')
        if(x ~= []) then //pads file is in hidden dir
            vprinfo()
            unix_s('mv ' + hid_dir+'/' +fname' + '.pads '+ hid_dir+'/' +fname' + '.place '+ hid_dir+'/' +fname' + '.net '+ hid_dir+'/' +fname' + '.route '+ path); 
            if plcvpr & addvmm then // add -vmm option for some blocks
                unix_s('python /home/ubuntu/rasp30/vpr2swcs/genswcs.py -c ' + path + fname + ' -d '+ path + ' -vmm -route' + brdtype +' -v');
            elseif plcvpr
                unix_s('python /home/ubuntu/rasp30/vpr2swcs/genswcs.py -c ' + path + fname + ' -d '+ path+ ' -route' + brdtype+' -v');
            elseif addvmm then // add -vmm option for some blocks
                unix_s('python /home/ubuntu/rasp30/vpr2swcs/genswcs.py -c ' + path + fname + ' -d '+ path + ' -vmm' + brdtype+' -v');
            else
                unix_s('python /home/ubuntu/rasp30/vpr2swcs/genswcs.py -c ' + path + fname + ' -d '+ path + brdtype+' -v');
            end
            unix_s('mv ' + fname' + '.pads ' + fname + '.place ' + fname + '.net ' + fname + '.route ' +hid_dir);
            filebrowser();
        else //pads not in hidden dir
            x = fileinfo(fname' + '.pads')
            if(x ~= []) then //pads file in current dir
                vprinfo()
                if plcvpr & addvmm then // add -vmm option for some blocks
                    unix_s('python /home/ubuntu/rasp30/vpr2swcs/genswcs.py -c ' + path + fname + ' -d '+ path + ' -vmm -route' + brdtype +' -v');
                elseif plcvpr
                    unix_s('python /home/ubuntu/rasp30/vpr2swcs/genswcs.py -c ' + path + fname + ' -d '+ path+ ' -route' + brdtype+' -v');
                elseif addvmm then // add -vmm option for some blocks
                    unix_s('python /home/ubuntu/rasp30/vpr2swcs/genswcs.py -c ' + path + fname + ' -d '+ path + ' -vmm' + brdtype+' -v');
                else
                    unix_s('python /home/ubuntu/rasp30/vpr2swcs/genswcs.py -c ' + path + fname + ' -d '+ path + brdtype+' -v');
                end
                unix_s('mv ' + fname' + '.pads ' + fname + '.place ' + fname + '.net ' + fname + '.route ' +hid_dir);
                filebrowser();
            else
                messagebox(["You do not have a ' + fname+ '.pads file in the current directory." "Please create one by compiling your design or by hand."], "Missing File", "warning");
            end
        end
    else
        messagebox(["You do not have a ' + fname+ '.blif file in the current directory." "Please create one by compiling your design or by hand."], "Missing File", "warning");
    end
endfunction

function Take_Data_callback(handles)
    disp('Taking Data...');
    exec('/home/ubuntu/rasp30/prog_assembly/libs/scilab_code/dc_setup_gui.sce', -1);
    disp('DC setup done');
    global RAMP_ADC_check;//had to add this for ramp
    if RAMP_ADC_check==1 then
    noDAC=1;
    exec("~/rasp30/prog_assembly/libs/scilab_code/Ramp_ADC_voltage.sce",-1);
    else
    exec('/home/ubuntu/rasp30/prog_assembly/libs/scilab_code/voltage_measurement_gui.sce', -1);
    end    
    disp("Data Collected ");
    filebrowser();
endfunction

function Send_Email_callback(handles)
    global email_name fname;

    if (email_name == []) then
        messagebox(["Please provide your email address in the designated location."], "No Netlist Selected", "warning");
    else
        exec('/home/ubuntu/rasp30/sci2blif/send_email_ip_pw.sce',-1);
    end
endfunction

function Load_Data_callback(handles)
    global path fname rm_results;
    disp("Loading Data...");
    unix_s('python /home/ubuntu/rasp30/sci2blif/rmunzip.py ' + path)
    exec('/home/ubuntu/rasp30/prog_assembly/libs/scilab_code/outhexfile2voltfile_gui.sce', -1);
    rm_results=fscanfMat(path + fname +'.data')
    figure();plot(rm_results)
    disp("Your data is loaded and saved in the variable rm_results. It can also be located in the Variable Browser.");
endfunction

function Choose_Netlist_callback(handles)
    clc
    global file_name path fname extension
    path =  pwd();
    dirpwd = pwd()+'/';
    file_name=uigetfile(["*.blif*"],path, "Choose the Netlist to be Compiled");
    [path,fname,extension]=fileparts(file_name);
    if(path ~= "") then
        if(path ~= dirpwd) then
            cd(path);
            filebrowser();
        end
        text_box_callback(handles)
    end
endfunction


function Program_Netlist_callback(handles)
    global file_name path fname extension
    clc
    [amm_opt, amm_con1] = unix_g('sudo chmod 777 /dev/rasp30');
    if amm_con1 then
        messagebox(["FPAA Board is not connected under the VM Devices tab." "Please select the board and program again."],"FPAA Board is not Connected via USB Devices" , "info", "modal");
    else
        hid_dir=path+'.'+fname;
        if(extension == '.blif') then 
            unix_s('mkdir -p '+hid_dir);
            x = fileinfo(hid_dir+'/' +fname + '.pads')
            if(x ~= []) then //pads file is in hidden dir
                unix_s('mv ' + hid_dir+'/' +fname' + '.pads '+ path); 
                disp("Determining the Switch List...");
                unix_s('python /home/ubuntu/rasp30/vpr2swcs/genswcs.py -c ' + path + fname + ' -d '+ path);
                unix_s('mv ' + fname' + '.pads ' + fname + '.place ' + fname + '.net ' + fname + '.route ' +hid_dir);
                disp("Switch List Created.");
                filebrowser();
                disp('Programming...')
                exec("~/rasp30/prog_assembly/libs/scilab_code/MakeProgramlilst_CompileAssembly.sce",-1);
                exec('/home/ubuntu/rasp30/prog_assembly/libs/scilab_code/tunnel_revtun_ver00_gui.sce', -1);
                disp('tunnel , reverse tunnel done');
                exec('/home/ubuntu/rasp30/prog_assembly/libs/scilab_code/switch_program_ver05_gui.sce', -1);
                disp('switch_program done');
                exec('/home/ubuntu/rasp30/prog_assembly/libs/scilab_code/target_program_ver02_gui.sce', -1);
                disp('target_program done');
                disp("Programming Completed...Ready to Take Data");
            else //pads not in hidden dir
                x = fileinfo(fname + '.pads')
                if(x ~= []) then //pads file in current dir
                    disp("Determining the Switch List...");
                    unix_s('python /home/ubuntu/rasp30/vpr2swcs/genswcs.py -c ' + path + fname + ' -d '+ path);
                    unix_s('mv ' + fname' + '.pads ' + fname + '.place ' + fname + '.net ' + fname + '.route ' +hid_dir);
                    disp("Switch List Created.");
                    filebrowser();
                    disp('Programming...')
                    exec("~/rasp30/prog_assembly/libs/scilab_code/MakeProgramlilst_CompileAssembly.sce",-1);
                    exec('/home/ubuntu/rasp30/prog_assembly/libs/scilab_code/tunnel_revtun_ver00_gui.sce', -1);
                    disp('tunnel , reverse tunnel done');
                    exec('/home/ubuntu/rasp30/prog_assembly/libs/scilab_code/switch_program_ver05_gui.sce', -1);
                    disp('switch_program done');
                    exec('/home/ubuntu/rasp30/prog_assembly/libs/scilab_code/target_program_ver02_gui.sce', -1);
                    disp('target_program done');
                    disp("Programming Completed...Ready to Take Data");
                else
                    messagebox(["You do not have a ' + fname+ '.pads file in the current directory." "Please create one by compiling a design or doing by hand."], "Missing File", "warning");
                end
            end
        else
            messagebox(["You have not selected a Netlist (.blif)" "Please choose one to compile."], "No Netlist Selected", "warning");
        end
    end

endfunction

function Choose_Swc_List_callback(handles)
    clc
    global file_name path fname extension
    path =  pwd();
    dirpwd = pwd()+'/';
    file_name=uigetfile(["*.swcs*"],path, "Choose the Switch List to be Compiled");
    [path,fname,extension]=fileparts(file_name);
    if(path ~= "") then
        if(path ~= dirpwd) then
            cd(path);
            filebrowser();
        end
        text_box_callback(handles)
    end
endfunction

function Program_SwcList_callback(handles)
    global file_name path fname extension
    clc
    if(extension == '.swcs') then 
        unix_g('>./input_vector');
        y_input=mopen('./input_vector','wb');
        mputl('0x0001 0x000c 0x03e8 0xb238 0xFFFF',y_input);
        mclose(y_input);
        disp('Programming...');
        errcatch(-1,"pause");
        hid_dir=path+'.'+fname;
        unix_s('mkdir -p '+hid_dir);
        x = fileinfo('input_vector')
        if(x == []) then 
            fd = mopen('input_vector','wt'); mputl('0x0000 0x0000 0x03e8 0xFFFF', fd); mclose(fd); // making fake input_vector
        end
        exec("~/rasp30/prog_assembly/libs/scilab_code/MakeProgramlilst_CompileAssembly.sce",-1);
        
        // Count # of switches and target_fgs. 
        swc_fg_list = fscanfMat(path+fname+'.swcs');
        temp_size= size(swc_fg_list); n=temp_size(1,1);
        No_swcs=0; No_swcs_sr=0; No_target_fgs=0;
        tar_prog_offset1=0; tar_prog_offset2=0; tar_prog_offset3=0; tar_prog_offset4=0; tar_prog_offset6=0;
        for i=1:n
            if swc_fg_list(i,4) == 0 & swc_fg_list(i,3) == 0 then No_swcs=No_swcs+1; end
            if swc_fg_list(i,4) == 0 & swc_fg_list(i,3) == 1 then No_swcs_sr=No_swcs_sr+1; end
            if swc_fg_list(i,4) == 1 then No_target_fgs=No_target_fgs+1; tar_prog_offset1=20; end
            if swc_fg_list(i,4) == 2 then No_target_fgs=No_target_fgs+1; tar_prog_offset2=20; end
            if swc_fg_list(i,4) == 3 then No_target_fgs=No_target_fgs+1; tar_prog_offset3=20; end
            if swc_fg_list(i,4) == 4 then No_target_fgs=No_target_fgs+1; tar_prog_offset4=20; end
            if swc_fg_list(i,4) == 6 then No_target_fgs=No_target_fgs+1; tar_prog_offset6=20; end
        end
        tun_revtun_time=7; // Tunnel and Reverse tunnel time (s) (a value measured in scilab execution)
        swc_prog_unit=0.3; swc_prog_offset=9; // Switch program unit time (s) (a value measured in scilab execution)
        swc_prog_time=swc_prog_offset+swc_prog_unit*(No_swcs+10*No_swcs_sr);
        tar_prog_unit=20; // Target program unit time (s) (a value measured in scilab execution)
        tar_prog_time=tar_prog_offset1+tar_prog_offset2+tar_prog_offset3+tar_prog_offset4+tar_prog_offset6+tar_prog_unit*No_target_fgs
        dc_time=5 // DC setup time (s) (a value measured in scilab execution)
        
        string_tun_revtun='Tunnel & Rev. tunnel (../'+string(tun_revtun_time)+'s)';
        string_prog_swc='Program Switches (../'+string(swc_prog_time)+'s)';
        string_prog_tar='Program Target FGs (../'+string(tar_prog_time)+'s)';
        string_dc_setup='DC setup (../'+string(dc_time)+'s)';
        
        winH=progressionbar(['-> '+string_tun_revtun string_prog_swc string_prog_tar string_dc_setup]);
        tic(); realtimeinit(1); realtime(0); realtime(2);
        exec('/home/ubuntu/rasp30/prog_assembly/libs/scilab_code/tunnel_revtun_ver00_gui.sce', -1);
        time1=toc(); string_tun_revtun='Tunnel & Rev. tunnel ('+string(time1)+'/'+string(tun_revtun_time)+'s)';
        disp('tunnel, reverse tunnel done');
        progressionbar(winH,[string_tun_revtun '-> '+string_prog_swc string_prog_tar string_dc_setup]);
        tic(); realtimeinit(1); realtime(0); realtime(2);
        exec('/home/ubuntu/rasp30/prog_assembly/libs/scilab_code/switch_program_ver05_gui.sce', -1);
        time1=toc(); string_prog_swc='Program Switches ('+string(time1)+'/'+string(swc_prog_time)+'s)';
        disp('switch_program done');
        progressionbar(winH,[string_tun_revtun string_prog_swc '-> '+string_prog_tar string_dc_setup]);
        tic(); realtimeinit(1); realtime(0); realtime(2);
        exec('/home/ubuntu/rasp30/prog_assembly/libs/scilab_code/target_program_ver02_gui.sce', -1);
        time1=toc(); string_prog_tar='Program Target FGs ('+string(time1)+'/'+string(tar_prog_time)+'s)';
        disp('target_program done');
        b1=unix("ls "+hid_dir+"/switch_list_ble");
        if (b1==0) then
            progressionbar(winH,[string_tun_revtun string_prog_swc string_prog_tar '-> Program ble switches' string_dc_setup]);
            exec('/home/ubuntu/rasp30/prog_assembly/libs/scilab_code/tunnel_clb_ver00_gui.sce', -1);
            disp('tunnel , reverse tunnel for clb done');
            exec('/home/ubuntu/rasp30/prog_assembly/libs/scilab_code/switch_program_ble_ver00_gui.sce', -1);
            disp('switch_program for ble done');
        end
        progressionbar(winH,[string_tun_revtun string_prog_swc string_prog_tar '-> '+string_dc_setup]);
        tic(); realtimeinit(1); realtime(0); realtime(2);
        exec('/home/ubuntu/rasp30/prog_assembly/libs/scilab_code/dc_setup_gui.sce', -1);
        time1=toc(); string_dc_setup='DC setup ('+string(time1)+'/'+string(dc_time)+'s)';
        disp('DC setup done');
        disp("Programming Completed...Ready to Take Data");
        close(winH);
        filebrowser();
    else
        messagebox(["You have not selected a Switch List (.swcs)" "Please choose one to compile."], "No Switch List Selected", "warning");
    end
endfunction

function Reset_Com_callback(handles)
    disp('Resetting USB connections...');
    unix_s('/home/ubuntu/rasp30/sci2blif/usbreset');
    disp('Done!');
endfunction

//function file6_callback()
//    file_name= '/home/ubuntu/rasp30/work/peakdet_test.xcos';
//
//    xcos(file_name);
//endfunction
//
//function file3_callback()
//    file_name= '/home/ubuntu/rasp30/work/ota_flwr_test.xcos';
//
//    xcos(file_name);
//endfunction
//
function file4_callback()
    global file_name path fname extension

    unix_s('cp /home/ubuntu/rasp30/work/examples/LPF/lpf.xcos /home/ubuntu/RASP_Workspace/demo_files/LPF/');
    file_name= '/home/ubuntu/RASP_Workspace/demo_files/LPF/lpf.xcos';
    [path,fname,extension]=fileparts(file_name);

    dirpwd = pwd()+'/';

    if(path ~= dirpwd) then
        cd(path);
        filebrowser();
    end

    xcos(file_name);
    arb_msg();
endfunction

function file5_callback()
    global file_name path fname extension

    unix_s('cp /home/ubuntu/rasp30/work/examples/C4/c4.xcos /home/ubuntu/RASP_Workspace/demo_files/C4/');
    file_name= '/home/ubuntu/RASP_Workspace/demo_files/C4/c4.xcos';
    [path,fname,extension]=fileparts(file_name);

    dirpwd = pwd()+'/';

    if(path ~= dirpwd) then
        cd(path);
        filebrowser();
    end
    xcos(file_name);
    arb_msg();
endfunction

function file21_callback()
    global file_name path fname extension

    unix_s('cp /home/ubuntu/rasp30/work/examples/LPF/lpf_meas.xcos /home/ubuntu/RASP_Workspace/demo_files/LPF/');
    file_name= '/home/ubuntu/RASP_Workspace/demo_files/LPF/lpf_meas.xcos';
    [path,fname,extension]=fileparts(file_name);

    dirpwd = pwd()+'/';

    if(path ~= dirpwd) then
        cd(path);
        filebrowser();
    end
    com_prep();
    xcos(file_name);
    arb_msg2();
endfunction 

function file22_callback()
    global file_name path fname extension

    unix_s('cp /home/ubuntu/rasp30/work/examples/C4/c4_ramp.xcos /home/ubuntu/RASP_Workspace/demo_files/C4/version_wo_pad/');
    file_name= '/home/ubuntu/RASP_Workspace/demo_files/C4/version_wo_pad/c4_ramp.xcos';
    [path,fname,extension]=fileparts(file_name);

    dirpwd = pwd()+'/';

    if(path ~= dirpwd) then
        cd(path);
        filebrowser();
    end
    com_prep();
    xcos(file_name);
    arb_msg2();
endfunction

function file20_callback()
    global file_name path fname extension

    unix_s('cp /home/ubuntu/rasp30/work/examples/Pin2Pin_LPF/dac_adc.xcos /home/ubuntu/RASP_Workspace/demo_files/Pin2Pin_LPF/');
    file_name= '/home/ubuntu/RASP_Workspace/demo_files/Pin2Pin_LPF/dac_adc.xcos';
    [path,fname,extension]=fileparts(file_name);

    dirpwd = pwd()+'/';

    if(path ~= dirpwd) then
        cd(path);
        filebrowser();
    end
    com_prep();
    xcos(file_name);
    arb_msg2();
endfunction

function file11_callback()
    global file_name path fname extension

    unix_s('cp /home/ubuntu/rasp30/work/examples/VMM+WTA/vmmwta.xcos /home/ubuntu/RASP_Workspace/demo_files/VMM+WTA/');
    file_name= '/home/ubuntu/RASP_Workspace/demo_files/VMM+WTA/vmmwta.xcos';
    [path,fname,extension]=fileparts(file_name);

    dirpwd = pwd()+'/';

    if(path ~= dirpwd) then
        cd(path);
        filebrowser();
    end

    //file_name= '/home/ubuntu/rasp30/work/c4_test.xcos';
    xcos(file_name);
    arb_msg();
endfunction

function file7_callback()
    global file_name path fname extension;

    unix_s('cp /home/ubuntu/rasp30/work/examples/LPF/lpf_test.xcos /home/ubuntu/RASP_Workspace/demo_files/LPF/version_wo_pad/');
    file_name= '/home/ubuntu/RASP_Workspace/demo_files/LPF/version_wo_pad/lpf_test.xcos';

    [path,fname,extension]=fileparts(file_name);
    dirpwd = pwd()+'/';
    if(path ~= dirpwd) then
        cd(path);
        filebrowser();
    end
    clear scs_m;
    clear blk_objs;
    clear blk; 
    global scs_m;
    text_box_callback(handles)
    xcos(file_name);
endfunction

function file8_callback()
    global file_name path fname extension;

    unix_s('cp /home/ubuntu/rasp30/work/examples/C4/c4_test.xcos /home/ubuntu/RASP_Workspace/demo_files/C4/version_wo_pad/');
    file_name= '/home/ubuntu/RASP_Workspace/demo_files/C4/version_wo_pad/c4_test.xcos';
    [path,fname,extension]=fileparts(file_name);
    dirpwd = pwd()+'/';
    if(path ~= dirpwd) then
        cd(path);
        filebrowser();
    end
    clear scs_m;
    clear blk_objs;
    clear blk; 
    global scs_m;
    text_box_callback(handles)
    xcos(file_name);
endfunction

function file12_callback()
    global file_name path fname extension;

    unix_s('cp /home/ubuntu/rasp30/work/examples/VMM+WTA/vmmwta_test.xcos /home/ubuntu/RASP_Workspace/demo_files/VMM+WTA/version_wo_pad/');
    file_name= '/home/ubuntu/RASP_Workspace/demo_files/VMM+WTA/version_wo_pad/vmmwta_test.xcos';
    [path,fname,extension]=fileparts(file_name);
    dirpwd = pwd()+'/';
    if(path ~= dirpwd) then
        cd(path);
        filebrowser();
    end
    clear scs_m;
    clear blk_objs;
    clear blk; 
    global scs_m;
    text_box_callback(handles)
    //file_name= '/home/ubuntu/rasp30/sci2blif/nfet_test.xcos';
    xcos(file_name);
endfunction

function file9_callback()
    global file_name path fname extension;

    unix_s('cp /home/ubuntu/rasp30/work/examples/LPF/lpf_test2.xcos /home/ubuntu/RASP_Workspace/demo_files/LPF/version_w_pad/');
    file_name= '/home/ubuntu/RASP_Workspace/demo_files/LPF/version_w_pad/lpf_test2.xcos';
    [path,fname,extension]=fileparts(file_name);
    dirpwd = pwd()+'/';
    if(path ~= dirpwd) then
        cd(path);
        filebrowser();
    end
    clear scs_m;
    clear blk_objs;
    clear blk; 
    global scs_m;
    text_box_callback(handles)
    //file_name= '/home/ubuntu/rasp30/sci2blif/src_foll_test.xcos';
    xcos(file_name);

endfunction

function file10_callback()
    global file_name path fname extension;

    unix_s('cp /home/ubuntu/rasp30/work/examples/C4/c4_test2.xcos /home/ubuntu/RASP_Workspace/demo_files/C4/version_w_pad/');
    file_name= '/home/ubuntu/RASP_Workspace/demo_files/C4/version_w_pad/c4_test2.xcos';
    [path,fname,extension]=fileparts(file_name);
    dirpwd = pwd()+'/';
    if(path ~= dirpwd) then
        cd(path);
        filebrowser();
    end
    clear scs_m;
    clear blk_objs;
    clear blk; 
    global scs_m;
    text_box_callback(handles)
    xcos(file_name);
endfunction

function file13_callback()
    global file_name path fname extension;

    unix_s('cp /home/ubuntu/rasp30/work/examples/VMM+WTA/vmmwta_test2.xcos /home/ubuntu/RASP_Workspace/demo_files/VMM+WTA/version_w_pad/');
    file_name= '/home/ubuntu/RASP_Workspace/demo_files/VMM+WTA/version_w_pad/vmmwta_test2.xcos';
    [path,fname,extension]=fileparts(file_name);
    dirpwd = pwd()+'/';
    if(path ~= dirpwd) then
        cd(path);
        filebrowser();
    end
    clear scs_m;
    clear blk_objs;


    clear blk; 
    global scs_m;
    text_box_callback(handles)
    xcos(file_name);
endfunction

function file29_callback()
    global file_name path fname extension;

    unix_s('cp /home/ubuntu/rasp30/work/examples/VMM+WTA/vmmwta_test2a.xcos /home/ubuntu/RASP_Workspace/demo_files/VMM+WTA/version_w_pad/');
    file_name= '/home/ubuntu/RASP_Workspace/demo_files/VMM+WTA/version_w_pad/vmmwta_test2a.xcos';
    [path,fname,extension]=fileparts(file_name);
    dirpwd = pwd()+'/';
    if(path ~= dirpwd) then
        cd(path);
        filebrowser();
    end
    clear scs_m;
    clear blk_objs;


    clear blk; 
    global scs_m;
    text_box_callback(handles)
    xcos(file_name);
    arb_msg2();
endfunction

function file30_callback()
    global file_name path fname extension;

    unix_s('cp /home/ubuntu/rasp30/work/examples/HHneuron/hhn.xcos /home/ubuntu/RASP_Workspace/demo_files/HHneuron/');
    file_name= '/home/ubuntu/RASP_Workspace/demo_files/HHneuron/hhn.xcos';
    [path,fname,extension]=fileparts(file_name);
    dirpwd = pwd()+'/';
    if(path ~= dirpwd) then
        cd(path);
        filebrowser();
    end
    clear scs_m;
    clear blk_objs;


    clear blk; 
    global scs_m;
    text_box_callback(handles)
    xcos(file_name);
    arb_msg2();
endfunction

function file16_callback()
    global file_name path fname extension;

    unix_s('cp /home/ubuntu/rasp30/work/examples/Pin2Pin_LPF/pin2pin_lpf.xcos /home/ubuntu/RASP_Workspace/demo_files/Pin2Pin_LPF/');
    file_name= '/home/ubuntu/RASP_Workspace/demo_files/Pin2Pin_LPF/pin2pin_lpf.xcos';
    [path,fname,extension]=fileparts(file_name);
    dirpwd = pwd()+'/';
    if(path ~= dirpwd) then
        cd(path);
        filebrowser();
    end

    clear scs_m;
    clear blk_objs;
    clear blk; 
    global scs_m;
    text_box_callback(handles)
    xcos(file_name);
endfunction

function file24_callback()
    global file_name path fname extension;

    unix_s('cp /home/ubuntu/rasp30/work/examples/Pin2Pin_LPF/pin2pin_lpf2.xcos /home/ubuntu/RASP_Workspace/demo_files/Pin2Pin_LPF/');
    file_name= '/home/ubuntu/RASP_Workspace/demo_files/Pin2Pin_LPF/pin2pin_lpf2.xcos';
    [path,fname,extension]=fileparts(file_name);
    dirpwd = pwd()+'/';
    if(path ~= dirpwd) then
        cd(path);
        filebrowser();
    end

    clear scs_m;
    clear blk_objs;
    clear blk; 
    global scs_m;
    text_box_callback(handles)
    xcos(file_name);
endfunction

function file14_callback()
    global file_name path fname extension;

    unix_s('cp /home/ubuntu/rasp30/work/examples/Digital/logic.xcos /home/ubuntu/RASP_Workspace/demo_files/Digital/');
    file_name= '/home/ubuntu/RASP_Workspace/demo_files/Digital/logic.xcos';
    [path,fname,extension]=fileparts(file_name);
    dirpwd = pwd()+'/';
    if(path ~= dirpwd) then
        cd(path);
        filebrowser();
    end
    clear scs_m;
    clear blk_objs;
    clear blk; 
    global scs_m;
    text_box_callback(handles)
    xcos(file_name);
endfunction

function file25_callback()
    global file_name path fname extension;

    unix_s('cp /home/ubuntu/rasp30/work/examples/Digital/logic2.xcos /home/ubuntu/RASP_Workspace/demo_files/Digital/');
    file_name= '/home/ubuntu/RASP_Workspace/demo_files/Digital/logic2.xcos';
    [path,fname,extension]=fileparts(file_name);
    dirpwd = pwd()+'/';
    if(path ~= dirpwd) then
        cd(path);
        filebrowser();
    end
    clear scs_m;
    clear blk_objs;
    clear blk; 
    global scs_m;
    text_box_callback(handles)
    xcos(file_name);
endfunction

function file18_callback()
    global file_name path fname extension;

    unix_s('cp /home/ubuntu/rasp30/work/examples/C4/c4_test3.xcos /home/ubuntu/RASP_Workspace/demo_files/C4/version2/');
    file_name= '/home/ubuntu/RASP_Workspace/demo_files/C4/version2/c4_test3.xcos';
    [path,fname,extension]=fileparts(file_name);
    dirpwd = pwd()+'/';
    if(path ~= dirpwd) then
        cd(path);
        filebrowser();
    end
    clear scs_m;
    clear blk_objs;
    clear blk; 
    global scs_m;
    text_box_callback(handles)
    xcos(file_name);
endfunction

function file26_callback()
    global file_name path fname extension;

    unix_s('cp /home/ubuntu/rasp30/work/examples/C4/c4_test3a.xcos /home/ubuntu/RASP_Workspace/demo_files/C4/version2/');
    file_name= '/home/ubuntu/RASP_Workspace/demo_files/C4/version2/c4_test3a.xcos';
    [path,fname,extension]=fileparts(file_name);
    dirpwd = pwd()+'/';
    if(path ~= dirpwd) then
        cd(path);
        filebrowser();
    end
    clear scs_m;
    clear blk_objs;
    clear blk; 
    global scs_m;
    text_box_callback(handles)
    xcos(file_name);
endfunction

function file17_callback()
    global file_name path fname extension;

    unix_s('cp /home/ubuntu/rasp30/work/examples/C4+Amp/C4_MD.xcos /home/ubuntu/RASP_Workspace/demo_files/C4+Amp/');
    file_name= '/home/ubuntu/RASP_Workspace/demo_files/C4+Amp/C4_MD.xcos';
    [path,fname,extension]=fileparts(file_name);
    dirpwd = pwd()+'/';
    if(path ~= dirpwd) then
        cd(path);
        filebrowser();
    end
    clear scs_m;
    clear blk_objs;
    clear blk; 
    global scs_m;
    text_box_callback(handles)
    xcos(file_name);
endfunction

function file27_callback()
    global file_name path fname extension;

    unix_s('cp /home/ubuntu/rasp30/work/examples/C4+Amp/C4_MD2.xcos /home/ubuntu/RASP_Workspace/demo_files/C4+Amp/');
    file_name= '/home/ubuntu/RASP_Workspace/demo_files/C4+Amp/C4_MD2.xcos';
    [path,fname,extension]=fileparts(file_name);
    dirpwd = pwd()+'/';
    if(path ~= dirpwd) then
        cd(path);
        filebrowser();
    end
    clear scs_m;
    clear blk_objs;
    clear blk; 
    global scs_m;
    text_box_callback(handles)
    xcos(file_name);
endfunction

function file15_callback()
    global file_name path fname extension;

    unix_s('cp /home/ubuntu/rasp30/work/examples/Sigma_Delta/sigmadelta.xcos /home/ubuntu/RASP_Workspace/demo_files/Sigma_Delta/');
    file_name= '/home/ubuntu/RASP_Workspace/demo_files/Sigma_Delta/sigmadelta.xcos';
    [path,fname,extension]=fileparts(file_name);
    dirpwd = pwd()+'/';
    if(path ~= dirpwd) then
        cd(path);
        filebrowser();
    end
    clear scs_m;
    clear blk_objs;
    clear blk; 
    global scs_m;
    text_box_callback(handles)
    xcos(file_name);
endfunction

function file28_callback()
    global file_name path fname extension;

    unix_s('cp /home/ubuntu/rasp30/work/examples/Sigma_Delta/sigmadelta2.xcos /home/ubuntu/RASP_Workspace/demo_files/Sigma_Delta/');
    file_name= '/home/ubuntu/RASP_Workspace/demo_files/Sigma_Delta/sigmadelta2.xcos';
    [path,fname,extension]=fileparts(file_name);
    dirpwd = pwd()+'/';
    if(path ~= dirpwd) then
        cd(path);
        filebrowser();
    end
    clear scs_m;
    clear blk_objs;
    clear blk; 
    global scs_m;
    text_box_callback(handles)
    xcos(file_name);
endfunction

function up1_callback()

    global path;
    messagebox(["Once you press OK, RASP Tools will update." "Please wait for the update confirmation message to appear."],"Update to Begin" , "info", "modal");
    if(path ~= "") then
        unix_s('cd; sudo chown ubuntu:ubuntu rasp30/ -R')


        unix_s('cd; svn update rasp30; cd '+path);
    else
        unix_s('cd; sudo chown ubuntu:ubuntu rasp30/ -R')
        unix_s('cd; svn update rasp30');
    end
    messagebox(["RASP Tools is updated." "Scilab will now close for the changes to take effect in RASP Tools." "Please restart RASP Tools."],"Update Complete!" , "info", "modal");

    sleep(1000);
    quit;
endfunction

function up2_callback()

    global path;   
    messagebox(["Once you press OK, RASP Tools will reset itself." "Please wait for the reset confirmation message to appear."],"Reset to Begin" , "info", "modal");

    if(path ~= "") then
        unix_s('cd; sudo chown ubuntu:ubuntu rasp30/ -R')
        unix_s('cd; rm ~/rasp30 -rf; svn co https://github.com/sumagin/rasp30/trunk ~/rasp30/; cd '+path);
    else
        unix_s('cd; sudo chown ubuntu:ubuntu rasp30/ -R')
        unix_s('cd; rm ~/rasp30 -rf; svn co https://github.com/sumagin/rasp30/trunk ~/rasp30/');
    end
    messagebox(["RASP Tools has been reset." "Scilab will now close for the changes to take effect in RASP Tools." "Please restart RASP Tools."],"Reset Complete!" , "info", "modal");

    sleep(1000);
    quit;
endfunction

function doc1_callback()
    [a,b]=unix_g('acroread /home/ubuntu/rasp30/sci2blif/documentation/30board.pdf &'); 
    if b == 1 then
        messagebox("Install Adobe Reader via the Documents menu. ", "Adode Reader not installed yet!", "scilab")
    end
endfunction

function doc2_callback()
    [a,b]=unix_g('acroread /home/ubuntu/rasp30/sci2blif/documentation/30aboard.pdf &'); 
    if b == 1 then
        messagebox("Install Adobe Reader via the Documents menu. ", "Adode Reader not installed yet!", "scilab")
    end  
endfunction

function doc3_callback()
    [a,b]=unix_g('acroread /home/ubuntu/rasp30/sci2blif/documentation/VM_FPAA_setup.pdf &');  
    if b == 1 then
        messagebox("Install Adobe Reader via the Documents menu. ", "Adode Reader not installed yet!", "scilab")
    end 
endfunction

function doc4_callback()
    [a,b]=unix_g('acroread /home/ubuntu/rasp30/sci2blif/documentation/demo_block_discussion.pdf &');  
    if b == 1 then
        messagebox("Install Adobe Reader via the Documents menu. ", "Adode Reader not installed yet!", "scilab")
    end 
endfunction

function doc5_callback()
    [a,b]=unix_g('acroread /home/ubuntu/rasp30/sci2blif/documentation/blockappearance.pdf &');   
    if b == 1 then
        messagebox("Install Adobe Reader via the Documents menu. ", "Adode Reader not installed yet!", "scilab")
    end
endfunction

function doc6_callback()
    global path
    disp('Initiating Install...')
    unix_g('sudo apt-get update');
    disp('Step 1 of 3')
    unix_g('sudo apt-get -y install gdebi'); 
    unix_g('sudo apt-get -y install libgnome2-0');
    disp('Step 2 of 3') 
    unix_g('cd /home/ubuntu/rasp30/sci2blif/documentation && sudo gdebi -n AdbeRdr9.5.5-1_i386linux_enu.deb');
    disp('Step 3 of 3') 
    unix_s('cd '+path); 
    messagebox(['When you select a document to view, please wait for the End User Agreement window to appear and Press OK.'],'Adobe Reader is now installed!', "info");
endfunction

function gui1_callback()
    exec('/home/ubuntu/rasp30/sci2blif/fpaacal.sce',-1)
endfunction

function gui2_callback()
    exec('/home/ubuntu/rasp30/sci2blif/curswp.sce',-1)
endfunction

function gui3_callback()
    exec('/home/ubuntu/rasp30/sci2blif/dig_gui.sce',-1)
endfunction

function gui4_callback()
    exec("/home/ubuntu/rasp30/sci2blif/level2to1_gui.sce");
endfunction

function etc1_callback(handles)
    global file_name path fname extension
    hid_dir=path+'.'+fname;
    if isdir(hid_dir) then
        unix_s('mv ' + hid_dir+'/' +fname + '.pads '+ path); 
        unix_s('rm -rf ' + hid_dir);
        disp('Misc. files have been deleted from your current directory.');
    else
        disp('There is no hidden folder in your current directory to delete.'); 
    end
endfunction

function etc2_callback(handles)
    global file_name path fname extension
    clc
    disp('Programming...');
    hid_dir=path+'.'+fname;
    unix_s('cp ' + hid_dir+'/input_vector '+ path); 
    exec("~/rasp30/prog_assembly/libs/scilab_code/MakeProgramlilst_CompileAssembly.sce",-1);
    exec('/home/ubuntu/rasp30/prog_assembly/libs/scilab_code/finetune_program_ver00_gui.sce', -1);
    exec('/home/ubuntu/rasp30/prog_assembly/libs/scilab_code/dc_setup_gui.sce', -1);
    disp('DC setup done');
    //unix_s('rm ' + path +'input_vector');
    disp("Programming Completed...Ready to Take Data"); 
endfunction

function etc3_callback(handles)
    fignums = [3 10:18 20:28 30:38 40:48 50:58 60:68 70:78 101 2 4:9]
    delfig = intersect(winsid(),fignums)
    if delfig ~= [] then
        for i = 1:length(delfig)
            xdel(delfig(i));
        end
        disp('All programming graphs are now closed.');
    else
        disp('There are no programming graphs to close.'); 
    end
endfunction

function etc5_callback(handles)
    global showprog
    showprog = 1;
endfunction

function etc6_callback(handles)
    global showprog
    showprog = 0;
endfunction

function etc7_callback(handles)
    [amm_opt, amm_con] = unix_g('sudo chmod 777 /dev/prologix');   
    if amm_con then
        messagebox(["Prologix GPIB-USB Controller is not connected under the VM Devices tab." "Please select Prologix and initiate again."],"Ammeter is not Connected via USB Devices" , "info", "modal");
    else
        disp("Ammeter has been initiated.")
    end
endfunction 

csvpath="/home/ubuntu/RASP_Workspace";

function etc9_callback(handles)
    global csvdata
    [filename, pathname] = uigetfile(["*.csv*"], csvpath, "Choose the CSV to Load");
    if(filename ~= "") then
        csvdata = csvRead(pathname+'/'+filename);
        csvpath = pathname;
        disp("Data has been stored in variable: csvdata")
    end
    csvpath=resume(csvpath)
endfunction 

function etc10_callback(handles)

    csvdir=uigetdir("/home/ubuntu/RASP_Workspace", "Choose a directory.")
    if ~(isempty(csvdir)) then
        csvf = x_mdialog("CSV File Setup",['Name of variable';'Name for CSV file'],['';'']);
        if ~(isempty(csvf(1))) & ~(isempty(csvf(2))) then
            csvWrite(evstr(csvf(1)),csvdir+"/"+csvf(2)+'.csv')
            disp(csvf(2)+'.csv has been created in your chosen directory.')
        end
    end
endfunction

function arb_msg()
    usevar=messagebox(["This design contains an Arbitrary Waveform Generator Block."...
    "It requires a variable that contains the input signal(s)."...
    "You have the option to use a pre-defined variable or create your own."...
    "Will you create your own variable via the Scilab Console?"], "modal", "info", ["Yes" "No"]);
    if usevar == 1 then
        usevar=messagebox(["Do not forget to type your variable name in the Arbitrary Waveform Generator Block."],"info");
    end
endfunction

function arb_msg2()
    messagebox(["The AWG block requires a variable that contains the input signal(s)."...
    "You need to create your own variable via the Scilab Console."...
    "Do not forget to type your variable name in the Arbitrary Waveform Generator Block."], "Arbitrary Waveform Generator (AWG) Block","modal");
endfunction

function com_prep()
    clear scs_m;
    clear blk_objs;
    clear blk; 
    global scs_m;
    text_box_callback(handles)
endfunction
