return function (t)
 local n,f
 for k,v in pairs(file.list())do
  if k:match("(.*).mqtt")then n,f=pcall(dofile(k),true)end
 end
 return f
end

