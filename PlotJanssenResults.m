simMass = 1;
simDiam = 1;
simGrav = 1;


% simDt   = data.timestep;
inCylR  = 3.5;

g       = 9.8;         %actual gravity
d       = 0.006;       %actual single particle diam
m       = 0.0001;      %actual single particle mass .0001165 kg
boxPos  = 15.5;
% http://lammps.sandia.gov/doc/units.html unit and conversions
%* is unitless quantity
sigma= d/simDiam;
epsilon= g*m*sigma/(simMass*simGrav);
tau = (sigma^2*m/epsilon)^(1/2);



fold = ('A:\LAMMPS\Janssen\');
% fold = uigetdir('A:\LAMMPS\Janssen');
radFolds =dir2(fold);
radFolds= radFolds(strncmpi('r=', {radFolds.name}, 2));
if isempty(radFolds)
    error('no files found!');
end

% data=cell(length(radFolds)*4,1);
c = 1;
for(i=1:length(radFolds))
    expr='r=*([\d.]+)';
    [r, t] =regexp(fullfile(fold,radFolds(i).name),expr,'tokens','match');
    partsFolds =dir2(fullfile(fold,radFolds(i).name));
    for j=1:length(partsFolds)
        data(c).rad= str2double(r{1}{1});
        data(c).n= str2double(partsFolds(j).name);
        
        pts(fullfile(fold,radFolds(i).name,partsFolds(j).name));


        [data(c).dat, data(c).fzS, data(c).lfzS] = readJanssenFile(fullfile(fold,radFolds(i).name,partsFolds(j).name));
        data(c).simDt= 0.001;%try and get this from file somehow?
%         data(c).simDt= data(c).dat.timestep;
        data(c).dt  =  tau*data(c).simDt;
        data(c).tfinal = data(c).dat.timestep*data(c).dt;
        
        data(c).m= 0.0001;
       
        
    
        pouredPartsType=3;
        data(c).pouredParts = data(c).dat.atom_data(data(c).dat.atom_data(:,2)==pouredPartsType,:);
        data(c).n = length(data(c).pouredParts);

        data(c).Hs = mean(data(c).pouredParts(1:3,5)+boxPos); %height is mean of top 3 particle positions
        data(c).H  = data(c).Hs*sigma;
        

        data(c).fz  = data(c).fzS*epsilon/sigma;
        data(c).lfz = data(c).lfzS*epsilon/sigma;

        data(c).areaz = sigma^2*pi*data(c).rad.^2;
        data(c).stress =data(c).fz/data(c).areaz;
        
        data(c).trueWeight = data(c).m*data(c).n*g;
        
        %lamda = D/(4*mu*K) %sig_rr = K*sig_zz k= const. let k =1
        data(c).lambda=2*data(c).rad*sigma/(4*.08*1);
        
        %is rho the density of the GM in the container or the density of
        %particle?
        data(c).rho=m/(4*pi*1/2*sigma^3/3);
        data(c).rhoSys=m*data(c).n/(data(c).areaz*data(c).H);
        
        data(c).stress_rhoglam= data(c).stress(1)/(data(c).rho*g*data(c).lambda);
        data(c).z_lam= data(c).H/data(c).lambda;
        c=c+1;
    end
    

end

janDat = [[data(:).z_lam]',[data(:).stress_rhoglam]'];
janDat=sortrows(janDat,2);

plot(janDat(:,1),janDat(:,2),'.','markersize',12);

% plot(0:data(c):.*,data(c).lfz);
% ylabel('Normal force on bottom plate (N)');
% xlabel('time')
% figText(4,13)

% numParts = 1000;
% rad = 3.5;
% fold = horzcat('r=',num2str(rad),'/',num2str(numParts));
% data=readdump_all(horzcat(fold,'/lastframePour.txt'));
% tFinal = data.timestep*dt;
% pouredPartsType=3;
% pouredParts=data.atom_data(data.atom_data(:,2)==pouredPartsType,:);
% pouredParts=sortrows(pouredParts,-5);
% Hs=mean(pouredParts(1:3,5)+boxPos); %height is mean of top 3 particle positions
% H=Hs*sigma;
% 
% 
% 
% force=importdata(horzcat(fold,'/forces.txt'));
% fzS=force.data(1,4);
% 
% forceLang=importdata(horzcat(fold,'/forcesLang.txt'));
% lfzS=forceLang.data(2:end,4);
% 
% fz =fzS*epsilon/sigma;
% halfLF= floor(length(lfzS)/2);
% lfZfzEarly =lfzS(1:halfLF).*epsilon/sigma;
% lfZfzLate =lfzS(1:end)*epsilon/sigma;
% areaz = sigma^2*pi*inCylR.^2;
% pressure =fz/areaz;
% 
% trueForce = m*500*9.8;
% measuredForce = fz;
% % [trueForce measuredForce lfZfzEarly lfZfzLate]
% [trueForce measuredForce mean(lfZfzLate)]
% figure(4);
% hold on;
% % plot(lfZfzEarly);
% plot(lfZfzLate);
% ylabel('Normal force on bottom plate (N)');
% xlabel('time')
% mean(lfZfzLate);
% figText(4,13)
% 
% %lamda = D/(4*mu*K) %sig_rr = K*sig_zz k= const. let k =1
% lambda = 2*inCylR*sigma/(4*.08*1);
% 
% rho=m/(4*pi*1*sigma^3/3);
% 
% yax= pressure(1)/(rho*g*lambda);
% xax= H/lambda;
% 



% t= tau*tS;
% f= fS.*epsilon/sigma;
% pos = posS*sigma;
% areaz = sigma^2*pi*inCylR.^2;
