function exportMeshToVTK(filename, m)

global printFunctionName
if exist('printFunctionName')
    if printFunctionName==1
        disp('exportMeshToVTK')
    end
end

meshType='unstructured';

if isprop(m,'i_isTensorGrid')
    if m.i_isTensorGrid==1
        meshType='rectilinear';
    end
end

switch meshType
   case 'unstructured'
      exportUnstructredToVTK(filename, m);
   case 'rectilinear'
      exportRectilinearToVTK(filename, m);
   otherwise
      error('you should not be here')
end
