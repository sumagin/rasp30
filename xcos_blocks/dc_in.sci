function [x,y,typ]=dc_in(job,arg1,arg2)
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
            [ok,in_out_num,dc_values,exprs]=getvalue('Set DC Parameters',['Number of DC blocks';'DC values'],list('vec',1,'row',-1),exprs)

            if ~ok then break,end

            if ok then
                model.out=in_out_num
                model.ipar=in_out_num
                model.rpar = [dc_values]'
                graphics.exprs=exprs;
                x.graphics=graphics;x.model=model
                break
            end
        end
    case 'define' then
        in_out_num =1
        dc_values = 1.5
        model=scicos_model()
        model.sim=list('dc_in_c',5)
        model.out=-1
        model.out2=1
        model.outtyp=-1
        model.ipar=in_out_num
        model.rpar = [dc_values]
        model.blocktype='d'
        model.dep_ut=[%t %t]

        exprs=[sci2exp(in_out_num); sci2exp(dc_values)]
        gr_i=['txt=''DC_in '';';'xstringb(orig(1),orig(2),txt,sz(1),sz(2),''fill'')']
        x=standard_define([3 2],model,exprs,gr_i)
    end
endfunction
