-- pin.init.lua --

function initPins()
    for name, pin in pairs(pinBlinds) do
        gpio.mode(pin, gpio.OUTPUT)
        gpio.write(pin, gpio.LOW)
    end
    pinsInitialized = true
end
