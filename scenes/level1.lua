local sc = types.scene:extend("Level 1")
local player = nil
local weapon = nil

function sc:new()
	sc.super.new(self, "Level 1")
	self.grass = {	}
	self.grass.increment = 16
	self.grass.start = self.grass.increment * 90
	self.grass.texture = res:getsprite('land', 'grass')
	self.grass.boundx = graphics.screen_width / 2
	self.grass.boundy = graphics.screen_height / 2
end

function sc:load()
	if nil == player then 
		player = heros.sohib()
		self:addentity(player)
	end
	if nil == weapon then
		weapon = entities.weapon(100, 300, "gun1")
		self:addentity(weapon)
	end
	self.super.load(self)

end

function sc:update(_dt)
	sc.super.update(self, _dt)
	camera:follow(herox, heroy)
	psys:update(_dt)
end

function sc:drawground()
	for _i=-self.grass.start, self.grass.start, self.grass.increment do
		if _i > herox - self.grass.boundx and _i < herox + self.grass.boundx then
			for _j=-self.grass.start, self.grass.start, self.grass.increment do
				if _j > heroy - self.grass.boundy and _j < heroy + self.grass.boundy then
					graphics.drawtexture(self.grass.texture, _i, _j, graphics.gettint(_i, _j))
				end
			end
		end
	end
end

function sc:draw()
	camera:attach()
	self:drawground()
	
	sc.super.draw(self)
	psys:draw()
	camera:detach()
	camera:draw()
	DrawText("Level 1", 0, 0, 12, rl.GREEN)
end

function sc:unload()
	self.super.unload(self)
end

return sc()
