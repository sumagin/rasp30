function [x,y,typ]=adc(job,arg1,arg2)
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
        while %t do
            [ok,exprs]=scicos_getvalue('Set ADC Block',exprs)

            if ~ok then break,end

            if ok then
                model.sim=list('adc_c',5)
                graphics.exprs=exprs;
                x.graphics=graphics;
                x.model=model
                break;
            end

        end
    case 'define' then
        model=scicos_model()
        model.sim=list('adc_c',5)
        model.in=-1
        model.intyp=-1
        model.blocktype='d'
        model.dep_ut=[%t %f]

        exprs=" "
        gr_i=['txt='' ADC '';';'xstringb(orig(1),orig(2),txt,sz(1),sz(2),''fill'')']
        x=standard_define([5 2],model, exprs,gr_i)
    end
endfunction
