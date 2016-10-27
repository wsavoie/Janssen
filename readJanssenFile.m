% function [data,fzS,lfzS,stressSides] = readJanssenFile(dataFold)
function varargout = readJanssenFile(dataFold,type)
[~,p]=system('who');
if(p(1:2)=='ws')
    if(dataFold(end)~='/')
        dataFold(end+1)='/';
    end
else
        if(dataFold(end)~='\')
        dataFold(end+1)='\';
        end
end
switch type
    case 1%before crush implementation
        
        nOutputs = 4;%[data,fxS,fyS,fzS]
        varargout = cell(1,nOutputs);
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
%          
        varargout{1}=data;
        varargout{2}=fxS;
        varargout{3}=fyS;
        varargout{4}=fzS;
        case 2%linux ocomp edited gran wall
        
        nOutputs = 3;%[data,fxS,fyS,fzS]
        varargout = cell(1,nOutputs);
        force=importdata(horzcat(dataFold,'forces.txt'));
        
        % forceLang=importdata(horzcat(dataFold,'forcesLang.txt'));
        % lfzS=forceLang.data(2:end,4);
        %
        % sides=importdata(horzcat(dataFold,'cylForces.txt'));
        % stressSides=sides.data(2:4);
        frS=abs(force.data(1,1));
        fzS=abs(force.data(1,2));
        data=readdump_all(horzcat(dataFold,'lastFramePour.txt'));
%          
        varargout{1}=data;
        varargout{2}=frS;
        varargout{3}=fzS;
end