-- server.functions.lua --

function parseRequestBasics(request)
    local _, _, method, path, getVars = string.find(request, "([A-Z]+) (.+)?(.+) HTTP");
    if method == nil then 
        _, _, method, path = string.find(request, "([A-Z]+) (.+) HTTP"); 
    end
    return method, path, parseRequestVars(getVars)
end

function parseRequestBody(request)
    local _, _, postVars = string.find(request, ".*\r?\n\r?\n(.+)")
    local _, _, contentType = string.find(request, ".*\r?\nContent[-]Type: ([^\r\n]+)\r?\n.*")

    print(contentType)

    -- just working for Content-Type: application www-x-form !!!
    if contentType == "application/x-www-form-urlencoded" or contentType == "application/x-www-form-urlencoded; charset=UTF-8" then
        return parseRequestVars(postVars)
    end
    return {}
end

function parseRequestVars(requestVars)
    local _VARS = {}
    if requestVars ~= nil then
        for k, v in string.gmatch(requestVars, "(%w+)=(%w+)&*") do
            _VARS[k] = v
        end
    end
    return _VARS
end

function parseRequest(request)

    local _POST = {}
    local method, path, _GET = parseRequestBasics(request)

    if method == "POST" then
        _POST = parseRequestBody(request)
    end

    print(request)
    print(
        "\nmethod: ", method,
        "\npath: ", path,
        "\n_GET: ", tableToJson(_GET),
        "\n_POST: ", tableToJson(_POST)
    )

    return method, path, _GET, _POST
end

function doPost(_GET, _POST)

    if _POST["blindsMove"] ~= nil then
        switchOff("open")
        switchOff("close")
        if _POST["blindsMove"] ~= nil then
            switchOn(_POST["blindsMove"])
        end
    end
    if _POST["blindsTurn"] ~= nil then
        switchOff("left")
        switchOff("right")
        if _POST["blindsTurn"] ~= nil then
            switchOn(_POST["blindsTurn"])
        end
    end
end

function doGet(_GET)
    switchOffAnything()
end
