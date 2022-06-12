function BER=equalize(alg,modu,Nt,Nr)
%MMSE equalization algo
loop=1000;
num=120;
EbNo=0:25; %signal to noise ratio
idx=1;
%decide the modulation scheme
if strcmpi(modu,'BPSK')
    BITS=1;
end
if strcmpi(modu,'QPSK')
    BITS=2;
end 
if strcmpi(modu,'16QAM')
    BITS=4;
end
if strcmpi(modu,'64QAM')
    BITS=6;
end

for SNR=EbNo
    errors=zeros(1,loop);
    for i=1:loop
        x=randn(1,num*Nt)>0; %introduce the input signal
        tx_bits=reshape(x,Nt,num); %assign the signal to each antenna 
        %modulate the transmission signal
        for a1=1:Nt
            tx_modu(a1,:)=modulation(tx_bits(a1,:),BITS);
        end
        %add gaussian white noise to the channel to simulate the noise encounter during transmission
        H=(randn(Nr,Nt)+j*randn(Nr,Nt))/sqrt(2);
        [m,n]=size(tx_modu);
        spow=sum(sum(abs(tx_modu).^2))/(m*n);
        attn=0.5*spow/10.^(SNR/10);
        attn=sqrt(attn);
        inoise=(randn(Nt,num/BITS)+j*randn(Nt,num/BITS))*attn;
        r=H*tx_modu+inoise;
        %MMSE equalization
        if strcmpi(alg,'MMSE')
            G=inv(H'*H+Nt/(10^(0.1*SNR))*eye(Nt))*H';
        end
        rx_equal=G*r;
        %demodulation
        rx_deci=decision(rx_equal,BITS);
        for a2=1:Nt
            rx_demodu(a2,:)=demodulation(rx_deci(a2,:),BITS);
        end
        %calculate the BER
        errors(i)=sum(sum(rx_demodu~=tx_bits))/(Nt*num);
    end
    BER(idx)=sum(errors)/loop; %the final BER after 1000 loops
    idx=idx+1;
end