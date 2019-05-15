local I2C = require 'periphery'.I2C
local socket = require 'socket'

local M = {
  Command = {
    GetFeatureSet     = {0x20, 0x2f},
    InitAirQuality    = {0x20, 0x03},
    MeasureAirQuality = {0x20, 0x08},
  },
  DEVICE = 0x58
}

function M.initAirQuality(i2c, device)
  local msgs = {M.Command.InitAirQuality}
  i2c:transfer(device or M.DEVICE, msgs)
  socket.sleep(.010)
end

function M.measureAirQuality(i2c, device)
  local msgs = {M.Command.MeasureAirQuality}
  i2c:transfer(device or M.DEVICE, msgs)
  socket.sleep(.012)
  msgs = {{0x00, 0x00, 0x00, 0x00, 0x00, 0x00, flags=I2C.I2C_M_RD}}
  i2c:transfer(device or M.DEVICE, msgs)
  local data = msgs[1]
  local co2PPM = data[1]*256 + data[2]
  local vocPPB = data[4]*256 + data[5]
  return co2PPM, vocPPB
end

function M.readVersion(i2c, device)
  local msgs = {M.Command.GetFeatureSet, {0x00, 0x00, 0x00, flags=I2C.I2C_M_RD}}
  i2c:transfer(device or M.DEVICE, msgs)
  local lsb = msgs[2][2]
  return lsb
end

return M
