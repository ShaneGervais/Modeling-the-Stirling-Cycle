%{
Modeling the Stirling Cycle
by Shane Gervais
2022/04/06
This program is to model the Stirling Cycle in a PV graph
based on a realistic Stirling Engine
%}

close all
clear all
clc

R = 1.25; %cm Radius of piston
Ap = 1.9; %cm^2 surface area of piston
Vc = 40; %cm^3 Compressed volume
theta0 = 0; %angle at which we have max amplitude
L = 20; %cm Stroke length of the piston
rodLength = 30; %cm Rod length
Th = 600; %K Max temperature
Tl = 300; %K Min Temperature
kB = 1.38064852E-23; %m^2kgs^-2K^-1 Boltzman constant
N = 6.02214E23; %number of particles
Na = 6.02214E23;%mol^-1 Avegadro's number
Rconstant = kB*Na;
n = N/Na; %Number of moles

x0 = R*(1 + cosd(theta0)); %Maximum amplitude of x
Vd = Vc + Ap*x0; %Displacement volume
Pa = (n*Rconstant*Th)/Vc;

%At point A
Vexp = pistonMotion(L, rodLength, Vc, Vd, 0, 180);
constant = Pa*Vc;
Pexp = constant./Vexp;

%Isothermal from A to B
%With PaVa = PbVb
Pb = Pa*(Vc/Vd);

%Isochoaric from B to C
%With Pb/Tb = Pc/Tc
Pc = Pb*(Tl/Th);
Vcomp = pistonMotion(L, rodLength, Vc, Vd, 180, 0);
constant = Pc*Vd;
Pcomp = constant./Vcomp;

%Isochoric from C to D
%With PcVc = PdVd
Pd = Pc*(Vd/Vc);

%Plot the cycle
figure(1)
hold on
plot(Vexp, Pexp, 'r')
plot([Vd Vd], [Pb Pc], 'k')
plot(Vcomp, Pcomp, 'b')
plot([Vc Vc], [Pd Pa], 'm')
legend('A -> B Isothermal', 'B -> C Isochoric', 'C -> D Isothermal', 'D -> A Isochoric')
axis([39.8 45 50 130])
xlabel('Volume (/cm^3)')
ylabel('Pressure (/cPa)')