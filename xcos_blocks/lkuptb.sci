function [x,y,typ]=lkuptb(job,arg1,arg2)
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
            [ok,name,in_num,trcase,fix_loc,exprs]=scicos_getvalue('LookUp Table Parameters',['Name';'No. of Inputs';'True Conditions';'Fix_location'],list('str',-1,'vec',1,'str',-1,'vec',-1),exprs)
//,in_num 'Number of inputs (1-4)'; 'vec',1,
            if ~ok then break,end

//            if (in_num > 4) | (in_num < 1) then
//                message('LookUp Tables are only able to have 1-4 inputs.'); 
//                ok=%f;
//            end

            if ok then
                model.opar=list(name,trcase)
                //model.in=-ones(in_num,1) 
                //model.in2=ones(in_num,1) 
                //model.intyp=-ones(in_num,1)
                model.in=-[1:in_num]'
                model.intyp=-ones(in_num,1)
                model.ipar=in_num
                model.rpar= [fix_loc'];
                graphics.exprs=exprs;
                x.graphics=graphics;
                x.model=model
                break;
            end

        end
    case 'define' then
        in_num=4
        name='LookUp Table'
        trcase='01-- 10-- 11--'
        fix_loc=[0 0 0]
        model=scicos_model()
        model.sim=list('lkuptb_c',5)
        //model.in=-ones(in_num,1) 
        //model.in2=ones(in_num,1) 
        //model.intyp=-ones(in_num,1)
        model.in=-[1:in_num]'
        model.intyp=-ones(in_num,1)
        model.out=-1
        model.out2=1
        model.outtyp=-1
        model.ipar=in_num
        model.opar=list(name,trcase)
        model.rpar= [fix_loc'];
        model.state=zeros(1,1)
        model.blocktype='d'
        model.dep_ut=[%t %t] 

        exprs=[name;sci2exp(in_num);trcase;sci2exp(fix_loc)] //sci2exp(in_num);
        gr_i=['txt='' LookUp Table'';';'xstringb(orig(1),orig(2),txt,sz(1),sz(2),''fill'')']
        x=standard_define([7 3],model, exprs,gr_i) 
    end
endfunction
