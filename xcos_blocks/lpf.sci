function [x,y,typ]=lpf(job,arg1,arg2)
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
            [ok,in_out_num,ibias,cap1,exprs]=getvalue('Set LPF parameters', ['Number of LPF';'ibias';'Output Cap 64fF [1-6X] or [18X]'],..
            list('vec',1,'vec',-1,-1,-1),exprs)
            if ~ok then break,end
            
            if (cap1 == 0) | (cap1 > 18) then
                message('You have not entered a value 1-18.');
                ok=%f;
            end
            
            if ok then
                model.in=in_out_num
                model.out=in_out_num
                model.rpar=[in_out_num,ibias,cap1]
                graphics.exprs=exprs;
                x.graphics=graphics;x.model=model
                break
            end
        end
    case 'define' then
        in_out_num=1
        ibias=10E-09
        cap1=18
//        state= 0
//        tau = 0.5
        model=scicos_model()
        model.sim=list('lpf_func',5)
        model.in=-1
        model.in2=-1
        model.intyp=-1
        model.out=-1
        model.out2=-1
        model.outtyp=-1
//        model.ipar=in_out_num
//        model.rpar = tau
//        model.state= state
        model.rpar=[in_out_num,ibias,cap1]
//        model.nzcross=1;
        model.blocktype='c'
        model.dep_ut=[%f %t]

        exprs=[sci2exp(in_out_num); sci2exp(ibias) ; sci2exp(cap1)]
        gr_i=['txt=''LPF '';';'xstringb(orig(1),orig(2),txt,sz(1),sz(2),''fill'')']
        x=standard_define([5 2],model,exprs,gr_i)
    end
endfunction
