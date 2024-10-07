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
        % not used
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
        end
        % function writeToFile(obj,filenameOut,version)
        % 
        %     filename{1}='01.txt';
        %     filename{2}='02.txt';
        %     filename{3}='03.txt';
        %     filename{4}='04.txt';
        %     filename{5}='05.txt';
        %     filename{6}='06.txt';
        %     filename{7}='07.txt';
        %     filename{8}='08.txt';
        %     filename{9}='09.txt';
        %     filename{10}='10.txt';
        %     outputfile=filenameOut;
        % 
        %     %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %     %%%%%%%%%%%
        %     %%%%%%%%%%% SECTION 1
        %     %%%%%%%%%%%
        %     %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        % 
        %     if strcmp(version,'1.8.0')
        % 
        %         line{1}='libMesh-1.8.0\n';
        %         line{2}='\t # number of elements\n';
        %         line{3}='\t # number of nodes\n';
        %         line{4}='.\t # boundary condition specification file\n';
        %         line{5}='.\t # subdomain id specification file\n';
        %         line{6}='n/a\t # processor id specification file\n';
        %         line{7}='n/a\t # p-level specification file\n';
        %         line{8}='8\t # type size\n';
        %         line{9}='8\t # uid size\n';
        %         line{10}='0\t # pid size\n';
        %         line{11}='8\t # sid size\n';
        %         line{12}='0\t # p-level size\n';
        %         line{13}='8\t # eid size\n';
        %         line{14}='8\t # side size\n';
        %         line{15}='8\t # bid size\n';
        %         line{16}='0\t # extra integer size\n';
        %         line{17}='0\t # vector length\n';
        %         line{18}='\t # node integer names\n';
        %         line{19}='0\t # vector length\n';
        %         line{20}='\t # elem integer names\n';
        %         line{21}='0\t # vector length\n';
        %         line{22}='\t # elemset codes\n';
        %         line{23}='0\t # subdomain id to name map\n';
        %         line{24}='\t # n_elem at level 0, [ type uid sid (n0 ... nN-1) ]\n';
        %     end
        % 
        %     if strcmp(version,'1.8.0')
        % 
        %         line{1}='libMesh-1.8.0\n';
        %         line{2}='\t # number of elements\n';
        %         line{3}='\t # number of nodes\n';
        %         line{4}='.\t # boundary condition specification file\n';
        %         line{5}='.\t # subdomain id specification file\n';
        %         line{6}='n/a\t # processor id specification file\n';
        %         line{7}='n/a\t # p-level specification file\n';
        %         line{8}='8\t # type size\n';
        %         line{9}='8\t # uid size\n';
        %         line{10}='0\t # pid size\n';
        %         line{11}='8\t # sid size\n';
        %         line{12}='0\t # p-level size\n';
        %         line{13}='8\t # eid size\n';
        %         line{14}='8\t # side size\n';
        %         line{15}='8\t # bid size\n';
        %         line{16}='0\t # extra integer size\n';
        %         line{17}='0\t # vector length\n';
        %         line{18}='\t # node integer names\n';
        %         line{19}='0\t # vector length\n';
        %         line{20}='\t # elem integer names\n';
        %         line{21}='0\t # vector length\n';
        %         line{22}='\t # elemset codes\n';
        %         line{23}='0\t # subdomain id to name map\n';
        %         line{24}='\t # n_elem at level 0, [ type uid sid (n0 ... nN-1) ]\n';
        %     end
        % 
        %     if strcmp(version,'1.3.0')
        % 
        %         line{1}='libMesh-1.3.0\n';
        %         line{2}='\t # number of elements\n';
        %         line{3}='\t # number of nodes\n';
        %         line{4}='.\t # boundary condition specification file\n';
        %         line{5}='.\t # subdomain id specification file\n';
        %         line{6}='n/a\t # processor id specification file\n';
        %         line{7}='n/a\t # p-level specification file\n';
        %         line{8}='8\t # type size\n';
        %         line{9}='8\t # uid size\n';
        %         line{10}='0\t # pid size\n';
        %         line{11}='8\t # sid size\n';
        %         line{12}='0\t # p-level size\n';
        %         line{13}='8\t # eid size\n';
        %         line{14}='8\t # side size\n';
        %         line{15}='8\t # bid size\n';
        %         line{16}='0\t # subdomain id to name map\n';
        %         line{17}='\t # n_elem at level 0, [ type uid sid (n0 ... nN-1) ]\n';
        %     end
        % 
        % 
        %     fileID = fopen(filename{1},'w');
        % 
        %     fprintf(fileID,line{1});
        %     fprintf(fileID,[num2str(obj.ne),line{2}]);
        %     fprintf(fileID,[num2str(obj.nv),line{3}]);
        %     for i=4:length(line)-1
        %         fprintf(fileID,[line{i}]);
        %     end
        %     fprintf(fileID,[num2str(obj.ne),line{end}]);
        %     fclose(fileID);
        % 
        %     %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %     %%%%%%%%%%%
        %     %%%%%%%%%%% SECTION 2
        %     %%%%%%%%%%%
        %     %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        % 
        %     ne=obj.ne;
        %     nv=obj.nv;
        % 
        %     31
        %     dd=[5*ones(ne,1) nv+(0:ne-1)' obj.elem_flag(:) obj.connectivity(:,[1 2 4 3])-1];
        %     writematrix(dd,filename{2},"Delimiter"," ");
        % 
        %     %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %     %%%%%%%%%%%
        %     %%%%%%%%%%% SECTION 3
        %     %%%%%%%%%%%
        %     %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        % 
        %     dd=[obj.c zeros(nv,1)];
        %     writematrix(dd,filename{3},"Delimiter"," ");
        % 
        %     %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %     %%%%%%%%%%%
        %     %%%%%%%%%%% SECTION 4
        %     %%%%%%%%%%%
        %     %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        % 
        %     line{25}='1\t # presence of unique ids\n';
        %     fileID = fopen(filename{4},'w');
        % 
        %     fprintf(fileID,line{25});
        %     fclose(fileID);
        % 
        %     %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %     %%%%%%%%%%%
        %     %%%%%%%%%%% SECTION 5
        %     %%%%%%%%%%%
        %     %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        % 
        %     dd=(0:obj.nv-1)';
        %     writematrix(dd,filename{5},"Delimiter"," ");
        % 
        %     %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %     %%%%%%%%%%%
        %     %%%%%%%%%%% SESTA PARTE
        %     %%%%%%%%%%%
        %     %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        % 
        %     line{1}='4\t # sideset id to name map\n';
        %     line{2}='4\t # vector length\n';
        %     line{3}='0\t 1\t 2\t 3\n';
        %     line{4}='4\t # vector length\n';
        %     line{5}='bottom\t right\t top\t left\t \n';
        %     line{6}='\t # number of side boundary conditions\n';
        % 
        %     fileID = fopen(filename{6},'w');
        % 
        %     for i=1:5
        %         fprintf(fileID,line{i});
        %     end
        % 
        %     nex=obj.nex;
        %     ney=obj.ney;
        %     nez=obj.nez;
        % 
        %     number=2*(nex+ney);%+2*nex*nez+2*ney*nez;
        % 
        %     fprintf(fileID,[num2str(number),line{6}]);
        %     fclose(fileID);
        % 
        %     %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %     %%%%%%%%%%%
        %     %%%%%%%%%%% settima PARTE
        %     %%%%%%%%%%%
        %     %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        % 
        %     e_id_visual=flipud(obj.ME');
        % 
        %     dbottom=e_id_visual(end,:);
        %     dbottom=sort(dbottom(:))-1;
        %     dbottom=[dbottom 0*dbottom 0*dbottom];
        % 
        %     dright=e_id_visual(:,end);
        %     dright=sort(dright(:))-1;
        %     dright=[dright 0*dright+1 0*dright+1];
        % 
        %     dtop=e_id_visual(1,:);
        %     dtop=sort(dtop(:))-1;
        %     dtop=[dtop 0*dtop+2 0*dtop+2];
        % 
        %     dleft=e_id_visual(:,1);
        %     dleft=sort(dleft(:))-1;
        %     dleft=[dleft 0*dleft+3 0*dleft+3];
        % 
        %     dd=[dbottom; dright; dtop; dleft];
        %     writematrix(dd,filename{7},"Delimiter"," ");
        % 
        % 
        %     %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %     %%%%%%%%%%%
        %     %%%%%%%%%%% ottava PARTE
        %     %%%%%%%%%%%
        %     %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        % 
        %     nvx=obj.nvx;
        %     nvy=obj.nvy;
        % 
        %     nn=2*(nvx+nvy);%+2*nvx*nvz+2*nvy*nvz;
        % 
        %     line{1}='4\t # nodeset id to name map\n';
        %     line{2}='4\t # vector length\n';
        %     line{3}='0\t 1\t 2\t 3\t \n';
        %     line{4}='4\t # vector length\n';
        %     line{5}='bottom\t right\t top\t left\t \n';
        %     line{6}='\t # number of nodesets\n';
        % 
        %     fileID = fopen(filename{8},'w');
        % 
        %     for i=1:5
        %         fprintf(fileID,line{i});
        %     end
        %     fprintf(fileID,[num2str(nn),line{6}]);
        %     fclose(fileID);
        % 
        % 
        %     %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %     %%%%%%%%%%%
        %     %%%%%%%%%%% nona PARTE
        %     %%%%%%%%%%%
        %     %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        % 
        %     e_id_visual=flipud(obj.MV');
        % 
        %     dbottom=e_id_visual(end,:);
        %     dbottom=sort(dbottom(:))-1;
        %     dbottom=[dbottom 0*dbottom];
        % 
        %     dright=e_id_visual(:,end);
        %     dright=sort(dright(:))-1;
        %     dright=[dright 0*dright+1];
        % 
        %     dtop=e_id_visual(1,:);
        %     dtop=sort(dtop(:))-1;
        %     dtop=[dtop 0*dtop+2];
        % 
        %     dleft=e_id_visual(:,1);
        %     dleft=sort(dleft(:))-1;
        %     dleft=[dleft 0*dleft+3];
        % 
        %     dd=[dbottom; dright; dtop; dleft];
        % 
        % 
        %     writematrix(dd,filename{9},"Delimiter"," ");
        % 
        %     %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %     %%%%%%%%%%%
        %     %%%%%%%%%%% decima PARTE
        %     %%%%%%%%%%%
        %     %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        % 
        %     line{1}='4\t # sideset id to name map\n';
        %     line{2}='4\t # vector length\n';
        %     line{3}='0\t 1\t 2\t 3\t \n';
        %     line{4}='4\t # vector length\n';
        %     line{5}='bottom\t right\t top\t left\t \n';
        %     line{6}='0\t # number of edge boundary conditions\n';
        %     line{7}='4\t # sideset id to name map\n';
        %     line{8}='4\t # vector length\n';
        %     line{9}='0\t 1\t 2\t 3\t \n';
        %     line{10}='4\t # vector length\n';
        %     line{11}='bottom\t right\t top\t left\t \n';
        %     line{12}='0\t # number of shellface boundary conditions\n';
        % 
        %     fileID = fopen(filename{10},'w');
        % 
        %     for i=1:12
        %         fprintf(fileID,line{i});
        %     end
        %     fclose(fileID);
        % 
        %     merge
        % 
        %     line=['rm -rf ',outputfile];
        %     system(line);
        %     for i=1:10
        %         line=['cat ',filename{i},' >> ',outputfile];
        %         system(line);
        %     end
        % 
        %     for i=1:10
        %         line=['rm -rf ',filename{i}];
        %         system(line);
        %     end
        % 
        % end
    end
end

