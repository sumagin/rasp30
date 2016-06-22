function [x,y,typ]=dendiff(job,arg1,arg2)
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
            [ok,dsynapse,daxial,dleak,dvmem,exprs]=scicos_getvalue('Set dendritic diffuser block parameters',['Synaptic gate voltages';'Axial gate voltages';'Leakage gate voltages';'Membrane gate voltage'],list('str',-1,'str',-1,'str',-1,'str',-1),exprs)
            
            if ~ok then break,end

            //Can check for consistency in the user's input or highlight a mistake
//            if your_variable2 == 12 then
//                message('You have entered the number 12 for second variable.'); //or messagebox
//                ok=%f;
//            end
//
            if ok then
                // Any papermeters that may change 
                //can use set_io function: it updates the model and the graphic of a block by adjusting its input/output number size, type and data type & you can search for this function at www.scicos.org/Newblock.pdf
                model.opar=list(1,dsynapse,daxial,dleak,dvmem)
                //model.ipar = in_out_num;
                //model.rpar= Ibias;
                graphics.exprs=exprs;
                x.graphics=graphics;
                x.model=model
                break;
            end

        end
        // case 'compile' - This case is available for Scilab compiler to call the interfacing functions of Scilab and Modelica blocks with the job 'compile' during the compilation process to improve checks/sets of some block parameters (like input/output sizes and types...) 
    case 'define' then
		dsynapse='10e-9,10e-9,10e-9,10e-9,10e-9,10e-9'
		daxial='10e-9,10e-9,10e-9,10e-9,10e-9,10e-9'
		dleak='10e-9,10e-9,10e-9,10e-9,10e-9,10e-9'
		dvmem='100e-9'
        //Ibias = 0
        //in_out_num = 1
//        your_variable2 = 10
        model=scicos_model()
        //There are more subcategories of model and descriptions refer to help.scilab.org/docs/5.4.1/en_US/scicos_model.html
        //Any negative number tell Scilab to figure it out
        //Can delete or comment out any model category not being used
        model.sim=list('dendiff_c',5)
        model.in=[-1;-1;-1;-1;-1;-1] //first/row dimension
        model.in2=[-1;-1;-1;-1;-1;-1] //second/column dimension
        model.intyp=[-1;-1;-1;-1;-1;-1] 
        model.out=[-1]
        model.out2=[-1]
        model.outtyp=[-1]
		model.opar=list(1,dsynapse,daxial,dleak,dvmem)
//        model.state=zeros(1,1)
        //model.rpar= Ibias;
        //model.ipar = in_out_num;
        model.blocktype='d'
        model.dep_ut=[%f %t] //[block input has direct feedthrough to output w/o ODE   block always active]
        
        
        exprs=[dsynapse;daxial;dleak;dvmem]
//exprs=[sci2exp(in_out_num); sci2exp(Ibias)] // exprs MUST BE semicolon separated & sci2exp() also converts an expression to string
        gr_i=['txt='' Hysteretic Differentiator '';';'xstringb(orig(1),orig(2),txt,sz(1),sz(2),''fill'')']
        x=standard_define([12 5],model, exprs,gr_i) //Numbers define the width and height of block
    end
endfunction
