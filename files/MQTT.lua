local function con(val)
 if val then
  print("MQTT: trying to connect to ".._M.server..":".._M.port)
  _M.mqtt:connect(_M.server,_M.port,0,function(c)
  print("Connected to MQTT...")
  _M.start=true
  _M.recon:stop()
  c:subscribe(_M.topic.."comm/*",0,function(c)print("subscribe success")end)
  _M.int:start()
  dofile("MQTT_sub.lua")(true)
 end,
 function(c,r)
  print("failed reason: "..tostring(r))
  collectgarbage()
 end)
else
 _M.mqtt:close()
 _M.start=false
 print("Disconnected to MQTT")
end
end

local function pub(t,v,r)
 if _M.start then
  _M.mqtt:publish((r and "/"..t or _M.topic..t),tostring(v),0,0,function(c)end)
 end
end

local function init()
_M.mqtt = mqtt.Client(_M.id,120,_M.login,_M.pass)
_M.pub=pub
_M.recon=tmr.create()
_M.recon:register(5000,tmr.ALARM_AUTO,function(t)dofile("MQTT.lua")({con=true})end)
_M.recon:interval(5000)
_M.int=tmr.create()
_M.int:register(5000,tmr.ALARM_AUTO,function(t)_DoT:set()end)
_M.int:interval(_M.timer*1000)
_M.start=false
_M.mqtt:on("offline",function(client)print("offline")_M.recon:start()_M.int:stop()dofile("MQTT.lua")({con=true})end)
_M.mqtt:on("message",dofile("MQTT_mes.lua"))
_M.recon:start()
end

return function (t)
 if t.init then init()end
 if t.con then con(true)end
 if t.discon then con(false)end
 if t.status then r=_M and _M.start end
 return tostring(r)
end
