function appendSolutionToVtkFile(meshfile,filename,solution,variableName,datatype)

if ~strcmp(meshfile,filename)
    if ispc
        string=['copy ',meshfile,' ',filename,' >NUL'];
    else
        string=['cp ',meshfile,' ',filename];
    end
    system(string);
end

npoint=numel(solution);

fid=fopen(filename,'a');

if strcmp(datatype,'CELL')
    datatype=['CELL_DATA'];
elseif strcmp(datatype,'POINT')
    datatype=['POINT_DATA'];
else
    error('datatype can be POINT OR CELL')
end

fprintf(fid, [datatype,' %d\n'], npoint);
fprintf(fid, ['SCALARS ',variableName,' float 1\n']);
fprintf(fid, 'LOOKUP_TABLE default\n');
fprintf(fid, '%f\n', solution);
fclose(fid);
