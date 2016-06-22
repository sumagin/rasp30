function block=lpfota_c(block,flag)
    if flag ==1
        r = 1:block.ipar(1)
        block.outptr(1)(r)=block.x(r)
    elseif flag==0
        kap= 0.7;
        C = 5e-9;
        Ut = 0.256;
        j = 1:block.ipar(1)
        block.xd(j)=(block.rpar(j)/C).*tanh((kap*(block.inptr(1)(j)-block.x(j)))/(2*Ut))
    end
endfunction 

