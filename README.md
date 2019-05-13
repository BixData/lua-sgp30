<img align="right" src="sgp30.jp2" height="100">

# SGP30 Lua driver

A [lua-periphery](https://github.com/vsergeev/lua-periphery) based sensor driver for the [SGP30](https://www.adafruit.com/product/3709) air quality sensor.

## Usage

```lua
local periphery = require 'periphery'
local sgp30 = require 'sgp30'
local device = 0x58

local i2c = periphery.I2C('/dev/i2c-1')
sgp30.initAirQuality(i2c, device)
```
