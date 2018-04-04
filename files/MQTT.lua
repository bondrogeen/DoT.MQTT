local function init(t)
m = mqtt.Client(s.device,120,s.login,s.pass)
end

function set_mqtt(top,val)
m:publish(topic_start..top,val, 0, 0, function(client)end)
end

local reconnMqtt = tmr.create()
reconnMqtt:register(6, tmr.ALARM_SEMI, function (t)
  reconnMqtt:interval(5000);
  print("MQTT: trying to connect to "..s.mqtt_server..":"..s.mqtt_port)
  m:close()
  mqtt_init (true)
end)

local publishMqtt = tmr.create()
publishMqtt:register(s.mqtt_time*1000, tmr.ALARM_AUTO, function (t)
set_mqtt("/sensors/light",adc.read(0))
set_mqtt("/sensors/rssi",wifi.sta.getrssi())
set_mqtt("/sensors/uptime",tmr.time())
set_mqtt("/sensors/free_ram",node.heap())
end)

m:on("offline", function(client)
print ("offline")
publishMqtt:stop()
reconnMqtt:start()
m_init = false
end)

m:on("message",function (client, topic, data)
  if data then print(topic..":"..data) end
  if (topic==topic_start.."/data/temp")then
    temp = data
  end
end)

function mqtt_init (val)
 if val then
  m:connect(s.mqtt_server, s.mqtt_port, 0, function(client)
  print("Connected to MQTT...")
  m_init = true
  publishMqtt:start()
  client:subscribe(topic_start.."/data/*", 0, function(client) print("subscribe success") end)
  set_mqtt("/data/temp","")
  set_mqtt("/data/test","test")
 end,
 function(client, reason)
  print("failed reason: " .. reason)
  reconnMqtt:start()
 end)
else
 m:close()
end
end

if (not m_init)then mqtt_init(true)end



return function (t)

 return r
end
