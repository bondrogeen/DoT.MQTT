return function (c,t,d)
 if d then
  print(t..":"..d)
  local m = t:match("/comm/(.*)")
  if not m then return end
  local f,s,x = m:match("(.-)/"), m:match("/(.*)"),{}
  print(s,f)
  print(m)
  if f and s and file.exists(f..".lua") then x[s]=d local o,j = pcall(dofile(f),x)
   _M:pub("comm/"..m,"")
   print(o,j)end
 end
 return r
end
