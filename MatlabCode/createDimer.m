% create dimer
% for i=0:6:36
l=28;
w=28;

N=2*l+w;

%%%%
load('configAngles.mat');
% for i=1:length(Ax)
    t=[-100,-80]; deg=1;
%%%%%
%     t=[90,90]; deg=1; %setting theta is degrees

diam=0.5;
type=3;
mass=0.0654;
overlap=0.5;
%create matrices for generation
pos=createStaple(diam,l,w,t,deg,overlap);
types=type*ones(1,N);
masses=mass*ones(1,N);
diams=diam*ones(1,N);
filename=['a1=',num2str(t(1)),'_a2=',num2str(t(2)),'_l=',num2str(l),'_w=',num2str(w),'_d=',num2str(diam),'_o=',num2str(overlap)];
% filename=['w=',num2str(w),'_l=',num2str(l),'_o=',num2str(overlap)];
fold='/home/ws/Janssen/Dimers/';

[momI,com]=CalcMomentOfInertiaAndCOM(pos,masses);

generateLammpsDimer( pos,types,diams,masses,com,momI,filename,fold);
% end