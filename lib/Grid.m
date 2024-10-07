classdef Grid
    properties
        
        % dimension of grid
        dim

        % number of vertices
        nv
        % number of elements
        ne

        % coordinates in matrix form
        X
        Y
        Z

        % node flag
        nodeflag

        %
        connectivity

        %
        elemflag

        Xc
        Yc
        Zc

        MV
        ME

    end
    methods
        function obj=Grid(x,y,z)
            if ~exist('x') | isempty(x)
                x=0;
            end
            if ~exist('y') | isempty(y)
                y=0;
            end
            if ~exist('z') | isempty(z)
                z=0;
            end
            %if isempty(x)
            %    x=0;
            %end
            %if isempty(y)
            %    y=0;
            %end
            %if isempty(z)
            %    z=0;
            %end
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
            obj.dim=3-temp;
            clear temp nvv
            if (obj.dim==0)
                error('mesh is a point')
            end

            % forse si puo fare meglio
            [obj.X,obj.Y,obj.Z]=ndgrid(x,y,z);
            obj.nodeflag=zeros(size(obj.X));
            obj.nv=numel(obj.X);

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
            [obj.Xc,obj.Yc,obj.Zc]=ndgrid(xc,yc,zc);

            obj.MV=reshape(1:obj.nv,[nvx nvy nvz]);
            obj.MV=squeeze(obj.MV);
            row=cell(2^obj.dim,1);
            if (obj.dim==1)
                row{1}=obj.MV(1:end-1);
                row{2}=obj.MV(2:end);
            end
            if (obj.dim==2)
                row{1}=obj.MV(1:end-1,1:end-1);
                row{2}=obj.MV(2:end,1:end-1);
                row{3}=obj.MV(1:end-1,2:end);
                row{4}=obj.MV(2:end,2:end);
            end
            if (obj.dim==3)
                row{1}=obj.MV(1:end-1,1:end-1,1:end-1);
                row{2}=obj.MV(2:end,1:end-1,1:end-1);
                row{3}=obj.MV(1:end-1,2:end,1:end-1);
                row{4}=obj.MV(2:end,2:end,1:end-1);
                row{5}=obj.MV(1:end-1,1:end-1,2:end);
                row{6}=obj.MV(2:end,1:end-1,2:end);
                row{7}=obj.MV(1:end-1,2:end,2:end);
                row{8}=obj.MV(2:end,2:end,2:end);
            end
            for i=1:length(row)
                row{i}=row{i}(:)';
            end
            obj.connectivity=cell2mat(row);
            obj.ne=size(obj.connectivity,2);
            obj.elemflag=zeros(obj.ne,1);

            obj.ME=reshape(1:obj.ne,[nex ney nez]);
            obj.ME=squeeze(obj.ME);

        end
    end
end
