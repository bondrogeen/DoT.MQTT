return function (c,t,d)
 if d then
  print(t..":"..d)
  m = t:match("/comm/(.*)")
  local f,s,x = m:match("(.-)/")..".lua",m:match("/(.*)"),{}
  print(s,f)
  if file.exists(f) and s then x[s]=d local o,j = pcall(dofile(f),x)
   _M.pub("comm/"..m,"")
   print(o,j)end
 end
 return r
end
