%% taking off the DC offset on the graph with a user input line. 
%
% Should be used in conjunction with % Data_plotting_tool_rotating_field.m
%
% JDZ 06/08/18
%
% ========================================================================

%hline = gline();
%w(1) = waitforbuttonpress; w(2) = waitforbuttonpress;
coefficients = polyfit([hline.XData(2), hline.XData(1)], [hline.YData(2), hline.YData(1)], 1);
gradient = coefficients (1);
intercept = coefficients (2);
checkergrad = (hline.YData(2)- hline.YData(1))/(hline.XData(2)- hline.XData(1));

for b = 1:size(exp1,2)
plot_data1 = exp1(1,b).values;
plot_data2 = exp2(1,b).values;

angle = -plot_data1(:,7);
sig_para = plot_data1(:,12).*sind(angle)+plot_data2(:,12).*cosd(angle);
sig_perp = plot_data1(:,12).*cosd(angle)-plot_data2(:,12).*sind(angle);
field = plot_data1(:,6);
Bx = field.*cosd(angle); % Perpendicular I think.
By = field.*sind(angle); % Parallel. 
Bx = Bx-intercept-(gradient.*By);

radB = sqrt(Bx.^2+By.^2);
dotszmat = (radB.*(13/sqrt(2)/400)).^2;

figure(13)
hold on
scatter(By,Bx,dotszmat,sig_para,'filled')

figure(14)
hold on
scatter(By,Bx,dotszmat,sig_perp,'filled')


end

%%
figure(13)
title 'Parallel signal'
ylabel 'B_p_e_r_p_e_n_d_i_c_u_l_a_r [Oe]'
xlabel 'B_p_a_r_a_l_l_e_l [Oe]'
colormap(parula)
colorbar
ax = gca;
ax.XAxisLocation = 'origin';
ax.YAxisLocation = 'origin';

figure(14)
title 'Perpendicular signal'
ylabel 'B_p_e_r_p_e_n_d_i_c_u_l_a_r [Oe]'
xlabel 'B_p_a_r_a_l_l_e_l [Oe]'
caxis([-0.0001,0.0001])
colormap(parula);
colorbar
ax = gca;
ax.XAxisLocation = 'origin';
ax.YAxisLocation = 'origin';


%%
% children = get(gca, 'children');
% delete(children(1));