% INSTANTANEOUS EROSION CASE
% Script to calculate numerical solution of Beryllium-10 cosmogenic nuclide
% production as a function of depth.
% Final class project, Earth System Modeling
% Zach Lifton, 11/16/09

% Initial concentration = 0 (no inheritance)
% Erosion rate = instantaneous removal of thickness h from surface
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
t = input('Enter Time of Erosion Event (years):');
h = input('Enter Thickness of Erosion (cm):');
% Solution:

for k = 1:501+h             % Depth loop, calculate solution beyond 500 cm, index will adjust later
        x(k) = k - 1;
        N(k) = (Po/lambda)*exp(-mu*(x(k)))*(1 - exp(-lambda*t));
end

No = zeros(1,501+h);        % New vector, fill with zeros
No(1,1:501) = N(1,1+h:501+h);  % Set previous final values as new initial values


% Plot original profile (dashed) and truncated profile (red line)
figure(8)
plot(N(1:501),x(1:501),'k--'); hold on
plot(No(1:length(x)-h),x(1:length(x)-h),'r-');
set(gca,'YDir','reverse');
set(gca,'XAxisLocation','top');
title('100 kyr of Exposure, 50 cm of Instantaneous Erosion');
xlabel('Concentration of Be-10 (atoms/gram)');
ylabel('Depth (cm)');
hold on

l = input('Enter Time to Calculate After Erosion (years):');
n=0;
for j = 1:l/10:l+1          % Time loop, time step = input time "l" divided by 10 steps
    n = n + 1;
    t(n) = j - 1;
    for k = 1:501           % Depth loop
        x(k) = k - 1;
        N(k) = No(k)*exp(-lambda*t(n)) + (Po/lambda)*exp(-mu*(x(k)))*(1 - exp(-lambda*t(n)));
    end
    % Plot each time step as a new line
    plot(N,x,'b-');
    set(gca,'YDir','reverse');
    set(gca,'XAxisLocation','top');
    title('100 kyr of Exposure, 50 cm of Instantaneous Erosion, 100 kyr of Exposure');
    xlabel('Concentration of Be-10 (atoms/gram)');
    ylabel('Depth (cm)');
    hold on
end
