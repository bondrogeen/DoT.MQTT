# MQTT (test)

 MQTT plugin for [DoT](https://github.com/bondrogeen/DoT)

or run manual

```lua
_M={
  server="192.168.1.10",
  port=1883,
  login="admin",
  pass=""
}
 _M.id = string.format("%x",node.chipid()*256):sub(0,6):upper()
 _M.topic = "/ESP".._M.id.."/"
 dofile("MQTT.lua")({init=true})

_M.pub("topic/test","1234")

```



## Changelog

### 0.1.0 (2018-06-19)
* (bondrogeen) test.
### 0.0.4 (2018-05-03)
* (bondrogeen) test.
### 0.0.1 (2018-04-04)
* (bondrogeen) init.