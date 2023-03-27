% SIMPLE CASE
% Script to calculate numerical solution of Beryllium-10 cosmogenic nuclide
% production as a function of depth.
% Final class project, Earth System Modeling
% Zach Lifton, 11/16/09

% Initial concentration = 0 (no inheritance)
% Erosion rate = 0
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

% Solution:
n=0;
for j = 1:1000000:10000001  % Time loop, 10 Myr in 1 Myr time steps
    n = n + 1;
    t(n) = j - 1;
    for k = 1:500           % Depth loop, 0 to 500 cm depth
        x(k) = k - 1;
        N(k) = (Po/lambda)*exp(-mu*(x(k)))*(1 - exp(-lambda*t(n)));
    end
    % Plot:
    figure(1)
    plot(N,x,'k-');
    set(gca,'YDir','reverse');
    set(gca,'XAxisLocation','top');
    xlabel('Concentration of Be-10 (atoms/gram)');
    ylabel('Depth (cm)');
    hold on
end
