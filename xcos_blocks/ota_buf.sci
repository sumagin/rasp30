function [x,y,typ]=ota_buf(job,arg1,arg2)
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
            [ok,buf_num, exprs]=getvalue('Set OTA Buffer block parameters',..
            ['Number of buffers'],list('vec',-1),exprs)
            if ~ok then break,end

            if ok then
                model.rpar(2)=[buf_num]
                graphics.exprs=exprs;
                x.graphics=graphics;x.model=model
                break
            end
        end
    case 'define' then
        buf_num=1
        ibias=2e-6
        model=scicos_model()
        model.sim=list('ota_func',5)
        model.in=-1
        model.in2=-1
        model.intyp=-1
        model.out=-1
        model.out2=-1
        model.outtyp=-1
        model.rpar=[ibias,buf_num]
        model.blocktype='c'
        model.dep_ut=[%t %f]

        exprs=[sci2exp(buf_num)]
        gr_i=['text=[''OTA Buffer''];';'xstringb(orig(1),orig(2),text,sz(1),sz(2),''fill'');']
        x=standard_define([5 2],model,exprs,gr_i)
    end
endfunction
