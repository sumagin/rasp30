function [x,y,typ]=pfet_gldn(job,arg1,arg2)
// Copyright INRIA
x=[];y=[];typ=[];
select job
case 'plot' then
  standard_draw(arg1)
   case 'getinputs' then //** GET INPUTS 
    [x,y,typ]=standard_inputs(arg1)
    case 'getoutputs' then
    [x,y,typ]=standard_outputs(arg1)
    case 'getorigin' then
    [x,y]=standard_origin(arg1)
    case 'set' then
    x=arg1;
    graphics=arg1.graphics;exprs=graphics.exprs
    model=arg1.model;
    if size(exprs,'*')==1 then exprs=[exprs;sci2exp(0)];end // compatibility
    while %t do
      [ok,gain,over,exprs]=getvalue('Set gain block parameters',..
			       ['Gain';..
				'Do On Overflow(0=Nothing 1=Saturate 2=Error)'],..
				list('mat',[-1,-1],'vec',1),exprs)
      if ~ok then break,end
      if gain==[] then
	message('Gain must have at least one element')
      else
        model.ipar=over // temporary storage removed in job compile
        model.opar(1)=gain
        ot=do_get_type(gain)
        if ot==1 then
          ot=-1
        elseif ot==2 then
           message("Complex type is not supported");
           ok=%f;
        end
        if ok then
          in=2
          out=1
          it=-ones(in,1)
          ot=-ones(out,1)
          inp=[-[1:in]',ones(in,1)]
          oup=[-[1:out]',ones(out,1)]
          [model,graphics,ok]=set_io(model,graphics,...
                               list(inp,it),...
                               list(oup,ot),[],[])
        end
	if ok then
	  graphics.exprs=exprs
	  x.graphics=graphics;x.model=model
	  break
	end
      end
    end
 
    case 'compile' then
    model=arg1
    ot=model.intyp
    if model.opar==list() then
       gain=model.rpar(1)  
    else
       gain=model.opar(1)
    end
    over=model.ipar
    model.ipar=[];
    if ot==1 then 
       model.rpar=double(gain(:));
       model.opar=list();
       model.sim=list('ota_c',5);
    else
      if ot==2 then
        error("Complex type is not supported");
      else
        select ot
        case 3
          model.opar(1)=int32(model.opar(1))
          supp1='i32'
        case 4
          model.opar(1)=int16(model.opar(1))
          supp1='i16'
        case 5
          model.opar(1)=int8(model.opar(1))
          supp1='i8'
        case 6
          model.opar(1)=int32(model.opar(1))
          supp1='ui32'
        case 7
          model.opar(1)=int16(model.opar(1))
          supp1='ui16'
        case 8
          model.opar(1)=int8(model.opar(1))
          supp1='ui8'
        else
          error("Type "+string(ot)+" not supported.")
        end
        select over
        case 0
          supp2='n'
        case 1
          supp2='s'
        case 2
          supp2='e'
        end
      end
      model.sim=list('gainblk_'+supp1+supp2,4)
    end
    x=model    

    case 'define' then
    model=scicos_model()
  junction_name='nfet';
  funtyp=4;
  model.sim=list(junction_name,funtyp)
  model.in=[-1;-1]
  model.in2=[-2;-3]
  model.intyp=[1 1]
  model.out=-1
  model.out2=0
  model.outtyp=-1
  model.evtin=[]
  model.evtout=[]
  model.state=[]
  model.dstate=[]
  model.rpar=[]
  model.ipar=[]
  model.blocktype='c' 
  model.firing=[]
  model.dep_ut=[%t %f]
  label=[sci2exp(2)];
  gr_i=['text=[''Src'';'' Gate''];';'xstringb(orig(1),orig(2),text,sz(1),sz(2),''fill'');']
  x=standard_define([6 3],model,label,gr_i)
  end
endfunction
