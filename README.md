# Intelligent_wildlife_tracking-_system#

Developed an algorithm for transmitting the data over a shortest path to the server. The aim was to track the animals’ locations in sanctuaries and jungles using Wi-Fi Devices eliminating the cost of GPS and GSM technologies. And then the location of an animal can be seen on the tablets using the android app. This project was sponsored by Persistent Systems.

You will need following components to run this project:-
1. First read what the project is about.
2. Then you will need 3 ESP8266 wifi module (which costs about $5 each) and download it's drivers from https://cityos-air.readme.io/docs/1-usb-drivers-for-nodemcu-v10

The above repository contains the hardware level coding files programmed in Lua programming.
Follow the steps to install lua and hardware flasher:-
1. extract luaload.zip
2. install lualoader by clicking on luaload.exe
3. extract flasher.zip
4. install it.
5. burn the server.lua code using flasher to the stationary esp8266 module.
6. burn the client.lua code using flasher to the mobile esp8266 module.

Then Install the neatbeans to run the server side code and then import the following project in netbeans.
I am providing you the link to the google drive for the netbeans project because it contains a lot of files.

Link: https://drive.google.com/open?id=1T5vGKnws23EOCO07dBI8FT03-YR194GU

Then once you import that project run it directly and then connect the ESP 8266 to battery (using USB cable) and then you will see the lcoation of ESP8266 modules.
