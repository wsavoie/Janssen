function [out]=readShake(D,o,pouredPartsType,fold,PourOrCrush)

[path,outfold,ext]=fileparts(fold);
fname=[outfold,ext];
crushType=2;
Np=dir2(fold,1);
expr='=([-\d.]+)';
[pat, t] =regexp(fname,expr,'tokens','match');
p = str2double([pat{:}]);
if length(p)==4
    a1=90; a2=90;
    w=p(1); l=p(2);
    o=p(3); r=p(4);
elseif length(p)==3
    w=p(1); l=p(2); r=p(4);
elseif length(p)==7
    a1=p(1); a2=p(2); l=p(3); w=p(4); d=p(5); o=p(6); r=p(7);
else
    error(['unrecognizable amount of params for folder name ',fname...
        ,' found ',num2str(length(p))]);
end

%get molecule number file
f2=dir2(fold);
Np=f2.name;

%get atoms per molecule
datname=fname;
%really ugly way to get file
c=dir(fullfile(fold,Np));

for i=1:numel(c)
    if(regexp(c(i).name,'(w=)','match','once'))
    break
    end
end 
apm=importdata(fullfile(fold,Np,c(i).name));


apm=regexp(apm.textdata(2),'\d*','match');
apm = str2double(apm{1});
%check if poured/apm

if(PourOrCrush==0) %0 = pour
    dat=readdump_all(fullfile(fold,Np,'lastFramePour.txt'));
elseif(PourOrCrush==1) %1 = crush
    dat=readdump_all(fullfile(fold,Np,'lastFrameEnd.txt'));
    crushParts = length(dat.atom_data(dat.atom_data(:,2)==crushType,:));
    if(abs(crushParts-12302)>10)
        pts(fold,crushParts,' ',crushParts,'/',12302,' crush particles'); 
    end
end
L=l*D*o;
W=w*D*o;
N=str2double(Np);

pouredParts = dat.atom_data(dat.atom_data(:,2)==pouredPartsType,:);
atoms=size(pouredParts,1); %number of particles
if atoms/(apm*N)~=1
    %             error(['missing some particles in file ',fold,radFolds(i).name])
    pts(fold,' not enough particles');
end

% vp=pi*(D/2)^2*(2*L+W+4/3*(D/2));
% vp=(4*pi/3*(D/2)^3)*(w+l);

%%%%%%%precise vol%%%%%%%%%

v=5/12*pi*(D/2)^3; %overlap volume
V=4/3*pi*(D/2)^3-v;%non-overlap volume
VV=V-v;%non overlap volume for a double overlapped volume
vf=@(n) 2*V+(n-1)*v+(n-2)*VV; %function for volume given a number of spheres
vp=vf(w)+2*vf(l);

%%%%%%%%%%%%%%%%%%%%%%%%
% r=r+D/2;
temp= sortrows(pouredParts,5);
% H=mean(temp(end-300:end,5));
% h=importdata(fullfile(fold,Np,'finalHeight.txt'),' ',4);
% h=h.data(:,end);
% H=max(h)+min(h);
xx=1/2*max(L,W)*cos(pi/4);
% H=H+xx;
H=mean(temp(end,5))+xx;

phi=(N*vp)/(pi*r^2*H(end));
LW=L/W;


[~,ord]=sort(L,'ascend');

out=[a1,a2,L,W,LW,phi,vp,H,r,N,pouredPartsType];
save([fold,'/','stapleDat.mat'],'vp','L','W','H','r','N','D','pouredPartsType','phi','LW','ord','a1','a2');
end
