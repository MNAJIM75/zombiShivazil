local tb = {}
local _tbName = "entities"
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

return tb
