local input = {
	actions = {
		move = 0,
		aim = 0,
		fire = 0,
		grab = 0
	},
	threshold = {
		right = 0.3,
		left = 0.3
	},
	currentDevice = "keyboard", -- TODO: keyboard or gamepad 
}

function input.newaction(_button, _value)
	return { button = _button, value = _value }
end

function input:load()
	self.gamepad = require'utls.input.gamepad'
	self.gamepad:load()

	self.actions.move = input.newaction("leftstick", libs.vector(0, 0))
	self.actions.aim = input.newaction("rightstick", libs.vector(0, 0))
	self.actions.fire = input.newaction("right_shoulder", false)
	self.actions.grab = input.newaction("x", false)

	eventsystem:subscripe("buttonpressed", self)
	eventsystem:subscripe("buttonreleased", self)
end

function input:checkDevice()
	
end

function input:buttonpressed(_button)
	--print("[Input]  " .. _button)
end

function input:buttonreleased(_button)
	--print("[Input] .. " .. _button)
end

function input:update()
	self.gamepad:update()
	for _k, _v in pairs(self.actions) do
		_v.value = self.gamepad:getFromController(_v.button)
	end
	--[[
		self.actions.move.value = self.gamepad:getFromController("leftstick")
		self.actions.aim = self.gamepad:getFromController("rightstick")
		self.actions.fire = self.gamepad:getFromController("rightshoulder") 
	]]
end

-- game specific axis
function input:getactionvalue(_action)
	return self.actions[_action].value
end

function input:getactionvaluepressed(_action)
	assert(self.actions[_action], "[Input] Error: No action of name " .. _action .. " is implemented.")
	return self.gamepad:getbuttonpressed(self.actions[_action].button)
end

return input