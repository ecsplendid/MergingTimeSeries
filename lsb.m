function b = lsb(N) 

if mod(N,2)~=0;
   b = 0; 
end
p = floor(log2(N));
x = N - 2^p;
if( x == 0 )
   b = p;
else
    b = lsb(x);
end

end