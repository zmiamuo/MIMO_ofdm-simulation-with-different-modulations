function rx_deci=decision(rx_equal,BITS)
%decide the type of signal at the receiving end
if BITS==1
    rx_denor=rx_equal;
    rx_deci=sign(real(rx_denor));
elseif BITS==2
    rx_denor=rx_equal*sqrt(2);
    rx_deci=sign(real(rx_denor))+j*sign(imag(rx_denor));
    rx_deci=rx_deci/sqrt(2);
elseif BITS==4
    rx_denor=rx_equal*sqrt(10);
    r=real(rx_denor);
    i=imag(rx_denor);
    r_deci=(r>2)*3+(r<2 & r>0)+(r<0 & r>(-2))*(-1)+(r<(-2))*(-3);
    i_deci=(i>2)*3+(i<2 & i>0)+(i<0 & i>(-2))*(-1)+(i<(-2))*(-3);
    rx_deci=r_deci+j*i_deci;
    rx_deci=rx_deci/sqrt(10);
elseif BITS==6
    rx_denor=rx_equal*sqrt(42);
    r=real(rx_denor);
    i=imag(rx_denor);
    r_deci=(r>6)*7+(r<6 & r>4)*5+(r<4 & r>2)*3+(r<2 & r>0)+(r<0 & r>(-2))*(-1)+(r<(-2) & r>(-4))*(-3)+(r<(-4) & r>(-6))*(-5)+(r<(-6))*(-7);
    i_deci=(i>6)*7+(i<6 & i>4)*5+(i<4 & i>2)*3+(i<2 & i>0)+(i<0 & i>(-2))*(-1)+(i<(-2) & i>(-4))*(-3)+(i<(-4) & i>(-6))*(-5)+(i<(-6))*(-7);
    rx_deci=r_deci+j*i_deci;
    rx_deci=rx_deci/sqrt(42);
end