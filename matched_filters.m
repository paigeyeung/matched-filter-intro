timeStep = 0.001;
time = 0:timeStep:(1-timeStep);

waveform1 = phased.LinearFMWaveform('PulseWidth',1e-4,'PRF',5e3,...
    'SampleRate',1e6,'OutputFormat','Pulses','NumPulses',1,...
    'SweepBandwidth',1e5);
waveform1
wav1 = getMatchedFilter(waveform1);

waveform2 = phased.LinearFMWaveform('PulseWidth',2e-4,'PRF',5e3,...
    'SampleRate',1e6,'OutputFormat','Pulses','NumPulses',1,...
    'SweepBandwidth',1e5);
waveform2 = 2.^(-time.^2./2);
wav2 = getMatchedFilter(waveform2);

sig1 = waveform1()
subplot(2,1,1),plot(real(sig1))

filter1 = phased.MatchedFilter('Coefficients', wav1)
filter2 = phased.MatchedFilter('Coefficients', wav2)
taylorfilter1 = phased.MatchedFilter('Coefficients', wav1,'SpectrumWindow', 'Taylor')
x1 = sig1 + 0.5*(randn(length(sig1),1) + 1j*randn(length(sig1),1));
y1 = filter1(x1);
y2 = filter2(x1);
y_taylor = taylorfilter1(x1);

% Plot real parts of waveform and noisy signal
t = linspace(0,numel(sig1)/waveform1.SampleRate,...
    waveform1.SampleRate/waveform1.PRF);
subplot(3,1,1)
plot(t,real(sig1))
title('Input Signal')
xlim([0 max(t)])
grid on
ylabel('Amplitude')
subplot(3,1,2)
plot(t,real(x1))
title('Input Signal + Noise')
xlim([0 max(t)])
grid on
xlabel('Time (sec)')
ylabel('Amplitude')

% Plot magnitudes of two matched filter outputs
subplot(3,1,3)

plot(t,abs(y1),'b-')
title('Matched Filter Output')
xlim([0 max(t)])

grid on
hold on

plot(t,abs(y2),'g-')
plot(t,abs(y_taylor),'r-')

ylabel('Magnitude')
xlabel('Seconds')
legend('No Spectrum Weighting','Waveform 2', 'Taylor Window')
hold off