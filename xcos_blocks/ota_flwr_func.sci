function block=ota_flwr_func(block,flag)
    kappa=0.7;
    Ut=25e-3;
if flag==1
block.outptr(1)(1)=block.x(1)
elseif flag==0
block.xd(1)=tanh((block.inptr(1)-block.x(1))*(kappa/2*Ut))*block.rpar;
elseif flag==2&block.nevprt==-1&block.jroot(1)<0
block.x(1)=-block.x(1)
elseif flag==9
block.g(1)=block.x(1)
end
endfunction
