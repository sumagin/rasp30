function [x,y,typ]=h_rect(job,arg1,arg2)
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
            [ok,in_out_num,ibias,exprs]=getvalue('Set h_rect Parameters',['Number of h_rect blocks';'ibias'],list('vec',1,'vec',-1),exprs)
            if ~ok then break,end            
            if ok then
                model.in=[in_out_num;in_out_num]
                model.out=in_out_num
                model.ipar=[in_out_num]
                model.rpar=[ibias]
                graphics.exprs=exprs;
                x.graphics=graphics;x.model=model
                break
            end
        end
    case 'define' then
        in_out_num=1
        ibias =1E-06
        model=scicos_model()
        model.sim=list('h_rect_c',5)
        model.in=[in_out_num;in_out_num]
        model.in2=[1;1]
        model.intyp=[-1;-1]
        model.out=-1
        model.out2=-1
        model.outtyp=-1
        model.ipar=[in_out_num]
        model.rpar=[ibias]
        model.blocktype='c'
        model.dep_ut=[%f %t]

        exprs=[sci2exp(in_out_num); sci2exp(ibias)]
        gr_i=['txt=''h_rect '';';'xstringb(orig(1),orig(2),txt,sz(1),sz(2),''fill'')']
        x=standard_define([5 2],model,exprs,gr_i)
    end
endfunction
