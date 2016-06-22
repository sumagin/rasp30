function [x,y,typ]=ota(job,arg1,arg2)
    x=[];y=[];typ=[];
    select job
    case 'plot' then standard_draw(arg1);
    case 'getinputs' then [x,y,typ]=standard_inputs(arg1);
    case 'getoutputs' then [x,y,typ]=standard_outputs(arg1);
    case 'getorigin' then [x,y]=standard_origin(arg1);
    case 'set' then
        x=arg1;
        graphics=arg1.graphics;
        exprs=graphics.exprs;
        model=arg1.model;
        while %t do
            //[ok,ibias,linrge, exprs]=getvalue('Set OTA block parameters', ['Ibias';'Linear Range'],list('vec',-1,'vec',-1),exprs);
            [ok,num_of_blk,ibias,exprs]=getvalue('Set OTA block parameters', ['No. of OTAs';'Ibias'],list('vec',1,'vec',-1),exprs);
            if ~ok then break,end
            if ok then
                model.ipar=[num_of_blk];
                //model.rpar=[ibias,linrge];
                model.rpar=[ibias];
                graphics.exprs=exprs;
                x.graphics=graphics;
                x.model=model;
                break;
            end
        end
    case 'define' then
        num_of_blk=1;
        //linrge=2;
        ibias=1e-6;
        model=scicos_model();
        model.sim=list('ota_func',5);
        model.in=[1;1];
        model.in2=[1;1];
        model.intyp=[-1;-1];
        model.out=-1;
        model.out2=1;
        model.outtyp=-1;
        //model.rpar=[ibias,linrge];
        model.ipar=[num_of_blk];
        model.rpar=[ibias];
        model.blocktype='c';
        model.dep_ut=[%t %f];

        //exprs=[sci2exp(ibias);sci2exp(linrge)];
        exprs=[sci2exp(num_of_blk);sci2exp(ibias)];
        gr_i=['text=[''OTA''];';'xstringb(orig(1),orig(2),text,sz(1),sz(2),''fill'');'];
        x=standard_define([6 3],model,exprs,gr_i);
    end
endfunction
