-- resources
local tb = {
    resType = {
        image = {'player', 'enemy', 'item', 'vfx', 'weapon', "land"},
        audio = {'sfx'},
        font = {'font'}
    },
    loadedsprite = {}
}
local _tbName = "Res"
local _tbpath = "./".. _tbName .. "/"

function tb:load()
    self.image = {}
    self.audio = {}
    self.font = {}
    self.font['font_default'] = rl.GuiGetFont()
    libs.path.each(_tbpath, function(P, mode)
        if mode == 'file' then
            local _filepath, _extension = libs.path.splitext(P)
            local _module = libs.path.basename(_filepath)
            if ".png" == _extension then
                self.image[_module] = loader.loadimage(P)
            elseif ".wav" == _extension then
                self.audio[_module] = loader.loadwave(P)
            elseif ".ttf" == _extension then
                self.font[_module] = loader.loadfont(P)
            end
            print("[".. _tbName .. "] -> " .. _module .. _extension .. " Loaded.")
        end
    end, {
        param = "fm",   -- request full path and mode
        delay = true,   -- use snapshot of directory
        recurse = false, -- include subdirs
        reverse = false -- subdirs at first 
    })
end
--[[
function tb:load()
    libs.path.each("./".. _tbName .. "/*.png", function(P, mode)
        if mode == 'file' then
            local _module = libs.path.basename(libs.path.splitext(P))
            self[_module] = loader.loadimage(P)
            print("[".. _tbName .. "] -> " .. "[" .. type(self[_module]).."]" .. _module .. " Loaded.")
        end
    end, {
      param = "fm",   -- request full path and mode
      delay = true,   -- use snapshot of directory
      recurse = false, -- include subdirs
      reverse = false -- subdirs at first 
    })
    libs.path.each("./".. _tbName .. "/*.wav", function(P, mode)
        if mode == 'file' then
            local _module = libs.path.basename(libs.path.splitext(P))
            self[_module] = loader.loadwave(P)
            print("[".. _tbName .. "] -> " .. "[" .. type(self[_module]).."]" .. _module .. " Loaded.")
        end
    end, {
      param = "fm",   -- request full path and mode
      delay = true,   -- use snapshot of directory
      recurse = false, -- include subdirs
      reverse = false -- subdirs at first 
    })
    libs.path.each("./".. _tbName .. "/*.ttf", function(P, mode)
        if mode == 'file' then
            local _module = libs.path.basename(libs.path.splitext(P))
            self[_module] = loader.loadfont(P)
            print("[".. _tbName .. "] -> " .. "[" .. type(self[_module]).."]" .. _module .. " Loaded.")
        end
    end, {
      param = "fm",   -- request full path and mode
      delay = true,   -- use snapshot of directory
      recurse = false, -- include subdirs
      reverse = false -- subdirs at first 
    })
    
end]]

function tb:unload()
    for k,v in pairs(self.loadedsprite) do loader.unloadsprite(v) end
    self:unloadresources("image", loader.unloadimage)
    self:unloadresources("font", loader.unloadfont)
    self:unloadresources("audio", loader.unloadwave)
end

function tb:unloadresources(_tablename, _unloadfunc)
    assert(self[_tablename], "[Res] Error: no table was found by the name of " .. _tablename .. '.')
    assert(_unloadfunc, "[Res] Error: no unload function was provided.")
    for _k, _r in pairs(self[_tablename]) do 
        _unloadfunc(_r)
        print("[".. _tbName .. "] -> " .. _k .. " Unloaded.")
    end
end

--[[
function tb:unload()
    for k,v in pairs(self.loadedsprite) do loader.unloadsprite(v) end
    for k, v in pairs(tb) do
        if "cdata" == type(v) then
            print("[".. _tbName .. "] -> " .. "[" .. type(tb[k]) .."]" .. k .. " Unloaded.")
            for _i, _type in ipairs(self.resType.audio) do
                if string.find(k, _type) then loader.unloadwave(v)
                else loader.unloadimage(v); end
            end
        end
    end
end
]]
function tb:getres(_table, _type, _name)
    return self[_table][_type .. "_" .. _name]
end

function tb:getsprite(_type, _name)
    for i, s in ipairs(self.resType.image) do
        if s == _type then
            if not self.loadedsprite[_type .. "_" .. _name] then
                self.loadedsprite[_type .. "_" .. _name] = loader.loadsprite(self:getres("image", _type, _name))
                graphics.canvasfilter(self.loadedsprite[_type .. "_" .. _name], graphics.canvas_filter.point)
            end
            return self.loadedsprite[_type .. "_" .. _name]
        end
    end
    assert(false, "[Res] Error: No sprite was loaded of type (".._type..") or name (".._name..")")
end

function tb:getsound(_type, _name)
    for i, s in ipairs(self.resType.audio) do
        if s == _type then
            return self:getres("audio", _type, _name)
        end
    end
end

--[[
function tb:getsprite(_type, _name)
    for i, s in ipairs(self.resType.image) do
        if s == _type then
            if not self.loadedsprite[_type .. "_" .. _name] then
                self.loadedsprite[_type .. "_" .. _name] = loader.loadsprite(self[_type .. "_" .. _name])
                graphics.canvasfilter(self.loadedsprite[_type .. "_" .. _name], graphics.canvas_filter.point)
            end
            return self.loadedsprite[_type .. "_" .. _name]
        end
    end
    assert(false, "[Res] Error: No sprite was loaded of type (".._type..") or name (".._name..")")
end
]]

function tb:getfont(_name)
    return self:getres("font", "font", _name)
end

return tb
