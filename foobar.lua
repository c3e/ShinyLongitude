print(wifi.sta.getip())

-- init ws2812 lights
ws2812.init(ws2812.MODE_SINGLE)
ws2812.write(string.char(255, 0, 0, 255, 0, 0))
buffer = ws2812.newBuffer(4, 3)
buffer:fill(0, 0, 0);
ws2812.write(buffer)
r, g, b = 168, 255, 0

i = 0
light_timer = tmr.create()
light_timer:register(100, tmr.ALARM_AUTO, function (t)
        --print("light loop")
        i=i+1
        buffer:fade(4)
        buffer:set(i%buffer:size()+1, r, g, b)
        ws2812.write(buffer .. buffer)
end)

function start_light()
    print("lights on")

    print(light_timer:start())
end

function stop_light()
    light_timer:stop()
    i = 0
    buffer:fill(0,0,0)
    ws2812.write(buffer .. buffer)
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
    if topic == mqtt_topic .. "action" then
        if message == "down" then
            lower_leinwand()
        elseif message == "halt" then
            halt_leinwand()
        elseif message == "up" then
            upper_leinwand()
        end
    elseif topic == mqtt_topic .. "set/r" then
        r = int(message)
    elseif topic == mqtt_topic .. "set/g" then
        g = int(message)
    elseif topic == mqtt_topic .. "set/b" then
        b = int(message)
    elseif topic == mqtt_topic .. "set/default" then
        r, g, b = 168, 255, 0
    end
    print(message)
end)
