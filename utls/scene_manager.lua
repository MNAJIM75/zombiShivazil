local smgr = {}
smgr.camera = nil


function smgr:load()
	self.currentScene = nil
	if not self.camera then
		self.camera = graphics.objects.camera(
			0, 0, -- target
			graphics.virtual_width / 2, graphics.virtual_height / 2, -- origin
			nil, nil
		)
	end
	self.scenes = require'scenes'
	print("[Scene Manager] -> loaded.")
	self:changeScene(1)
end

function smgr:changeScene(_scene)
	-- error handling
	assert(type(_scene) == 'string' or type(_scene) == 'number',
	'[Scene Manager] -> Error: invalid scene type ( '..type(_scene) .. " )")

	-- scene changing
	if self.currentScene then 
		self.currentScene:unload() 
		print("[Scene Manager] -> Unload " .. self.currentScene.name .. " Scene.")
	end
	self.currentScene = self.scenes[_scene]
	print("[Scene Manager] -> load " .. self.currentScene.name .. " Scene.")
	self.currentScene:load()
end

function smgr:setCameraPosition(_x, _y, _ax, _ay)
	self.camera.target.x = _x + graphics.virtual_width / 2 + _ax or 0
	self.camera.target.y = _y  + graphics.virtual_height / 2 + _ay or 0
end


function smgr:update(dt)
	if self.currentScene then
		self.currentScene:update(dt)
	end
end

function smgr:draw()
	if self.currentScene then
		self.currentScene:draw()
	end
end

function smgr:unload()
	self.currentScene:unload()
end

return smgr
