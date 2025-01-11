local quadtree = libs.classic:extend()
local crcollision = rl.CheckCollisionCircleRec
local rrcollision = rl.CheckCollisionRecs
function quadtree:new(_x, _y, _width, _height)
	self.boundary = graphics.objects.rectangle(_x, _y, _width, _height)
	self.length = 0
	self.objects = {} -- list of items
	
	self.divided = false
	self.nw = nil 
	self.ne = nil 
	self.sw = nil 
	self.se = nil 
end

-- we assume that the _object has a vector called position with x and y.
function quadtree:insert(_object)
	local _obx, _oby = _object.position.x, _object.position.y
	local _objectposition = graphics.objects.vector(x, y)
	local _radius = _object.radius
	if not crcollision(_objectposition, _radius, self.boundary) then return false end
	if self.length < consts.quadtree_capacity then
		table.insert(self.objects, _object)
		self.length = self.length + 1
		return true
	else
		if not self.divided then self:subdivision() end
		return 
			self.nw:insert(_object) or
			self.ne:insert(_object) or
			self.sw:insert(_object) or
			self.se:insert(_object)
	end
end

function quadtree:subdivision()
	local _x, _y = self.boundary.x, self.boundary.y
	local _nw, _nh = self.boundary.width / 2, self.boundary.height / 2
	
	self.nw = types.quadtree(_x, _y, _nw, _h)
	self.ne = types.quadtree(_x + _nw, _y, _nw, _nh)
	self.sw = types.quadtree(_x, _y + _nh, _nw, _nh)
	self.sw = types.quadtree(_x + _nw, _y + _nh, _nw, _nh)
	
	self.divided = true
end

function quadtree:draw()
	graphics.drawrect(self.boundary.x, self.boundary.y, self.boundary.width, self.boundary.height, graphics.colors.green)
	if self.divided then
		self.nw:draw(); self.ne:draw()
		self.sw:draw(); self.se:draw()
	end
end

function quadtree:getobjectsinlist(_rect, _list)
	if not rrcollision(self.boundary, _rect) then return end
	if self.divided then
		self.nw:getobjects(_rect, _list); self.ne:getobjects(_rect, _list)
		self.sw:getobjects(_rect, _list); self.se:getobjects(_rect, _list)
	end
	for _i, _obj in pairs(self.objects) do
		if crcollision(graphics.objects.vector(_obj.position.x, _obj.position.y), _obj.radius, _rect) then
			table.insert(_list, _obj)
		end
	end
end

function quadtree:getobjects(_rect)
	local _list = {}
	self:getobjectsinlist(_rect, _list)
	return _list
end

return quadtree