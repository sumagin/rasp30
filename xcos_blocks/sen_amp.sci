function [x,y,typ]=sen_amp(job,arg1,arg2)
    // Copyright INRIA
    x=[];y=[];typ=[];
    select job
    case 'plot' then
        standard_draw(arg1)
    case 'getinputs' then //** GET INPUTS 
        [x,y,typ]=standard_inputs(arg1)
    case 'getoutputs' then
        [x,y,typ]=standard_outputs(arg1)
    case 'getorigin' then
        [x,y]=standard_origin(arg1)
    case 'set' then
        x=arg1;
        graphics=arg1.graphics;
        exprs=graphics.exprs
        model=arg1.model;
        while %t do
            [ok,in_out_num,obias,fgobias,fgonbias,fgopbias,vmmtrgt,exprs]=getvalue('Set VMM + Sense Amp block parameters',['Number of VMM + Sense Amp blocks';'Ota bias';'FG Ota bias';'FG Ota Neg bias';'FG Ota Pos bias';'Vmm Target'],list('vec',1,'vec',-1,'vec',-1,'vec',-1,'vec',-1,'row',-1),exprs)

            if ~ok then break,end

            if ok then
                model.in=[in_out_num;in_out_num]
                model.out=in_out_num
                model.ipar=in_out_num
                model.rpar=[obias,fgobias,fgonbias,fgopbias,vmmtrgt]
                graphics.exprs=exprs
                x.graphics=graphics;x.model=model
                break
            end
        end
    case 'define' then
        in_out_num =1
        obias= 2e-5;
        fgobias= 2e-7;
        fgonbias= 2e-7;
        fgopbias= 2e-7;
        vmmtrgt= [6e-5,5e-5];
        model=scicos_model()
        model.sim=list('ota_func',5)
        model.in=[in_out_num;in_out_num]
        model.in2=[1;1]
        model.intyp=[-1;-1]
        model.out=in_out_num
        model.out2=1
        model.outtyp=-1
        model.ipar=in_out_num
        model.rpar=[obias,fgobias,fgonbias,fgopbias,vmmtrgt]
        model.blocktype='c' 
        model.dep_ut=[%t %f]
        exprs=[sci2exp(in_out_num);string(obias);sci2exp(fgobias);sci2exp(fgonbias);sci2exp(fgopbias);sci2exp(vmmtrgt)];
        gr_i= ['text=[''Src'';'' Gate''];';'xstringb(orig(1),orig(2),text,sz(1),sz(2),''fill'');']
        x=standard_define([11 3],model,exprs,gr_i)
    end
endfunction
