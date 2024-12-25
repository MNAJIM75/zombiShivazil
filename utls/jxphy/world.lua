local world = libs.classic:extend()

function world:new(_gravityx, _gravityy)
	self.gravity = libs.vector(_gravityx, _gravityy)
	self.bodies = {}
end

function world:addbody(_body) table.insert(self.bodies, _body) end
function world:getatindex(_index) return self.bodies[_index] end
function world:removeatindex(_index) table.remove(self.bodies, _index) end

function world:update(_dt)
	for i = 1, #self.bodies - 1 do
		for j = i + 1, #self.bodies do
			if phy.intersection.circles(self:getatindex(i), self:getatindex(j)) then 
				-- print("intersection ["..i..']:['..j.."]") 
				world.trigger(self:getatindex(i), "collide", self:getatindex(j))
				world.trigger(self:getatindex(j), 'collide', self:getatindex(i))
				phy.resolve.circles(self:getatindex(i), self:getatindex(j))
			end
		end
	end
end

function world:draw()
	for i, _b in ipairs(self.bodies) do
		phy.circle.draw(_b)
	end
end

function world.trigger(_b, _trigger, ...)
	if _b[_trigger] ~= nil then
		_b[_trigger](_b, ...)
	end
end

return world