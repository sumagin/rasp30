function [x,y,typ]=fgswitch(job,arg1,arg2)
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
            [ok,in_out_num,ibias,exprs]=scicos_getvalue('Set FG Switch Block',['Number of FG Switches';'Ibias'],list('vec',1,'vec',-1),exprs)

            if ~ok then break,end

            if ok then
                model.ipar=in_out_num
                model.rpar=ibias
                model.sim=list('fgswitch_c',5)
                graphics.exprs=exprs;
                x.graphics=graphics;
                x.model=model
                break;
            end

        end
    case 'define' then
        in_out_num = 1
        ibias = 5e-9
        model=scicos_model()
        model.sim=list('fgswitch_c',5)
        model.in=-1
        model.intyp=-1
        model.out=-1
        model.outtyp=-1
        model.ipar=in_out_num
        model.rpar=ibias
        model.blocktype='d'
        model.dep_ut=[%f %t]

        exprs=[sci2exp(in_out_num); sci2exp(ibias)] 
        gr_i=['txt='' FG Switch '';';'xstringb(orig(1),orig(2),txt,sz(1),sz(2),''fill'')']
        x=standard_define([5 2],model, exprs,gr_i)
    end
endfunction
