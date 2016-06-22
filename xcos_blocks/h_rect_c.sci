function block=h_rect_c(block,flag)
    if flag==1
        //Variables - beg Sahil/Michelle/Sihwan/Suma for ODEs
        block.outptr(1)(1)=block.inptr(1)*4;
    elseif flag==0
        //variables and ODE
        //block.xd(abc)= something
    end
endfunction
