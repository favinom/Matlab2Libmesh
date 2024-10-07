function len=checkVector(input)

if ~isvector(input)
    error('input is not a vector')
else
    len=length(input);
end
