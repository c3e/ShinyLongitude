wifi.setmode(wifi.STATION)
wifi.sta.config(wifi_ssid,wifi_pw)
wifi.sta.autoconnect(1)
wifi.sta.eventMonReg(wifi.STA_GOTIP, function()
	print(wifi.sta.getip())
	dofile("foobar.lua")
	end)

wifi.sta.eventMonStart()

wifi.sta.connect()
