function [out]=readShake(D,o,pouredPartsType,fold,PourOrCrush)

[path,outfold,ext]=fileparts(fold);
fname=[outfold,ext];
crushType=2;
Np=dir2(fold,1);
expr='=([-\d.]+)';
[pat, t] =regexp(fname,expr,'tokens','match');
p = str2double([pat{:}]);
if length(p)==4
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
apm=importdata(fullfile(fold,Np,datname(1:end-7)));
apm=regexp(apm.textdata(2),'\d*','match');
apm = str2double(apm{1});
%check if poured/apm

if(PourOrCrush==0) %0 = pour
    dat=readdump_all(fullfile(fold,Np,'lastFramePour.txt'));
elseif(PourOrCrush==1) %1 = crush
    dat=readdump_all(fullfile(fold,Np,'lastFrameCrush.txt'));
    crushParts = length(dat.atom_data(dat.atom_data(:,2)==crushType,:));
    if(abs(crushParts-12302)>10)
        pts(fold,crushParts,' ',crushParts,'/',12302,' crush particles'); 
    end
end
L=l*D*o-D;
W=w*D*o-D;
N=str2double(Np);

pouredParts = dat.atom_data(dat.atom_data(:,2)==pouredPartsType,:);
atoms=size(pouredParts,1); %number of particles
if atoms/(apm*N)~=1
    %             error(['missing some particles in file ',fold,radFolds(i).name])
    pts(fold,' not enough particles');
end

vp=pi*(D/2)^2*(2*L+W+4/3*(D/2));

temp= sortrows(pouredParts,5);
H=mean(temp(end-300:end,5));
phi=(N*vp)/(pi*r^2*H);
LW=L/W;

out=[a1,a2,L,W,LW,phi,vp,H,r,N,pouredPartsType];

% [~,ord]=sort(L,'ascend');
% save([fold,'/','stapleDat.mat'],'VP','L','W','H','R','N','D','pouredPartsType','','phi','LW','ord','a1','a2');
end
