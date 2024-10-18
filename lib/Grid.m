classdef Grid < MeshBase
    properties
        % coordinates in matrix form
        i_X
        i_Y
        i_Z

        connectivity

        i_Xc
        i_Yc
        i_Zc

        i_MV
        i_ME

        i_isGrid

    end
    methods
        function obj=Grid(x,y,z)

            obj.i_isGrid=1;
            
            if ~exist('x') | isempty(x)
                x=0;
            end
            if ~exist('y') | isempty(y)
                y=0;
            end
            if ~exist('z') | isempty(z)
                z=0;
            end
            nvx=checkVector(x);
            nvy=checkVector(y);
            nvz=checkVector(z);
            if nvx>1
                nex=nvx-1;
            else
                nex=1;
            end
            if nvy>1
                ney=nvy-1;
            else
                ney=1;
            end
            if nvz>1
                nez=nvz-1;
            else
                nez=1;
            end
            
            nvv=[nvx nvy nvz];
            temp=sum(nvv==1);
            obj.i_dim=3-temp;
            clear temp nvv
            if (obj.dim==0)
                error('mesh is a point')
            end 
            [obj.i_X,obj.i_Y,obj.i_Z]=ndgrid(x,y,z);
            obj.i_nodeflag=zeros(size(obj.i_X));
            obj.i_nv=numel(obj.i_X);
 
            if (nvx==1)
                xc=x;
            else
                xc=0.5*(x(1:end-1)+x(2:end));
            end
            if (nvy==1)
                yc=y;
            else
                yc=0.5*(y(1:end-1)+y(2:end));
            end
            if (nvz==1)
                zc=z;
            else
                zc=0.5*(z(1:end-1)+z(2:end));
            end
            [obj.i_Xc,obj.i_Yc,obj.i_Zc]=ndgrid(xc,yc,zc);
            
            obj.i_MV=reshape(1:obj.i_nv,[nvx nvy nvz]);
            obj.i_MV=squeeze(obj.i_MV);
            row=cell(2^obj.i_dim,1);
            if (obj.dim==1)
                row{1}=obj.i_MV(1:end-1);
                row{2}=obj.i_MV(2:end);
            end
            if (obj.i_dim==2)
                row{1}=obj.i_MV(1:end-1,1:end-1);
                row{2}=obj.i_MV(2:end,1:end-1);
                row{3}=obj.i_MV(1:end-1,2:end);
                row{4}=obj.i_MV(2:end,2:end);
            end
            if (obj.i_dim==3)
                row{1}=obj.i_MV(1:end-1,1:end-1,1:end-1);
                row{2}=obj.i_MV(2:end,1:end-1,1:end-1);
                row{3}=obj.i_MV(1:end-1,2:end,1:end-1);
                row{4}=obj.i_MV(2:end,2:end,1:end-1);
                row{5}=obj.i_MV(1:end-1,1:end-1,2:end);
                row{6}=obj.i_MV(2:end,1:end-1,2:end);
                row{7}=obj.i_MV(1:end-1,2:end,2:end);
                row{8}=obj.i_MV(2:end,2:end,2:end);
            end
            for i=1:length(row)
                row{i}=row{i}(:)';
            end
            obj.connectivity=cell2mat(row);
            obj.i_ne=size(obj.connectivity,2);
            obj.i_elemflag=zeros(obj.ne,1);
            
            obj.i_ME=reshape(1:obj.ne,[nex ney nez]);
            obj.i_ME=squeeze(obj.i_ME);

        end
        % virtual class
        function [X,Y,Z]=coo(obj)
            X=obj.i_X;
            Y=obj.i_Y;
            Z=obj.i_Z;
        end
        function out=conn(obj)
            out=obj.connectivity;
        end
        function [Xc,Yc,Zc]=centers(obj)
            Xc=obj.i_X;
            Yc=obj.i_Y;
            Zc=obj.i_Z;
        end
        function out=ME(obj)
            out=obj.i_ME;
        end
        function out=MV(obj)
            out=obj.i_MV;
        end
        % other classes
    end
end
