local bullet = types.entity:extend()

function bullet:new(_x, _y, _direction, _angle)
	bullet.super.new(self, _x, _y, "bullet_entity")
	self:settype("bullet")
	self.radius = 5
	self.direction = _direction
	self.headangle = _angle
	self.velocity = self.direction * const.bullet_maxspeed

	-- afterlife
	self.timer = 0
	self.startcount = false

	-- hit and damage system
	self.damage = 100 * math.random()
	self.dead = false
	self.startcount = true

	-- animator and bullet aniamtions sprites
	local _sprite = res:getsprite("vfx", "bullet")
	local _swidth, _sheight = 16, 16
	local _animations = {
		default = types.animator.newanimation(
			336, 339
		)
	}

	self.animator = types.animator(_sprite, _swidth, _sheight, _animations, "default")
	self.animator:setloop(true)
	self.animator:setrotation(self.headangle)
	smgr.currentscene:addentity(self) 

end

function bullet:afterphyupdate(_dt)
	if self.startcount then
		self.timer = self.timer + _dt
		if self.timer > const.bullet_maxlife and not self.dead then
			smgr.currentscene:removeentity(self)
			self.dead = true
		end
	end
	self.animator:setposition(
		self.position.x,
		self.position.y
	)
	self.animator:update(_dt)
end

function bullet:collide()
	self.startcount = true
end

function bullet:draw()
	self.animator:draw()
end

return bullet