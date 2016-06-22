function [x,y,typ]=vdd_i(job,arg1,arg2)
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
            [ok,volt,exprs]=scicos_getvalue('Set VDD Block',['Set Input Voltage'],list('vec',-1),exprs)

            if ~ok then break,end

            if ok then
                model.rpar = volt;
                model.sim=list('vdd_c',5)
                graphics.exprs=exprs;
                x.graphics=graphics;
                x.model=model
                break;
            end

        end
    case 'define' then
        volt= 2.5
        model=scicos_model()
        model.sim=list('vdd_c',5)
        model.out=-1
        model.outtyp=-1
        model.rpar = volt
        model.blocktype='d'
        model.dep_ut=[%t %f]

        exprs=sci2exp(volt)
        gr_i=['txt='' VDD '';';'xstringb(orig(1),orig(2),txt,sz(1),sz(2),''fill'')']
        x=standard_define([3 2],model, exprs,gr_i)
    end
endfunction
