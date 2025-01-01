local circle = libs.classic:extend()

function circle:new(_x, _y, _vx, _vy, _ax, _ay, _radius, _id)
	self.position = libs.vector(_x, _y)
	self.velocity = libs.vector(_vx, _vy)
	self.acceleration = libs.vector(_ax, _ay)
	self.radius = _radius
	self.id = _id
	self.color = graphics.colors['green']

	self.drag = 0.9
	self.velocitymin = 10
	self.mass = self.radius * 10

	self.static = false
	self.nobody = false
	self.skiploop = false
end

function circle:draw()
	graphics.drawcircle(self.position.x ,self.position.y, self.radius, self.color, true)
end

function circle:setmass(_mass) self.mass = _mass end

function circle:update(_dt)
	self.acceleration.x = -self.velocity.x * self.drag
	self.acceleration.y = -self.velocity.y * self.drag
	self.velocity = self.velocity + self.acceleration * _dt
	self.position = self.position + self.velocity * _dt

	if self.velocity:magSq() < self.velocitymin then self.velocity:set(0, 0) end
	if self['afterphyupdate'] then self['afterphyupdate'](self, _dt) end
end

return circle