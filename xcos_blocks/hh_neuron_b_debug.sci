function [x,y,typ]=hh_neuron_b_debug(job,arg1,arg2)
    // Copyright INRIA
    x=[];y=[];typ=[];
    select job
    case 'plot' then
        standard_draw(arg1)
    case 'getinputs' then
        [x,y,typ]=standard_inputs(arg1)
    case 'getoutputs' then
        [x,y,typ]=standard_outputs(arg1)
    case 'getorigin' then
        [x,y]=standard_origin(arg1)
    case 'set' then
        x=arg1;
        graphics=arg1.graphics;
        exprs=graphics.exprs;
        model=arg1.model;
        while %t do
            [ok,in_out_num,in_fg_bias,in_fg_pbias,in_fg_nbias,fix_loc,exprs]=getvalue('Set shift register 1 input 16 output Parameters',['Number of Outputs';'in_fgota_bias';'in_fgota_pbias';'in_fgota_nbias';'Fix_location'],list('vec',1,'vec',1,'vec',1,'vec',1,'vec',-1),exprs);

            if ~ok then break,end

            if ok then
                model.in=[1;1;1;1];
                model.out=[1;1;1];
                model.ipar= [in_out_num;fix_loc'];
                model.rpar= [in_fg_bias;in_fg_pbias;in_fg_nbias];
                graphics.exprs=exprs;
                x.graphics=graphics;x.model=model;
                break
            end
        end
    case 'define' then
        in_out_num =1;
        in_fg_bias =10E-09;
        in_fg_pbias =100E-09;
        in_fg_nbias =10E-09;
        model=scicos_model();
        fix_loc=[0 0 0];
        //model.sim=list('c4_func',5)
        model.in=[1;1;1;1];
        model.in2=[1;1;1;1];
        model.intyp=[-1;-1;-1;-1];
        model.out=[1;1;1];
        model.out2=[1;1;1];
        model.outtyp=[-1;-1;-1];
        model.ipar= [in_out_num;fix_loc'];
        model.rpar= [in_fg_bias;in_fg_pbias;in_fg_nbias];
        model.blocktype='d'
        model.dep_ut=[%t %t]

        exprs=[sci2exp(in_out_num);sci2exp(in_fg_bias);sci2exp(in_fg_pbias);sci2exp(in_fg_nbias);sci2exp(fix_loc)]
        gr_i=['txt=''sr_1i_16o '';';'xstringb(orig(1),orig(2),txt,sz(1),sz(2),''fill'')']
        x=standard_define([8 3],model,exprs,gr_i)
    end
endfunction
