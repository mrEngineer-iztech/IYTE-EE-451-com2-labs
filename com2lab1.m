d=0.005;
f1=500; f2=2000;
fs1=36000; fs2=12000; fs3=6000;

t1=0:1/fs1:d;
t2=0:1/fs2:d;
t3=0:1/fs3:d;

x1=cos(2*pi*f1*t1)+sin(2*pi*f2*t1);
x2=cos(2*pi*f1*t2)+sin(2*pi*f2*t2);
x3=cos(2*pi*f1*t3)+sin(2*pi*f2*t3);

figure(1)
subplot(311); plot(t1,x1);title('fs1');
subplot(312); plot(t2,x2);title('fs2');
subplot(313); plot(t3,x3);title('fs3');

N=length(x1);
ff1=linspace(-fs1/2,fs1/2,N);
fftx1=abs(fftshift(fft(x1,N))/N);
N1=length(x2);
ff2=linspace(-fs2/2,fs2/2,N1);
fftx2=abs(fftshift(fft(x2,N1))/N1);
N2=length(x3);
ff3=linspace(-fs3/2,fs3/2,N2);
fftx3=abs(fftshift(fft(x3,N2))/N2);

figure(2)
subplot(311); plot(ff1,fftx1);
subplot(312); plot(ff2,fftx2);
subplot(313); plot(ff3,fftx3);

figure(3)
int1=interp1(t2,x2,t1,'spline');
int2=interp1(t2,x2,t1,'lnear');

int3=interp1(t3,x3,t1,'spline');
int4=interp1(t3,x3,t1,'linear');

subplot(411);
plot(t2,x2,'o',t1,int1);
hold on
plot(t1,x1);
subplot(412);
plot(t2,x2,'x',t1,int2);
hold on
plot(t1,x1);
subplot(413);
plot(t3,x3,'o',t1,int3)
hold on
plot(t1,x1);
subplot(414);plot(t3,x3,'o',t1,int4);
hold on
plot(t1,x1);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fs4=8000;   n1=2; n2=4; n3=7;

t4=0:1/fs4:4.9902;
y= audioread('speech_dft_8kHz.wav');
%sound(y,fs4);
%y1=transpose(y);
a=min(y);
b=max(y);
xq1=floor(((y-a)/(b-a)*(2^n1-1)))*(b-a)/(2^n1-1)+a;
xq2=floor(((y-a)/(b-a)*(2^n2-1)))*(b-a)/(2^n2-1)+a;
xq3=floor(((y-a)/(b-a)*(2^n3-1)))*(b-a)/(2^n3-1)+a;

% sound(xq1);
% sound(xq2);
% sound(xq3);

figure(4)
subplot(311); plot(t4,xq1);
xlabel('N=2');
ylabel('AMP');
subplot(312); plot(t4,xq2);
xlabel('N=4');
ylabel('AMP');
subplot(313); plot(t4,xq3);
xlabel('N=7');
ylabel('AMP');

figure(5)
subplot(311);plot(t4,y,t4,xq1); title('N=2');
subplot(312);plot(t4,y,t4,xq2); title('N=4');
subplot(313);plot(t4,y,t4,xq3); title('N=7');

figure(6)
d1=y-xq1; d2=y-xq2; d3=y-xq3;
subplot(311); plot(t4,d1); title('N=2');
subplot(312); plot(t4,d2); title('N=4');
subplot(313); plot(t4,d3); title('N=7');











