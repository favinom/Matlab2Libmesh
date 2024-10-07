clear all
close all

x=linspace(0,1,4);
m=Grid(x,x);

m.elemflag(:,:)=2;
[w]=find(m.Xc<0.6);
m.elemflag(w)=4;

exportMeshToVTK('basicExample.vtk',m);
appendSolutionToVtkFile('basicExample.vtk','basicExample.vtk',m.elemflag,'elemflag','CELL');
exportMeshToXDA('basicExample.xda', m, '1.8.0')
