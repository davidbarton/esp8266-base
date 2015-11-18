-- Begin WiFi configuration

-- General config
--wifi.setmode(env.wifi_general.mode)
--wifi.setphymode(env.wifi_general.phymode)
--wifi.sleeptype(env.wifi_general.sleeptype)
--print('set (mode='..wifi.getmode()..')')

-- AP config
wifi.ap.config(env.wifi_AP)
wifi.ap.setip(env.wifi_AP_IP)
print('Wifi AP MAC: ',wifi.ap.getmac())

-- Client config
wifi.sta.config(env.wifi_station.ssid, env.wifi_station.pwd, 1)
print('Wifi Client MAC: ',wifi.sta.getmac())

-- Cleanup
print('chip: ',node.chipid())
print('heap: ',node.heap())
env.wifi_general = nil
env.wifi_AP = nil
env.wifi_AP_IP = nil
env.wifi_station = nil
collectgarbage()

-- End WiFi configuration


-- Create fallback AP
local start_AP = function()
  wifi.setmode(wifi.STATION)
  --TODO
end

-- Connect to hotspos, waits few seconds for establishing connection
local connect_hotspot = function()
  local d = deferred.new()
  local i = 0
  wifi.setmode(wifi.STATION)
  wifi.sta.connect()
  tmr.alarm(1, 1000, 1, function()
    if (wifi.sta.status() ~= 5 and i < 10) then
      --print("Status:"..wifi.sta.status())
      i = i + 1
    else
      tmr.stop(1)
      if (wifi.sta.status() == 5) then
        d:resolve("IP:"..wifi.sta.getip())
      else
        d:reject("Status:"..wifi.sta.status())
      end
    end
  end)
  return d
end

-- Connect to hotspot, try n-times before creating fallback AP
local wifi_init = function(max_attempts, timer_us)
  connect_hotspot():next(function(success)
    -- success continue
    print('Successfuly connected to hotspot. ', success)
  end, function(err)
    -- try again few times or create hotpost
    print('Connection to hotspot failed. ', err)
    if max_attempts > 0 then
      tmr.delay(timer_us)
      wifi_init(max_attempts-1, timer_us)
    else
      start_AP()
    end
  end)
end

-- Init sequence
wifi_init(3, 1000*500)
-- Start http server
--TODO
-- Start events
--TODO
