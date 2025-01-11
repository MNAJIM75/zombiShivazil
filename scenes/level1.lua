local sc = types.scene:extend("Level 1")
local player = nil

function sc:new()
	sc.super.new(self, "Level 1")
	self.texture = {}
	self.texture.grass = res:getsprite('land', 'grass')
	self.grassstart = 1100
end

function sc:load()
	if nil == player then 
		player = heros.sohib()
		self:addEntity(player)
	end
	self.super.load(self)

end

function sc:update(_dt)
	sc.super.update(self, _dt)
end

function sc:draw()
	for _i=-self.grassstart, self.grassstart, 16 do
		for _j=-self.grassstart, self.grassstart, 16 do
			rl.DrawTexture(self.texture.grass, _i, _j, graphics.gettint(_i, _j))
		end
	end
	sc.super.draw(self)
	DrawText("Level 1", 0, 0, 12, rl.GREEN)
end

function sc:unload()
	self.super.unload(self)
end

return sc()
