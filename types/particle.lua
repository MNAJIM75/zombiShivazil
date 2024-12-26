local p = libs.classic:extend()

function p:new(_x, _y, _vx, _vy, _ax, _ay, _sprite, _rectsource, _origin)
	self.x = _x
	self.y = _y
	self.vx = _vx
	self.vy = _vy
	self.ax = _ax
	self.ay = _ay
	self.sprite = _sprite
	self.color = graphics.colors.white
	self.cx = rl.GetRandomValue(5, 10) / 10
	self.cy = rl.GetRandomValue(5, 10) / 10
	self.rectdest = graphics.objects.rectangle(self.x, self.y, self.sprite.width, self.sprite.height)
	self.rectsource  = _rectsource 
	self.origin = _origin
	self.angle = 0
	self.dead = false
	self.deadlimit = 0.1
end

function p:update(_dt)
	self.vx = self.vx + self.ax * _dt
	self.vy = self.vy + self.ay * _dt
	self.x = self.x + self.vx * _dt
	self.y = self.y + self.vy * _dt
	--self.vx = self.vx * self.cx
	--self.vy = self.vy * self.cy

	self.rectdest.x = self.x; self.rectdest.y = self.y
	self.angle = math.atan2(self.vy, self.vx)
	self.dead = (self.vx*self.vx) + (self.vy*self.vy) < self.deadlimit
end

function p:draw()
	if self.dead then return end
	graphics.drawsprite(self.sprite, self.rectsource, self.rectdest, self.origin, self.angle, self.color)
end

return p