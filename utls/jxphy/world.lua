local world = libs.classic:extend()

function world:new(_gravityx, _gravityy)
	self.gravity = libs.vector(_gravityx, _gravityy)
	self.bodies = {}
end

function world:addbody(_body) table.insert(self.bodies, _body) end
function world:getatindex(_index) return self.bodies[_index] end
function world:getbodyindex(_body) 
	for _i, _b in ipairs(self.bodies) do
		if _b.id == _body.id then return _i end
	end
	assert(false, "[Physics] Error: No matching id in the bodies in this world id = ".._body.id..'.')
end
function world:removeatindex(_index) table.remove(self.bodies, _index) end
function world:removebody(_body) table.remove(self.bodies, self:getbodyindex(_body)) end

function world:update(_dt)
	for _i, _b in pairs(self.bodies) do phy.circle.update(_b, _dt) end
	for i = 1, #self.bodies - 1 do
		local _ca = self:getatindex(i) 
		if not _ca.skiploop then
			for j = i + 1, #self.bodies do
				local _cb = self:getatindex(j)
				if not _cb.skiploop then
					if phy.intersection.circles(_ca, _cb) then 
						-- trigger functions
						-- resolve collision
						if not _ca.nobody and not _cb.nobody then 
							local _distance = self:getatindex(i).position:dist(self:getatindex(j).position)
							phy.resolve.circles(self:getatindex(i), self:getatindex(j), _distance)
							phy.resolve.dynamic(self:getatindex(i), self:getatindex(j), _distance)
						end
						world.trigger(_ca, "collide", _cb)
						world.trigger(_cb, 'collide', _ca)
					end
				end
			end
		end
	end
end

function world:draw()
	for i, _b in ipairs(self.bodies) do
		phy.circle.draw(_b)
		--print("draw -> " .. _b.id)
	end
end

function world.trigger(_b, _trigger, ...)
	if _b[_trigger] ~= nil then
		_b[_trigger](_b, ...)
	end
end

return world