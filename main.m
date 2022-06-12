clear, clc

BER1=equalize('MMSE','16QAM',1 ,1);
BER2=equalize('MMSE','16QAM',2,2);
BER3=equalize('MMSE','16QAM',4,4);
BER4=equalize('MMSE','16QAM',8,8);
EbNo=0:25;

figure
semilogy(EbNo,BER1,'black-x');
hold on
semilogy(EbNo,BER2,'r-d');
hold on
semilogy(EbNo,BER3,'g-*');
hold on
semilogy(EbNo,BER4,'b-x');
hold on
xlabel('SNR [dB]');
ylabel('BER');
axis([0 25 1e-6 1]);
grid on
title('BER with different number of antennas using 16QAM Modulation');
legend('1x1-SISO','2x2-MIMO','4x4-MIMO','8x8-MIMO');
