local function con(val)
 if val then
  print("MQTT: trying to connect to "..M.server..":"..M.port)
  M.mqtt:connect(M.server,M.port,0,function(c)
  print("Connected to MQTT...")
  M.start=true
  M.timer:stop()
  c:subscribe(M.topic.."+/comm/*",0,function(c)print("subscribe success")end)
--  M.pub("comm/in","")
 end,
 function(c,r)
  print("failed reason: "..tostring(r))
  collectgarbage()
 end)
else
 M.mqtt:close()
 M.start=false
 print("Disconnected to MQTT")
end
end

local function pub(t,v)
 if M.start then
  M.mqtt:publish(M.topic..t,tostring(v),0,0,function(c)end)
 end
end

local function init()
M.mqtt = mqtt.Client(M.id,120,M.login,M.pass)
M.pub=pub
M.timer = tmr.create()
M.timer:register(5000,tmr.ALARM_AUTO,function(t)
 dofile("MQTT.lua")({con=true})end)
M.timer:interval(5000)
M.start=false
M.mqtt:on("offline",function(client)
print("offline")
M.timer:start()
dofile("MQTT.lua")({con=true})
end)
M.mqtt:on("message",dofile("MQTT_mes.lua"))
M.timer:start()
end

return function (t)
 if t.init then init()end
 if t.con then con(true)end
 if t.discon then con(false)end
 if t.status then r=M and M.start end
 return tostring(r)
end
