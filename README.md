# MQTT (test)

 MQTT plugin for [DoT](https://github.com/bondrogeen/DoT)

or run manual

```lua

_M={
  server="192.168.1.10",  
  port=1883,              
  login="admin",                   -- optional, def ""
  pass="pass",                     -- optional, def ""
  id="myDevice",                   -- optional, def "ESPXXXXXX"
  topic="/myFirstTopic/"           -- start topic. optional, def "/ESPXXXXXX/"
}

function _M.on(c)                  --callback when connecting
 print("Connected")
 c:subscribe(_M.topic.."*",0)  
 
 _M:pub("topic/test","1234")       -- topic "/ESPXXXXXX/topic/test" | value "1234"
 _M:pub("topic/test","1234",true)  -- topic "/topic/test" | value "1234"
end

function _M.off(c,r)               -- callback when disconnecting
 print("Disconnected")
end

function _M.mes(c,t,d)             -- callback message
 if d then
  print(t..":"..d)
 end
end

dofile("MQTT.lua")({init=true})    -- initialization MQTT (autoconnect) 

-- dofile("MQTT.lua")({con=false}) -- Disconnect

-- dofile("MQTT.lua")({con=true})  -- Connect


```



## Changelog

### 0.1.5 (2018-12-04)
* (bondrogeen) minor fix.
### 0.1.0 (2018-06-19)
* (bondrogeen) test.
### 0.0.4 (2018-05-03)
* (bondrogeen) test.
### 0.0.1 (2018-04-04)
* (bondrogeen) init.