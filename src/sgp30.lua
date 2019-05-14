local I2C = require 'periphery'.I2C

local M = {
  Command = {
    GetFeatureSet  = {0x20, 0x2f},
    InitAirQuality = {0x20, 0x03}
  },
  DEVICE = 0x58
}

function M.initAirQuality(i2c, device)
  local msgs = {M.Command.InitAirQuality}
  i2c:transfer(device or M.DEVICE, msgs)
end

function M.readVersion(i2c, device)
  local msgs = {M.Command.GetFeatureSet, {0x00, 0x00, 0x00, flags=I2C.I2C_M_RD}}
  i2c:transfer(device or M.DEVICE, msgs)
  local lsb = msgs[2][2]
  return lsb
end

return M
