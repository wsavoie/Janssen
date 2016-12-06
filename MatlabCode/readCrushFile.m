function [ varargout ] = readCrushFile( dataFold,type,crushOrPour)
%READCRUSHFILE reads and outputs data from lammps janssen data
%   reads and outputs data from lammps janssen data where a mass is
%   generated on top of GM which has already been settled

if(dataFold(end)~='/')
    dataFold(end+1)='/';
end


switch type
    case 1
        nOutputs = 1;%[data,fxS,fyS,fzS]
        varargout = cell(1,nOutputs);
        
        force=importdata(horzcat(dataFold,'crushforces.txt'));
        force = abs(force.data);
        varargout{1}=force;
        
        data=readdump_all(horzcat(dataFold,'lastFrameCrush.txt'));
        varargout{2}=data;
end



end

