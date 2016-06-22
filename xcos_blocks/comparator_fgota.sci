function [x,y,typ]=comparator_fgota(job,arg1,arg2)
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
            [ok,num_of_blk, ibias, p_ibias,n_ibias,smcap,exprs]=getvalue('Set FG OTA Parameters',['No. of FG OTAs';'Ibias';'P Ibias'; 'N Ibias';'Use small cap Yes-1 No-0'],list('vec',1,'str',-1,'str',-1,'str',-1,'vec',-1),exprs);
            if ~ok then break,end
            if num_of_blk ~= 1 then
                if ((size(evstr(ibias),'r') ~= num_of_blk) & (size(evstr(ibias),'c') ~= num_of_blk)) | ((size(evstr(p_ibias),'r') ~= num_of_blk) & (size(evstr(p_ibias),'c') ~= num_of_blk)) | ((size(evstr(n_ibias),'r') ~= num_of_blk) & (size(evstr(n_ibias),'c') ~= num_of_blk)) then 
                    message('The number of ibias/pbias/nbias values that you have entered does not match the number of Peak Detector blocks.');
                    ok=%f;
                end
            end
            if length(smcap) ~= num_of_blk then
                message('The number of small cap decision values that you have entered does not match the number of Peak Detector blocks.');
                ok=%f;
            end
            if ok then
                model.ipar=[num_of_blk smcap];
                model.rpar=[ibias,p_ibias,n_ibias];
                graphics.exprs=exprs;
                x.graphics=graphics;
                x.model=model;
                break
            end
        end
    case 'define' then
        num_of_blk=1;
        smcap = [0];
        ibias='10e-9';
        p_ibias='10e-9';
        n_ibias='10e-9 ';
        model=scicos_model();
        model.sim=list('ota_func',5);
        model.in=[1;1];
        model.in2=[1;1];
        model.intyp=[-1;-1];
        model.out=-1;
        model.out2=1;
        model.outtyp=-1;
        model.ipar=[num_of_blk smcap];
        model.rpar=[ibias,p_ibias,n_ibias];
        model.blocktype='c';
        model.dep_ut=[%t %f];

        exprs=[sci2exp(num_of_blk);ibias;p_ibias;n_ibias;sci2exp(smcap)];
        gr_i=['text=[''FG''];';'xstringb(orig(1),orig(2),text,sz(1),sz(2),''fill'');'];
        x=standard_define([7 3],model,exprs,gr_i);
    end
endfunction
