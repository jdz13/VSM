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

for b = 1:size(exp1,2)
plot_data1X = exp1X(1,b).values;
plot_data1Y = exp1Y(1,b).values;

angle1X = -plot_data1X(:,7);
angle1Y = -plot_data1Y(:,7);
sig_para1 = plot_data1X(:,12).*sind(angle1X)+plot_data1Y(:,12).*cosd(angle1X);
sig_perp1 = plot_data1X(:,12).*cosd(angle1X)-plot_data1Y(:,12).*sind(angle1X);
field1 = plot_data1X(:,6);
B1x = field1.*cosd(angle1X); % Perpendicular I think.
B1y = field1.*sind(angle1Y); % Parallel. 
B1x = B1x-intercept-(gradient.*B1y);

% second set 
plot_data2X = exp2X(1,b).values;
plot_data2Y = exp2Y(1,b).values;

angle2X = -plot_data2X(:,7);
angle2Y = -plot_data2Y(:,7);
sig_para2 = plot_data2X(:,12).*sind(angle2X)+plot_data2Y(:,12).*cosd(angle2X);
sig_perp2 = plot_data2X(:,12).*cosd(angle2X)-plot_data2Y(:,12).*sind(angle2X);
field2 = plot_data2X(:,6);
B2x = field2.*cosd(angle2X); % Perpendicular I think.
B2y = field2.*sind(angle2Y); % Parallel. 
B2x = B2x-intercept-(gradient.*B2y);


figure(11)
hold on
scatter(B1y,B1x,20,sig_para1-sig_para2,'filled')

figure(12)
hold on
scatter(B1y,B1x,20,sig_perp1-sig_perp2,'filled')

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
caxis([-0.0001,0.0001])
colormap(parula);
colorbar
ax = gca;
ax.XAxisLocation = 'origin';
ax.YAxisLocation = 'origin';


%%
% children = get(gca, 'children');
% delete(children(1));