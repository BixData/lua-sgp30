print('Begin test')

local sgp30 = require 'sgp30'
local periphery = require 'periphery'

-- ============================================================================
-- Mini test framework
-- ============================================================================

local failures = 0

local function assertEquals(expected,actual,message)
  message = message or string.format('Expected %s but got %s', tostring(expected), tostring(actual))
  assert(actual==expected, message)
end

local function it(message, testFn)
  local status, err =  pcall(testFn)
  if status then
    print(string.format('✓ %s', message))
  else
    print(string.format('✖ %s', message))
    print(string.format('  FAILED: %s', err))
    failures = failures + 1
  end
end


-- ============================================================================
-- sgp30 module
-- ============================================================================

it('initAirQuality', function()
  local i2c = periphery.I2C('/dev/i2c-1')
  sgp30.initAirQuality(i2c)
end)

it('measureAirQuality', function()
  local i2c = periphery.I2C('/dev/i2c-1')
  sgp30.initAirQuality(i2c)
  local co2PPM, vocPPB = sgp30.measureAirQuality(i2c)
  assertEquals(co2PPM >= 400)
end)

it('measureRawSignals', function()
  local i2c = periphery.I2C('/dev/i2c-1')
  sgp30.initAirQuality(i2c)
  local sout_H2, sout_EthOH = sgp30.measureRawSignals(i2c)
  assertEquals(true, sout_H2 > 0)
  assertEquals(true, sout_EthOH > 0)
end)

it('readVersion', function()
  local i2c = periphery.I2C('/dev/i2c-1')
  local actual = sgp30.readVersion(i2c)
  assertEquals(0x20, actual)
end)
