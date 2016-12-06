function [ force ] = readForces( dataFold,PourOrCrush)
%READFORCES Summary of this function goes here
%   Detailed explanation goes here
%         nOutputs = 1;%[data,fxS,fyS,fzS]
%         varargout = cell(1,nOutputs);
        fname='';
        if(PourOrCrush==0) %pourData
            fname='forces.txt';
        elseif(PourOrCrush==1) %crush data
            fname='crushforces.txt';
        else
            error('did not specify correctly pourOrCrush var');
        end
        fOut=importdata(fullfile(dataFold,fname));
        force=fOut.data;
        force = abs(force);
%         varargout{1}=force;
end

