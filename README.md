<img align="right" src="sgp30.jp2" height="100">

# SGP30 Lua driver

A [lua-periphery](https://github.com/vsergeev/lua-periphery) based sensor driver for the [SGP30](https://www.adafruit.com/product/3709) air quality sensor.

The SGP30 requires a delay between making a request and reading a response, which is why a [luasocket](https://luarocks.org/modules/luasocket/luasocket) dependency exists for its _sleep_ capability.

## Usage

Note that this particular device must be asked to perform measurements at 1-second intervals for at least 15 seconds before it begins to function.

```lua
local periphery = require 'periphery'
local sgp30 = require 'sgp30'
local socket = require 'socket'

local device = 0x58

local i2c = periphery.I2C('/dev/i2c-1')
sgp30.initAirQuality(i2c, device)
for i = 1, 20 do
	local co2PPM, vocPPB = sgp30.measureAirQuality(i2c, device)
	print(string.format('--------------------------:---------'))
	print(string.format('Carbon Dioxide            : %4i PPM', co2PPM))
	print(string.format('Volatile Organic Compounds: %4i PPB', vocPPB))
	socket.sleep(1)
end
```

Sample output, obtained by waiting for 15 seconds, then breathing on the device:

```
...
--------------------------:---------
Carbon Dioxide            : 400 PPM
Volatile Organic Compounds:   0 PPB
...
--------------------------:---------
Carbon Dioxide            :  400 PPM
Volatile Organic Compounds:    0 PPB
--------------------------:---------
Carbon Dioxide            :  406 PPM
Volatile Organic Compounds:    1 PPB
--------------------------:---------
Carbon Dioxide            : 1409 PPM
Volatile Organic Compounds:   68 PPB
--------------------------:---------
Carbon Dioxide            : 2710 PPM
Volatile Organic Compounds:  147 PPB
...
```
