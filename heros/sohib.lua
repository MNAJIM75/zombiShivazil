local so = entities.player:extend()

function so:new()
	so.super.new(self, entities.player.characters.SOHIB)
end

function so:load()
	
end

function so:update(_dt)
	so.super.update(self, _dt)

end

function so:draw()
	so.super.draw(self)
end

return so