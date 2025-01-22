local tb = {}
local _tbName = "Types"
local _namespace = "ui"
local _searchformat = "./".. _tbName .. "/" .. _namespace .. "/*"
local _requireformat = _tbName .. "." .. _namespace

libs.path.each(_searchformat, function(P, mode)
    if mode == 'file' then
        local _module = libs.path.basename(libs.path.splitext(P))
        if _module and "init" == _module then return end
        tb[_module] = require(_requireformat .. '.' .. _module)
        print("[".. _requireformat .. "] -> " .. _module .. " Loaded.")
    elseif mode == 'directory' then
        local _module = libs.path.basename(P)
        tb[_module] = require(_tbName .. '.' .. _module)
    end
end, {
  param = "fm",   -- request full path and mode
  delay = true,   -- use snapshot of directory
  recurse = false, -- include subdirs
  reverse = false -- subdirs at first 
})

return tb
