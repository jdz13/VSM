
which = 6;

% 6 = SP6772
% 7 = SP7953
% 8 = SP8214

which2 = 2;

% 1 = SH
% 2 = SH + tape

col = 11; % (could change to 11 for manipulated data)
Hcol = 6;

n = 6;
n1 = 2; 

JSHnu = [3,5];
SHTnu = (4:2:14);
SP6nu = (3:2:19);
SP7nu = (3:2:13);
SP8nu = (3:2:13);


    
pltdata = SP8214(SP6nu(n)).data(:,col) - SH_tape(SHTnu(n1)).data(:,col);
% pltdata = pltdata';

figure(23); clc;
subplot(1,2,1)
plot(SH_tape(SHTnu(n1)).data(:,Hcol)/1e3, pltdata*1e6)
title 'Subtracted data'
xlabel 'Field(kOe)'; ylabel 'Signal (\muemu)'
subplot(1,2,2)
vsmplot(SH_tape(SHTnu(n1)).data(:,Hcol)/1e3, pltdata*1e6)
title 'Slope corrected data'
xlabel 'Field(kOe)'; ylabel 'Signal (\muemu)'