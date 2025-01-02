local bullet = types.entity:extend()

function bullet:new(_x, _y, _direction)
	bullet.super.new(self, _x, _y, "bullet_entity")
	self:settype("bullet")
	self.radius = 5
	self.direction = _direction
	self.velocity = self.direction * const.bullet_maxspeed

	-- afterlife
	self.timer = 0
	self.startcount = false

	-- hit and damage system
	self.damage = 10 * math.random()
end

function bullet:afterphyupdate(_dt)
	if self.startcount then
		self.timer = self.timer + _dt
		if self.timer > const.bullet_maxlife and not self.dead then
			self.dead = true
		end
	end
end

function bullet:collide()
	self.startcount = true
end

return bullet