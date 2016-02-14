-- pin.init.lua --

function initPins()
    for name, pin in pairs(pinBlinds) do
        gpio.mode(pin, gpio.OUTPUT)
        gpio.write(pin, gpio.LOW)
    end
    for name, pin in pairs(pinSwitches) do
        gpio.mode(pin, gpio.INT, gpio.PULLUP)
        local statusField = "z"
        if name == "open" or name == "close" then
            statusField = "x"
        end
        gpio.trig(pin, "low", function (level)
            print("Level for pin (" .. pin .. "): " .. level)
            if level == gpio.HIGH then
                gpio.trig(pin, "low")
                status[statusField] = "nil"
            else
                gpio.trig(pin, "high")
                status[statusField] = name
                switchOff(name)
            end
            print(tableToJson(status))
        end)
    end
    pinsInitialized = true
end
