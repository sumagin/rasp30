function [x,y,typ]=CurrentstarvedInverter(job,arg1,arg2)
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
            [ok, in_out_num,INV_cs_NBIAS,INV_cs_PBIAS, exprs]=scicos_getvalue('New Block Parameter',['number of blocks','INV_cs_NBIAS','INV_cs_PBIAS'],list('vec',-1,'vec',-1,'vec',-1),exprs)
            
            if ~ok then break,end

            //Can check for consistency in the user's input or highlight a mistake

            if ok then
                // Any papermeters that may change 
                //can use set_io function: it updates the model and the graphic of a block by adjusting its input/output number size, type and data type & you can search for this function at www.scicos.org/Newblock.pdf
                model.ipar=in_out_num //always a list
                model.rpar= [INV_cs_NBIAS;INV_cs_PBIAS]
                graphics.exprs=exprs;
                x.graphics=graphics;
                x.model=model
                break;
            end

        end
        // case 'compile' - This case is available for Scilab compiler to call the interfacing functions of Scilab and Modelica blocks with the job 'compile' during the compilation process to improve checks/sets of some block parameters (like input/output sizes and types...) 
    case 'define' then
        in_out_num=1
				INV_cs_NBIAS=1e-6
				INV_cs_PBIAS=500e-9
        model=scicos_model()
        model.sim=list('CurrentstarvedInverter_c',5)
        model.in=[in_out_num;in_out_num] //first/row dimension
        model.in2=[-1;-1] //second/column dimension
        model.intyp=[-1;-1] 
        model.out=[in_out_num]
        model.out2=[-1]
        model.outtyp=[-1]
        model.rpar= [INV_cs_NBIAS;INV_cs_PBIAS] 
        model.ipar=in_out_num;
        model.blocktype='d'
        model.dep_ut=[%f %t] //[block input has direct feedthrough to output w/o ODE   block always active]

        exprs=[sci2exp(in_out_num);sci2exp(INV_cs_NBIAS);sci2exp(INV_cs_PBIAS)] // exprs MUST BE semicolon separated & sci2exp() also converts an expression to string
        gr_i=['txt='' Blank '';';'xstringb(orig(1),orig(2),txt,sz(1),sz(2),''fill'')']
        x=standard_define([7 2],model, exprs,gr_i) //Numbers define the width and height of block
    end
endfunction
