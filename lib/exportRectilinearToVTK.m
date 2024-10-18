function exportRectilinearToVTK(filename, m)

global printFunctionName
if exist('printFunctionName')
    if printFunctionName==1
        disp('exportRectilinearToVTK')
    end
end

fileID = fopen(filename, 'w');

x=m.x;
y=m.y;
z=0;

nx=length(x);
ny=length(y);
nz=length(z);

% header
fprintf(fileID, '# vtk DataFile Version 3.0\n');
fprintf(fileID, 'Rectilinear Grid\n');
fprintf(fileID, 'ASCII\n');
fprintf(fileID, 'DATASET RECTILINEAR_GRID\n');

% Scriviamo le dimensioni della griglia
fprintf(fileID, 'DIMENSIONS %d %d %d\n', nx, ny, nz);

% Scriviamo le coordinate X
fprintf(fileID, 'X_COORDINATES %d float\n', nx);
fprintf(fileID, '%f \n', x);

% Scriviamo le coordinate Y
fprintf(fileID, 'Y_COORDINATES %d float\n', ny);
fprintf(fileID, '%f \n', y);

fprintf(fileID, 'Z_COORDINATES %d float\n', nz);
fprintf(fileID, '%f \n', z);

fclose(fileID);
