return function (t)
 print(t.topic)
 if t and _M then
 _M:pub(t.topic,t.value,true)
 end
 return r
end
