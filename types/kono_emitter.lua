local ps = libs.classic:extend()
local rnd = GetRandomValue

function ps:new(_amount, _colorrange)
	self.meshs = {} -- particels list
	self.emitlimit = _amount -- how much amount of particles initialized each emit call
	self.colorrange = _colorrange or {RED, ORANGE, WHITE}-- list of colors
	self.offset = 3
	self.vel = 20
	self.acc = 9.81 * 2
	self.radius = 10
end

function ps:emit(_x, _y)
	for _i = 1, self.emitlimit do
		_x = _x + rnd(-1, 1) 
		_y = _y + rnd(-1, 1)
		--local _vx, _vy = rnd(-30, 30), rnd(-80, -20)
		--local _ax, _ay = 0, 9.81*10
		local _vx, _vy = rnd(-self.vel, self.vel), rnd(-self.vel, self.vel)
		local _ax, _ay = rnd(-self.acc, self.acc), rnd(-self.acc, self.acc)
		local _r = rnd(self.radius/2, self.radius)
		local _color = self.colorrange[funcs.limit(#self.colorrange, _i)]
		local _line = rnd(-1, 1) < 0
		table.insert(self.meshs, types.kono_particle(_x, _y, _vx, _vy, _ax, _ay, _r, _color, _line))
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