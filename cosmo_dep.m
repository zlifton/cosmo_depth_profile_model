% CONSTANT DEPOSITION CASE
% Script to calculate numerical solution of Beryllium-10 cosmogenic nuclide
% production as a function of depth.
% Final class project, Earth System Modeling
% Zach Lifton, 11/16/09

% Steady-state deposition = 1 mm/yr
% Initial concentration = 0 (no inheritance)
% Erosion rate = 0
% Altitude = 0-5 km
% Latitude = 40 N
% Be-10 half-life = 1.36*10^6 yr (Nishiizumi et al, 2007)

clear
% Inputs:
lambda = 5.09*10^(-7);      % Be-10 decay constant
rho = 0.002;                % Density of alluvium (g/mm^3)
caplamb = 1.65;             % Characteristic attenuation length (g/mm^2)
mu = rho/caplamb;
Po = 4.8;                   % Be-10 production rate (atoms/g/yr)

% Solution:
n=0;
time = 1 + input('Enter time elapsed (yr):');
No = zeros(1,5001);         % Create vector 5000 units long (5000mm = 500cm)
for j = 1:time              % Time loop
    n = n + 1;
    t(n) = j - 1;
    for k = 1:5001          % Depth loop
        x(k) = k - 1;
        N(k) = No(k)*exp(-lambda*t(n)) + (Po/lambda)*exp(-mu*(x(k)))*(1 - exp(-lambda*t(n)));
    end
    for i = 1:5001-1        % Reset index of vector; move all points "down" 1mm and deposit 1mm of material at top
        No(i+1) = N(i);
        No(1) = 0;
    end
end
 % Plot:
    figure(4)
    plot(N,x,'k-');
    set(gca,'YDir','reverse');
    set(gca,'XAxisLocation','top');
    title('Steady-state Deposition (1 mm/yr)')
    xlabel('Concentration of Be-10 (atoms/gram)');
    ylabel('Depth (mm)');
    hold on
