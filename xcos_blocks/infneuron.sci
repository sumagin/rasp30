function [x,y,typ]=infneuron(job,arg1,arg2)
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
        graphics=arg1.graphics;
        exprs=graphics.exprs
        model=arg1.model;
        while %t do
            [ok,gbias,fbias, nbias, exprs]=getvalue('Set Integrate and Fire Neuron Parameters',['Gain Bias'; 'Feedback Bias'; 'Neuron Bias'],list('vec',1,'vec',1,'vec',1),exprs)
            if ~ok then break,end
            if ok then
                model.rpar = [gbias;fbias;nbias]
                graphics.exprs=exprs
                x.graphics=graphics;x.model=model
                break
            end
        end
    case 'define' then
        gbias = 1.5e-6
        fbias = 1e-6
        nbias = 1e-6
        model= scicos_model()
        model.sim=list('infneuron_c',5)
        model.in=[-1;-1;-1]
        model.in2=[1;1;1]
        model.intyp=[-1;-1;-1]
        model.out=-1
        model.out2=1
        model.outtyp=-1
        model.evtin=[]
        model.evtout=[]
        model.state=[]
        model.dstate=[]
        model.rpar = [gbias;fbias;nbias]
        model.ipar=[]
        model.blocktype='c' 
        model.firing=[]
        model.dep_ut=[%f %t]
        exprs=[sci2exp(gbias) ;sci2exp(fbias);sci2exp(nbias)];
        gr_i= ['text=[INF Neuron];';'xstringb(orig(1),orig(2),text,sz(1),sz(2),''fill'');']
        x=standard_define([5 3],model,exprs,gr_i)
    end
endfunction
