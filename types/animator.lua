local animator = libs.classic:extend()
local function rect(_x, _y, _w, _h) return
	new("Rectangle", _x, _y, _w, _h)
end
function animator:new(_sprite, _framewidth, _frameheight, _animations, _defaultanim)
	self.sprite = _sprite

	self.animations = _animations
	self.frame = {
		width = _framewidth,
		height = _frameheight
	}
	self.defaultanimation = _defaultanim
	self.currentanimation = _defaultanim
	self.nextanimation = nil
	self.scale = 1
	self.ratation = 0
	self.tint = rl.WHITE
	
	self.maxcol = self.sprite.width / self.frame.width
	self.maxrow = self.sprite.height / self.frame.height
	self.frameindex = self.animations[_defaultanim].start
	
	self.framebox = rect(0, 0, self.frame.width, self.frame.height)
	self.framedest = rect(0, 0, self.frame.width * self.scale, self.frame.height * self.scale)
	self.framecenter = new("Vector2", self.frame.width / 2, self.frame.height / 2)

	self.timer = 0
	self.loop = false
	self.framerate = 1/18
	self.playanimation = true
end

function animator:setfps(_fps) self.framerate = 1/(_fps>0 and _fps or 1) end
function animator:setloop(_value) self.loop = _value end
function animator:setrotation(_angle) self.rotation = _angle end
function animator:setposition(_x, _y)
	self.framedest.x = _x; self.framedest.y = _y
end
function animator:setscale(_scale) 
	self.scale = _scale
	self.framedest.width = self.frame.width * self.scale
	self.framedest.height = self.frame.height * self.scale
	self.framecenter.x = self.framedest.width / 2
	self.framecenter.y = self.framedest.height / 2
end

function animator:getrotation() return self.rotation end
function animator:getscale() return self.scale end
function animator:update(_dt)
	if self.playanimation then self.timer = self.timer + _dt end
	if self.timer > self.framerate then
		self.frameindex = self.frameindex + 1
		self.timer = 0
	end
	
	if self.frameindex > self.animations[self.currentanimation].finish then
		if self.loop then self:reset()
		else self.frameindex = self.animations[self.currentanimation].finish
		end
		self:checknext()
	end
	
	self.framebox.x = math.floor (self.frameindex % self.maxcol) * self.frame.width
	self.framebox.y = math.floor (self.frameindex / self.maxcol) * self.frame.height
end

function animator:checknext()
	if self.nextanimation then
		self:play(self.nextanimation, true)
		self.nextanimation = nil
	end
end

function animator:draw()
	--DrawTexturePro(Texture2D texture, 
	--	Rectangle source, 
	--	Rectangle dest, 
	--	Vector2 origin, 
	--	float rotation, 
	--	Color tint
	--)
	rl.DrawTexturePro(self.sprite, self.framebox, self.framedest, self.framecenter, self.rotation, self.tint)
	rl.DrawText(tostring(self.frameindex), 10, 10, 32, rl.GREEN)
	rl.DrawText(tostring(self.framebox.x), 10, 50, 32, rl.GREEN)
	rl.DrawText(tostring(self.framebox.y), 10, 90, 32, rl.GREEN)
	rl.DrawText(tostring(self.timer), 10, 90+40, 32, rl.GREEN)
end

function animator:pause() self.playanimation = false end
function animator:resume() self.playanimation = true end
function animator:stop() self:pause(); self:reset() end
function animator:reset() self.frameindex = self.animations[self.currentanimation].start end
function animator:play(_animation, _breakanimation)
	assert(self.animations[_animation], "[Animator] Error: no such animation was found by name " .. _animation..'.')
	if _breakanimation then
		self.currentanimation = _animation
		self:reset()
	else self.nextanimation = _animation
	end
end


function animator.newanimation(_startindex, _finishindex)
	return {
		start = _startindex,
		finish = _finishindex
	}
end

return animator
