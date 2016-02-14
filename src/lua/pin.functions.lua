-- pin.functions.lua --

function testPins()
    for name, pin in pairs(pinBlinds) do
        --print("test pin named: '" .. name .. "'")
        gpio.write(pin, gpio.HIGH)
        tmr.delay(1000000)
        gpio.write(pin, gpio.LOW)
    end
end

-- functions call from server.functions.lua#doPost and server.functions.lua#doGet

function switchOffAnything()
    for name, pin in pairs(pinBlinds) do
        gpio.write(pin, gpio.LOW)
    end
end

function switchOn(pinName)
    if pinBlinds[pinName] ~= nil then
        print(tableToJson(status))
        print( (status["x"] ~= pinName and status["y"] ~= pinName) )
        if status["x"] ~= pinName and status["y"] ~= pinName then
            print("Writing HIGH to " .. pinName)
            gpio.write(pinBlinds[pinName], gpio.HIGH)
        end
    end
end

function switchOff(pinName)
    if pinBlinds[pinName] ~= nil then
        gpio.write(pinBlinds[pinName], gpio.LOW)
    end
end
