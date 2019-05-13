local M = {
  DEVICE = 0x58
}

function M.initAirQuality(i2c, device)
  local msgs = {{0x20, 0x03}}
  i2c:transfer(device or M.DEVICE, msgs)
end

return M
