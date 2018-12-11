local function cbC(c)
  _M.start=true
  _M.recon:stop()
  if _M.on then _M.on(c) else
   print("Connected")
   c:subscribe(_M.topic.."comm/*",0,function(c)print("subscribe success")end)
   dofile("MQTT_sub.lua")(_M.timer)
  end
end

local function cbD(c,r)
 if _M.off then _M.off(c,r) end
  print("Failed reason: "..tostring(r))
  collectgarbage()
end

local function con(v)
 if v then
  print("Trying connect to ".._M.server..":".._M.port)
  _M.mqtt:connect(_M.server,_M.port,0,cbC,cbD)
else
  _M.recon:stop()_M.mqtt:close()_M.start=false print("Disconnected")
end
end

local function init()
_M.id=_M.id or "ESP"..string.format("%x",node.chipid()*256):sub(0,6):upper()
_M.topic=_M.topic or "/".._M.id.."/"
_M.mqtt = mqtt.Client(_M.id,120,_M.login or"",_M.pass or"")
function _M:pub(t,v,r)if _M.start then _M.mqtt:publish((r and "/"..t or _M.topic..t),tostring(v),0,0)end end
_M.recon=tmr.create()
_M.recon:register(5000,tmr.ALARM_AUTO,function(t)dofile("MQTT.lua")({con=true})end)
_M.recon:interval(5000)
_M.mqtt:on("offline",function(c)_M.recon:start()end)
_M.mqtt:on("message",_M.mes or dofile("MQTT_mes.lua"))
_M.recon:start()
end

return function (t)
 if t.init then init()end
 if t.con ~= nil then con(t.con)end
 return true
end
