function [] = generateLammpsDimer( coords,types,diams,masses,filename,fold)
%MAKELAMMPSDIMER generates LAMMPS molecule template file describing
%describing dimer given by inputs

fid = fopen( fullfile(fold,filename),'w+');
N=length(types); %number of atoms
%%create first line (comment line describing file)
fprintf(fid,'# dimer file created by matlab\n');

%%create header info
%define number of atoms in
fprintf(fid,'%g atoms\n',N);
fprintf(fid,'\n');

%% start file info
%define position (coords) of atoms
fprintf(fid,'Coords\n\n');
for i=1:N
    fprintf(fid,'%g %1.12g %1.12g %1.12g\n',i,coords(i,1),coords(i,2),coords(i,3));
end
fprintf(fid,'\n');

%define types
fprintf(fid,'Types\n\n');
for i=1:N
    fprintf(fid,'%g %g\n',i,types(i));
end
fprintf(fid,'\n');

%define Diameters
fprintf(fid,'Diameters\n\n');
for i=1:N
    fprintf(fid,'%g %1.12g\n',i,diams(i));
end
fprintf(fid,'\n');

%define masses
fprintf(fid,'Masses\n\n',N);
for i=1:N
    fprintf(fid,'%g %1.12g\n',N,masses(i));
end

end

