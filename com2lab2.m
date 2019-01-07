fs =80; ts=1;
t=0:1/fs:ts;
t1=0:1/fs:ts/2;
t2=ts/2:1/fs:ts;
k=length(t);

s0=heaviside(t);
s2=heaviside(t1);
s3=(-1)*heaviside(t2);

t3= [t1 t2];
s1= [s2 s3];



figure(1)
subplot(211);plot(t,s0,'LineWidth',2);
subplot(212);plot(t3,s1,'LineWidth',2);

x1 = random('Normal',0,1,1,80);
r0=zeros(1,80);
for i=1:80
   r0(i)=s0(i)+x1(i);
end

figure(2)
fu=correlator(r0,s0);
%plot(t3,fu);

function z=correlator(y,x)
sum=0;

for i=1:80
    sum=sum+y(i)*x(i); 
    z(i)=sum;
end
end


