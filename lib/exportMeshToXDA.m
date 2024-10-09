function exportMeshToXDA(filename, m, version)

ne=m.ne;
nv=m.nv;
conn=m.conn;
elemflag=m.elemflag;
[X,Y,Z]=m.coo;
coo=[X(:) Y(:) Z(:)];
clear X Y Z

vert_per_elem=size(conn,1);

vertid=(1:nv)-1;
elemid=(1:ne)+vertid(end);

elemtype=5; % 31;

conn=[  elemtype*ones(1,ne);
        elemid(:)';
        elemflag(:)';
        conn([1 2 4 3],:)-1];

% prepare section 1

if strcmp(version,'1.8.0')
    line{1}='libMesh-1.8.0\n';
    line{2}='%d\t # number of elements\n';
    line{3}='%d\t # number of nodes\n';
    line{4}='.\t # boundary condition specification file\n';
    line{5}='.\t # subdomain id specification file\n';
    line{6}='n/a\t # processor id specification file\n';
    line{7}='n/a\t # p-level specification file\n';
    line{8}='8\t # type size\n';
    line{9}='8\t # uid size\n';
    line{10}='0\t # pid size\n';
    line{11}='8\t # sid size\n';
    line{12}='0\t # p-level size\n';
    line{13}='8\t # eid size\n';
    line{14}='8\t # side size\n';
    line{15}='8\t # bid size\n';
    line{16}='0\t # extra integer size\n';
    line{17}='0\t # vector length\n';
    line{18}='\t # node integer names\n';
    line{19}='0\t # vector length\n';
    line{20}='\t # elem integer names\n';
    line{21}='0\t # vector length\n';
    line{22}='\t # elemset codes\n';
    line{23}='0\t # subdomain id to name map\n';
    line{24}='%d\t # n_elem at level 0, [ type uid sid (n0 ... nN-1) ]\n';
end

if strcmp(version,'1.3.0')
    line{1}='libMesh-1.3.0\n';
    line{2}='%d\t # number of elements\n';
    line{3}='%d\t # number of nodes\n';
    line{4}='.\t # boundary condition specification file\n';
    line{5}='.\t # subdomain id specification file\n';
    line{6}='n/a\t # processor id specification file\n';
    line{7}='n/a\t # p-level specification file\n';
    line{8}='8\t # type size\n';
    line{9}='8\t # uid size\n';
    line{10}='0\t # pid size\n';
    line{11}='8\t # sid size\n';
    line{12}='0\t # p-level size\n';
    line{13}='8\t # eid size\n';
    line{14}='8\t # side size\n';
    line{15}='8\t # bid size\n';
    line{16}='0\t # subdomain id to name map\n';
    line{17}='%d\t # n_elem at level 0, [ type uid sid (n0 ... nN-1) ]\n';
end

% HEADER PART 1

fid = fopen(filename,'w');
fprintf(fid,line{1});
fprintf(fid,line{2},ne);
fprintf(fid,line{3},nv);
for i=4:length(line)-1
    fprintf(fid,line{i});
end
fprintf(fid,line{end},ne);


% CONNECTIVITY PART 2
printline='%d %d %d';
for i=1:vert_per_elem
    printline=[printline,' %d'];
end
printline=[printline,'\n'];
fprintf(fid,printline, conn);


% coordinates PART 3
printline='%f %f %f\n';
fprintf(fid,printline, coo');

% unique IDs PART 4

printline='1\t # presence of unique ids\n';
fprintf(fid,printline);
printline='%d\n';
fprintf(fid,printline, vertid);

% side sets PART 4
line{1}='4\t # sideset id to name map\n';
line{2}='4\t # vector length\n';
line{3}='0\t 1\t 2\t 3\n';
line{4}='4\t # vector length\n';
line{5}='bottom\t right\t top\t left\t \n';
line{6}='%d\t # number of side boundary conditions\n';

ME=m.ME;
e_id_visual=flipud(ME');

dbottom=e_id_visual(end,:);
dbottom=sort(dbottom(:))-1;
dbottom=[dbottom 0*dbottom 0*dbottom];
dright=e_id_visual(:,end);
dright=sort(dright(:))-1;
dright=[dright 0*dright+1 0*dright+1];
dtop=e_id_visual(1,:);
dtop=sort(dtop(:))-1;
dtop=[dtop 0*dtop+2 0*dtop+2];
dleft=e_id_visual(:,1);
dleft=sort(dleft(:))-1;
dleft=[dleft 0*dleft+3 0*dleft+3];

dd=[dbottom; dright; dtop; dleft]';

for i=1:5
    fprintf(fid,line{i});
end
fprintf(fid,line{6},size(dd,2));

fprintf(fid,'%d %d %d\n',dd);

% node sets PART 5
line{1}='4\t # nodeset id to name map\n';
line{2}='4\t # vector length\n';
line{3}='0\t 1\t 2\t 3\t \n';
line{4}='4\t # vector length\n';
line{5}='bottom\t right\t top\t left\t \n';
line{6}='%d\t # number of nodesets\n';

e_id_visual=flipud(m.MV');
dbottom=e_id_visual(end,:);
dbottom=sort(dbottom(:))-1;
dbottom=[dbottom 0*dbottom];
dright=e_id_visual(:,end);
dright=sort(dright(:))-1;
dright=[dright 0*dright+1];
dtop=e_id_visual(1,:);
dtop=sort(dtop(:))-1;
dtop=[dtop 0*dtop+2];
dleft=e_id_visual(:,1);
dleft=sort(dleft(:))-1;
dleft=[dleft 0*dleft+3];
dd=[dbottom; dright; dtop; dleft]';
        

for i=1:5
    fprintf(fid,line{i});
end
fprintf(fid,line{6},size(dd,2));
fprintf(fid,'%d %d\n',dd);

% edge sets PART 5

line{1}='4\t # sideset id to name map\n';
line{2}='4\t # vector length\n';
line{3}='0\t 1\t 2\t 3\t \n';
line{4}='4\t # vector length\n';
line{5}='bottom\t right\t top\t left\t \n';
line{6}='0\t # number of edge boundary conditions\n';
line{7}='4\t # sideset id to name map\n';
line{8}='4\t # vector length\n';
line{9}='0\t 1\t 2\t 3\t \n';
line{10}='4\t # vector length\n';
line{11}='bottom\t right\t top\t left\t \n';
line{12}='0\t # number of shellface boundary conditions\n';

for i=1:12
    fprintf(fid,line{i});
end

fclose(fid);

return
