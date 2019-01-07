clear all;
close all;
M=2;    fs=8000; fd=500;
t=0:1/fs:0.5;

r = randi([0,1],1,1000);

for i=1:1000
    if r(i) == 1
        r(i)=1;
    else
        r(i)= -1;
    end
end
%  figure(1)
%  plot(r);
 h1 = rcosdesign(0.1,6,8000/500);
 h2 = rcosdesign(1,6,8000/500);
 
 N=length(h1);
 ff1=linspace(-fs/2,fs/2,N);
 fftx1=abs(fftshift(fft(h1,N))/N);
 N=length(h2);
 ff2=linspace(-fs/2,fs/2,N);
 fftx2=abs(fftshift(fft(h2,N))/N);

 figure(2)
 
 subplot(221);plot(h1); title(' time domain =0.1');
 subplot(222);plot(h2);title(' time domain =1');
 subplot(223); plot(ff1,fftx1);title(' frequency domain =0.1');
 subplot(224); plot(ff2,fftx2);title(' frequency domain =1');
 
 txsig1=upfirdn(r,h1,8000/500);
 txsig2=upfirdn(r,h2,8000/500);
 
 rx1 = awgn(txsig1,7,'measured'); 
 rx2 = awgn(txsig2,7,'measured');
 
 yout1=upfirdn(rx1,h1,1,8000/500);
 yout2=upfirdn(rx2,h2,1,8000/500);
%  yout3=upfirdn(rx1,h2,8000/500);
%  yout4=upfirdn(rx2,h2,8000/500);

 y01=yout1(1,7:end-6);
 y02=yout2(1,7:end-6);
 
 eyediagram(y01,16,1/fs,0);
 eyediagram(y02,16,1/fs,0);
   

