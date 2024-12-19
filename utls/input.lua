local input = {
	actions = {
		move = 0,
		aim = 0
	},
	threshold = {
		right = 0.3,
		left = 0.3
	},
	currentDevice = "keyboard", -- TODO: keyboard or gamepad 
}

function input:load()
	self.gamepad = require'utls.input.gamepad'
	self.gamepad:load()

	self.actions.move = libs.vector(0, 0)
	self.actions.aim = libs.vector(0, 0)
end

function input:checkDevice()
	
end

function input:update()
	self.gamepad:update()
	self.actions.move = self.gamepad:getFromController("leftstick")
	self.actions.aim = self.gamepad:getFromController("rightstick")
end

-- game specific axis
function input:getAction(_action)
	return self.actions[_action]
end

return input