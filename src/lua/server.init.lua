-- server.init.lua --

function initServer()
    srv = net.createServer(net.TCP)

    srv:listen(80, function (conn)

        print("Connecting server to port 80")

        conn:on("receive", function (client, request)

            local method, path, _GET, _POST = parseRequest(request)

            local statusMessage, responseBody, responseBuf = "", {}, "";

            if method == "POST" then
                responseBuf = doPost(path, _GET, _POST)
            elseif method == "GET" then
                responseBuf = doGet(path, _GET)
            else
                responseBuf = doError(path)
            end

            client:send(responseBuf);

            client:close();
            collectgarbage();
        end)

        conn:on("sent", function (conn)
            conn:close()
        end)

    end)
    serverInitialized = true
end
