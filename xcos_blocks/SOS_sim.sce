function block=lpf_func(block,flag)
    if flag==1
        block.outptr(1)=block.x(1)
    elseif flag==0
        block.xd(1)=(block.inptr(1)(2)-block.x(1))/block.rpar;
        block.xd(2)=(block.inptr(1)(2)-block.x(1))/block.rpar;
    end
endfunction
