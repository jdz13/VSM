function [rejigy] = offset_tool (X,Y)

hline = gline();
w(1) = waitforbuttonpress; w(2) = waitforbuttonpress;
coefficients = polyfit([hline.XData(2), hline.XData(1)], [hline.YData(2), hline.YData(1)], 1);
gradient = coefficients (1);
intercept = coefficients (2);
checkergrad = (hline.YData(2)- hline.YData(1))/(hline.XData(2)- hline.XData(1));


rejigy = Y - intercept - (gradient.*X);
end 
