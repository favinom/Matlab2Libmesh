clear all
close all

be=1280;
be2=be/2;
be4=be/4;
be8=be/8;

fe=16;

eps=1e-3;
c=[0.5 0.625 0.75];

l=[0 c(1)-eps/2 c(1)+eps/2 c(2)-eps/2 c(2)+eps/2 c(3)-eps/2 c(3)+eps/2];

r=[c(1)-eps/2 c(1)+eps/2 c(2)-eps/2 c(2)+eps/2 c(3)-eps/2 c(3)+eps/2 1];

elementVector=[be2 fe be8 fe be8 fe be4];

for i=1:length(l)
    x{i}=linspace(l(i),r(i),elementVector(i)+1);
end

xx=x{1};
for i=2:length(l)
    xx=[xx x{i}(2:end)];
end

yy=xx;
[~,i]=min(abs(yy-0.7));
yy(i)=0.7;

g=TensorGrid2D(xx,yy);

[xc,yc]=g.centers;

w=cell(6,1);

w{1}=find( c(1)-eps/2 < xc & xc <c(1)+eps/2);
w{2}=find( c(1)-eps/2 < yc & yc <c(1)+eps/2);

w{3}=find( c(3)-eps/2 < xc & xc <c(3)+eps/2 & 0.5<yc);
w{4}=find( c(3)-eps/2 < yc & yc <c(3)+eps/2 & 0.5<xc);

w{5}=find( c(2)-eps/2 < xc & xc <c(2)+eps/2 & 0.5<yc & yc<0.75);
w{6}=find( c(2)-eps/2 < yc & yc <c(2)+eps/2 & 0.5<xc & xc<0.75);

W=cell2mat(w);

g.i_elemflag(W)=2;

exportMeshToVTK('meshRegular.vtk',g);
appendSolutionToVtkFile('meshRegular.vtk','elemFlag.vtk',g.elemflag,'elemflag','CELL');
exportMeshToXDA('meshRegular.xda', g, '1.8.0');

