local smgr = {}
smgr.camera = nil


function smgr:load()
	self.currentscene = nil
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

	self:initscenetransition()
end

function smgr:initscenetransition()
	self.transition = {}
	self.transition.stopcurrent = true
	self.transition.playing = true
	self.transition.background = {
		rect = graphics.objects.rectangle(0, 0, graphics.screen_width, graphics.screen_height),
		color = graphics.colors.black,
		alpha = 1
	}
	self.transition.label = {
		text = "Loading",
		filelog = io.open("utls/transition_filelog.txt", 'r'),
		newlinetimer = 0,
		newlinethreshold = 0.3,
		newlinenumber = 1,
		font = res:getfont("loading"),
		alpha = 1,
		size = 18,
		spacing = 1,
		pos = graphics.objects.vector(
			10,
			20
		),
		update = function(_self, _dt)
			if self.transition.playing then
				_self.newlinetimer = _self.newlinetimer + _dt
				if _self.newlinetimer > _self.newlinethreshold then
					_self.text = _self.text .. "\n".._self.filelog:read("*l")
					_self.newlinenumber = _self.newlinenumber + 1
					_self.newlinetimer = 0
					if _self.newlinenumber > 10 then 
						_self.pos.y = _self.pos.y - 18
					end
				end
			end
		end
	}
	self.transition.tweens = {}
	self.transition.tweens.label = libs.tween.new(5, self.transition.label, {newlinethreshold = 0.02, alpha=0}, 'inCubic')
	self.transition.tweens.background = libs.tween.new(5, self.transition.background, {alpha=0}, "inCubic")
	self.transition.update = function(self, dt)
		for _key, _tween in pairs(self.tweens) do _tween:update(dt) end
		self.label:update(dt)
	end
	self.transition.draw = function(self)
		if self.playing then
			if not self.stopcurrent then 
				self.stopcurrent = true
				self.background.alpha = 1
				self.label.alpha = 1
				self.label.text = "Loading"
			end
			graphics.drawrect(0, 0, graphics.screen_width, graphics.screen_height, rl.Fade(self.background.color, self.background.alpha))
			graphics.drawtextex(self.label.font, self.label.text, self.label.pos, self.label.size, self.label.spacing, rl.Fade(graphics.colors.white, self.label.alpha))
		end
	end
end

function smgr:changeScene(_scene)
	-- error handling
	assert(type(_scene) == 'string' or type(_scene) == 'number',
	'[Scene Manager] -> Error: invalid scene type ( '..type(_scene) .. " )")

	-- scene changing
	if self.currentscene then 
		self.currentscene:unload() 
		print("[Scene Manager] -> Unload " .. self.currentscene.name .. " Scene.")
	end
	self.currentscene = self.scenes[_scene]
	print("[Scene Manager] -> load " .. self.currentscene.name .. " Scene.")
	self.currentscene:load()
end

function smgr:setCameraPosition(_x, _y, _ax, _ay)
	self.camera.target.x = _x + graphics.virtual_width / 2 + _ax or 0
	self.camera.target.y = _y  + graphics.virtual_height / 2 + _ay or 0
end


function smgr:update(dt)
	if self.currentscene and not self.transition.stopcurrent then
		self.currentscene:update(dt)
	end
	self.transition:update(dt)
end

function smgr:draw()
	if self.currentscene and not self.transition.stopcurrent then
		self.currentscene:draw()
	end
	self.transition:draw()
end

function smgr:unload()
	self.currentscene:unload()
end

return smgr
