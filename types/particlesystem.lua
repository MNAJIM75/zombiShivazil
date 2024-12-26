local ps = libs.classic:extend()

function ps:new(_spritename, _amount)
	self.spritename = _spritename
	self.particlesamount = _amount

	self.resources = {}
	self.resources.sprite = res:getsprite('vfx', _spritename)
	self.resources.origin = graphics.objects.vector(self.resources.sprite.width / 2, self.resources.sprite.height / 2)
	self.resources.rectsource = graphics.objects.rectangle(0, 0, self.resources.sprite.width, self.resources.sprite.height)
	
	self.particles = {}
	for i = 1, self.particlesamount do
		local _angle = (i/self.particlesamount) * 2 * math.pi
		table.insert(self.particles, types.particle(math.cos(_angle) * 32, 0, math.cos(_angle), -32, 0, 9.81 * 2, self.resources.sprite, self.resources.rectsource, self.resources.origin))
	end

	self._restart = false
end

function ps:restart() self._restart = true end

function ps:update(_dt)
	for _i = #self.particles, 1, -1 do
		self.particles[_i]:update(_dt)
		if self._restart then
			self.particles[_i].x = 0
			self.particles[_i].y = 0
			self.particles[_i].vx = 100
			self.particles[_i].vy = 100
		end
	end
	if self._restart then self._restart = false end
end

function ps:draw()
	for _i, _p in ipairs(self.particles) do _p:draw() end
end

return ps