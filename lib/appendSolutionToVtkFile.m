function appendSolutionToVtkFile(meshfile,filename,solution,variableName,datatype)

global printFunctionName
if exist('printFunctionName')
    if printFunctionName==1
        disp('appendSolutionToVtkFile')
    end
end

if ~isa(filename,'char')
    filename=meshfile;
end

if isa(variableName,'char')
    save=variableName;
    clear variableName
    variableName{1}=save;
    clear save
end

if ~isa(solution,'cell')
    save=solution;
    clear solution
    solution{1}=save;
    clear save
end

if ~strcmp(meshfile,filename)
    if ispc
        string=['copy ',meshfile,' ',filename,' >NUL'];
    else
        string=['cp ',meshfile,' ',filename];
    end
    system(string);
end

npoint=numel(solution{1});

fid=fopen(filename,'a');

if strcmp(datatype,'CELL')
    datatype=['CELL_DATA'];
elseif strcmp(datatype,'POINT')
    datatype=['POINT_DATA'];
else
    error('datatype can be POINT OR CELL')
end

fprintf(fid, [datatype,' %d\n'], npoint);

for i=1:length(variableName)
    fprintf(fid, ['SCALARS ',variableName{i},' float 1\n']);
    fprintf(fid, 'LOOKUP_TABLE default\n');
    fprintf(fid, '%f\n', solution{i});
end

fclose(fid);
