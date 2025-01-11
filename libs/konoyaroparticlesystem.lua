local ps = {}
ps.rnd = GetRandomValue

ps.particle = function (_x, _y, _vx, _vy, _ax, _ay, _r, _color, _line, _lifetime)
	local p = {}
	p.x = _x;	p.y = _y
	p.vx = _vx;	p.vy = _vy
	p.ax = _ax;	p.ay = _ay
	p.color = _color
	p.alpha = 1
	p.r = _r
	p.line = _line
	p.lifetime = _lifetime or 1

	function p:update(_dt, _reducevel)
		self.vx = self.vx + self.ax * _dt
		self.vy = self.vy + self.ay * _dt

		self.x = self.x + self.vx * _dt
		self.y = self.y + self.vy * _dt
		if _reducevel then
			self.vx = self.vx - self.vx *0.009
			self.vy = self.vy - self.vy*0.009
		end
		self.alpha = self.alpha - _dt/self.lifetime
	end

	function p:isdead() return self.alpha <= 0 end

	function p:draw()
		if not self.line then
			DrawCircle(self.x, self.y, self.r, Fade(self.color, self.alpha))
		else DrawCircleLines(self.x, self.y, self.r, Fade(self.color, self.alpha))
		end
	end
	return p
end
function ps:init(_amount, _colorrange, _reducevel)
	self.meshs = {} -- particels list
	self.emitlimit = _amount -- how much amount of particles initialized each emit call
	self.colorrange = _colorrange or {RED, ORANGE, WHITE}-- list of colors
	self.reducevel = _reducevel
	self.offset = 3
	self.vel = 5000
	self.acc = 300
	self.radius = 10
end

function ps:emit(_x, _y)
	for _i = 1, self.emitlimit do
		_x = _x + self.rnd(-1, 1) 
		_y = _y + self.rnd(-1, 1)
		--local _vx, _vy = self.rnd(-30, 30), self.rnd(-80, -20)
		--local _ax, _ay = 0, 9.81*10
		local _vx, _vy = self.rnd(-self.vel, self.vel), self.rnd(-self.vel, self.vel)
		local _ax, _ay = self.rnd(-self.acc, self.acc), self.rnd(-self.acc, self.acc)
		local _r = self.rnd(self.radius/2, self.radius)
		local _color = self.colorrange[funcs.limit(#self.colorrange, _i)]
		local _line = self.rnd(-1, 1) < 0
		table.insert(self.meshs, self.particle(_x, _y, _vx, _vy, _ax, _ay, _r, _color, _line))
	end
end

function ps:update(_dt)
	for _i = #self.meshs, 1, -1 do
		self.meshs[_i]:update(_dt, self.reducevel)
		if self.meshs[_i]:isdead() then table.remove(self.meshs, _i) end
	end
end

function ps:draw()
	for _i = #self.meshs, 1, -1 do
		self.meshs[_i]:draw()
	end
end

return ps