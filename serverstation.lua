function listap(t)

	max=nil
	bss=nil
	print("\n"..string.format("%32s","SSID").."\tBSSID\t\t\t\t  RSSI\t\tAUTHMODE\tCHANNEL")
	for ssid,v in pairs(t) do
       		local authmode, rssi, bssid, channel = string.match(v, "([^,]+),([^,]+),([^,]+),([^,]+)")
		if max==nil then
			max=rssi
			name=ssid
			bss=bssid
		end
		if max<rssi then
	
		else
			max=rssi
			name=ssid
			bss=bssid	
		end
        	print(string.format("%32s",ssid).."\t"..bssid.."\t  "..rssi.."\t\t"..authmode.."\t\t\t"..channel)
    	end
    	print("\nClosest "..name)
	if name=="test" then
		print("ESP8266 Client")
		wifi.sta.disconnect()
		wifi.sta.config(name,"12345678",bss) -- connecting to server
		wifi.sta.connect() 
		print("Looking for a connection")

		tmr.alarm(1, 2000, 1, function()
     			if(wifi.sta.getip()~=nil) then
        	  		tmr.stop(1)
        	  		print("Connected!"..name)
        	  		print("Client IP Address:",wifi.sta.getip())
				cl=nil
				cl=net.createConnection(net.TCP, 0)
				print("after createConn() !!")
				
				file.open("animal.lua","r")
				cl:send(wifi.sta.getmac()..file.read())
				print("DAta sent!!!!!!")
				cl:connect(80,"192.168.4.1")
      			else
         			print("Connecting...")
      			end
		end)
	end
end

print("ESP8266 Server")
wifi.setmode(wifi.STATIONAP);
wifi.ap.config({ssid="test1",pwd="12345678"});
print("Server IP Address:",wifi.ap.getip())

sv = net.createServer(net.TCP) 

sv:listen(80,
function(conn)
conn:on("receive", 
	function(conn, receivedData) 
	       	print("Received Data: " .. receivedData)
		file.open("animal.lua","a+")
		file.writeline(receivedData)
		file.close()
    	end) 
    	conn:on("sent", function(conn) 
      	
    	end)
end)

wifi.sta.getap(listap)