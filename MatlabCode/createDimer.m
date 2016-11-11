% create dimer

l=4;
w=6;

N=2*l+w;
t=[90,90]; deg=1; %setting theta is degrees

diam=1;
type=1;
mass=0.5236;
overlap=0.25;
%create matrices for generation
pos=createStaple(diam,l,w,t,deg,overlap);
types=type*ones(1,N);
masses=mass*ones(1,N);
diams=diam*ones(1,N);
filename=['a1=',num2str(t(1)),'_a2=',num2str(t(2)),'_l=',num2str(l),'_w=',num2str(w),'_d=',num2str(diam),'_o=',num2str(overlap)];
fold='/home/ws/Janssen/Dimers/';

[momI,com]=CalcMomentOfInertiaAndCOM(pos,masses);

generateLammpsDimer( pos,types,diams,masses,com,momI,filename,fold);
