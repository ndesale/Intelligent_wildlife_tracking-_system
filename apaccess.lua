wifi.setmode(wifi.STATIONAP);
wifi.ap.config({ssid="test2",pwd="12345678"});
print("Server IP Address:",wifi.ap.getip())
sv = net.createServer(net.TCP)

sv:listen(80,
function(conn)
conn:on("receive", 
	function(conn, receivedData) 
	       	print("Received Data: " .. receivedData)
		file.open("animal.lua","a+")
		file.writeline(receivedData)
		file.writeline(",")
		file.close()
		file.open("animal.lua","r")
		conn:send(" Area,"..wifi.ap.getmac()..",Data,"..file.read())
		file.close()
    	end)
    	conn:on("sent", function(conn) 
      	conn:close()
    	end)
end)

wifi.sta.disconnect()
wifi.sta.config("test","12345678")
wifi.sta.connect()
print("Looking for a connection")
tmr.alarm(1, 2000, 1, function()
	if(wifi.sta.getip()~=nil) then
  		tmr.stop(1)
  		print("Connected!")
	else
		print("Connecting.....")
	end
end)