function [x,y,typ]=SOS(job,arg1,arg2)
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
            [ok,in_out_num,ibias1,ibias2,ibiasfb,exprs]=getvalue('Set SOS Parameters',..
            ['Number of SOS blocks';'ibias1'; 'ibias2'; 'ibiasfb'],list('vec',1,'vec',-1,'vec',-1,'vec',-1),exprs)
            if ~ok then break,end            
            if ok then
                model.in=in_out_num
                model.out=in_out_num
                model.ipar=[in_out_num]
                model.rpar=[ibias1,ibias2,ibiasfb]
                graphics.exprs=exprs;
                x.graphics=graphics;x.model=model
                break
            end
        end
    case 'define' then
        in_out_num=1
        ibias1=500E-09
        ibias2=500E-09
        ibiasfb=800E-09
        model=scicos_model()
        model.sim=list('SOS_sim',5)
        model.in=-1
        model.in2=-1
        model.intyp=-1
        model.out=-1
        model.out2=-1
        model.outtyp=-1
        model.ipar=[in_out_num]
        model.rpar=[ibias1,ibias2,ibiasfb]
        model.blocktype='c'
        model.dep_ut=[%f %t]

        exprs=[sci2exp(in_out_num); sci2exp(ibias1) ; sci2exp(ibias2) ; sci2exp(ibiasfb) ]
        gr_i=['txt=''SOS '';';'xstringb(orig(1),orig(2),txt,sz(1),sz(2),''fill'')']
        x=standard_define([5 2],model,exprs,gr_i)
    end
endfunction
