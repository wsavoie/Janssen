function [sigOut,sigOutS]=parsed2Sigma(pars,force,sysInfo)
% pars=[a1,a2,L,W,LW,phi,vp,H,r,N,pouredPartsType];
% force=[fout,fbottom]
% sysInfo=[D,o,mup]
%sigOut=[rr,zz] sigOutS=[rrS,zzS]

dS = sysInfo(1); %sim diameter of particles

%%%%WILL BE AN INPUT%%%%%
mS = 5.4936; %molecule mass
MS = 0.0654; %particle mass
np =84;

%%%%%%%%%%%%%%%%%%%%%%%%%
staplem=.123e-3;
stapleW=1.17e-2; %staple w in meters
particlesInSpine=6.5/(sysInfo(2)); %with no overlap
d=stapleW/(particlesInSpine);

[a1,a2,L,W,LW,phi,vpS,HS,rS,N,pouredPartsType]=separateVec(pars,1);
[frrS,fzzS]=separateVec(force,1);
gS = 1; %sim gravity
dtS=.001; %sim timestep
g       = 9.8;         %actual gravity
% d       = 0.006;       %actual single particle diam
m       = staplem/np;      %actual single particle mass .0001165 kg


sigma= d/dS;
epsilon= g*m*sigma/(MS*gS);
tau = (sigma^2*m/epsilon)^(1/2);

dt=tau*dtS;
sigrrS=frrS./(2*pi*rS.*HS);
sigzzS=fzzS./(pi*rS.^2);
mTotS=mS.*N;
rhoS=mTotS./(HS.*pi.*rS.^2);
k= sigrrS./sigzzS;
lambdaS=2*rS./(4.*sysInfo(3).*k);

sigOutS=[sigrrS,sigzzS];

% pressure = reduced LJ pressure, where P* = P sigma^3 / epsilon
sigOut=[sigrrS,sigzzS]*epsilon/sigma^3;


