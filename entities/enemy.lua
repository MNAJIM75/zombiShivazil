local enemy = types.entity:extend()

function enemy:new(_posx, _posy, _index)
	enemy.super.new(self, _posx, _posy)
	self.index = _index
end

return enemy