kStep = 0.001;
k = -2:kStep:(2-kStep);
v1 = 0.2*rand(size(k));
v2 = 0.2*rand(size(k));

s1 = 2.^(-(k.^2)./2);
s1 = 0.5*sin(k*4);
s2 = 2.^(-(k.^2)./4);
sig1 = s1 + 0.5*(randn(length(s1),1) + 1j*randn(length(s1),1));
sig2 = s2 + 0.5*(randn(length(s2),1) + 1j*randn(length(s2),1));

subplot(6,1,1)
plot(k, s1, k, s2,'g-')
subplot(6,1,2)
plot(k, real(sig1), k, real(sig2))

b = conj(s1(end:-1:1));
c = conj(s2(end:-1:1));
y1 = filter(b,1,sig1);
y21 = filter(b,1,sig2);
y22 = filter(c,1,sig2);

subplot(6,1,3)
%plot(k,y1)

%Plot magnitudes of matched filter outputs
plot(k,abs(y1),'b-')
title('Matched Filter Output')
xlim([min(k) max(k)])

subplot(6,1,4)
plot(k,abs(y21),'b-')
title('Matched Filter Output')
xlim([min(k) max(k)])

snr(y1, sig1);
snr(y21, sig2);
snr(y22, sig2);

fprintf('Loss in SNR: %d\n', snr(real(y22), real(sig2)) - snr(real(y21), real(sig2)));

%wav = getMatchedFilter(waveform);

