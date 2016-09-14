simMass = 1;
simDiam = 1;
simGrav = 1;
simDt   = .001;
inCylR  = 3.5;

g       = 9.8;         %actual gravity
d       = 0.006;       %actual single particle diam
m       = 0.0001;      %actual single particle mass .0001165 kg

% http://lammps.sandia.gov/doc/units.html unit and conversions
%* is unitless quantity
sigma= d/simDiam;
epsilon= g*m*sigma/(simMass*simGrav);
tau = (sigma^2*m/epsilon)^(1/2);

dt      =  tau*simDt;

data=readdump_all('1000/lastframePour.txt');
tFinal = data.timestep*dt;
forceLast=importdata('1000/forces.txt');
fzS=forceLast.data(1,4);
lfzS=forceLast.data(2:end,4);
fz =fzS*epsilon/sigma;
lfZfz =fzS*epsilon/sigma;
areaz = sigma^2*pi*inCylR.^2;
pressure =fz/areaz;

trueForce = m*1000*9.8;
measuredForce = fz;
[trueForce measuredForce langForceEarly langForceLate]
% t= tau*tS;
% f= fS.*epsilon/sigma;
% pos = posS*sigma;
% areaz = sigma^2*pi*inCylR.^2;
