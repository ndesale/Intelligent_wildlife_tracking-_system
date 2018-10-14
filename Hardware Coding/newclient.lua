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
	if name=="test" or name=="test1" then
		print("ESP8266 Client")
		wifi.sta.disconnect()
		wifi.sta.config(name,"12345678",bss) -- connecting to server
		wifi.sta.connect() 
		print("Looking for a connection")

		tmr.alarm(1, 2000, 1, function()
     			if(wifi.sta.getip()~=nil) then
        	  		tmr.stop(1)
        	  		print("Connected!")
        	  		print("Client IP Address:",wifi.sta.getip())
        	  		cl=net.createConnection(net.TCP, 0)
				cl:on("connection", function(sck, c)
			      	  sck:send(wifi.sta.getmac())
				end)
        	  		cl:connect(80,"192.168.4.1")
      			else
         			print("Connecting...")
      			end
		end)
	end
end

wifi.setmode(wifi.STATION)
tmr.alarm(2, 10000, 1, function()
     			wifi.sta.getap(listap)
	end)