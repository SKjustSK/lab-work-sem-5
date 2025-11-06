clf;
clear;

// Define parameters
samples = 100
frequency = 4

// Generate input
digital = round(grand(1, 8, "uin", 0, 1))
disp(digital)

// Generate unipolar wave vector
m = ones(1, samples)
digital_wave = digital .*. m

// Generate time vector
time = 0:1/samples:length(digital)
time($) = []

// Generate carrier
carrier = 5*sin(2 * %pi * frequency * time)

// "Modulate" (multiply input with carrier)
modulated = carrier .* digital_wave

// Demodulation
demodulated = modulated ./ carrier

// Plot signals
subplot(4, 1, 1)
plot(time, digital_wave)
xgrid()
gca().data_bounds = [0, -1.5; max(time), 1.5];

subplot(4, 1, 2)
plot(time, carrier)
xgrid()

subplot(4, 1, 3)
plot(time, modulated)
xgrid()

subplot(4, 1, 4)
plot(time, demodulated)
xgrid()
gca().data_bounds = [0, -1.5; max(time), 1.5];


