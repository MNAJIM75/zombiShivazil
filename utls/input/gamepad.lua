local const = {
	lsx = 0, lsy = 1,
	rsx = 2, rsy = 3,
}

local pad = {
	enable = 0,
	FC = 0,-- first controller
	controller = {
		leftstick = 0,
		rightstick = 0		
	},
}

function pad:load()
	self.controller.leftstick = libs.vector(0, 0)
	self.controller.rightstick = libs.vector(0, 0)
end

function pad:update()
	self.enable =					rl.IsGamepadAvailable(self.FC)
	self.controller.leftstick.x =	rl.GetGamepadAxisMovement(self.FC, const.lsx)
	self.controller.leftstick.y =	rl.GetGamepadAxisMovement(self.FC, const.lsy)
	self.controller.rightstick.x =	rl.GetGamepadAxisMovement(self.FC, const.rsx)
	self.controller.rightstick.y =	rl.GetGamepadAxisMovement(self.FC, const.rsy)
end

function pad:getFromController(_key)
	return self.controller[_key]
end

return pad