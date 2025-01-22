local scene = libs.classic:extend()

function scene:new(_scName)
	self.name = _scName or "Scene01"
	self.entities = {}
end

function scene:update(_dt)
	for k, e in pairs(self.entities) do
		if e.update then e:update(_dt) end
	end
end

function scene:addentity(_ent)
	table.insert(self.entities, _ent)
end

function scene:findindex(_ent)
	for _i, _e in ipairs(self.entities) do
		if _ent == _e then return _i end
	end
	assert(false, "[Scene] " .. self.name .. ": No entity was found.")
end

function scene:removeentity(_ent)
	--self:destoryentity(_ent)
	table.remove(self.entities, self:findindex(_ent))
end

function scene:destoryentity(_ent)
	if _ent.sprite then
		loader.unloadsprite(_ent.sprite)
	end
	if _ent.animator then
		loader.unloadsprite(_ent.animator.sprite)
	end
end

function scene:draw()
	for i, e in ipairs(self.entities) do 
		if e.draw then e:draw() end
	end
end

function scene:load()
	print("[Scene] ".. self.name .. " loaded.")
end

function scene:unload()
	for _i, _en in pairs(self.entities) do
		--self:destoryentity(_en)
	end
	print("[Scene] ".. self.name .. " Unloaded.")
end


return scene
