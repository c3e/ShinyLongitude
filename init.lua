dofile("credentials.lua")
dofile("foobar-wifi.lua")
--Startup file--

NextFile="foobar-wifi.lua"
 l = file.list();
    for k,v in pairs(l) do
    --  print("name:"..k..", size:"..v)
         if k == NextFile then
         print("Wait 15 seconds please til wifi is up")
         tmr.alarm(0, 15000, 0, function() dofile(NextFile) end)
         print("Started file ".. NextFile)
         else
       --  do nothing
         end
    end
print("End of startup")
