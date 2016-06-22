function [x,y,typ]=peakdet_block(job,arg1,arg2)
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
            [ok,in_out_num,xx,ib,caps,exprs]=getvalue('Set Peak Detector Parameters',..
            ['Number of Peak Detector Blocks';'State';'Ib (A)';'Capacitance 64fF [1-6X]'],..
            list('vec',1,'vec',-1,'vec',-1,'vec',-1),exprs)

            if ~ok then break,end
            
            if length(xx) ~= in_out_num then
                message('The number of initial state values that you have entered does not match the number of Peak Detector blocks.');
                ok=%f;
            end
            if length(ib) ~= in_out_num then
                message('The number of current values that you have entered does not match the number of Peak Detector blocks.');
                ok=%f;
            end
            if length(caps) ~= in_out_num then
                message('The number of capacitance values that you have entered does not match the number of Peak Detector blocks.');
                ok=%f;
            end


            if ok then
                model.in=in_out_num
                model.out=in_out_num
                model.ipar=in_out_num
                model.rpar = [ib;caps]
                model.state = xx
                graphics.exprs=exprs;
                x.graphics=graphics;x.model=model
                break
            end
        end
    case 'define' then
        in_out_num=1
        state= 0
        Ib = 0.5*10^(-9)
        C = 6
        model=scicos_model()
        model.sim=list('peakdet_func',5)
        model.in=[in_out_num;in_out_num]
        model.in2=[1;1]
        model.intyp=-1
        model.out=in_out_num
        model.out2=1
        model.outtyp=-1
        model.ipar=in_out_num
        model.rpar = [Ib;C]
        model.state= state
        model.nzcross=1;
        model.blocktype='c'
        model.dep_ut=[%f %t]

        exprs=[sci2exp(in_out_num); sci2exp(state) ; sci2exp(Ib); sci2exp(C)]
        gr_i=['txt=''Peak Detector'';';'xstringb(orig(1),orig(2),txt,sz(1),sz(2),''fill'')']
        x=standard_define([5 2],model,exprs,gr_i)
    end
endfunction
