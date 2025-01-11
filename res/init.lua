-- resources
local tb = {
    resType = {
        image = {'player', 'enemy', 'item', 'vfx', 'weapon', "land"},
        audio = {'sfx'}
    },
    loadedsprite = {}
}
local _tbName = "Res"

function tb:load()
    libs.path.each("./".. _tbName .. "/*.png", function(P, mode)
        if mode == 'file' then
            local _module = libs.path.basename(libs.path.splitext(P))
            if _module and "init" == _module then return end
            tb[_module] = loader.loadimage(P)
            print("[".. _tbName .. "] -> " .. "[" .. type(tb[_module]).."]" .. _module .. " Loaded.")
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
            if _module and "init" == _module then return end
            tb[_module] = loader.loadwave(P)
            print("[".. _tbName .. "] -> " .. "[" .. type(tb[_module]).."]" .. _module .. " Loaded.")
        end
    end, {
      param = "fm",   -- request full path and mode
      delay = true,   -- use snapshot of directory
      recurse = false, -- include subdirs
      reverse = false -- subdirs at first 
    })
end

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

function tb:getsprite(_type, _name)
    for i, s in ipairs(self.resType.image) do
        if s == _type then
            print("[Res] Requesting ".._type .. "_" .. _name.." sprite.")
            self.loadedsprite[_type .. "_" .. _name] = loader.loadsprite(self[_type .. "_" .. _name])
            graphics.canvasfilter(self.loadedsprite[_type .. "_" .. _name], graphics.canvas_filter.point)
            return self.loadedsprite[_type .. "_" .. _name]
        end
    end
    assert(false, "[Res] Error: No sprite was loaded of type (".._type..") or name (".._name..")")
end

return tb
