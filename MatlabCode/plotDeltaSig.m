% [fname,path]=uigetfile('~/Janssen/Results');
fname='stapleDat.mat';path='/home/ws/Janssen/Results/lw=1_configspace/';
load([path,fname]);


%%
%out/outForce   = pour data
%out2/outForce2 = crush data
%out=[a1,a2,L,W,LW,phi,vp,H,r,N,pouredPartsType];
%force=[forceOut,forceBottom];

%full config space
A1=[-100:20:100];
A2=[-100:20:100];
[a1,a2,L,W,LW,phi,vp,H,r,N,pouredPartsType]=separateVec(out,1);
[A1q,A2q]=meshgrid(A1,A2);
phiq=griddata(a1,a2,phi,A1q,A2q);
figure(5)
hold on;
plot3(a1,a2,phi,'o');
mesh(A1q,A2q,vq);
xlabel('\alpha_1');ylabel('\alpha_2');zlabel('\phi');
axis([-130 130 -130 130 0.085, 0.13]);
%%



[X1,X2]=meshgrid(A1,A2);
Z=ones(size(X1,1),size(X1,2))*NaN;

P=zeros(size(X1,1),size(X1,2),2);
P(:,:,1)=X1;P(:,:,2)=X2;
a=[a1,a2];
zz=[a,phi];
for(i=1:numel(X1))
    [I,J]=ind2sub([size(X1,1),size(X1,2)],i);
    [~,found]= ismember(squeeze(P(I,J,:))',a,'rows');
    if(found==0)
    else
        Z(I,J)=phi(found);
    end
    
end
% Z(isnan(Z(:)))=0;

figure(1);
hold on;
mesh(X1,X2,Z);
scatter(a1,a2);

% scatter(a1,a2)
% % a
% [X1,X2]=meshgrid(a1,a2);
% contour(L,W,phi)    
%%

griddata(a1,a2,phi,A1,A2)

%%
[a1,a2,L,W,LW,phi,vp,H,r,N,pouredPartsType]=separateVec(out,1);
sysInfo=[0.5,0.5,0.25];
[psig,psigS]=parsed2Sigma(out,outForce,sysInfo);
[csig,csigS]=parsed2Sigma(out2,outForce2,sysInfo);

dsigA=(csig-psig); dsigAS=(csigS-psigS);
[dsigrr dsigzz]=separateVec(dsigA,1);
[dsigrrS dsigzzS]=separateVec(dsigAS,1);
A1=[-100:20:100]; A2=[-100:20:100];  [A1q,A2q]=meshgrid(A1,A2);

dsigrrq=griddata(a1,a2,dsigrr,A1q,A2q);
dsigrrSq=griddata(a1,a2,dsigrrS,A1q,A2q);

figure(23);
hold on;
title('\Delta\sigma_{rr}');
plot3(a1,a2,dsigrr,'o');
mesh(A1q,A2q,dsigrrq);
xlabel('\alpha_1');ylabel('\alpha_2');zlabel('\Delta\sigma_{rr}');


figure(24);
hold on;
title('\Delta\sigma_{rr}_{sim} ');
plot3(a1,a2,dsigrrS,'o');
mesh(A1q,A2q,dsigrrSq);
xlabel('\alpha_1');ylabel('\alpha_2');zlabel('\Delta\sigma_{rr}');