env = {}

-- Set up Wifi modes, see NodeMCU API doc for all options, don't change these
env.wifi_general = {}
env.wifi_general.mode = wifi.STATION
env.wifi_general.phymode = wifi.PHYMODE_B
env.wifi_general.sleeptype = wifi.NONE_SLEEP

-- Set up Wifi Access Point
env.wifi_AP = {}
env.wifi_AP.ssid = "ESP-"..node.chipid()   -- Name of the SSID you want to create
env.wifi_AP.pwd = "ESP-"..node.chipid()    -- WiFi password - at least 8 characters

-- Set up Wifi Access Point IPs
env.wifi_AP_IP = {}
env.wifi_AP_IP.ip = "192.168.100.1"
env.wifi_AP_IP.netmask = "255.255.255.0"
env.wifi_AP_IP.gateway = "192.168.100.1"

-- Set up Wifi network to connect to
env.wifi_station = {}
env.wifi_station.ssid = ""               -- Name of the WiFi network you want to join
env.wifi_station.pwd =  ""         -- Password for the WiFi network
