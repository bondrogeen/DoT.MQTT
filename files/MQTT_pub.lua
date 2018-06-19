return function (t)
 print(t.topic)
 if t and _M then
 _M.pub(t.topic,t.value)
 end
 return r
end
