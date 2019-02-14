local function callbackConn(client)
  _M.start=true
  _M.recon:stop()
--   print("Connected")
  client:subscribe( _M.topic.."*/comm", 0, function(client)
  --  print("subscribe success")
  end)
  dofile("MQTT_sub.lua")(_M.timer)
end

local function callbackDisconn(client, reason)
--  print("Failed reason: "..tostring(reason))
  collectgarbage()
end

local function connection(state)
  if state then
    print("Trying connect to ".._M.server..":".._M.port)
    _M.mqtt:connect( _M.server, _M.port, 0, callbackConn, callbackDisconn )
  else
    _M.recon:stop()
    _M.mqtt:close()
    _M.start = false
--    print("Disconnected")
  end
end

local function init()
  _M.id = _M.id or "DoT-"..string.format("%x", node.chipid()*256):sub(0,6):upper()
  _M.topic = _M.topic or "/".._M.id.."/"
  _M.mqtt = mqtt.Client(_M.id, 120, _M.login or "", _M.pass or "")

  function _M:pub(topic, value, start)
    if _M.start then
      _M.mqtt:publish(( start and "/"..topic or _M.topic..topic ), tostring(value),0,0)
    end
  end

  _M.recon=tmr.create()
  _M.recon:register(5000, tmr.ALARM_AUTO, function(t)
    dofile("MQTT.lua")({conn=true})
  end)

  _M.recon:interval(5000)
  _M.mqtt:on("offline", function(c) _M.recon:start() end)
  _M.mqtt:on("message", dofile("MQTT_mes.lua"))
  _M.recon:start()
end

return function (t)
 if t.init then init()end
 if t.conn ~= nil then connection(t.conn)end
 return true
end
