function block=hystdiff_c(block,flag)
    if flag==1
        //Variables - beg Sihwan/Jen/Suma/Michelle/Sahil for ODEs
        block.outptr(1)(1)=block.inptr(1)*4;
    elseif flag==0
        //variables and ODE
        //block.xd(abc)= something
    end
endfunction
