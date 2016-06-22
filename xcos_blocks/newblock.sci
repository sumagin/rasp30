function [x,y,typ]=newblock(job,arg1,arg2)
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
            [ok,in_out_num, name,exprs]=scicos_getvalue('New Block Parameter',['Number of New Blocks';'Name of Block'],list('vec',1,'str',-1),exprs)

            if ~ok then break,end

            //Can check for consistency in the user's input or highlight a mistake
            if in_out_num > 2 then
                message('No More Than Two Blocks!'); //or messagebox
                ok=%f;
            end

            if ok then
                model.opar=list(name) 
                model.ipar = in_out_num;
                graphics.exprs=exprs;
                x.graphics=graphics;
                x.model=model
                break;
            end

        end
        // case 'compile' - This case is available for Scilab compiler to call the interfacing functions of Scilab and Modelica blocks with the job 'compile' during the compilation process to improve checks/sets of some block parameters (like input/output sizes and types...) 
    case 'define' then
        in_out_num=1
        name= "Cad"
        model=scicos_model()
        //There are more subcategories of model and descriptions refer to help.scilab.org/docs/5.4.1/en_US/scicos_model.html
        //Any negative number tell Scilab to figure it out
        //Can delete or comment out any model category not being used
        model.sim=list('newblock_c',5)
        model.in=[-1;1] //first/row dimension
        model.in2=[1;1] //second/column dimension
        model.intyp=[-1;-1] 
        model.out=[-1]
        model.out2=[1]
        model.outtyp=[-1]
        model.opar=list(name) //always a list
        model.state=zeros(1,1)
        model.ipar = in_out_num;
        model.blocktype='d'
        model.dep_ut=[%f %t] //[block input has direct feedthrough to output w/o ODE   block always active]

        exprs=[sci2exp(in_out_num);name] // exprs MUST BE semicolon separated & sci2exp() also converts an expression to string
        gr_i=['txt='' Blank '';';'xstringb(orig(1),orig(2),txt,sz(1),sz(2),''fill'')']
        x=standard_define([10 3],model, exprs,gr_i) //Numbers define the width and height of block
    end
endfunction
