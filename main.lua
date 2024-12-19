setmetatable(_G, {__index = rl})
libs = require'libs'
graphics = require'utls.graphics'
config = require'utls.config'
types = require"types"
res = require"res"
input = require'utls.input'
entities = require'entities'
heros = require'heros'
smgr = require'utls.scene_manager'


graphics.initwindow(
	config.graphics.window.width,
	config.graphics.window.height,
	config.graphics.window.title
)
res:load()
input:load()
smgr:load()
while graphics.windowopen() do
	input:update()
	smgr:update(GetFrameTime())
	graphics.begindrawing()
		graphics.clearbackground(graphics.colors.background)
		smgr:draw()
	graphics.enddrawing()
end

smgr:unload()
res:unload()
graphics.closewindow()
