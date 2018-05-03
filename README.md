# MQTT (test)

 MQTT plugin for [DoT](https://github.com/bondrogeen/DoT)

or run manual

```lua
M={
  server="192.168.1.10",
  port=1883,
  login="admin",
  pass=""
}
 M.id = string.format("%x",node.chipid()*256):sub(0,6):upper()
 M.topic = "/ESP"..M.id.."/"
 dofile("MQTT.lua")({init=true})

```



## Changelog
### 0.0.4 (2018-05-03)
* (bondrogeen) test.
### 0.0.1 (2018-04-04)
* (bondrogeen) init.