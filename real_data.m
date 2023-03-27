% REAL DATA
% Script to calculate numerical solution of Beryllium-10 cosmogenic nuclide
% production as a function of depth.
% Final class project, Earth System Modeling
% Zach Lifton, 11/16/09

% Plot real data:

% Basento fluvial terrace:
xbas = [106576 62061 50447 35498 24936];
ybas = [-30 -70 -110 -175 -265];

% Sinni fluvial terrace:
xsinni = [87994 94935 89209 36137 21045 15569];
ysinni = [-30 -60 -100 -160 -240 -340];

% Cucumongo Canyon alluvial fan:
xcucu = [566626 579534 590354 425583 217935];
ycucu = [-25 -50 -80 -130 -180];

figure(9)
subplot(1,3,1)
plot(xbas,ybas,'bo');
axis([0 600000 -500 0]);
set(gca,'XAxisLocation','top');
title('Basento Fluvial Terrace, Italy');
xlabel('Concentration of Be-10 (atoms/gram)');
ylabel('Depth (cm)');
hold on

subplot(1,3,2)
plot(xsinni,ysinni,'ro');
axis([0 600000 -500 0]);
set(gca,'XAxisLocation','top');
title('Sinni Fluvial Terrace, Italy');
xlabel('Concentration of Be-10 (atoms/gram)');
ylabel('Depth (cm)');

subplot(1,3,3)
plot(xcucu,ycucu,'go');
axis([0 600000 -500 0]);
set(gca,'XAxisLocation','top');
title('Cucumongo Canyon Alluvial Fan, Death Valley');
xlabel('Concentration of Be-10 (atoms/gram)');
ylabel('Depth (cm)');