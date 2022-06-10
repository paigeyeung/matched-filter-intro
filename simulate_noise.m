x = linspace(-2*pi, 2*pi);
a = 0.2*rand(size(x));
plot(a)
hold on

b=sin(x);

g=real(ifft(fft(a).*fft(b)));
plot(b)

plot(g)
hold off