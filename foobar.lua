print(wifi.sta.getip())

--init ws2812 lights
ws2812.init(ws2812.MODE_SINGLE)
ws2812.write(string.char(255, 0, 0, 255, 0, 0))
buffer = ws2812.newBuffer(8, 3)
buffer:fill(0, 0, 0);
ws2812.write(buffer)

function start_light()
    print("lights on")
    local i = 0
    tmr.alarm(5, 100, 1, function()
            print("light loop")
            i=i+1
            buffer:fade(3)
            buffer:set(i%buffer:size()+1, 168, 255, 0)
            ws2812.write(buffer)
    end)
end

function stop_light()
    tmr.stop(5)
    buffer:fill(0,0,0)
    ws2812.write(buffer)
end

dofile("leinwand.lua")

function on_mqtt_connect(client)
    -- body
    print("mqtt connected")
end
m = mqtt.Client("leinwand", 120)
m:on("connect", function (client, topic, message)
        print("mqtt online")
        m:subscribe(mqtt_topic .. "#",0, function(client) print("subscribe success") end)
    end)
m:on("offline", function (client, topic, message) print("mqtt offline") end)

m:connect(mqtt_host, mqtt_port, 0, 0,on_mqtt_connect(client),
                                  function(client, reason) print("failed reason: "..reason) end)
m:on("message", function (client, topic, message)
    print(topic)
    if topic == mqtt_topic .. "down" then lower_leinwand()
    elseif topic == mqtt_topic .. "up" then  upper_leinwand()
    elseif topic == mqtt_topic .. "halt" then halt_leinwand()
    else stop_light()
    end
    print(message)
end)
