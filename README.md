# ShinyLongitude
ESP8266 based canvas controls over mqtt
## Requirements
The following NodeMCU Modules have to be included in the Firmware: 
* file
*  GPIO
*  net
*  node
*  timer
*  uart
*  wifi
*  ws2812
*  mqtt
  
## Usage
"credentials-example.lua" has to be renamed to "credentials.lua" and edited with the correct parameters.

## MQTT Topics
    action = up|down|halt
    set/r = 0-255
    set/g = 0-255
    set/b = 0-255
    set/default = anything
