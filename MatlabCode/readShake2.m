pouredPartsType=3; %type value of poured particles
fold = uigetdir('~/Janssen/Results');
radFolds =dir2(fold);
% radFolds=regexp({radFolds.name},'r=([0-9.]+)','match');
if isempty(radFolds)
    error('no files found!');
end

c = 1;
clear data
D=0.5;
o=0.5;
dataLoaded=0;
for(i=1:length(radFolds))
    
    if isequal(radFolds(i).name,'stapleDat.mat');
        dataLoaded=1;
        load([fold,'/','stapleDat.mat']);
    end
end

if(~dataLoaded)
    n=length(radFolds);
    L=zeros(n,1);
    W=L;R=L;N=L;VP=L;phi=L;LW=L;
    for(i=1:n)
        pts(i,'/',n);
        expr='([\d.]+)';
        fname =fullfile(fold,radFolds(i).name);
        [pat, t] =regexp(radFolds(i).name,expr,'tokens','match');
        w=str2double(pat{1}); l=str2double(pat{2}); r=str2double(pat{3});
        f2=dir2(fname);
        Np=f2.name;
%         dat=readdump_all([fname,'/',Np,'/lastFrameEnd.txt']);
        L(i)=l*D*o-D;
        W(i)=w*D*o-D;
        R(i)=r;
        N(i)=str2double(Np);
%         pouredParts = dat.atom_data(dat.atom_data(:,2)==pouredPartsType,:);
%         NP=size(pouredParts,1); %number of particles
        x=importdata([fname,'/',Np,'/finalHeight.txt']);
        H(i)=x.data;
        
        vp=pi*(D/2)^2*(2*L(i)+W(i)+4/3*(D/2));
        VP(i)=vp;
%         temp= sortrows(pouredParts,5);
%         H(i)=mean(temp(end-800:end,5))+20;
%         N(i)=round(NP/(2*L(i)+W(i)));
        
        phi(i)=(N(i)*VP(i))/(pi*(R(i))^2*H(i));
        LW(i)=L(i)/W(i);    
    end
    [~,ord]=sort(L,'ascend');
    save([fold,'/','stapleDat.mat'],'VP','L','W','H','R','N','D','pouredPartsType','phi','LW','ord');
end


plot(LW(ord),phi(ord));