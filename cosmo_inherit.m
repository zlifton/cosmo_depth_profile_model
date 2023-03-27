% INHERITANCE CASE
% Script to calculate numerical solution of Beryllium-10 cosmogenic nuclide
% production as a function of depth.
% Final class project, Earth System Modeling
% Zach Lifton, 11/16/09

% Initial concentration = 20000 Be-10 atoms/g
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
No = 23000;                 % All material has 23000 intial atoms/gram of Be-10

% Solution:
n=0;
for j = 1:10000:100001      % Time loop, 100 kyr in 10 kyr time steps
    n = n + 1;
    t(n) = j - 1;
    for k = 1:500           % Depth loop, 0 cm to 500 cm depth
        x(k) = k - 1;
        N(k) = No*exp(-lambda*t(n)) + (Po/lambda)*exp(-mu*(x(k)))*(1 - exp(-lambda*t(n)));
    end
    % Plot:
    figure(5)
    plot(N,x,'k-');
    set(gca,'YDir','reverse');
    set(gca,'XAxisLocation','top');
    xlabel('Concentration of Be-10 (atoms/gram)');
    ylabel('Depth (cm)');
    hold on
end
