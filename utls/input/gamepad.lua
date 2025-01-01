local pconst = {
	lsx = 0, lsy = 1,
	rsx = 2, rsy = 3,
	right_shoulder = const.gamepad_button_right_trigger_1,
	right_trigger = const.gamepad_button_right_trigger_2,
	left_shoulder = const.gamepad_button_left_trigger_1,
	left_trigger = const.gamepad_button_left_trigger_2,
	x = const.gamepad_button_right_face_down,
}

local pad = {
	enable = 0,
	FC = 0,-- first controller
	controller = {
		leftstick = 0,
		rightstick = 0,
		buttons = {
			right_shoulder = false,
			right_trigger = false,
			left_shoulder = false,
			left_trigger = false,
			x = false,
		}
	},
	lastpressed = {},
	once = false
}

function pad:load()
	self.controller.leftstick = libs.vector(0, 0)
	self.controller.rightstick = libs.vector(0, 0)
end

function pad:update()
	self.enable =					rl.IsGamepadAvailable(self.FC)
	self.controller.leftstick.x =	rl.GetGamepadAxisMovement(self.FC, pconst.lsx)
	self.controller.leftstick.y =	rl.GetGamepadAxisMovement(self.FC, pconst.lsy)
	self.controller.rightstick.x =	rl.GetGamepadAxisMovement(self.FC, pconst.rsx)
	self.controller.rightstick.y =	rl.GetGamepadAxisMovement(self.FC, pconst.rsy)
	for _k, _v in pairs(self.controller.buttons) do
		local b_v = pconst[_k]
		local _buttonpressed = rl.IsGamepadButtonDown(self.FC, b_v)
		local _buttonreleased = rl.IsGamepadButtonReleased(self.FC, b_v)
		if _buttonpressed then
			if not self.controller[_k] then
				eventsystem:call("buttonpressed", _k)
				self.controller[_k] = true
			end
		end

		if _buttonreleased then
			if self.controller[_k] then
				eventsystem:call("buttonreleased", _k)
				self.controller[_k] = false
			end
		end
	end
end

function pad:getbuttonpressed(_key)
	return rl.IsGamepadButtonPressed(self.FC, pconst[_key])
end

function pad:getFromController(_key)
	if self.controller[_key] then return self.controller[_key]
	else return self.controller.buttons[_key] end
end

return pad