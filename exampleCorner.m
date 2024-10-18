clear all
close all

% define a 1D set of coordinates
x=linspace(0,1,41);
% define a tensor grid
g=TensorGrid2D(x,x);

[xc,yc]=g.centers;

w=find(0.25 < xc & xc <0.75 & yc>0.5);
g.i_elemflag(w)=2;

exportMeshToVTK('cornerMesh.vtk',g);
appendSolutionToVtkFile('cornerMesh.vtk',[],g.i_elemflag,'elemflag','CELL');
exportMeshToXDA('cornerMesh.xda', g, '1.8.0')
