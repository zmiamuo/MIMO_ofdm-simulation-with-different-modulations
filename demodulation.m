function rx_demodu=demodulation(rx_deci,BITS)
%demodulate the signal after deciding which signal it is
len=length(rx_deci);
if BITS==1
    rx_demodu=(rx_deci+1)/2;
elseif BITS==2
    inp=reshape(rx_deci*sqrt(2),len,1);
    r=real(inp);
    i=imag(inp);
    outp=([r i]+1)/2;
    rx_demodu=reshape(outp',1,2*len);
elseif BITS==4
    table=[0 0;0 1;1 0;1 1];
    inp=reshape(rx_deci*sqrt(10),len,1);
    r=floor((real(inp)+5)/2);
    i=floor((imag(inp)+5)/2);
    outp1=table(r,:);
    outp2=table(i,:);
    outp=[outp1 outp2];
    rx_demodu=reshape(outp',1,4*len);
elseif BITS==6
    table=[0 0 0;0 0 1;0 1 0;0 1 1;1 0 0;1 0 1;1 1 0;1 1 1];
    inp=reshape(rx_deci*sqrt(42),len,1);
    r=floor((real(inp)+9)/2);
    i=floor((imag(inp)+9)/2);
    outp1=table(r,:);
    outp2=table(i,:);
    outp=[outp1 outp2];
    rx_demodu=reshape(outp',1,6*len);
end