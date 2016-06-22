function [x,y,typ]=lpf_2(job,arg1,arg2)
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
            [ok,in_out_num,ibias1,ibias2,exprs]=getvalue('Set 2nd Order LPF Parameters',['Number of 2nd Order LPF blocks';'First Stage Bias';'Second Stage Bias'],list('vec',1,'vec',-1,'vec',-1),exprs)

            if ~ok then break,end


            if length(ibias1) ~= in_out_num then
                message('The number of first stage bias values that you have entered does not match the number of 2nd Order LPF blocks.');
                ok=%f;
            end
            if length(ibias2) ~= in_out_num then
                message('The number of second stage bias values that you have entered does not match the number of 2nd Order LPF blocks.');
                ok=%f;
            end
           
            if ok then
                model.in=in_out_num
                model.out=in_out_num
                model.ipar=in_out_num
                model.rpar = [ibias1;ibias2]
                model.state = zeros(2*in_out_num,1)
                graphics.exprs=exprs;
                x.graphics=graphics;x.model=model
                break
            end
        end
    case 'define' then
        ibias1 = 40e-9
        ibias2 = 40e-9
        xx=[0;0]
        in_out_num =1
        model=scicos_model()
        model.sim=list('lpf_2_c',5)
        model.in=in_out_num
        model.in2=-1
        model.intyp=-1
        model.out=in_out_num
        model.out2=-1
        model.outtyp=-1
        model.rpar = [ibias1;ibias2]
        model.ipar=in_out_num
        model.state=xx
        model.blocktype='d'
        model.dep_ut=[%f %t]

        exprs=[sci2exp(in_out_num); sci2exp(ibias1) ; sci2exp(ibias2)]
        gr_i=['txt=''2nd Order LPF '';';'xstringb(orig(1),orig(2),txt,sz(1),sz(2),''fill'')']
        x=standard_define([6 3],model,exprs,gr_i)
    end
endfunction
