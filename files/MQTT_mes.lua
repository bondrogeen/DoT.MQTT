return function (c,t,d)
 if d then
  print(t..":"..d)
  t = t:match("/comm/(.*)")
  local f,s,t = t:match("(.-)/")..".lua",t:match("/(.*)"),{}
  print(s,f)
  if file.exists(f) and fun then t[s]=d local o,j = pcall(dofile(f),t) end
 end
 return r
end
