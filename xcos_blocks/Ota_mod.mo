model Ota_mod "OTA"
//  parameter Real OLGain=1000 "Open Loop gain";
//  parameter Real SatH=10  "Positive saturation voltage";
//  parameter Real SatL=-10 "Negative Saturation voltage";

  Pin in_p "Positive pin of the input port";
  Pin in_n "Negative pin of the input port";
  Pin out "Output pin";
    
    Real V1;
    Real V2;
    Real I1;
    Real I2;
    Real Iout;
    
equation    

  in_p.i = 0;
  in_n.i = 0;
  V1=in_p.v ;
  V2=in_n.v;
  Vout=out.v;
  Iout=out.i;
  I1=Ibias*(0.5+0.5*tanh(K*(V1-V2)/2*UT));
  I2=Ibias*(0.5-0.5*tanh(K*(V1-V2)/2*UT));
  Iout=I1*(1-exp(-(Vdd-Vout)/UT))-I2*(1-exp(-Vout/UT));
  
  //in_p.v=I0*exp(Vg-VT);
  //der(V)=I0*exp(Vs-VT)*(exp(Vg-UT))
  //der(out.v)=(Ibias/C)*tanh((in_p.v-in_n.v)/VL);
  //out.i=in_p.i-in_n.i;
  //C*der(out.v)=out.i;
  //I=Ith*exp((Vdd-K*Vg-VT)/UT)*(exp(-Vdd-Vs-VT));
  
end Ota_mod;
