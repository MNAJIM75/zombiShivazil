local colors = {}

colors.background = rl.new("Color", 18, 18, 18, 1) 
colors.white = rl.WHITE
colors.green = rl.GREEN
colors.red = rl.RED
colors.black = rl.BLACK
colors.shade = nil

--[[
colors.getshade = function(self, _value)
	if not self.shade then
		self.shade = {}
		for i=1, 10 do
			table.insert(self.shade, rl.new("Color", math.floor((i/10) * 255), math.floor((i/10) * 255), math.floor((i/10) * 255), 255))
			print("[Color] ", self.shade[i].r, self.shade[i].g, self.shade[i].b, self.shade[i].a)
		end
	end
	return self.shade[funcs.clamp(math.floor(_value * 10), 1, #self.shade)]
end
]]

colors.getshade = function(self, _x, _y, _r)
	if not self.shade then
		local _hsw = graphics.screen_width / 2
		local _shadeslevel = const.graphics_shader_level
		self.shade = {}
		for _i = 0, _hsw, _hsw / _shadeslevel do
			local _ratio = _i / _hsw
			local _shader =	{
					shader = rl.new(
						"Color",
						math.floor(_ratio * 255),
						math.floor(_ratio * 255),
						math.floor(_ratio * 255),
						255
					),
					x = _hsw,
					y = graphics.screen_height / 2,
					r = (_hsw) - _i
			}
			table.insert(self.shade, _shader)
			print("[Shade] -> ", _shader.shader.r, _shader.shader.g, _shader.shader.b, _shader.shader.a)
		end
	end
	for _i=#self.shade, 1, -1 do
		local _tint = self.shade[_i]
		if phy.intersection._circles(_tint.x, _tint.y, _tint.r, _x, _y, _r) then return _tint.shader end
	end
	return graphics.colors.black
end
return colors