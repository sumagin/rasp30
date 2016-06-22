function block=newblock_c(block,flag)
    if flag==1 //Output(s) of Block are updated
        //Variables
        block.outptr(1)(1)=block.inptr(1)*4;
    elseif flag==0 //ODEs are detailed
        //variables and ODE
        //where abc is some index
        //block.xd(abc)= something
    end
endfunction

//Reference Website:
//                http://help.scilab.org/docs/5.5.0/en_US/sci_struct.html
//                http://www.scicos.org/HELP/eng/scicos/C_struct.htm
