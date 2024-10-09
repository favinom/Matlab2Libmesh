classdef MeshBase
    properties
        i_dim uint64 {mustBeInteger}
        i_nv uint64 {mustBeInteger}
        i_ne uint64 {mustBeInteger}
        i_nodeflag uint64 {mustBeInteger}
        i_elemflag uint64 {mustBeInteger}
    end
    methods
        function out=ne(obj)
            out=obj.i_ne;
        end
        function out=nv(obj)
            out=obj.i_nv;
        end
        function out=dim(obj)
            out=obj.i_dim;
        end
        function out=nodeflag(obj)
            out=obj.i_nodeflag;
        end
        function out=elemflag(obj)
            out=obj.i_elemflag;
        end
    end
    methods(Abstract)
        [X,Y,Z]=coo(obj);
        conn=conn(obj);
        [Xc,Yc,Zc]=centers(obj);
    end
end
