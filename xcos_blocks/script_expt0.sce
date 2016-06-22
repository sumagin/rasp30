//load "ota.sci"
//load "ota_func.sci"
//***********************************
//SCRIPT TO READ FROM MODEL FILE
//***********************************
cd /usr/lib/scicoslab-gtk-4.4.1/macros/scicos_blocks/cadsp/
//LOAD OBJECT FILE
clear scs_m;
clear 
load "expt0.cos";
disp("Hello World");

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
for i =1:no
    if(length(scs_m.objs(i) )==8)  then 
        disp("Scicos_link block ",i);
        //LINK BLOCK CODE
        numoflink=numoflink+1;
        link_name(1,numoflink)=i;
    elseif ( length(scs_m.objs(i) )==1) then
        disp("deleted block",i);
    else
        disp ("Obj code ",i);
        blk(j,1)=i;
        //blk(j,2)=scs_m.objs(i).gui
        blk_name.entries(j)=scs_m.objs(i).gui;
        j=j+1;
        numofblk=numofblk+1;
        
        if(length(scs_m.objs(i).model.in)>numofip) then
            numofip=length(scs_m.objs(i).model.in);
            disp("Yeehoo :",i)
        end;

        if(length(scs_m.objs(i).model.out)>numofop) then
            numofop=length(scs_m.objs(i).model.out);
        end; 
    end;
end;

numofio=numofip+numofop;//blknumber+ip+op
disp("Greatest number of inputs", numofip);
disp("Greatest number of outputs", numofop);
disp("Number of blocks", numofblk);
disp("Number of links", numoflink);

blk=[blk,zeros(numofblk,numofio)]
link_blk=link_name(1, 1:numoflink)

for m=1:numoflink
    curblk=scs_m.objs(link_blk(1,m)).from(1,1);
    for r=1:numofblk
        if(blk(r,1)==curblk) then
            outofblk=scs_m.objs(link_blk(1,m)).from(1,2);
            idx=1+numofip+outofblk;
            blk(r,idx)=net;blk
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
  

//COMPARE OBJECT NAME TO FIND CORRESP. NETLIST
//if scs_m.objs(1).gui== "ota_new" then 
//  disp("Hurray!"),..
//  //OPEN FILE TO WRITE NETLIST
// fd_w= mopen ("./netlist.txt",'wt')
//  //mputl(".INCLUDE fpaa_tech.sp",fd_w);
//  mputl(".model ota",fd_w)
//  mputl(".inputs vinp vinn",fd_w)
//  mputl(".outputs vout",fd_w)
//  mputl(".blackbox",fd_w)
//  mputl(".end",fd_w)
//  //mputl("Xota Vp vout vout OTA PARAMS: Ib=1e-6",fd_w);
//  mclose(fd_w);
//  disp("Done writing!")
//  
//  else disp("Bummer!"),..
//  end
//  //READ FROM WRITTEN FILE
//  fd_2= mopen ("./netlist.txt",'rt')
//  mgetl(fd_2);
//  mclose(fd_2);
//  disp("DOne reading!");

