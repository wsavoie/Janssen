% [fname,path]=uigetfile('~/Janssen/Results');
fname='stapleDat.mat';path='/home/ws/Janssen/Results/lw=1_configspace/';
load([path,fname]);

%%
[a1,a2,L,W,LW,phi,vp,H,r,N,pouredPartsType]=separateVec(out,1);
sysInfo=[0.5,0.5,0.25];
[psig,psigS]=parsed2Sigma(out,outForce,sysInfo);
[csig,csigS]=parsed2Sigma(out2,outForce2,sysInfo);

dsigA=(csig-psig)./(psig); dsigAS=(csigS-psigS)./(psigS);
[dsigrr dsigzz]=separateVec(dsigA,1);
[dsigrrS dsigzzS]=separateVec(dsigAS,1);
A1=[-100:20:100]; A2=[-100:20:100];  [A1q,A2q]=meshgrid(A1,A2);

dsigrrq=griddata(a1,a2,dsigrr,A1q,A2q);
dsigrrSq=griddata(a1,a2,dsigrrS,A1q,A2q);
dsigzzq=griddata(a1,a2,dsigzz,A1q,A2q);
dsigzzSq=griddata(a1,a2,dsigzzS,A1q,A2q);


figure(23);
hold on;
title('\Delta\sigma_{rr}');
% contour3(A1q,A2q,dsigrrq);
surf(A1q,A2q,dsigrrq);
% mesh(A1q,A2q,dsigrrq,'FaceColor','none');

plot3(a1,a2,dsigrr,'k.','markersize',15);
xlabel('\alpha_1');ylabel('\alpha_2');zlabel('\Delta\sigma_{rr}');
colorbar;
figText(gcf,16);
% % axis([-130 130 -130 130 0,1000]);

figure(24);
hold on;
title('\Delta\sigma_{zz} ');
% contour3(A1q,A2q,dsigzzq);
surf(A1q,A2q,dsigzzq);
% mesh(A1q,A2q,dsigzzq,'FaceColor','none');
plot3(a1,a2,dsigzz,'k.','markersize',15);
xlabel('\alpha_1');ylabel('\alpha_2');zlabel('\Delta\sigma_{zz}');
colorbar;
figText(gcf,16);
% axis([-130 130 -130 130 0,5]);