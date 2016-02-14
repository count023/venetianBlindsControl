-- server.functions.lua --

function parseRequestVars(requestVars)
    local _VARS = {}
    if requestVars ~= nil then
        for k, v in string.gmatch(requestVars, "(%w+)=(%w+)&*") do
            _VARS[k] = v
        end
    end
    return _VARS
end

function parseRequestBasics(request)
    local _, _, method, path, getVars = string.find(request, "([A-Z]+) (.+)?(.+) HTTP");
    if method == nil then 
        _, _, method, path = string.find(request, "([A-Z]+) (.+) HTTP"); 
    end
    return method, path, parseRequestVars(getVars)
end

-- TODO: implement POST request with JSON body
function parseRequestBody(request)
    local _, _, postVars = string.find(request, ".*\r?\n\r?\n(.+)")
    local _, _, contentType = string.find(request, ".*\r?\nContent[-]Type: ([^\r\n]+)\r?\n.*")

    -- just working for Content-Type: application www-x-form !!!
    if contentType == "application/x-www-form-urlencoded" or contentType == "application/x-www-form-urlencoded; charset=UTF-8" then
        return parseRequestVars(postVars)
    end
    return {}
end

function parseRequest(request)

    local _POST = {}
    local method, path, _GET = parseRequestBasics(request)

    if method == "POST" then
        _POST = parseRequestBody(request)
    end

    return method, path, _GET, _POST
end

function writeResponse(statusMessage, responseBody)

    local buf =  "HTTP/1.1 " .. statusMessage .. "\r\n"
    buf = buf .. "Server: NodeMCU\r\n"
    buf = buf .. "Access-Control-Allow-Origin: *\r\n"
    buf = buf .. "Access-Control-Allow-Methods: POST, GET\r\n"
    buf = buf .. "Access-Control-Max-Age: 1000\r\n"
    buf = buf .. "Content-Type: application/json; charset=UTF-8\r\n"
    buf = buf .. "\r\n"

    buf = buf .. tableToJson(responseBody) .. "\r\n"

    return buf
end

function doPost(path, _GET, _POST)
    local statusMessage, responseBody = "", {}

    if _POST["blindsMove"] ~= nil then
        switchOff("open")
        switchOff("close")

        switchOn(_POST["blindsMove"])
    end

    if _POST["blindsTurn"] ~= nil then
        switchOff("left")
        switchOff("right")

        switchOn(_POST["blindsTurn"])
    end
    responseBody["status"] = "OK"
    statusMessage = "200 OK"

    return writeResponse(statusMessage, responseBody)
end

function doGet(path, _GET)
    local statusMessage, responseBody = "", {}

    if path == "/status" then
        responseBody = status
    else
        switchOffAnything()
        responseBody["status"] = "OK"
    end
    statusMessage = "200 OK"

    return writeResponse(statusMessage, responseBody)
end

function doError(path)
    local statusMessage, responseBody = "", {}

    responseBody["status"] = "ERROR"
    responseBody["message"] = "Sorry, do not understand your request"
    statusMessage = "405 Method Not Allowed"

    return writeResponse(statusMessage, responseBody)
end
