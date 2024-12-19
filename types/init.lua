local tb = {}
local _tbName = "Types"
libs.path.each("./".. _tbName .. "/*.lua", function(P, mode)
    if mode == 'file' then
        local _module = libs.path.basename(libs.path.splitext(P))
        if _module and "init" == _module then return end
        tb[_module] = require(_tbName .. '.' .. _module)
        print("[".. _tbName .. "] -> " .. _module .. " Loaded.")
    end
end, {
  param = "fm",   -- request full path and mode
  delay = true,   -- use snapshot of directory
  recurse = false, -- include subdirs
  reverse = false -- subdirs at first 
})

--[[
libs.path.each("./types/*.lua", function(P, mode)
  if mode == 'directory' then 
    print(P, mode)
  else
    print(libs.path.basename(P), mode)
  end
end,{
  param = "fm";   -- request full path and mode
  delay = true;   -- use snapshot of directory
  recurse = false; -- include subdirs
  reverse = false; -- subdirs at first 
})
]]
return tb
