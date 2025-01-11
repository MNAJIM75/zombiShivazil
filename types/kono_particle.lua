local particle = libs.classic:extend()
particle.behaviors = {
	friction = function (self, _dt, _firction)
		self.vx = self.vx - self.vx * _firction * _dt
		self.vy = self.vy - self.vy * _firction * _dt
	end
}

function particle:new(_x, _y, _vx, _vy, _ax, _ay, _r, _color, _line, _lifetime)
	self.x = _x;	self.y = _y
	self.vx = _vx;	self.vy = _vy
	self.ax = _ax;	self.ay = _ay
	self.r = _r
	self.color = _color
	self.line = _line
	self.lifetime = _lifetime or 1
	self.alpha = 1
end

function particle:move(_dt)
	self.vx = self.vx + self.ax * _dt
	self.vy = self.vy + self.ay * _dt

	self.x = self.x + self.vx * _dt
	self.y = self.y + self.vy * _dt
end

function particle:update(_dt, _behavior)
	self:move(_dt)
	if _behavior then _behavior(self, _dt) end
	self.alpha = self.alpha - _dt/self.lifetime
end

function particle:isdead() return self.alpha <= 0 end

function particle:draw()
	if not self.line then
		DrawCircle(self.x, self.y, self.r, Fade(self.color, self.alpha))
	else DrawCircleLines(self.x, self.y, self.r, Fade(self.color, self.alpha))
	end
end

return particle
