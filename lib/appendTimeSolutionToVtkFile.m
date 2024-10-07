function appendTimeSolutionToVtkFile(meshfile,filebase,solution,,variableName,datatype)

for i=1:size(solution,2)
    
    idname=num2str(i);
    if i<10
        idname=['0',idname];
    end
    if i<100
        idname=['0',idname];
    end
    if i<1000
        idname=['0',idname];
    end
    
    filename=[filebase(1:end-4),idname,filebase(end-3:end)];
    appendSolutionToVtkFile(meshfile,filename,solution(:,i),variableName,datatype);

end
