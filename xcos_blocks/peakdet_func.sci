function block=peakdet_func(block,flag)

    if flag==1
        r = 1:block.ipar(1)
        block.outptr(1)(r)=block.x(r)
    elseif flag==0
        A = 400
        kappa=0.7
        Ut=0.02585
        j = 1:block.ipar(1)
        row = length(block.ipar(1))
        expin = ((A*kappa*(block.inptr(1)(j)-block.x(j)))-block.x(j))/Ut
        expin_a = expin < -100*ones(row,1)
        expin_1=expin_a.*((-1)*(block.rpar(2*j-1)./block.rpar(2*j)));
        expin_b = expin > 10*ones(row,1)
        expin_2=expin_b.*((block.rpar(2*j-1)./block.rpar(2*j))*(exp(10)-1));
        expin_c = expin > -100*ones(row,1) & expin < 10*ones(row,1)
        expin_3=expin_c.*(block.rpar(2*j-1)./block.rpar(2*j)).*(exp(expin_c.*expin)-1); 
        block.xd(j)=expin_1+expin_2+expin_3
    end
endfunction
