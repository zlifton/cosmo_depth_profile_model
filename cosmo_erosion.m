% CONSTANT EROSION CASE
% Script to calculate numerical solution of Beryllium-10 cosmogenic nuclide
% production as a function of depth.
% Final class project, Earth System Modeling
% Zach Lifton, 11/16/09

% Initial concentration = 0 (no inheritance)
% Erosion rate = steady-state erosion from 0.1 mm/yr to 1 mm/yr and 0.01 mm/yr to
% 0.1 mm/yr
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
for m = 1:10                % Vary erosion rate, from 1.0 mm/yr to 10 mm/yr
    e = m*0.1;    
n=0;
for j = 1:1000:10001        % Time loop, 10 kyr in 1 kyr time steps
    n = n + 1;
    t(n) = j - 1;
    for k = 1:500           % Depth loop, 0 to 500 cm depth
        x(k) = k - 1;
        N(k) = (Po/(lambda + mu*e))*exp(-mu*(x(k)))*(1 - exp(-(lambda + mu*e)*t(n)));  % Includes an erosion term
    end
    % Plot:
    figure(2)
    subplot(3,4,m)
    plot(N,x,'k-');
    axis([0 3500 0 500]);
    set(gca,'YDir','reverse');
    set(gca,'XAxisLocation','top');
    xlabel('Concentration of Be-10 (atoms/gram)');
    ylabel('Depth (cm)');
    hold on
end
end

for m = 1:10                % Vary erosion rate, from 0.1 mm/yr to 1.0 mm/yr
    e = m*0.01;    
n=0;
for j = 1:1000:10001        % Time loop, 10 kyr in 1 kyr time steps
    n = n + 1;
    t(n) = j - 1;
    for k = 1:500           % Depth loop, 0 to 500 cm depth
        x(k) = k - 1;
        N(k) = (Po/(lambda + mu*e))*exp(-mu*(x(k)))*(1 - exp(-(lambda + mu*e)*t(n)));
    end
    % Plot:
    figure(3)
    subplot(3,4,m)
    plot(N,x,'k-');
    axis([0 12000 0 500]);
    set(gca,'YDir','reverse');
    set(gca,'XAxisLocation','top');
    xlabel('Concentration of Be-10 (atoms/gram)');
    ylabel('Depth (cm)');
    hold on
end
end
