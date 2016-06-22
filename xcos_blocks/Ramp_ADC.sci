function [x,y,typ]=Ramp_ADC(job,arg1,arg2)
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
        graphics=arg1.graphics
        model=arg1.model
        exprs=graphics.exprs
    case 'define' then
        model=scicos_model()
        model.sim=list('RampADC_func',5)
        model.in=-1
        model.intyp=-1
        model.blocktype='d'
        model.dep_ut=[%t %f]

        exprs=" "
        gr_i=['txt='' Ramp ADC '';';'xstringb(orig(1),orig(2),txt,sz(1),sz(2),''fill'')']
        x=standard_define([3 2],model, exprs,gr_i)
    end
endfunction
