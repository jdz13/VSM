%% Code to produce switching astroids from a series of data from VSM.
% Slightly funky way of creating the graphs, due to taking vector
% measurements with a single working LIA. For this reason, two runs are
% needed for full information (one for X - working LIA, and Y - working
% LIA). An example set of data, for an increasing angle is 

% C:\Users\JDZ\Documents\VSM\Angles\Rotating field\SP6772\rotating_300deg_reverse_2\SP6772_up\SP6772-Manual.vrd
% C:\Users\JDZ\Documents\VSM\Angles\Rotating field\SP6772\rotating_300deg_reverse_2\SP6772_XY_switch\SP6772_XY_switch\SP6772_XY_switch-Manual.vrd
% change user to Jake/JDZ whether on PC/laptop (respectively)

% Will show the moment perpendicular to the sample plane and moment parallel
% to the sample plane for all angles (0-320) at different start fields. 

% Jan 21, added in a new tool to show the switching point only. The 1st
% angle where the polarity of moment is reversed, for the two switching
% quadrants per run. For Dot presentation method in thesis. 

% open the figures that will have data loaded in continuously. 
figure(1); clf 
figure(2); clf

% figure(3); clf
% figure(4); clf

exp1 = VSM_import(); % C:\Users\Jake\Documents\VSM\Angles\Rotating field\SP6772\rotating_300deg_reverse_2\SP6772_up\SP6772-Manual.vrd
exp2 = VSM_import(); % C:\Users\Jake\Documents\VSM\Angles\Rotating field\SP6772\rotating_300deg_reverse_2\SP6772_XY_switch\SP6772_XY_switch\SP6772_XY_switch-Manual.vrd

len = round(size(exp1,2)/1); % length identifier, for easier use in code. 

plstr = zeros(4,len); % pre-allocate variable. 

for b = 1:len
    
    % extract the data from the structures.
    plot_data1 = exp1(1,b).values;
    plot_data2 = exp2(1,b).values;
    
    % definition of angle here reverse of in system - define. 
    angle = -plot_data1(:,7);
    
    % Calculate the moment both perpendicular and parallel to the sample
    % using rotation transformations. 
    sig_para = plot_data1(:,12).*sind(angle)+plot_data2(:,12).*cosd(angle);
    sig_perp = plot_data1(:,12).*cosd(angle)-plot_data2(:,12).*sind(angle);
    %extract field values from the structures - relative to the VSM
    %reference frame;
    field = plot_data1(:,6);
    % Calculate the field with respect to the samples reference frame. 
    Bx = field.*cosd(angle); % Perpendicular field.
    By = field.*sind(angle); % Parallel field. 

    %plot the perpendicular signal for all theta at this start field value.
    figure(1)
    hold on
    scatter(By,Bx,20,sig_para,'filled')

    %plot the perpendicular signal for all theta at this start field value.
    figure(2)
    hold on
    scatter(By,Bx,20,sig_perp,'filled')

    % find the indicies of the switching event, which can then be 
    %attributed to the appropriate field vector. 
    firstX = Bx(find(sig_perp <= 0, 1, 'first'));
    firstY = By(find(sig_perp <= 0, 1, 'first'));
    secondX = Bx(find(sig_perp <= 0, 1, 'last'));
    secondY = By(find(sig_perp <= 0, 1, 'last'));

    % lots of caveats here, just to make sure that non-switching events 
    % do not impact the code. But saving the values of the switching event.
    if isempty(firstX)
    else
        plstr(1,b) = firstX;
    end 
    if isempty(firstY)
    else
        plstr(2,b) = firstY;
    end
    if isempty(secondX)
    else
        plstr(3,b) = secondX;
    end
    if isempty(secondY)
    else
        plstr(4,b) = secondY;
    end

    % Initial debugging - ensuring the angle polarity is correct.
    % figure(3)
    % hold on
    % scatter(By,Bx,20,angle,'filled')
    % figure(4)
    % hold on
    % scatter(By,Bx,20,angle,'filled')

end


%% Make the plots look acceptable

figure(1);
title 'Parallel signal'
ylabel 'B_p_e_r_p_e_n_d_i_c_u_l_a_r [Oe]'
xlabel 'B_p_a_r_a_l_l_e_l [Oe]'
colormap(parula)
axis equal
colorbar
ax = gca;
ax.XAxisLocation = 'origin';
ax.YAxisLocation = 'origin';

figure(2); 
title 'Perpendicular signal'
xlabel 'B_p_e_r_p_e_n_d_i_c_u_l_a_r [Oe]'
ylabel 'B_p_a_r_a_l_l_e_l [Oe]'
caxis([-0.0001,0.0001])
colormap(parula);
colorbar
axis equal
ax = gca;
ax.XAxisLocation = 'origin';
ax.YAxisLocation = 'origin';

% figure(3)
% title 'Angle test for parallel signal'
% 
% figure(4)
% title 'Angle test for perpendicular signal'

figure; 
plot(plstr(2,:),plstr(1,:),'k+'); hold on
plot(plstr(4,:),plstr(3,:),'k+')
axis([-800,800,-800,800])
axis equal;
ax = gca;
ax.XAxisLocation = 'origin';
ax.YAxisLocation = 'origin';
title 'Rotational switching astroid'
xlabel 'B_p_e_r_p_e_n_d_i_c_u_l_a_r [Oe]'
ylabel 'B_p_a_r_a_l_l_e_l [Oe]'