%************************************************************
%* Fig numbers:
%* 1. plot phi vs lw
%* 2. plot phi vs a2
%************************************************************
showFigs=[2];

D=0.5;
o=0.5;
[fold] = uigetdir('B:\lammps2_jan_res\staplesEx3');
foldz=dir2(fold,'folders');
out=[];
for i=1:length(foldz)
   out(i,:)=readShake(D,o,3,fullfile(fold,foldz(i).name),1);
end
%% 1 plot phi vs l/w
xx=1;
if(showFigs(showFigs==xx))
    figure(xx)
    uniInd=5;    
    uni=unique(out(:,uniInd));
    ephi=[];mphi=[];dat={};
    for(i=1:length(uni))
        dat(i)={out(out(:,uniInd)==uni(i),6)};
    end
    ephi=cell2mat(cellfun(@std,dat,'UniformOutput',0));
    mphi=cell2mat(cellfun(@mean,dat,'UniformOutput',0));
    errorbar(uni,mphi,ephi)

    % plot(out(ord,5),out(ord,6),'o-','linewidth',2)
    hold on;
    %plot nicks data
    nickD=[[0:.1:1.4]',[.27 .235 .208 .185 .163 .148 .136 .13 .118 .11 .105 .1025 .095 .09 .085]'];
    plot(nickD(:,1),nickD(:,2),'ro-','linewidth',2);
    xlabel('L/W');
    ylabel('\phi');
    axis([0 1.4 0.05 0.3]);
    figText(gcf,16);
end
%% 2 plot phi vs a2
xx=2;
if(showFigs(showFigs==xx))
    figure(xx)

    uniInd=2;    
    uni=unique(out(:,uniInd));
    ephi=[];mphi=[];dat={};
    for(i=1:length(uni))
        dat(i)={out(out(:,uniInd)==uni(i),6)};
    end
    ephi=cell2mat(cellfun(@std,dat,'UniformOutput',0));
    mphi=cell2mat(cellfun(@mean,dat,'UniformOutput',0));
    errorbar(uni,mphi,ephi)
    hold on;
    xlabel('a2');
    ylabel('\phi');
    xlim([-110 110]);
    figText(gcf,16);
end

