clear;
clf;

digital = round(grand(1, 8, "uin", 0, 1));
samples = 200;

time = 0:1/samples:length(digital);
time($) = []; // Fix length issue

unipolar_nrz = zeros(1, length(time));
unipolar_rz = zeros(1, length(time));
polar_nrz = zeros(1, length(time));
polar_rz = zeros(1, length(time));
bipolar_nrz = zeros(1, length(time));
bipolar_rz = zeros(1, length(time));

prev = 1;

for i = 1:length(digital)
    for j = 1:samples
        ind = (i - 1)*samples + j;

        if digital(i) == 1 then
            if j <= samples/2 then
                unipolar_rz(ind) = 1;
                polar_rz(ind) = 1;
                bipolar_rz(ind) = prev;
            end

            unipolar_nrz(ind) = 1;
            polar_nrz(ind) = 1;
            bipolar_nrz(ind) = prev;

            if j == samples then
                prev = -prev;
            end
        else
            if j <= samples/2 then
                unipolar_rz(ind) = 0;
                polar_rz(ind) = -1;
                bipolar_rz(ind) = 0;
            end

            unipolar_nrz(ind) = 0;
            polar_nrz(ind) = -1;
            bipolar_nrz(ind) = 0;
        end
    end
end

disp("Digital Bits:");
disp(digital);

scf(0);

subplot(3, 2, 1);
plot(time, unipolar_nrz, 'r');
xtitle("Unipolar NRZ", "Time", "Amplitude");
xgrid();
gca().data_bounds = [0, -1.5; max(time), 1.5];

subplot(3, 2, 2);
plot(time, unipolar_rz, 'b');
xtitle("Unipolar RZ", "Time", "Amplitude");
xgrid();
gca().data_bounds = [0, -1.5; max(time), 1.5];

subplot(3, 2, 3);
plot(time, polar_nrz, 'g');
xtitle("Polar NRZ", "Time", "Amplitude");
xgrid();
gca().data_bounds = [0, -1.5; max(time), 1.5];

subplot(3, 2, 4);
plot(time, polar_rz, 'm');
xtitle("Polar RZ", "Time", "Amplitude");
xgrid();
gca().data_bounds = [0, -1.5; max(time), 1.5];

subplot(3, 2, 5);
plot(time, bipolar_nrz, 'k');
xtitle("Bipolar NRZ", "Time", "Amplitude");
xgrid();
gca().data_bounds = [0, -1.5; max(time), 1.5];

subplot(3, 2, 6);
plot(time, bipolar_rz, 'c');
xtitle("Bipolar RZ", "Time", "Amplitude");
xgrid();
gca().data_bounds = [0, -1.5; max(time), 1.5];
