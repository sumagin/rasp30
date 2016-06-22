function [x,y,typ]=vol_div(job,arg1,arg2)
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
        graphics=arg1.graphics;exprs=graphics.exprs
        model=arg1.model;
        while %t do
            [ok,in_out_num,fgotabias,pbias,mbias,ref_target,exprs]=getvalue('Set voltage divider Parameters',..
            ['Number of voltage divider blocks';'fgota bias'; 'ota plus bias'; 'ota minus bias'; 'reference target current'],list('vec',1,'vec',-1,'vec',-1,'vec',-1,'vec',-1),exprs)

            if ~ok then break,end

            if ok then
                model.in=[in_out_num;in_out_num]
                model.out=in_out_num
                model.ipar=in_out_num
                model.rpar = [fgotabias;pbias;mbias;ref_target]
                //model.state = xx
                graphics.exprs=exprs;
                x.graphics=graphics;x.model=model
                break
            end
        end
    case 'define' then
        in_out_num =1
        fgotabias = 2e-6
        pbias = 250e-6
        mbias = 245e-6
        ref_target = 20e-9
        model=scicos_model()
        //model.sim=list('c4_func',5)
        model.in=[in_out_num;in_out_num]
        model.in2=[1;1]
        model.intyp=[-1;-1]
        model.out=in_out_num
        model.out2=1
        model.outtyp=-1
        model.rpar = [fgotabias;pbias;mbias;ref_target]
        //model.state= state
        model.ipar=in_out_num
        model.blocktype='d'
        model.dep_ut=[%f %t]

        exprs=[sci2exp(in_out_num); sci2exp(fgotabias) ;sci2exp(pbias); sci2exp(mbias); sci2exp(ref_target)]
        gr_i=['txt=''C4 '';';'xstringb(orig(1),orig(2),txt,sz(1),sz(2),''fill'')']
        x=standard_define([8 3],model,exprs,gr_i)
    end
endfunction
