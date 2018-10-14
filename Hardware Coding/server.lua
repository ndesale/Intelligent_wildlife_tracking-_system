

print("ESP8266 Server")
wifi.setmode(wifi.STATIONAP);
wifi.ap.config({ssid="test",pwd="12345678"});
print("Server IP Address:",wifi.ap.getip())
sv = net.createServer(net.TCP)

sv:listen(80,
function(conn)
conn:on("receive", 
	function(conn, receivedData) 
		if string.find(receivedData,"NayanPC") ~=nil then
			if file.open("animal.lua","r") then
				conn:send(" Area,"..wifi.ap.getmac()..",Data,"..file.read())
				file.close()
				file.remove("animal.lua")
			else
				conn:send("nothing")
			end
		else
	       	 	print("Received Data: " .. receivedData)
			file.open("animal.lua","a+")
			file.writeline(receivedData)
			file.writeline(",")
			file.close()
		end
    	end) 
    	conn:on("sent", function(conn) 
      	conn:close()
    	end)
end)

wifi.sta.disconnect()
wifi.sta.config("Lenovo Vibe S1","244466666")
wifi.sta.connect()
