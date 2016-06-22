global file_name path fname extension chip_num board_num brdtype L1_name;

//////////
fcal=figure('figure_position',[400,400],'figure_size',[250,350],'auto_resize','on','background',[12],'figure_name','Generate Level1 block');
//////////
delmenu(fcal.figure_id,gettext('File'));
delmenu(fcal.figure_id,gettext('?'));
delmenu(fcal.figure_id,gettext('Tools'));
delmenu(fcal.figure_id,gettext('Edit'));
toolbar(fcal.figure_id,'off');
handles.dummy = 0;

handles.L1_block_name=uicontrol(fcal,'unit','normalized','BackgroundColor',[1,1,1],'Enable','on','FontAngle','normal','FontName','mukti narrow','FontSize',[14],'FontUnits','points','FontWeight','normal','ForegroundColor',[0,0,0],'HorizontalAlignment','center','ListboxTop',[],'Max',[1],'Min',[0],'Position',[0.15,0.724,0.7,0.1],'Relief','flat','SliderStep',[0.01,0.1],'String','Enter Block Name','Style','edit','Value',[0],'VerticalAlignment','middle','Visible','on','Tag','L1_block_name','Callback','L1_block_name_callback()');
handles.Generate_L1=uicontrol(fcal,'unit','normalized','BackgroundColor',[0.27,0.5,0.7],'Enable','on','FontAngle','normal','FontName','mukti narrow','FontSize',[14],'FontUnits','points','FontWeight','bold','ForegroundColor',[1,1,1],'HorizontalAlignment','center','ListboxTop',[],'Max',[1],'Min',[0],'Position',[0.15,0.578,0.7,0.1],'Relief','flat','SliderStep',[0.01,0.1],'String','Generate L1','Style','pushbutton','Value',[0],'VerticalAlignment','middle','Visible','on','Tag','Generate_L1','Callback','Generate_L1_callback()');

dir_menu = uimenu("Parent", fcal, "Label", gettext("Directions"), 'ForegroundColor',[0.53,0.81,0.98],"callback", "dir_callback();");

possible_elements();
