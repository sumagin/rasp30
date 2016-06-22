function [x,y,typ]=vmm_wta_nbias(job,arg1,arg2)
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
            //[ok,ipsize,Wts,bufbias, pfetbias,lin_rng,tau_1, tau_a, tau_z, tau_b, exprs]=scicos_getvalue('Set VMM + WTA Block',['Input Dimension [row,col]';'Weight Matrix'; 'Buf_bias';'Pfet_bias';'Input Linear Range';'Tau 1 (s)'; 'Tau A (s)' ;'Tau Z (s)' ;'Tau B (s)' ],list('vec',-1,'mat',[-1,-2],'vec',1,'vec',-1,'vec',1,'vec',1,'vec',1,'vec',1,'vec',1),exprs)
            [ok,ipsize,Wts,bufbias, pfetbias, nbias, exprs]=scicos_getvalue('Set VMM + WTA Block',['Input Dimension [row,col]';'Weight Matrix'; 'Buf_bias';'Pfet_bias';'nbias';],list('vec',-1,'mat',[-1,-2],'vec',1,'vec',-1,'vec',1),exprs)

            if ~ok then break,end

            if ok then
                num_st = size(Wts,2)
                model.state=[zeros(num_st,1);0.5*ones(num_st,1);1;0.5*ones(num_st,1)]
                model.rpar= [bufbias;pfetbias';nbias];
                model.opar=list(Wts);
                model.ipar=[size(Wts,2);ipsize'];
                model.in=[1]
                model.in2=[1]
                model.out=size(Wts,2)
                model.out2=ipsize(1,2)
                graphics.exprs=exprs;
                x.graphics=graphics;
                x.model=model
                break;
            end

        end
    case 'define' then
        ipsize=[4 1];
        Wts=[4e-06,1e-09,1e-09,1e-09;1e-09,3e-06,3e-06,1e-09;1e-09,1e-09,1e-09,1e-09;1e-09,1e-09,1e-09,1e-09];
        bufbias = 2e-06;
        pfetbias = [8.5e-09 10.5e-09 10e-09 10e-09];
        nbias = 10e-9;
        num_st = size(Wts,2);
        model=scicos_model();
        //model.sim=list('vmm_wta_c',5)
        model.in=[1];
        model.in2=[1];
        model.intyp=[-1];
        model.out=size(Wts,2);
        model.out2=ipsize(1,2);
        model.outtyp=-1;
        model.opar=list(Wts);
        model.state=[zeros(num_st,1);0.5*ones(num_st,1);1;0.5*ones(num_st,1)];
        model.rpar= [bufbias;pfetbias';nbias];
        model.ipar = [size(Wts,2);ipsize'];
        model.blocktype='d'
        model.dep_ut=[%f %t]

        exprs=[sci2exp(ipsize);sci2exp(Wts);sci2exp(bufbias);sci2exp(pfetbias);sci2exp(nbias)]
        gr_i=['txt='' VMM + WTA '';';'xstringb(orig(1),orig(2),txt,sz(1),sz(2),''fill'')']
        x=standard_define([10 2],model, exprs,gr_i) //6 2
    end
endfunction
