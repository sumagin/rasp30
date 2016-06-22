function [x,y,typ]=nfet_gldn(job,arg1,arg2)
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
            [ok,gain,over,exprs]=getvalue('Set NFET block parameters',['Gain';'Do On Overflow(0=Nothing 1=Saturate 2=Error)'],list('mat',[-1, -1],'vec',1),exprs)
            if ~ok then break,end
            if ok then
                graphics.exprs=exprs
                x.graphics=graphics;x.model=model
                break
            end
        end
    case 'define' then
        over=0
        gain=2
        model=scicos_model()
        model.sim=list('ota_func',5)
        model.in=[-1;-1]
        model.in2=[-2;-3]
        model.intyp=[1 1]
        model.out=-1
        model.out2=0
        model.outtyp=-1
        model.evtin=[]
        model.evtout=[]
        model.state=[]
        model.dstate=[]
        model.rpar=[]
        model.ipar=[]
        model.blocktype='c' 
        model.firing=[]
        model.dep_ut=[%t %f]
        exprs=[sci2exp(gain);sci2exp(over)];
        gr_i= ['text=[''Src'';'' Gate''];';'xstringb(orig(1),orig(2),text,sz(1),sz(2),''fill'');']
        x=standard_define([6 3],model,exprs,gr_i)
    end
endfunction
