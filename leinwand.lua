oc_up = 5
oc_stop =6
oc_down = 7

duration = 5*1000

gpio.mode(oc_up, gpio.OUTPUT)
gpio.write(oc_up, gpio.LOW)

gpio.mode(oc_stop, gpio.OUTPUT)
gpio.write(oc_stop, gpio.LOW)

gpio.mode(oc_down, gpio.OUTPUT)
gpio.write(oc_down, gpio.LOW)

-- Beamer Serial Codes
--* 0 IR 001 //on
--* 0 IR 002 //off

function lower_leinwand()
	--start_light()
	gpio.write(oc_up, gpio.LOW)
	gpio.write(oc_down, gpio.HIGH)
	--m:publish(mqtt_topic .. "status", "RAUF!", 0, 0) --breaks the light timer. dont use!
	print(light_timer:start())
	ll_timer = tmr.create()
	ll_timer:register(500, tmr.ALARM_SINGLE, function (t) gpio.write(oc_down, gpio.LOW); t:unregister() end)
	ll_timer:start()

	hl_timer = tmr.create()
	hl_timer:register(duration, tmr.ALARM_SINGLE, function (t) halt_leinwand(); t:unregister() end)
	hl_timer:start()
end

function upper_leinwand()
	--start_light()
	gpio.write(oc_down, gpio.LOW)
	gpio.write(oc_up, gpio.HIGH)
	--m:publish(mqtt_topic .. "status", "RAUF!", 0, 0)
	print(light_timer:start())
	ul_timer = tmr.create()
	ul_timer:register(500, tmr.ALARM_SINGLE, function (t) gpio.write(oc_up, gpio.LOW); t:unregister() end)
	ul_timer:start()

	hl_timer = tmr.create()
	hl_timer:register(duration, tmr.ALARM_SINGLE, function (t) halt_leinwand(); t:unregister() end)
	hl_timer:start()
end

function halt_leinwand()
	stop_light()
	gpio.write(oc_up, gpio.LOW)
	gpio.write(oc_down, gpio.LOW)
	gpio.write(oc_stop, gpio.HIGH)
	halt_timer = tmr.create()
	halt_timer:register(500, tmr.ALARM_SINGLE, function (t) gpio.write(oc_stop, gpio.LOW); t:unregister() end)
	halt_timer:start()
end
