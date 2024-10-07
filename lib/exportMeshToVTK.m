function exportMeshToVTK(filename, m)

dim=m.dim;
coo=[m.X(:) m.Y(:) m.Z(:)]';
conn=m.connectivity-1;
ne=m.ne;
nv=m.nv;
vert_per_elem=size(conn,1);

if dim==2 & vert_per_elem==4
    conn=conn([1 2 4 3],:);
end
if dim==3 & vert_per_elem==8
    conn=conn([1 2 4 3 5 6 8 7],:);
end
conn=[vert_per_elem*ones(1,ne); conn];

if (dim==2)
    celltype=9;
end
if (dim==3)
    celltype=12;
end


% open file for writing
fid = fopen(filename, 'w');

% HEADER PART 1
fprintf(fid, '# vtk DataFile Version 3.0\n');
fprintf(fid, 'Mesh\n');
fprintf(fid, 'ASCII\n');
fprintf(fid, 'DATASET UNSTRUCTURED_GRID\n');


% coordinates PART 2
fprintf(fid, 'POINTS %d float\n', nv);
fprintf(fid, '%f %f %f\n', coo);

% connectivity PART 3
fprintf(fid, 'CELLS %d %d\n', ne, ne * (vert_per_elem + 1));
line='%d';
for i=1:vert_per_elem
    line=[line,' %d'];
end
line=[line,'\n'];
fprintf(fid,line, conn);

% cell type PART 4
fprintf(fid, 'CELL_TYPES %d\n', ne);
fprintf(fid, '%d\n', celltype*ones(ne,1));

fclose(fid);

end
