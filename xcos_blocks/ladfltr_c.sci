function block=ladfltr_c(block,flag)
    if flag==1 
        k_n=block.rpar(1)
        k=1:k_n
        block.outptr(1)(k)= block.x(2:2:2*k_n);
    elseif flag==0 then
        k_n=block.rpar(1)
        j=2*k_n  
        block.xd(1)=(1/block.rpar(3))*(tanh((block.inptr(1)-block.x(2))/block.rpar(2)))
        if k_n > 1 then
            block.xd(2:(j-1))=(1/block.rpar(3))*(tanh((block.x(1:(j-2))-block.x(3:j))/block.rpar(2)))  
        end 
        block.xd(j)=(1/block.rpar(3))*(tanh(block.x(j-1)/block.rpar(2)))
    end
endfunction    
