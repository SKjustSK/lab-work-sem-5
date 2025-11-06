clf;
clear;

// Define parameters
samples = 100
hf_frequency = 8
lf_frequency = 2

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
hf_carrier = 5*sin(2 * %pi * hf_frequency * time)
lf_carrier = 5*sin(2 * %pi * lf_frequency * time)

// "Modulate" (multiply input with carrier)
modulated = zeros(1, length(digital_wave))
for i = 1:length(digital_wave)
    if digital_wave(i) == 1 then
        modulated(i) = hf_carrier(i)
    else
        modulated(i) = lf_carrier(i) 
    end
end
// Demodulation
demodulated = zeros(1, length(digital_wave))

// Plot signals
subplot(4, 1, 1)
plot(time, digital_wave)
xgrid()
gca().data_bounds = [0, -1.5; max(time), 1.5];

subplot(4, 1, 2)
plot(time, hf_carrier)
xgrid()

subplot(4, 1, 3)
plot(time, lf_carrier)
xgrid()

subplot(4, 1, 4)
plot(time, modulated)
xgrid()



