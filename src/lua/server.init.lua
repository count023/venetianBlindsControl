-- server.init.lua --

function initServer()
    srv = net.createServer(net.TCP)

    srv:listen(80, function (conn)

        print("Connecting server to port 80")

        conn:on("receive", function (client, request)

            local method, path, _GET, _POST = parseRequest(request)

            local responseBody, status = {}, "";

            if method == "POST" then
                doPost(_GET, _POST)
                responseBody["status"] = "OK"
                status = "200 OK"
            elseif method == "GET" then
                doGet(_GET)
                responseBody["status"] = "OK"
                status = "200 OK"
            else
                responseBody["status"] = "ERROR"
                responseBody["message"] = "Sorry, do not understand your request"
                status = "405 Method Not Allowed"
            end

            local buf =  "HTTP/1.1 " .. status .. "\r\n"
            buf = buf .. "Server: NodeMCU\r\n"
            buf = buf .. "Access-Control-Allow-Origin: *\r\n"
            buf = buf .. "Access-Control-Allow-Methods: POST\r\n"
            buf = buf .. "Access-Control-Max-Age: 1000\r\n"
            buf = buf .. "Content-Type: application/json; charset=UTF-8\r\n"
            buf = buf .. "\r\n"

            buf = buf .. tableToJson(responseBody) .. "\r\n"

            client:send(buf);

            client:close();
            collectgarbage();
        end)

        conn:on("sent", function (conn)
            conn:close()
        end)

    end)
    serverInitialized = true
end
