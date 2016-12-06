a1=[-100:20:100];
a2=[-100:20:100];

[X,Y]=meshgrid(a1);

Ax=reshape(X,[1,121]);
Ay=reshape(Y,[1,121]);
scatter(Ax,Ay,'o');
save('configAngles.mat','Ax','Ay')