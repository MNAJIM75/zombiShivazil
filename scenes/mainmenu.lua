local sc = types.scene:extend("Main Menu")
local function button(_x, _y, _text, _onclick) -- center points
	return {
		bound = graphics.objects.rectangle(
			_x - const.ui_button_width / 2,
			_y - const.ui_button_height / 2,
			const.ui_button_width,
			const.ui_button_height
		),
		text = _text,
		onclick = _onclick or nil,
		draw = function(self)
			if rl.GuiButton(self.bound, self.text) then
				if self.onclick then
					self:onclick() 
				end
			end
		end
	}
end

function sc:new()
	sc.super.new(self, "Main Menu")
	
	-- Game Title
	self.gametitle = {}
	self.gametitle.text = "Zombi Shirvaizil"
	self.gametitle.size = 72
	self.gametitle.pos = graphics.objects.vector(
		(graphics.screen_height - self.gametitle.size) / 2,
		(graphics.screen_width - rl.MeasureText(self.gametitle.text, self.gametitle.size)) / 2
	)
	self.gametitle.font = res:getfont('title')
	self.gametitle.spacing = 5
	self.gametitle.color = graphics.colors.white
	self.gametitle.alpha = 0

	self.tween = {
		gametitle = libs.tween.new(5, self.gametitle, {alpha = 1, })
	}

	self.fontdefault = res:getfont('default')

	self.pressany = {}
	self.pressany.size = 32
	self.pressany.text = "press any button"
	self.pressany.pos = graphics.objects.vector(
		(graphics.screen_height - self.pressany.size) / 2,
		self.gametitle.pos.y + self.pressany.size*2
	)
	self.pressany.font = res:getfont("pressbutton")
	self.pressany.spacing = 20
	self.pressany.color = graphics.colors.white
	

	-- press any button
	self.pressany.angle = 0
	--[[
	self:addentity(button(graphics.screen_width/2, graphics.screen_height/2, "Gundam is awesome", function(_self)
		print("Gundam")
		smgr:changeScene("level1")
	end))
	]]

	eventsystem:subscripe("buttonreleased", self)

end

function sc:load()
	self.super.load(self)
end

function sc:update(_dt)
	sc.super.update(self, _dt)
	for _key, _tween in pairs(self.tween) do
		_tween:update(_dt)
	end
	if self.gametitle.alpha < 1 then return end
	self.pressany.angle = self.pressany.angle + _dt
	if self.pressany.angle > math.pi then 
		self.pressany.angle = self.pressany.angle - math.pi
	end
end

function sc:buttonreleased(_button)
	print("Gundam")
	smgr:changeScene("level1")
end

function sc:draw()
	sc.super.draw(self)
	graphics.drawtextex(self.gametitle.font, self.gametitle.text, self.gametitle.pos, self.gametitle.size, self.gametitle.spacing, rl.Fade(self.gametitle.color, self.gametitle.alpha))
	if self.gametitle.alpha < 1 then return end
	graphics.drawtextex(self.pressany.font, self.pressany.text, self.pressany.pos, self.pressany.size, self.pressany.spacing, rl.Fade(self.pressany.color, math.sin(self.pressany.angle)))	

end

function sc:unload()
end

return sc()
