//load "ota.sci"
//load "ota_func.sci"
//***********************************
//SCRIPT TO READ FROM MODEL FILE
//***********************************
//cd /usr/lib/scicoslab-gtk-4.4.1/macros/scicos_blocks/cadsp/
//LOAD OBJECT FILE
//FILE PATHNAME


clear blk_objs;
clear blk;
global file_name
 load(file_name)
disp("Hello World");
vpr_path='/home/ubuntu/Downloads/vtr_release/vtr_flow/';
//get filename, path and extension
[path,fname,extension]=fileparts(file_name)
deletefile(fname+'.blif') 
//Loading array vectors
//CHECK FOR SCICOS LINK OBJECTS
//global variable to store
numofip=0;
numofop=0;
numofblk=0;
numoflink=0;
inps=0;
accblk=1;
blk_name=cell([1,1]);
link_blk=cell([1,1]);
no=length(scs_m.objs);
link_name=zeros(1,no);
j=1;
net=1;
objnum=1;
ip_count=1;//primary input count
op_count=1;//primary output count
prime_ips=[];
prime_ops=[];
blk_objs=[];


for i =1:no
    if(length(scs_m.objs(i) )==8)  then 
       // disp("Scicos_link block ",i);
        //LINK BLOCK CODE
        numoflink=numoflink+1;
        link_name(1,numoflink)=i;
    elseif ( length(scs_m.objs(i) )==1) then
        //disp("deleted block",i);
    else
        //disp ("Obj code ",i);
        blk(j,1)=i;
        //blk(j,2)=scs_m.objs(i).gui
        if(scs_m.objs(i).gui== "IN_f") then
          prime_ips(ip_count)=j;
          ip_count=ip_count+1;//primary ip count
          blk_name.entries(j)=  strcat([scs_m.objs(i).gui ,scs_m.objs(i).graphics.exprs(1,1)])
        elseif   (scs_m.objs(i).gui== "OUT_f") then
          prime_ops(op_count)=j;
          op_count=op_count+1;
          blk_name.entries(j)=  strcat([scs_m.objs(i).gui ,scs_m.objs(i).graphics.exprs(1,1)]) 
        else    
        blk_name.entries(j)=scs_m.objs(i).gui;
        //if (scs_m.objs(i).gui ~= "IN_f" | scs_m.objs(i).gui ~= "OUT_f")then
        blk_objs(objnum)=j; //BLOCK NUMBER actually stored
        objnum=objnum+1;
        //end
        
        end
    
        j=j+1;
        numofblk=numofblk+1;
        
        
    //end
    
        if(length(scs_m.objs(i).model.in)>numofip) then
            numofip=length(scs_m.objs(i).model.in);
            //disp("Yeehoo :",i)
        end;

        if(length(scs_m.objs(i).model.out)>numofop) then
            numofop=length(scs_m.objs(i).model.out);
        end; 
    end;
end;

numofio=numofip+numofop;//blknumber+ip+op
//disp("Greatest number of inputs", numofip);
//disp("Greatest number of outputs", numofop);
//disp("Number of blocks", numofblk);
//disp("Number of links", numoflink);

blk=[blk,zeros(numofblk,numofio)];
link_blk=link_name(1, 1:numoflink);

for m=1:numoflink
    curblk=scs_m.objs(link_blk(1,m)).from(1,1);
    for r=1:numofblk
        if(blk(r,1)==curblk) then
            outofblk=scs_m.objs(link_blk(1,m)).from(1,2);
            idx=1+numofip+outofblk;
            blk(r,idx)=net;
            break;
        end
    end
    curblk=scs_m.objs(link_blk(1,m)).to(1,1);
    for r=1:numofblk
        if(blk(r,1)==curblk) then
            inofblk=scs_m.objs(link_blk(1,m)).to(1,2);
            idx=1+inofblk;
            blk(r,idx)=net;
            net=net+1;
            break;
        end
    end
end
// primary input string

prime_ip_string= '.inputs net'+ string(blk(prime_ips(1),2+numofip));
for s=2: length(prime_ips)
    prime_ip_string=strcat([prime_ip_string," net",string(blk(prime_ips(s),2+numofip)) ]);
  end

  //primary o/p string
  prime_op_string= '.outputs net'+ string(blk(prime_ops(1),2));
for s=2: length(prime_ops)
    prime_op_string= prime_op_string + ' net'+ string(blk(prime_ops(s),2));
  end
    
disp("blk_objs",blk_objs);

disp("blk",blk);
disp("numips",numofip);
//Writing output .blif file
 fd_w= mopen (fname+'.blif','wt')
 //filename= basename('./expt2.cos')
  mputl(strcat([".model"," ",fname])  ,fd_w);
  mputl(prime_ip_string,fd_w)
  mputl(prime_op_string,fd_w)
   mclose(fd_w);
   
   //other stuff
   fl_name= basename(file_name)+'.blif'
  fd_w= mopen (fl_name,'a')
  for bl=1:length(blk_objs)
    if(blk_name.entries(bl)=='ota_2')  then
         mputl("# ota",fd_w)
        ota_str= '.subckt ota in[0]= net' + string(blk(blk_objs(bl),2)) + ' in[1]= net'+ string(blk(blk_objs(bl),3)) + ' out=net'+ string(blk(blk_objs(bl),2+numofip))
        mputl(ota_str,fd_w);
        //mputl(".blackbox",fd_w);
     //end;//ifota
     
 //elseif(blk_name.entries(bl) ~='IN_f' | blk_name.entries(bl) ~='OUT_f') then
elseif (blk_name.entries(bl) =='div2') then
    cd(vpr_path)
    digifl='div2.blif'
    unix_g(' perl scripts/run_vtr_flow.pl benchmarks/verilog/divBy2.v vpr_rasp3/rasp3_arch.xml -ending_stage scripts -no_mem')
    unix_g('cp temp/div*  .') 
    unix_g('pwd ') 
    unix_g('bash genblif.sh ') 
    cd(path)
    unix_g('cp '+vpr_path+digifl+' . -rf')
    fext=fname+'.blif'
    unix_g('cat '+digifl+' >> '+fext)
  end;
  end;//for
  mputl(".end",fd_w)
  mputl("  ",fd_w)
  mclose(fd_w);
  unix_g('cat analg_arch.sce >> expt2.blif ')
  disp("Done writing!")




