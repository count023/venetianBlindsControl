-- init.lua --


dofile("helper.lua")

-- Configure Wireless Internet
dofile("wifi.config.lua")
dofile("wifi.functions.lua")


-- Configure Simple HTTP-Server
dofile("server.functions.lua")
dofile("server.init.lua")


-- Configure the pins
dofile("pin.config.lua")
dofile("pin.functions.lua")
dofile("pin.init.lua")


-- Run the main file
dofile("main.lua")
