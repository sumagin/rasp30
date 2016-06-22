function [x,y,typ]=lpfota(job,arg1,arg2)
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
        graphics=arg1.graphics;exprs=graphics.exprs
        model=arg1.model;
        while %t do
            [ok,in_out_num,ibias,exprs]=getvalue('Set LPF block parameters',..
            ['Number of LPF Blocks';'Ibias'],list('vec',1,'row',-1),exprs)

            if ~ok then break,end
            
            if length(ibias) ~= in_out_num then
                message('The number of ibias values that you have entered does not match the number of LPF blocks.');
                ok=%f;
            end
            
            if ok then
                model.in=in_out_num
                model.out=in_out_num
                model.ipar=in_out_num
                model.rpar=ibias'
                model.state=zeros(1,in_out_num)
                graphics.exprs=exprs;
                x.graphics=graphics;x.model=model
                break
            end
        end
    case 'define' then
        in_out_num=1
        ibias=1e-6
        model=scicos_model()
        model.sim=list('lpfota_c',5)
        model.in=in_out_num
        model.in2=1
        model.intyp=-1
        model.out=in_out_num
        model.out2=1
        model.outtyp=-1
        model.rpar=ibias
        model.ipar=in_out_num
        model.state=0;
        model.blocktype='c'
        model.dep_ut=[%t %f]

        exprs=[sci2exp(in_out_num);sci2exp(ibias)]
        gr_i=['text=[''LPF''];';'xstringb(orig(1),orig(2),text,sz(1),sz(2),''fill'');']
        x=standard_define([5 2],model,exprs,gr_i)
    end
endfunction
