clear 

figure(1)
clf

% map =    [1 0 0;1 0.0322580635547638 0.0322580635547638;1 0.0645161271095276 0.0645161271095276;1 0.0967741906642914 0.0967741906642914;1 0.129032254219055 0.129032254219055;1 0.161290317773819 0.161290317773819;1 0.193548381328583 0.193548381328583;1 0.225806444883347 0.225806444883347;1 0.25806450843811 0.25806450843811;1 0.290322571992874 0.290322571992874;1 0.322580635547638 0.322580635547638;1 0.354838699102402 0.354838699102402;1 0.387096762657166 0.387096762657166;1 0.419354826211929 0.419354826211929;1 0.451612889766693 0.451612889766693;1 0.483870953321457 0.483870953321457;1 0.516129016876221 0.516129016876221;1 0.548387110233307 0.548387110233307;1 0.580645143985748 0.580645143985748;1 0.612903237342834 0.612903237342834;1 0.645161271095276 0.645161271095276;1 0.677419364452362 0.677419364452362;1 0.709677398204803 0.709677398204803;1 0.74193549156189 0.74193549156189;1 0.774193525314331 0.774193525314331;1 0.806451618671417 0.806451618671417;1 0.838709652423859 0.838709652423859;1 0.870967745780945 0.870967745780945;1 0.903225779533386 0.903225779533386;1 0.935483872890472 0.935483872890472;1 0.967741906642914 0.967741906642914;1 1 1;1 1 0.96875;1 1 0.9375;1 1 0.90625;1 1 0.875;1 1 0.84375;1 1 0.8125;1 1 0.78125;1 1 0.75;1 1 0.71875;1 1 0.6875;1 1 0.65625;1 1 0.625;1 1 0.59375;1 1 0.5625;1 1 0.53125;1 1 0.5;1 1 0.46875;1 1 0.4375;1 1 0.40625;1 1 0.375;1 1 0.34375;1 1 0.3125;1 1 0.28125;1 1 0.25;1 1 0.21875;1 1 0.1875;1 1 0.15625;1 1 0.125;1 1 0.09375;1 1 0.0625;1 1 0.03125;1 1 0];

figure(2)
clf

exp1 = VSM_import();
exp2 = VSM_import();

for b = [1:round(size(exp1,2)/4),3*round(size(exp1,2)/4):size(exp1,2)]
plot_data1 = exp1(1,b).values;
plot_data2 = exp2(1,b).values;

angle = -plot_data1(:,7);
sig_para = plot_data1(:,12).*sind(angle)+plot_data2(:,12).*cosd(angle);
sig_perp = plot_data1(:,12).*cosd(angle)-plot_data2(:,12).*sind(angle);
field = plot_data1(:,6);
Bx = field.*cosd(angle); % Perpendicular I think.
By = field.*sind(angle); % Parallel. 
figure(1)
hold on
scatter(By,Bx,20,sig_para,'filled')

figure(2)
hold on
scatter(By,Bx,20,sig_perp,'filled')

figure(3)
hold on
scatter(By,Bx,20,angle,'filled')
figure(4)
hold on
scatter(By,Bx,20,angle,'filled')

end


%%
figure(1)
title 'Parallel signal'
ylabel 'B_p_e_r_p_e_n_d_i_c_u_l_a_r [Oe]'
xlabel 'B_p_a_r_a_l_l_e_l [Oe]'
colormap(parula)
colorbar
ax = gca;
ax.XAxisLocation = 'origin';
ax.YAxisLocation = 'origin';

figure(2)
title 'Perpendicular signal'
xlabel 'B_p_e_r_p_e_n_d_i_c_u_l_a_r [Oe]'
ylabel 'B_p_a_r_a_l_l_e_l [Oe]'
caxis([-0.0001,0.0001])
colormap(parula);
colorbar
ax = gca;
ax.XAxisLocation = 'origin';
ax.YAxisLocation = 'origin';

figure(3)
title 'Angle test for parallel signal'

figure(4)
title 'Angle test for perpendicular signal'

%%
figure(5)
clf
figure(6)
clf

for b = round(size(exp1,2)/4):3*round(size(exp1,2)/4)
plot_data1 = exp1(1,b).values;
plot_data2 = exp2(1,b).values;

angle = -plot_data1(:,7);
sig_para = plot_data1(:,12).*sind(angle)+plot_data2(:,12).*cosd(angle);
sig_perp = plot_data1(:,12).*cosd(angle)-plot_data2(:,12).*sind(angle);
field = plot_data1(:,6);
Bx = field.*cosd(angle); % Perpendicular I think.
By = field.*sind(angle); % Parallel. 
figure(5)
hold on
scatter(By,Bx,20,sig_para,'filled')

figure(6)
hold on
scatter(By,Bx,20,sig_perp,'filled')

figure(7)
hold on
scatter(By,Bx,20,angle,'filled')
figure(8)
hold on
scatter(By,Bx,20,angle,'filled')

end


%%
figure(5)
title 'Parallel signal 2'
ylabel 'B_p_e_r_p_e_n_d_i_c_u_l_a_r [Oe]'
xlabel 'B_p_a_r_a_l_l_e_l [Oe]'
colormap(parula)
colorbar
ax = gca;
ax.XAxisLocation = 'origin';
ax.YAxisLocation = 'origin';

figure(6)
title 'Perpendicular signal 2'
xlabel 'B_p_e_r_p_e_n_d_i_c_u_l_a_r [Oe]'
ylabel 'B_p_a_r_a_l_l_e_l [Oe]'
caxis([-0.0001,0.0001])
colormap(parula);
colorbar
ax = gca;
ax.XAxisLocation = 'origin';
ax.YAxisLocation = 'origin';

figure(7)
title 'Angle test for parallel signal 2'

figure(8)
title 'Angle test for perpendicular signal 2'