function []= parseFolders()
pouredPartsType=3; %type value of poured particles
[fold] = uigetdir('B:\lammps2 jan res');
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
    
    if isequal(radFolds(i).name,'stapleDat.mat')
        dataLoaded=1;
        load([fold,'/','stapleDat.mat']);
    end
end
if(~dataLoaded)
    numLW=length(radFolds);
%     W=L;R=L;N=L;VP=L;phi=L;LW=L;
    for(i=1:numLW)
        innerFold=dir2(fullfile(fold,radFolds(i).name));
        innerFold=dir2(fullfile(innerFold.folder,innerFold.name));
        Np=innerFold.name;
        %        out=[a1,a2,L,W,LW,phi,vp,H,r,N,pouredPartsType];
        out(i,:)=readShake(D,o,pouredPartsType,fullfile(fold,radFolds(i).name),0);
        out2(i,:)=readShake(D,o,pouredPartsType,fullfile(fold,radFolds(i).name),1);
        %outforce=[fout,fbottom]
        outForce(i,:)=readForces(fullfile(fold,radFolds(i).name,Np),0);
        outForce2(i,:)=readForces(fullfile(fold,radFolds(i).name,Np),1);
    end
    
    [~,ord]=sortrows(out,3);
    out=out(ord,:);               out2=out2(ord,:);
    outForce=outForce(ord,:);     outForce2=outForce2(ord,:);
    save([fold,'/','stapleDat.mat'],'out','out2','outForce','outForce2');
end
