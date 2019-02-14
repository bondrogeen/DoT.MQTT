return function(a)local b,c;for d,e in pairs(file.list())do if d:match("(.*).mqtt")then b,c=pcall(dofile(d),a)end end;return f end
