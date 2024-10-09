classdef TensorGrid2D < MeshBase
    properties
        i_x
        i_y
    end
    methods
        % constructor
        function obj=TensorGrid2D(x,y)
            obj.i_dim=2;
            obj.i_x=x;
            obj.i_y=y;
            nvx=length(x);
            nvy=length(y);
            nex=nvx-1;
            ney=nvy-1;
            obj.i_nv=nvx*nvy;
            obj.i_ne=nex*ney;
            obj.i_nodeflag=zeros(nvx,nvy);
            obj.i_elemflag=zeros(nex,ney);
        end
        % overloaded methods
        function [X,Y,Z]=coo(obj)
            [X,Y]=ndgrid(obj.i_x,obj.i_y);
            Z=0*X;
        end
        function out=conn(obj)
            MV=obj.MV;
            row=cell(2^obj.dim,1);
            row{1}=MV(1:end-1,1:end-1);
            row{2}=MV(2:end,1:end-1);
            row{3}=MV(1:end-1,2:end);
            row{4}=MV(2:end,2:end);
            for i=1:length(row)
                row{i}=row{i}(:)';
            end
            out=cell2mat(row);
        end
        function [Xc,Yc,Zc]=centers(obj)
            xc=0.5*(obj.i_x(1:end-1)+obj.i_x(2:end));
            yc=0.5*(obj.i_y(1:end-1)+obj.i_y(2:end));
            [Xc,Yc]=ndgrid(xc,yc);
            Zc=[];
        end
        % local methods
        function out=x(obj)
            out=obj.i_x;
        end
        function out=y(obj)
            out=obj.i_y;
        end
        function out=hx(obj)
            out=diff(obj.i_x);
        end
        function out=hy(obj)
            out=diff(obj.i_y);
        end
        function [Hx,Hy]=H(obj)
            [Hx,Hy]=ndgrid(obj.hx,obj.hy);
        end
        function out=nvx(obj)
            out=length(obj.i_x);
        end
        function out=nvy(obj)
            out=length(obj.i_y);
        end
        function out=nex(obj)
            out=length(obj.i_x)-1;
        end
        function out=ney(obj)
            out=length(obj.i_y)-1;
        end
        function out=MV(obj)
            nvx=obj.nvx;
            nvy=obj.nvy;
            nv=obj.nv;
            out=reshape(1:nv,[nvx nvy]);
        end
        function out=ME(obj)
            nex=obj.nex;
            ney=obj.ney;
            ne=obj.ne;
            out=reshape(1:ne,[nex ney]);
        end
    end
end
