clear

figure(1)
clf

figure(2)
clf

exp1 = VSM_import();
exp2 = VSM_import();

for b = [1:round(size(exp1,2)/1)]
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