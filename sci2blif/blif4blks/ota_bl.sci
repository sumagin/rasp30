function ota_bl() //fd_w, blk, blk_objs,bl
    mputl("# ota",fd_w);
    ota_i=1;
    ota_str= '.subckt ota in[0]=net' + string(blk(blk_objs(bl),2))+"_" + string(ota_i)+' in[1]=net'+ string(blk(blk_objs(bl),3))+"_" + string(ota_i)+' out[0]=net'+ string(blk(blk_objs(bl),2+numofip))+"_" + string(ota_i)+" #ota_bias =" +string(sprintf('%1.12f',scs_m.objs(blk_objs(bl)).model.rpar(1)));
    mputl(ota_str,fd_w);
    mputl("  ",fd_w)
endfunction
