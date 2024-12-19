-- file reading handler
--print(io)
local file = io.open("config.json", "r")

assert(file, "Couldn't open config file")
local content = file:read("*all")
file:close()

-- json handler
local config = libs.json.decode(content)
return config


