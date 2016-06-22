function [x,y,typ]=sigma_delta(job,arg1,arg2)
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
            [ok,in_out_num,gbias1,gbias2,fbias,exprs]=getvalue('Set ADC Parameters',..
            ['Number of ADC blocks';'Gain Bias 1';'Gain bias 2';'Feedback Bias'],list('vec',1,'vec',-1,'vec',-1,'vec',-1),exprs)

            if ~ok then break,end

            
            if length(gbias1) ~= in_out_num then
                message('The number of gain biasn that you have entered does not match the number of C4 blocks.');
                ok=%f;
            end
             if length(gbias2) ~= in_out_num then
                message('The number of gain biasp that you have entered does not match the number of C4 blocks.');
                ok=%f;
            end
            if length(fbias) ~= in_out_num then
                message('The number of feedback  biases that you have entered does not match the number of C4 blocks.');
                ok=%f;
            end
          
            if ok then
                model.in=[in_out_num;in_out_num;in_out_num]
                model.out=in_out_num
                model.ipar=in_out_num
                model.rpar = [gbias1;gbias2;fbias]
                model.state = zeros(2*in_out_num,1)
                graphics.exprs=exprs;
                x.graphics=graphics;x.model=model
                break
            end
        end
    case 'define' then
        gbias1 = 300e-9
        gbias2 = 300e-9
        fbias = 300e-9
        xx=zeros(2,1)
        in_out_num =1
        model=scicos_model()
        model.sim=list('sigma_delta',5)
        model.in=[in_out_num;in_out_num;in_out_num]
        model.in2=[1;1;1]
        model.intyp=[-1;-1;-1]
        model.out=in_out_num
        model.out2=1
        model.outtyp=-1
        model.rpar = [gbias1;gbias2;fbias]
        model.ipar=in_out_num
        model.state=xx
        model.blocktype='d'
        model.dep_ut=[%f %t]

        exprs=[sci2exp(in_out_num); sci2exp(gbias1) ; sci2exp(gbias2) ; sci2exp(fbias)]
        gr_i=['txt=''sigma_delta'';';'xstringb(orig(1),orig(2),txt,sz(1),sz(2),''fill'')']
        x=standard_define([12 5],model,exprs,gr_i)
    end
endfunction
