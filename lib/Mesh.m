classdef Mesh < MeshBase
    properties

        % coordinates in matrix form
        i_X
        i_Y
        i_Z

        %
        i_connectivity

        i_Xc
        i_Yc
        i_Zc

    end
    methods
        function obj=Mesh(x,y,z,conn)
            if ~exist('x') | isempty(x)
                x=0;
            end
            if ~exist('y') | isempty(y)
                y=0;
            end
            if ~exist('z') | isempty(z)
                z=0;
            end
            x=x(:);
            y=y(:);
            z=z(:);
            nvx=length(x);
            nvy=length(y);
            nvz=length(z);    

            nvv=[nvx nvy nvz];
            temp=sum(nvv==1);
            obj.i_dim=3-temp;
            if (nvx~=nvy & nvx~=1 & nvy~=1)
                error('x and y have different sizes')
            end
            if (nvx~=nvz & nvx~=1 & nvz~=1)
                error('x and z have different sizes')
            end
            if (nvy~=nvz & nvy~=1 & nvz~=1)
                error('y and z have different sizes')
            end
            obj.i_nv=max(nvv);
            if nvx==1
                x=x*ones(obj.i_nv,1);
            end
            if nvy==1
                y=y*ones(obj.i_nv,1);
            end
            if nvz==1
                z=z*ones(obj.i_nv,1);
            end
            obj.i_X=x;
            obj.i_Y=y;
            obj.i_Z=z;

            obj.i_connectivity=conn;
            obj.i_ne=size(conn,2);

            obj.i_Xc=mean(x(conn))';
            obj.i_Yc=mean(y(conn))';
            obj.i_Zc=mean(z(conn))';

            obj.i_nodeflag=zeros(obj.nv,1);
            obj.i_elemflag=zeros(obj.ne,1);

        end
        function [X,Y,Z]=coo(obj)
            X=obj.i_X;
            Y=obj.i_Y;
            Z=obj.i_Z;
        end
        function out=conn(obj)
            out=obj.i_connectivity;
        end
        function [Xc,Yc,Zc]=centers(obj)
            Xc=obj.i_Xc;
            Yc=obj.i_Yc;
            Zc=obj.i_Zc;
        end
    end
end
