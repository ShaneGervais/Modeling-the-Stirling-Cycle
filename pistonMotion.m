%{
Function to calculate the motion of a Piston
by Shane Gervais
Recieves length of the piston extension L
The length of the rod
Compressed volume Vc
Displaced volume Vd
The angle which the rod starts and end
%}
function [V] = pistonMotion(L, rodLength, Vc, Vd, startAngle, endAngle)

pinRadius = L/2;
ratio = rodLength/pinRadius;

compressionRatio = Vd/Vc;

theta = linspace(startAngle, endAngle, 180);

A = (1/2)*(compressionRatio - 1);
B = ratio + 1 - cosd(theta);
C = (ratio^2 - sind(theta).^2).^(1/2);

V = (1 + A*(B - C)).*Vc;

end