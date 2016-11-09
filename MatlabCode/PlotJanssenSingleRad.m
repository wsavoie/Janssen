mS = 4*pi/3*(0.5)^3; %sim mass
dS = 1; %sim diameter of particles
gS = 1; %sim gravity
dtS=.001; %sim timestep

clear pts;

g       = 9.8;         %actual gravity
d       = 0.006;       %actual single particle diam
m       = 0.0001;      %actual single particle mass .0001165 kg
boxPos  = 15.5;
% http://lammps.sandia.gov/doc/units.html unit and conversions
%* is unitless quantity
sigma= d/dS;
epsilon= g*m*sigma/(mS*gS);
tau = (sigma^2*m/epsilon)^(1/2);

pouredPartsType=3; %type value of poured particles

muw=0.5;
% fold = ('A:\LAMMPS\Janssen\');
fold = uigetdir('~/Janssen/Results');
radFolds =dir2(fold);
% radFolds=regexp({radFolds.name},'r=([0-9.]+)','match');
if isempty(radFolds)
    error('no files found!');
end

% data=cell(length(radFolds)*4,1);
c = 0;
clear data
expr='r=*([\d.]+)';
[r, t] =regexp(fullfile(fold,radFolds(1).name),expr,'tokens','match');
partsFolds =dir2(fullfile(fold));
dataLoaded=0;

for(i=1:length(partsFolds))
    
    if isequal(partsFolds(i).name,['JanData.mat']);
        dataLoaded=1;
        load([fold,'/','JanData.mat']);
    end
end

if(~dataLoaded)
    for j=1:length(partsFolds)
        c=c+1;
        %         data(c).rad= str2double(r{1}{1});
        %         data(c).n= str2double(partsFolds(j).name);
        
        dataFold(c)= {fullfile(fold,partsFolds(j).name)};
        pts(dataFold(c));
        
        %%%%%%%%%%%%get all variables first%%%%%%%%%%%%%%
        cylRadS(c)=str2double(r{1}{1});
        [dat(c), frS(c), fzS(c)]=readJanssenFile(dataFold{c},2);
        dt(c)=tau*dtS;
        tfinalS(c) = dat(c).timestep*dtS; tfinal(c)=tfinalS(c)*tau;
        
        pouredParts = dat(c).atom_data(dat(c).atom_data(:,2)==pouredPartsType,:);
        n(c)=length(pouredParts);
        partSub=20;
        temp= sortrows(pouredParts,5);
        hS(c)=temp(end-partSub);
        %         hS=mean(hS((end-partsSub-partsMean):(end-partsSub),5));
        
        sigzzS(c)=fzS(c)/(pi*cylRadS(c)^2);
        sigrrS(c)=frS(c)/(2*pi*cylRadS(c)*hS(c));
        
        mTotS(c)=mS*n(c);
        
        rhoS(c)=mTotS(c)/(hS(c)*pi*cylRadS(c)^2);
        
        k(c)= sigrrS(c)/sigzzS(c);
        lambdaS(c)=2*cylRadS(c)/(4*muw*k(c));
        
        data(c).dataFold=dataFold(c);
        data(c).cylRadS=cylRadS(c);
        data(c).dt=dt(c);
        data(c).tfinalS=tfinalS(c);
        data(c).pouredParts=pouredParts;
        data(c).n=n(c);
        data(c).partSub=partSub;
        data(c).hS=hS(c);
        data(c).sigzzS=sigzzS(c);
        data(c).sigrrS=sigrrS(c);
        data(c).mTotS=mTotS(c);
        data(c).rhoS=rhoS(c);
        data(c).k=k(c);
        data(c).lambdaS=lambdaS(c);
        %         x(c)=hS(:)./lambdaS(:); tmp=sigzzS(:)./(rhoS(:)*gS.*lambdaS(:));
        %         plot(hS(:)./lambdaS(:),sigzzS(:)./(rhoS(:)*gS.*lambdaS(:)),'o','markersize',7);
        %         lmpDat=[hS(:)./lambdaS(:),sigzzS(:)./(rhoS(:)*gS.*lambdaS(:))];
        %%%%%%%%%%%%%%%%%%%%%%%
        %
        %         %         [data(c).dat, data(c).fzS, data(c).lfzS data(c).outStressS] = readJanssenFile(fullfile(fold,radFolds(i).name,partsFolds(j).name));
        %         %         [data(c).dat,data(c).fxS data(c).fyS data(c).fzS] = readJanssenFile(fullfile(fold,radFolds(i).name,partsFolds(j).name),1);
        %         [data(c).dat,data(c).frS,data(c).fzS] = readJanssenFile(fullfile(fold,radFolds(i).name,partsFolds(j).name),2);
        %         data(c).simDt= 0.001;%try and get this from file somehow?
        %         %         data(c).simDt= data(c).dat.timestep;
        %         data(c).dt  =  tau*data(c).simDt;
        %         data(c).tfinal = data(c).dat.timestep*data(c).dt;
        %
        %         data(c).m= 0.0001;
        %
        %
        %         %get all particles
        %         pouredPartsType=3;
        %         partsSub=0;
        %         partsMean=5;
        %         data(c).pouredParts = data(c).dat.atom_data(data(c).dat.atom_data(:,2)==pouredPartsType,:);
        %         data(c).pouredParts = sortrows(data(c).pouredParts,5);
        %         data(c).n = length(data(c).pouredParts)-partsSub;
        %
        %         %         data(c).outStress=sqrt(data(c).fxS^2+data(c).fyS^2)*epsilon/sigma;
        %         data(c).outStress=data(c).frS*epsilon/sigma;
        %         data(c).outStressS=data(c).frS;
        %         %sort particles by height in ascending order
        %         hs= sortrows(data(c).pouredParts,5);
        %         data(c).Hs = mean(hs((end-partsSub-partsMean):(end-partsSub),5)); %height is mean of top 3 particle positions
        %         data(c).H  = data(c).Hs*sigma;
        %
        %         %stress rr = sqrt(xx^2 +yy^2)
        %         %         data(c).outStress=sqrt((data(c).outStressS(1))^2+(data(c).outStressS(2))^2)*epsilon/sigma;
        %
        %         %divide force by inner surface area of cylinder
        %         %h already converted rad needs conversion
        %         data(c).outStress=data(c).outStress/(2*pi*data(c).rad*sigma*data(c).H);
        %
        %         %get fz on bottom plate for lfz and fz
        %         data(c).fz  = data(c).fzS*epsilon/sigma;
        %         %         data(c).lfz = data(c).lfzS*epsilon/sigma;
        %
        %         data(c).areaz = sigma^2*pi*data(c).rad.^2;
        %         data(c).trueWeight = data(c).m*data(c).n*g;
        %
        %
        %         %lamda = D/(4*mu*K) %sig_rr = K*sig_zz k= const. let k =1
        %         %is rho the density of the GM in the container or the density of
        %         %particle?
        %         %         data(c).rho=m/(4*pi*(1/2)^3*sigma^3/3);
        %         data(c).rho=m*data(c).n/(data(c).areaz*data(c).H);
        %         data(c).stress =data(c).fz/data(c).areaz;
        %
        %         crushPartsType=4;
        %
        %         % % %         [crush(c).forces crush(c).data]=readCrushFile(fullfile(fold,radFolds(i).name,partsFolds(j).name),1);
        %         % % %         crush(c).crushParts = crush(c).data.atom_data(crush(c).data.atom_data(:,2)==crushPartsType,:);
        %         % % %         crush(c).pouredParts = crush(c).data.atom_data(crush(c).data.atom_data(:,2)==pouredPartsType,:);
        %         % % %         crush(c).n=length(crush(c).crushParts);
        %         % % %         crush(c).trueWeight=data(c).trueWeight+crush(c).n*m*g;
        %         % % %         crush(c).fz= crush(c).forces(end,4)*epsilon/sigma;
        %         % % %         crush(c).areaz=sigma^2*pi*data(c).rad.^2;
        %         % % %         crush(c).stress=crush(c).fz/crush(c).areaz;
        %         % % %         hs= sortrows(crush(c).pouredParts,5);
        %         % % %         crush(c).Hs = mean(hs((end-5):(end),5)); %height is mean of top 3 particle positions
        %         % % %         crush(c).H  = crush(c).Hs*sigma;
        %         %%%%%%%%%%%%%%%non-units%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %         r = data(c).rad;
        %         fzS =data(c).fzS;
        %
        %
        %         data(c).stress=data(c).fzS/(pi*data(c).rad^2);
        %         data(c).k= data(c).outStressS/ data(c).stress;
        %         data(c).lambda=2*data(c).rad/(4*muw*data(c).k);
        %         %             data(c).lambda=2*data(c).rad;
        %         data(c).z_lam= data(c).Hs/data(c).lambda;
        %         data(c).rho=simMass*data(c).n/(pi*data(c).rad^2*data(c).Hs);
        %         data(c).stress_rhoglam= data(c).stress/(data(c).rho*g*data(c).lambda);
        %
        %
        %
        %         %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        
    end
    a=fullfile(fold);
    save(fullfile(fold,'JanData.mat'),'data');
end
figure(1);
hold on;
x=0:.1:10;plot(x,1-exp(-x),'-');
lmpDat=[[[data(:).hS]./[data(:).lambdaS]]',[[data(:).sigzzS]./([data(:).rhoS].*gS.*[data(:).lambdaS])]'];
lmpDat=sortrows(lmpDat,1); %sort by z/lam
xlabel('z/\lambda'); ylabel('\sigma_{zz}/\rhog\lambda');
plot(lmpDat(:,1),lmpDat(:,2)/max(lmpDat(:,2)),'o--','markersize',7);
plot(lmpDat(:,1),lmpDat(:,2),'o-','markersize',7);

axis([0,10,0,2]);

% for(i=1:c)
% plot(lmpDat(i,1),lmpDat(i,2)/max(lmpDat(:,2)),'o','markersize',7);
% pts(dataFold{i});
% pause;
% end

% figure(2);
% lmpDat2=[hS(:)*sigma,sigrrS(:)*epsilon/sigma^2,];
% plot(lmpDat2(:,1),lmpDat2(:,2),'o-','markersize',7);


% figure(1);
% hold on;
% janDat = [[data(:).z_lam]',[data(:).stress_rhoglam]'];
% janDat=sortrows(janDat,1);
% % plot(janDat(:,1),janDat(:,2),'.-','markersize',12);
% x=0:.1:10;plot(x,1-exp(-x),'-');
% xlabel('z/\lambda'); ylabel('\sigma_{zz}/\rhog\lambda');
%
% figure(2);
% hold on;
% janDat2 = [[data(:).H]',[data(:).stress]'];
% janDat2=sortrows(janDat2,2);
%
% % % % crushDat2= [[crush(:).H]',[crush(:).stress]'];
% % % % crushDat2=sortrows(crushDat2,1);
%
% plot(janDat2(:,1),janDat2(:,2),'.-','markersize',12);

