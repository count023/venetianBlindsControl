-- main.lua --

wifiInitialized = false
serverInitialized = false
pinsInitialized = false

print("\n\n\n################################################")
print("##        Venetian Blinds Control v0.3        ##")
print("##                     by                     ##")
print("##                  count023                  ##")
print("################################################\n\n")

initWifi()

tmr.alarm(1, 1100, tmr.ALARM_AUTO, function()
    if wifiInitialized then
        print("Will initiate the Server ...")
        initServer()
        tmr.stop(1)
    end
end)

tmr.alarm(2, 1200, tmr.ALARM_AUTO, function()
    if serverInitialized then
        print("Will initiate the Pins ...")
        initPins()
        tmr.stop(2)
    end
end)

tmr.alarm(3, 1300, tmr.ALARM_AUTO, function()
    if pinsInitialized then
        print("Will test the Pins ...")
        testPins()
        tmr.stop(3)
        print("\n\Initiated! Ready for PUNK ;)\n\n")
    end
end)
