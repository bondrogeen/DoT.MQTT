
return function (client, topic, data)
  if data then
--    print(topic..":"..data)
    local plugin, command = topic:match("./(.-)/comm/(.*)")
    if plugin and command then
      if file.exists(plugin..".lua") then
        local temp = {}
        temp[command] = data
        local state, result = pcall(dofile(plugin..".lua"), temp)
        if result then
          _M:pub(plugin.."/comm/"..command,"")
        end
      end
    end
  end
  return r
end
