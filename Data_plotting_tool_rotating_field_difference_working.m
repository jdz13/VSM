close all 
clear 


figure(1)
clf

figure(2)
clf

exp1 = VSM_import();
exp2 = VSM_import();
exp3 = VSM_import();
exp4 = VSM_import();


for b = 1:round(size(exp1,2)/1)
% ======================================================================
% Manipulate the first set of data 

plot_data1 = exp1(1,b).values;
plot_data2 = exp2(1,b).values;

anglex = -plot_data1(:,7);
angley = -plot_data2(:,7);
sig_para = plot_data1(:,12).*sind(anglex)+plot_data2(:,12).*cosd(anglex);
sig_perp = plot_data1(:,12).*cosd(anglex)-plot_data2(:,12).*sind(anglex);
field = plot_data1(:,6);
Bx = field.*cosd(anglex); % Perpendicular I think.
By = field.*sind(anglex); % Parallel. 
figure(1)
subplot(2,3,5)
hold on
scatter(By,Bx,20,sig_para,'filled')

subplot(2,3,2)
hold on
scatter(By,Bx,20,sig_perp,'filled')


% ======================================================================
% Manipulating the second set of data

plot_data3 = exp3(1,b).values;
plot_data4 = exp4(1,b).values;

anglex1 = -plot_data3(:,7);
angley1 = -plot_data4(:,7);
sig_para1 = plot_data3(:,12).*sind(anglex1)+plot_data4(:,12).*cosd(anglex1);
sig_perp1 = plot_data3(:,12).*cosd(anglex1)-plot_data4(:,12).*sind(anglex1);
field1 = plot_data3(:,6);
Bx1 = field1.*cosd(anglex1); % Perpendicular I think.
By1 = field1.*sind(anglex1); % Parallel. 
subplot(2,3,6)
hold on
scatter(By1,Bx1,20,sig_para1,'filled')

subplot(2,3,3)
hold on
scatter(By1,Bx1,20,sig_perp1,'filled')


% =====================================================================
% Difference measurements

subplot(2,3,1)
hold on
scatter(By1,Bx1,20,sig_perp1-flipud(sig_perp),'filled')

subplot(2,3,4)
hold on
scatter(By1,Bx1,20,sig_para1-flipud(sig_para),'filled')


% ======================================================================
% Angle measurements, all together to aid plotting. 

figure(2)
subplot(2,2,1)
hold on
scatter(By,Bx,20,anglex,'filled')

subplot(2,2,2)
hold on
scatter(By1,Bx1,20,anglex1,'filled')

subplot(2,2,3)
hold on
scatter(By,Bx,20,angley,'filled')

subplot(2,2,4)
hold on
scatter(By1,Bx1,20,angley1,'filled')


end


%%
figure(1)
subplot(2,3,5)
title 'Parallel signal'
ylabel 'B_p_e_r_p_e_n_d_i_c_u_l_a_r [Oe]'
xlabel 'B_p_a_r_a_l_l_e_l [Oe]'
polarmap
colorbar
ax = gca;
ax.XAxisLocation = 'origin';
ax.YAxisLocation = 'origin';
set(gca, 'Layer', 'Top');

subplot(2,3,2)
title 'Perpendicular signal'
xlabel 'B_p_e_r_p_e_n_d_i_c_u_l_a_r [Oe]'
ylabel 'B_p_a_r_a_l_l_e_l [Oe]'
%caxis([-0.0001,0.0001])
polarmap
colorbar
ax = gca;
ax.XAxisLocation = 'origin';
ax.YAxisLocation = 'origin';
set(gca, 'Layer', 'Top');

% =======================================================================

subplot(2,3,6)
title 'Parallel signal 1'
ylabel 'B_p_e_r_p_e_n_d_i_c_u_l_a_r [Oe]'
xlabel 'B_p_a_r_a_l_l_e_l [Oe]'
polarmap
colorbar
ax = gca;
ax.XAxisLocation = 'origin';
ax.YAxisLocation = 'origin';
set(gca, 'Layer', 'Top');

subplot(2,3,3)
title 'Perpendicular signal 1'
xlabel 'B_p_e_r_p_e_n_d_i_c_u_l_a_r [Oe]'
ylabel 'B_p_a_r_a_l_l_e_l [Oe]'
%caxis([-0.0001,0.0001])
polarmap
colorbar
ax = gca;
ax.XAxisLocation = 'origin';
ax.YAxisLocation = 'origin';
set(gca, 'Layer', 'Top');


% ======================================================================

subplot(2,3,1)
title 'Perpendicular difference'
ylabel 'B_p_e_r_p_e_n_d_i_c_u_l_a_r [Oe]'
xlabel 'B_p_a_r_a_l_l_e_l [Oe]'
polarmap
colorbar
ax = gca;
ax.XAxisLocation = 'origin';
ax.YAxisLocation = 'origin';
set(gca, 'Layer', 'Top');

subplot(2,3,4)
title 'Parallel difference'
xlabel 'B_p_e_r_p_e_n_d_i_c_u_l_a_r [Oe]'
ylabel 'B_p_a_r_a_l_l_e_l [Oe]'
%caxis([-0.0001,0.0001])
polarmap
colorbar
ax = gca;
ax.XAxisLocation = 'origin';
ax.YAxisLocation = 'origin';
set(gca, 'Layer', 'Top');


% ====================================================================

figure(2)
subplot(2,2,1)
title 'Angle test for x signal'

subplot(2,2,2)
title 'Angle test for x signal 1'

subplot(2,2,3)
title 'Angle test for y signal'

subplot(2,2,4)
title 'Angle test for y signal 1'
