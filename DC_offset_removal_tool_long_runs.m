%% taking off the DC offset on the graph with a user input line. 
%
% Should be used in conjunction with % Data_plotting_tool_rotating_field.m
%
% JDZ 06/08/18
%
% ========================================================================

hline = gline();
w(1) = waitforbuttonpress; w(2) = waitforbuttonpress;
coefficients = polyfit([hline.XData(2), hline.XData(1)], [hline.YData(2), hline.YData(1)], 1);
gradient = coefficients (1);
intercept = coefficients (2);
checkergrad = (hline.YData(2)- hline.YData(1))/(hline.XData(2)- hline.XData(1));

for b = [1:round(size(exp1,2)/4),3*round(size(exp1,2)/4):size(exp1,2)]
plot_data1 = exp1(1,b).values;
plot_data2 = exp2(1,b).values;

angle = -plot_data1(:,7);
sig_para = plot_data1(:,12).*sind(angle)+plot_data2(:,12).*cosd(angle);
sig_perp = plot_data1(:,12).*cosd(angle)-plot_data2(:,12).*sind(angle);
field = plot_data1(:,6);
Bx = field.*cosd(angle); % Perpendicular I think.
By = field.*sind(angle); % Parallel. 
Bx = Bx-intercept-(gradient.*By);



figure(11)
hold on
scatter(By,Bx,20,sig_para,'filled')

figure(12)
hold on
scatter(By,Bx,20,sig_perp,'filled')


end

%%
figure(11)
title 'Parallel signal'
ylabel 'B_p_e_r_p_e_n_d_i_c_u_l_a_r [Oe]'
xlabel 'B_p_a_r_a_l_l_e_l [Oe]'
colormap(parula)
colorbar
ax = gca;
ax.XAxisLocation = 'origin';
ax.YAxisLocation = 'origin';

figure(12)
title 'Perpendicular signal'
ylabel 'B_p_e_r_p_e_n_d_i_c_u_l_a_r [Oe]'
xlabel 'B_p_a_r_a_l_l_e_l [Oe]'
%caxis([-0.00015,0.00015])
colormap(parula);
colorbar
ax = gca;
ax.XAxisLocation = 'origin';
ax.YAxisLocation = 'origin';

%%

figure(15)
clf
figure(16)
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
Bx = Bx-intercept-(gradient.*By);
figure(15)
hold on
scatter(By,Bx,20,sig_para,'filled')

figure(16)
hold on
scatter(By,Bx,20,sig_perp,'filled')


end


%%
figure(15)
title 'Parallel signal 2'
ylabel 'B_p_e_r_p_e_n_d_i_c_u_l_a_r [Oe]'
xlabel 'B_p_a_r_a_l_l_e_l [Oe]'
colormap(parula)
colorbar
ax = gca;
ax.XAxisLocation = 'origin';
ax.YAxisLocation = 'origin';

figure(16)
title 'Perpendicular signal 2'
xlabel 'B_p_e_r_p_e_n_d_i_c_u_l_a_r [Oe]'
ylabel 'B_p_a_r_a_l_l_e_l [Oe]'
%caxis([-0.00015,0.00015])
colormap(parula);
colorbar
ax = gca;
ax.XAxisLocation = 'origin';
ax.YAxisLocation = 'origin';

%%
% children = get(gca, 'children');
% delete(children(1));
