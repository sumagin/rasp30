function [x,y,typ]=vmm16x16_sr(job,arg1,arg2)
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
            [ok,in_num,out_num,weight_1,weight_2,weight_3,weight_4,weight_5,weight_6,weight_7,weight_8,fix_loc_yn,fix_loc_1,fix_loc_2,exprs]=getvalue('Set VMM_16x16 Parameters',['No. of vmm16x16 inputs';'No. of vmm16x16 outputs';'Weight (1~8,1~4)';'Weight (9~16,1~4)';'Weight (1~8,5~8)';'Weight (9~16,5~8)';'Weight (1~8,9~12)';'Weight (9~16,9~12)';'Weight (1~8,13~16)';'Weight (9~16,13~16)';'Fix_location_Y_or_N';'col';'row'],list('vec',1,'vec',1,'vec',-1,'vec',-1,'vec',-1,'vec',-1,'vec',-1,'vec',-1,'vec',-1,'vec',-1,'vec',1,'vec',1,'vec',1),exprs)

            if ~ok then break,end

            if ok then
                model.in=[1;1;1;1]
                model.out=[1;1;1;1]
                model.ipar=[in_num,out_num,fix_loc_yn,fix_loc_1,fix_loc_2]
                model.rpar=[weight_1;weight_2;weight_3;weight_4;weight_5;weight_6;weight_7;weight_8]
                graphics.exprs=exprs;
                x.graphics=graphics;x.model=model
                break
            end
        end
    case 'define' then
        in_num =16
        out_num =16
        weight_1 =[50E-09 50E-09 50E-09 50E-09 50E-09 50E-09 50E-09 50E-09 50E-09 50E-09 50E-09 50E-09 50E-09 50E-09 50E-09 50E-09 50E-09 50E-09 50E-09 50E-09 50E-09 50E-09 50E-09 50E-09 50E-09 50E-09 50E-09 50E-09 50E-09 50E-09 50E-09 50E-09]
        weight_2 =[50E-09 50E-09 50E-09 50E-09 50E-09 50E-09 50E-09 50E-09 50E-09 50E-09 50E-09 50E-09 50E-09 50E-09 50E-09 50E-09 50E-09 50E-09 50E-09 50E-09 50E-09 50E-09 50E-09 50E-09 50E-09 50E-09 50E-09 50E-09 50E-09 50E-09 50E-09 50E-09]
        weight_3 =[50E-09 50E-09 50E-09 50E-09 50E-09 50E-09 50E-09 50E-09 50E-09 50E-09 50E-09 50E-09 50E-09 50E-09 50E-09 50E-09 50E-09 50E-09 50E-09 50E-09 50E-09 50E-09 50E-09 50E-09 50E-09 50E-09 50E-09 50E-09 50E-09 50E-09 50E-09 50E-09]
        weight_4 =[50E-09 50E-09 50E-09 50E-09 50E-09 50E-09 50E-09 50E-09 50E-09 50E-09 50E-09 50E-09 50E-09 50E-09 50E-09 50E-09 50E-09 50E-09 50E-09 50E-09 50E-09 50E-09 50E-09 50E-09 50E-09 50E-09 50E-09 50E-09 50E-09 50E-09 50E-09 50E-09]
        weight_5 =[50E-09 50E-09 50E-09 50E-09 50E-09 50E-09 50E-09 50E-09 50E-09 50E-09 50E-09 50E-09 50E-09 50E-09 50E-09 50E-09 50E-09 50E-09 50E-09 50E-09 50E-09 50E-09 50E-09 50E-09 50E-09 50E-09 50E-09 50E-09 50E-09 50E-09 50E-09 50E-09]
        weight_6 =[50E-09 50E-09 50E-09 50E-09 50E-09 50E-09 50E-09 50E-09 50E-09 50E-09 50E-09 50E-09 50E-09 50E-09 50E-09 50E-09 50E-09 50E-09 50E-09 50E-09 50E-09 50E-09 50E-09 50E-09 50E-09 50E-09 50E-09 50E-09 50E-09 50E-09 50E-09 50E-09]
        weight_7 =[50E-09 50E-09 50E-09 50E-09 50E-09 50E-09 50E-09 50E-09 50E-09 50E-09 50E-09 50E-09 50E-09 50E-09 50E-09 50E-09 50E-09 50E-09 50E-09 50E-09 50E-09 50E-09 50E-09 50E-09 50E-09 50E-09 50E-09 50E-09 50E-09 50E-09 50E-09 50E-09]
        weight_8 =[50E-09 50E-09 50E-09 50E-09 50E-09 50E-09 50E-09 50E-09 50E-09 50E-09 50E-09 50E-09 50E-09 50E-09 50E-09 50E-09 50E-09 50E-09 50E-09 50E-09 50E-09 50E-09 50E-09 50E-09 50E-09 50E-09 50E-09 50E-09 50E-09 50E-09 50E-09 50E-09]
        fix_loc_yn = 0;
        fix_loc_1 = 0;
        fix_loc_2 = 0;
        model=scicos_model()
        model.in=[1;1;1;1]
        model.in2=[1;1;1;1]
        model.intyp=[-1;-1;-1;-1;]
        model.out=[1;1;1;1]
        model.out2=[1;1;1;1]
        model.outtyp=[-1;-1;-1;-1]
        model.ipar=[in_num,out_num,fix_loc_yn,fix_loc_1,fix_loc_2]
        model.rpar=[weight_1;weight_2;weight_3;weight_4;weight_5;weight_6;weight_7;weight_8]
        model.blocktype='d'
        model.dep_ut=[%f %t]

        exprs=[sci2exp(in_num);sci2exp(out_num);sci2exp(weight_1);sci2exp(weight_2);sci2exp(weight_3);sci2exp(weight_4);sci2exp(weight_5);sci2exp(weight_6);sci2exp(weight_7);sci2exp(weight_8);sci2exp(fix_loc_yn);sci2exp(fix_loc_1);sci2exp(fix_loc_2)]
        gr_i=['txt=''vmm_16x16_sr'';';'xstringb(orig(1),orig(2),txt,sz(1),sz(2),''fill'')']
        x=standard_define([10 4],model,exprs,gr_i)
    end
endfunction
