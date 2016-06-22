function [x,y,typ]=c4_block(job,arg1,arg2)
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
            [ok,in_out_num,gbias,fbias,cap1,cap2,xx,ctr_freq,q,exprs]=getvalue('Set C4 Parameters',..
            ['Number of C4 blocks';'Gain Bias'; 'Feedback Bias'; 'Input Cap 64fF [1-6X]'; 'Feedback Cap 64fF [1-6X]';'State';'Center Frequency';'Q'],list('vec',1,'vec',-1,'vec',-1,'vec',-1,'vec',-1,'vec',-1,'vec',-1,'vec',-1),exprs)

            if ~ok then break,end

            if length(xx) ~= (2*in_out_num) then
                message('The number of state values that you have entered does not equal double the number of C4 blocks.');
                ok=%f;
            end
            if length(ctr_freq) ~= in_out_num then
                message('The number of center frequencies that you have entered does not match the number of C4 blocks.');
                ok=%f;
            end
            if length(q) ~= in_out_num then
                message('The number of Q values that you have entered does not match the number of C4 blocks.');
                ok=%f;
            end
            if (cap1 == 0) | (cap1 > 18) then
                message('You have not entered a value 1-6.');
                ok=%f;
            end
            if (cap2 == 0) | (cap2 > 6) then
                message('You have not entered a value 1-6.');
                ok=%f;
            end
//            if length(gbias) ~= in_out_num then
//                message('The number of center frequencies that you have entered does not match the number of C4 blocks.');
//                ok=%f;
//            end
//            if length(fbias) ~= in_out_num then
//                message('The number of Q values that you have entered does not match the number of C4 blocks.');
//                ok=%f;
//            end

            if ok then
                model.in=[in_out_num]
                model.out=in_out_num
                model.ipar=in_out_num
                model.rpar = [ctr_freq;q;gbias;fbias;cap1;cap2]
                model.state = xx
                graphics.exprs=exprs;
                x.graphics=graphics;x.model=model
                break
            end
        end
    case 'define' then
        gbias = 1.5e-6
        fbias = 1e-6
        cap1=3
        cap2=1
        in_out_num =1
        state= [0,0]
        CtrFreq = 1
        Q = 10
        model=scicos_model()
        model.sim=list('c4_func',5)
        model.in=[in_out_num]
        model.in2=[1]
        model.intyp=[-1]
        model.out=in_out_num
        model.out2=1
        model.outtyp=-1
        model.rpar = [CtrFreq;Q;gbias;fbias;cap1;cap2]
        model.state= state
        model.ipar=in_out_num
        model.blocktype='d'
        model.dep_ut=[%f %t]

        exprs=[sci2exp(in_out_num); sci2exp(gbias) ;sci2exp(fbias); sci2exp(cap1); sci2exp(cap2); sci2exp(state) ;sci2exp(CtrFreq); sci2exp(Q)]
        gr_i=['txt=''C4 '';';'xstringb(orig(1),orig(2),txt,sz(1),sz(2),''fill'')']
        x=standard_define([5 2],model,exprs,gr_i)
    end
endfunction
