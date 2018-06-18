return function (c,topic,data)
 if data then
  print(topic..":"..data)
  topic = topic:match("/comm/(.*)")
  local files,fun,t = topic:match("(.-)/")..".lua",topic:match("/(.*)"),{}
  print(fun)
  print(files)
  if file.exists(files) and fun then
   t[fun]=data
   local o,j = pcall(dofile(files),t)
   print(o)
   print(j)
  end
 end
 return r
end
