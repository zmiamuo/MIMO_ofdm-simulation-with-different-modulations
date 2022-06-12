function tx_modu=modulation(tx_bits,BITS)
%modulate the transmission signal on each antenna 
len=length(tx_bits);
%BPSK
if BITS==1
    table=[-1 1];
    inp=tx_bits;
    tx_modu=table(inp+1);
%QPSK
elseif BITS==2
    table=[-1-1i -1+1i 1-1i 1+1i]/sqrt(2);
    inp=reshape(tx_bits,2,len/2);
    tx_modu=table([2 1]*inp+1);
%16QAM
elseif BITS==4
    table=[-3-3j -3-j -3+j -3+3j -1-3j -1-j -1+j -1+3j 1-3j 1-j 1+j 1+3j 3-3j 3-j 3+j 3+3j]/sqrt(10);
    inp=reshape(tx_bits,4,len/4);
    tx_modu=table([8 4 2 1]*inp+1);
%64QAM
elseif BITS==6
    table=[-7-7j -7-5j -7-3j -7-j -7+j -7+3j -7+5j -7+7j...
    -5-7j -5-5j -5-3j -5-j -5+j -5+3j -5+5j -5+7j...
    -3-7j -3-5j -3-3j -3-j -3+j -3+3j -3+5j -3+7j...
    -1-7j -1-5j -1-3j -1-j -1+j -1+3j -1+5j -1+7j...
    1-7j 1-5j 1-3j 1-j 1+j 1+3j 1+5j 1+7j...
    3-7j 3-5j 3-3j 3-j 3+j 3+3j 3+5j 3+7j...
    5-7j 5-5j 5-3j 5-j 5+j 5+3j 5+5j 5+7j...
    7-7j 7-5j 7-3j 7-j 7+j 7+3j 7+5j 7+7j]/sqrt(42);
    inp=reshape(tx_bits,6,len/6);
tx_modu=table([32 16 8 4 2 1]*inp+1);

end