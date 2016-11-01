% create dimer

l=2;
w=4;

N=2*l+w;
t=[90,90]; deg=1;

diam=1;
type=3;
mass=0.5236;

%create matrices for generation
pos=createStaple(diam,l,w,t,deg);
types=type*ones(1,N);
masses=mass*ones(1,N);
diams=diam*ones(1,N);
filename=['a1=',num2str(t(1)),'_a2=',num2str(t(2)),'_l=',num2str(l),'_w=',num2str(w),'_d=',num2str(diam)];
fold='/home/ws/Janssen/Dimers/';
generateLammpsDimer( pos,types,diams,masses,filename,fold);
