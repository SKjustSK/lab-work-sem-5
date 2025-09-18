clf()

cycles = 4
frequency = 1000
sampling_rate = 30
sampling_frequency = frequency * sampling_rate

time_period = 1 / frequency
sampling_period = 1 / sampling_frequency

time_span = cycles * time_period

time = 0:0.00001:time_span
sampled_time = 0:sampling_period:time_span

amplitude = 1
signal = sin(2 * %pi * frequency * time)
sampled_signal = amplitude * sin(2 * %pi * frequency * sampled_time)

n_bits = 4
divisions = 2 ** n_bits
step_size = (max(sampled_signal) - min(sampled_signal)) / divisions
quantized_signal = round(sampled_signal / step_size)
quantized_signal = quantized_signal * step_size

subplot(3, 1, 1);
plot(time, signal, [2]);
xtitle('Original Signal', 'Time (s)', 'Amplitude');
xgrid();

subplot(3, 1, 2);
plot2d3(sampled_time, sampled_signal, [-6]);
xtitle('Sampled Signal', 'Time (s)', 'Amplitude');
xgrid();

subplot(3, 1, 3);
plot2d3(sampled_time, quantized_signal, [-4]);
xtitle('Quantized Signal', 'Time (s)', 'Amplitude');
xgrid();
