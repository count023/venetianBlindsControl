-- wifi.functions.lua --

function printWifiStationInfo()
    print("set mode=STATION (mode = " .. wifi.getmode() .. ")\n")
    print("MAC Address: ", wifi.sta.getmac())
    print("Chip ID: ", node.chipid())
    print("Heap Size: ", node.heap(), "\n")
end

function printWifiCurrentStatus()
    ip, nm, gw = wifi.sta.getip()
    print("IP Info: \nIP Address: ", ip)
    print("Netmask: ", nm)
    print("Gateway Addr: ", gw, "\n")
end

function initWifi()
    wifi.setmode(wifi.STATION)
    wifi.sta.config(ssid, pass)
    printWifiStationInfo()
    print("Connecting to AP...")
    tmr.alarm(0, 1000, tmr.ALARM_AUTO, function()
        if wifi.sta.getip() ~= nil then
            printWifiCurrentStatus()
            tmr.stop(0)
            wifiInitialized = true
        end
    end)
end
