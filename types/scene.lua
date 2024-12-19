local scene = libs.classic:extend()

function scene:new(_scName)
	self.name = _scName or "Scene01"
	self.entities = {}
end

function scene:update(_dt)
	for k, e in pairs(self.entities) do
		e:update(_dt)
	end
end

function scene:addEntity(_ent)
	table.insert(self.entities, _ent)
end

function scene:draw()
	for i, e in ipairs(self.entities) do e:draw() end
end

function scene:load()
	print("[Scene] ".. self.name .. " loaded.")
end

function scene:unload()
	print("[Scene] ".. self.name .. " Unloaded.")
end


return scene
