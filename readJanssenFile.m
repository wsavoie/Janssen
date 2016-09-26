% function [data,fzS,lfzS,stressSides] = readJanssenFile(dataFold)
function [data,fxS,fyS,fzS] = readJanssenFile(dataFold)
if(dataFold(end)~='/')
    dataFold(end+1)='/';
end

force=importdata(horzcat(dataFold,'forces.txt'));
fzS=abs(force.data(1,4));
fzA=abs(force.data);

% forceLang=importdata(horzcat(dataFold,'forcesLang.txt'));
% lfzS=forceLang.data(2:end,4);
% 
% sides=importdata(horzcat(dataFold,'cylForces.txt'));
% stressSides=sides.data(2:4);
fxS=abs(force.data(1,2));
fyS=abs(force.data(1,3));
data=readdump_all(horzcat(dataFold,'lastframePour.txt'));
end