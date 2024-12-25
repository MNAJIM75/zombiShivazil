local circle = libs.classic:extend()

function circle:new(_x, _y, _vx, _vy, _ax, _ay, _radius, _id)
	self.position = libs.vector(_x, _y)
	self.velocity = libs.vector(_vx, _vy)
	self.acceleration = libs.vector(_ax, _ay)
	self.radius = _radius
	self.id = _id
	self.color = graphics.colors['green']
end

function circle:draw()
	graphics.drawcircle(self.position.x ,self.position.y, self.radius, self.color)
end

return circle