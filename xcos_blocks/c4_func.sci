function block=c4_func(block,flag)
    if flag==1
        rr = 1:block.ipar(1)
        block.outptr(1)(rr)=block.x(2*rr-1) 
    elseif flag==0
        jj = 1:block.ipar(1)
        T = 1 ./(2*%pi*block.rpar(2*jj-1))
        tau2 = T./block.rpar(2*jj)
        tau1 =(T^2)./tau2
        a= -1 ./tau2
        b=1 ./tau1
        c=1 ./(tau1.*tau2)
        block.xd(2*jj-1)=block.x(2*jj)+a.*block.inptr(1)(jj);
        block.xd(2*jj)=-c.*block.x(2*jj-1)-b.*block.x(2*jj)-a.*b.*block.inptr(1)(jj);
    end
endfunction
