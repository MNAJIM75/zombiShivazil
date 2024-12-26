-- raylib functions
local loadsprite = rl.LoadTexture
local unloadsprite = rl.UnloadTexture

-- resources
local tb = {
    resType = {
        'player', 'enemy', 'item', 'vfx', 'weapon'
    }
}
local _tbName = "Res"

function tb:load()
    libs.path.each("./".. _tbName .. "/*.png", function(P, mode)
        if mode == 'file' then
            local _module = libs.path.basename(libs.path.splitext(P))
            if _module and "init" == _module then return end
            tb[_module] = loadsprite(P)
            graphics.canvasfilter(tb[_module], graphics.canvas_filter.point)
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
    for k, v in pairs(tb) do
        if "cdata" == type(v) then
            print("[".. _tbName .. "] -> " .. "[" .. type(tb[k]) .."]" .. k .. " Unloaded.")
            unloadsprite(v);
        end
    end
end

function tb:getsprite(_type, _name)
    for i, s in ipairs(self.resType) do
        if s == _type then
            return self[_type .. "_" .. _name]
        end
    end
    assert(false, "[Res] Error: No sprite was loaded of type (".._type..") or name (".._name..")")
end

return tb
