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
	start_light()
	gpio.write(oc_down, gpio.HIGH)
	m:publish(mqtt_topic .. "status", "RAUF!", 0, 0)
    tmr.alarm(3, duration, tmr.ALARM_SINGLE, function() halt_leinwand() end)
    tmr.start(5)
end

function upper_leinwand()
	start_light()
	gpio.write(oc_up, gpio.HIGH)
	m:publish(mqtt_topic .. "status", "RUNTER!", 0, 0)
    tmr.alarm(3, duration, tmr.ALARM_SINGLE, function() halt_leinwand() end)
    tmr.start(5)
end

function halt_leinwand()
	stop_light()
	gpio.write(oc_up, gpio.LOW)
	gpio.write(oc_down, gpio.LOW)
	gpio.write(oc_stop, gpio.HIGH)
	m:publish(mqtt_topic .. "status", "STOPP!", 0, 0)
    tmr.alarm(2, 500, tmr.ALARM_SINGLE, function() gpio.write(oc_stop, gpio.LOW) end)
end
