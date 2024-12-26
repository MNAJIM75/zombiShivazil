local bullet = types.entity:extend()

function bullet:new(_x, _y, _aim)
	bullet.super.new(self, _x, _y, "bullet_entity")
	self.aim = _aim
	self.velocity = self.aim * const.bullet_maxspeed
end

function bullet:collide()
	print("collsion bullet")
end

return bullet