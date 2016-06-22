function block=lpf_func(block,flag)
    if flag ==1
        r = 1:block.ipar(1)
        block.outptr(1)(r)=block.x(r)
    elseif flag==0
        j = 1:block.ipar(1)
        block.xd(j)=(block.inptr(1)(j)-block.x(j))./block.rpar(j);
    end
endfunction 

