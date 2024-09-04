clear all
close all

% xc=0.5;
% eps=1e-3;
% ney=1000;%1000;
% nex=499;%499;
% nf=2;
% 
% x1=linspace(0,xc-eps/2,nex+1);
% x2=linspace(xc-eps/2,xc+eps/2,nf+1);
% x3=linspace(xc+eps/2,1,nex+1);
% x=[x1 x2(2:end) x3(2:end)];
% y=linspace(0,1,ney+1);
% m=Mesh2D(x,y);

x=linspace(0,1,10);
m=Mesh2D(x,x);

m.elem_flag(:,:)=2;
[wi,wj]=find(m.Xc<0.6);
m.elem_flag(wi,wj)=4;

% X=m.X;
% Y=m.Y;
% 
% a=eps/2;
% b=(1+eps)/2;
% x0=0.5;
% y0=0.5;
% 
% for j=1:size(Y,2)
%     c=Y(:,j);
%     %[max(c) min(c)];
%     yc=c(1);
%     xp=x0+a*sqrt( 1-(yc-y0)^2/b^2 );
%     xn=-(xp-0.5)+0.5;
%     x1=linspace(0,xn,nex+1);
%     x2=linspace(xn,xp,nf+1);
%     x3=linspace(xp,1,nex+1);
%     x=[x1 x2(2:end) x3(2:end)];
% 
%     X(:,j)=x;
% end
% 
% m.X=X;

%plot(m.X,m.Y,'.')
%axis equal

m.writeToFile('ciao.xda');
