s = [ 1 0 1 1 0 0 1 0 1 0 ] ;
Fs = 30e3 ;
fc = 1e3 ;
Ts = 10e-3 ;
t = 0 : 1/Fs : Ts ;
c = sin(2*pi*fc*t);
T = [t t t t t t t t t t];
L = length(t);
for i=1:length(s)
    if s(i)==0
        s_signal(1+(i-1)*L : i*L) = 0 ;
    else
        s_signal(1+(i-1)*L : i*L) = 1 ;
    end
    tt(1+(i-1)*L : i*L) = t + Ts*(i-1) ;
end


for i=1:length(s)
    if s(i)==0
       s_ASK(1+(i-1)*L : i*L) = 0 ;
    else
       s_ASK(1+(i-1)*L : i*L) = c ;
    end
end

ASK_modulated = awgn(s_ASK,10,'measured') ;

%%%%demodulation

for i=1:length(s)
    correlation = sum(s_ASK(1+(i-1)*L : i*L).*c) ;
    if correlation > 1/4
        demodulated(1+(i-1)*L : i*L) = 1 ;
    else
        demodulated(1+(i-1)*L : i*L) = 0 ;
    end
end

figure(1)
subplot(4,1,1)
plot(tt,s_signal);
title('bit sequence s');
axis([0 0.1 -2 2]);
subplot(4,1,2)
plot(tt,s_ASK);
axis([0 0.1 -2 2]);
title('ASK modulated signal');
subplot(4,1,3)
plot(tt,ASK_modulated);
title('ASK modulated with noise');
axis([0 0.1 -2 2]);
subplot(4,1,4)
plot(tt,demodulated);
title('demodulated');
axis([0 0.1 -2 2]);


%%%%% 2. BPSK

for i=1:length(s)
    if s(i)==0
       s_PSK(1+(i-1)*L : i*L) = sin(2*pi*fc*t + pi/2) ;
    else
       s_PSK(1+(i-1)*L : i*L) = sin(2*pi*fc*t) ;
    end
end

PSK_modulated = awgn(s_PSK,10,'measured');

for i=1:length(s)
    correlation2 = sum(s_PSK(1+(i-1)*L : i*L).*c) ;
    if correlation2 > 1/4
        demodulated2(1+(i-1)*L : i*L) = 1 ;
    else
        demodulated2(1+(i-1)*L : i*L) = 0 ;
    end
end

figure(2)
subplot(4,1,1)
plot(tt,s_signal);
title('bit sequence s');
axis([0 0.1 -2 2]);
subplot(4,1,2)
plot(tt,s_PSK);
axis([0 0.1 -2 2]);
title('PSK modulated signal');
subplot(4,1,3)
plot(tt,PSK_modulated);
title('PSK modulated with noise');
axis([0 0.1 -2 2]);
subplot(4,1,4)
plot(tt,demodulated2);
title('demodulated');
axis([0 0.1 -2 2]);