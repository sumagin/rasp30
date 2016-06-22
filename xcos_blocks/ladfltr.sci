function [x,y,typ]=ladfltr(job,arg1,arg2)
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
            [ok,k_n,vl,tau,exprs]=scicos_getvalue('Set Ladder Filter Block',['Number of Outputs';'Voltage Parameter (VL)';'Tau'],list('vec',1,'vec',1,'vec',1),exprs)

            if ~ok then break,end

            if ok then
                model.out=k_n
                model.rpar=[k_n;vl;tau]
                model.state=zeros(2*k_n,1)
                graphics.exprs=exprs;
                x.graphics=graphics;
                x.model=model
                break;
            end

        end
    case 'define' then
        k_n=2
        tau=1
        vl=1
        model=scicos_model()
        model.sim=list('ladfltr_c',5)
        model.in=1
        model.in2=1
        model.intyp=-1
        model.out=k_n
        model.out2=1
        model.outtyp=-1
        model.state=zeros(2*k_n,1)
        model.blocktype='d'
        model.dep_ut=[%t %t]

        exprs=[sci2exp(k_n);sci2exp(vl);sci2exp(tau)]
        gr_i=['txt='' Ladder Filter '';';'xstringb(orig(1),orig(2),txt,sz(1),sz(2),''fill'')']
        x=standard_define([6 3],model, exprs,gr_i)
    end
endfunction
