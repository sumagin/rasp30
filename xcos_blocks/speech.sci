function [x,y,typ]=speech(job,arg1,arg2)
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
            [ok,in_out_num,gbias,fbias,xx,exprs]=getvalue('Set speech Parameters',..
            ['Number of speech blocks';'Gain Bias'; 'Feedback Bias';'State'],list('vec',1,'vec',-1,'vec',-1,'vec',-1),exprs)

            if ~ok then break,end

            if length(xx) ~= (2*in_out_num) then
                message('The number of state values that you have entered does not equal double the number of C4 blocks.');
                ok=%f;
            end

            if ok then
                model.in=[in_out_num;in_out_num;in_out_num]
                model.out=[in_out_num;in_out_num]
                model.ipar=in_out_num
                model.rpar = [gbias;fbias]
                model.state = xx
                graphics.exprs=exprs;
                x.graphics=graphics;x.model=model
                break
            end
        end
    case 'define' then
        gbias = 1.5e-6
        fbias = 1e-6
        
        in_out_num =1
        state= [0,0]
        model=scicos_model()
        model.sim=list('speech_c',5)
        model.in=[in_out_num;in_out_num;in_out_num]
        model.in2=[1;1;1]
        model.intyp=[-1;-1;-1]
        model.out=[in_out_num;in_out_num]
        model.out2=[1;1]
        model.outtyp=[-1;-1]
        model.rpar = [gbias;fbias]
        model.state= state
        model.ipar=in_out_num
        model.blocktype='d'
        model.dep_ut=[%f %t]

        exprs=[sci2exp(in_out_num); sci2exp(gbias) ;sci2exp(fbias); sci2exp(state)]
        gr_i=['txt=''speech'';';'xstringb(orig(1),orig(2),txt,sz(1),sz(2),''fill'')']
        x=standard_define([9 2],model,exprs,gr_i)
    end
endfunction
