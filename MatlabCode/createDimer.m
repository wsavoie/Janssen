% create dimer

l=5;
w=10;

N=2*l+w;
t=[90,90]; deg=1; %setting theta is degrees

diam=1;
type=3;
mass=0.5236;
overlap=.5;
%create matrices for generation
pos=createStaple(diam,l,w,t,deg,overlap);
types=type*ones(1,N);
masses=mass*ones(1,N);
diams=diam*ones(1,N);
filename=['a1=',num2str(t(1)),'_a2=',num2str(t(2)),'_l=',num2str(l),'_w=',num2str(w),'_d=',num2str(diam),'_o=',num2str(overlap)];
fold='/home/ws/Janssen/Dimers/';
generateLammpsDimer( pos,types,diams,masses,filename,fold);
