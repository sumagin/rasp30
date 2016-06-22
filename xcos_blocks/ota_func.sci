function block=ota_func(block,flag)
    if flag==1 then
        for j=1:block.insz(1)
           block.outptr(1)(j)=block.inptr(1)(j);
        end
      end
    endfunction
    
