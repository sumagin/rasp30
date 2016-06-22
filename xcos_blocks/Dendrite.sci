function [x,y,typ]=Dendrite(job,arg1,arg2)
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
            [ok,ipsize,Wts,exprs]=scicos_getvalue('Set Dendrite Block',['Input Dimension [row,col]';'Current Matrix'],list('vec',-1,'mat',[-1,-2]),exprs)

            if ~ok then break,end

       

            if ok then
                num_st = size(Wts,2)
                model.opar=list(Wts);
                model.ipar=[size(Wts,2);ipsize'];
                model.in=[-1;-1;-1;-1] //first/row dimension
                model.in2=[-1;-1;-1;-1] //second/column dimension
                graphics.exprs=exprs;
                x.graphics=graphics;
                x.model=model
                break;
            end

        end
    case 'define' then
        ipsize=[4 4];
        Wts=[200.00e-09,200.00e-09,200.00e-09,200.00e-09,200.00e-09,200.00e-09,200.00e-09,200.00e-09,200.00e-09,200.00e-09,2.00e-11,200.00e-09,200.00e-09,2e-11,200.00e-09]
        num_st = size(Wts,2)
        model=scicos_model()
        model.sim=list('Dendrite_c',5)
        //model.in=[ipsize(1);ipsize(2)]
        //model.in2=[1;1]
        //model.intyp=[-1;-1]
        model.in=[-1;-1;-1;-1] //first/row dimension
        model.in2=[-1;-1;-1;-1] //second/column dimension
        model.intyp=[-1;-1;-1;-1] 
        model.out=[-1;-1;-1;-1]
        model.out2=[-1;-1;-1;-1]
        model.outtyp=[-1;-1;-1;-1]
        model.opar=list(Wts)
        model.ipar = [size(Wts,2);ipsize'];
        model.blocktype='d'
        model.dep_ut=[%f %t]
 
        exprs=[sci2exp(ipsize);sci2exp(Wts)]
        gr_i=['txt='' Dendrite '';';'xstringb(orig(1),orig(2),txt,sz(1),sz(2),''fill'')']
        x=standard_define([5 2],model, exprs,gr_i) //6 2
    end
endfunction
