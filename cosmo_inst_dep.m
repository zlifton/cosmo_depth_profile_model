% INSTANTANEOUS DEPOSITION CASE
% Script to calculate numerical solution of Beryllium-10 cosmogenic nuclide
% production as a function of depth.
% Final class project, Earth System Modeling
% Zach Lifton, 11/16/09

% Initial concentration = 0 (no inheritance)
% Erosion rate = 0
% Instantaneous deposition of thickness h onto surface
% Altitude = 0-5 km
% Latitude = 40 N
% Be-10 half-life = 1.36*10^6 yr (Nishiizumi et al, 2007)

clear
% Inputs:
lambda = 5.09*10^(-7);      % Be-10 decay constant (yr^-1)
rho = 2;                    % Density of alluvium (g/cm^3)
caplamb = 165;              % Characteristic attenuation length (g/cm^2)
mu = rho/caplamb;
Po = 4.8;                   % Be-10 production rate (atoms/g/yr)
t = input('Enter Time of Deposition Event (years):');
h = input('Enter Thickness of Sediment Deposited (cm):');

% Solution:
for k = 1:501               % Depth loop, calculate profile just before deposition event
        x(k) = k - 1;
        N(k) = (Po/lambda)*exp(-mu*(x(k)))*(1 - exp(-lambda*t));
end

for i = 1:501               % Depth loop, adjust index to move all material "down" when buried by h depth material
    No(i+h) = N(i);
    No(1:h) = 0;
end
No = No(1:501);             % Adjust index, final values become intitial conditions for next calculation

% Plot original profile (dashed) buried by deposition (uncomment for first run, comment for second run)
figure(6)
plot(No,x,'k--');
set(gca,'YDir','reverse');
set(gca,'XAxisLocation','top');
title('100 kyr of Exposure, Instantaneous Deposition of 50 cm Material, Followed by 100 kyr of exposure')' 
xlabel('Concentration of Be-10 (atoms/gram)');
ylabel('Depth (cm)');
hold on

l = input('Enter Time to Calculate After Deposition (years):');
for k = 1:501               % Depth loop, calculate solution "l" years after deposition event
    x(k) = k - 1;
    N(k) = No(k)*exp(-lambda*l) + (Po/lambda)*exp(-mu*(x(k)))*(1 - exp(-lambda*l));
end

% Plot new profile after original profile is buried (uncomment for first run, comment for second run)
plot(N,x,'b-');
set(gca,'YDir','reverse');
set(gca,'XAxisLocation','top');
xlabel('Concentration of Be-10 (atoms/gram)');
ylabel('Depth (cm)');
hold on

% Plot a second instantaneous deposition event: (comment all code below for first run, uncomment for second run)
h = input('Enter Thickness of Sediment Deposited (cm):');
for i = 1:501               % Depth loop, adjust index, move all material "down"
    No(i+h) = N(i);
    No(1:h) = 0;
end
No = No(1:501);
l = input('Enter Time to Calculate After Deposition (years):');
for k = 1:501               % Depth loop, calculate solution "l" years after deposition event
    x(k) = k - 1;
    N(k) = No(k)*exp(-lambda*l) + (Po/lambda)*exp(-mu*(x(k)))*(1 - exp(-lambda*l));
end
% Plot profile after 100 kyr exposure, deposition event, another 100 kyr exposure, a second deposition event, and a third 100 kyr exposure
figure(7)
plot(N,x,'k-');
set(gca,'YDir','reverse');
set(gca,'XAxisLocation','top');
xlabel('Concentration of Be-10 (atoms/gram)');
ylabel('Depth (cm)');
title('100 kyr of Exposure, Instantaneous Deposition of 50 cm Material, 100 kyr of exposure, Instantaneous Deposition of 50 cm Material, 100 kyr of exposure'); 
