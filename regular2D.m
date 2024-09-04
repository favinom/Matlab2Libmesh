clear all
close all

be=1280;
be2=be/2;
be4=be/4;
be8=be/8;

fe=16;

eps=1e-4;
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

m=Mesh2D(xx,yy);
m.writeToFile('ciao.xda','1.3.0');
