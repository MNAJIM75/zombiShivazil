setmetatable(_G, {__index = rl})
libs = require'libs'
phy = require'utls.jxphy'
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
graphics:load(
	config.graphics.window.vwidth,
	config.graphics.window.vheight
)
world = phy.world(0, 0)
res:load()
input:load()
smgr:load()

local camera = libs.camera()
camera:setFollowStyle("TOPDOWN_TIGHT")

for i = 1, 10 do world:addbody(phy.circle(i * 21, 0, 0, 0, 0, 0, 10, phy.getid())) end
local body = phy.circle(0, 0, 0, 0, 0, 0, 10, phy.getid())
world:addbody(body)
while graphics.windowopen() do
	input:update()
	smgr:update(graphics.deltatime())
	camera:update(graphics.deltatime())
	camera:follow(herox, heroy) 
	world:update(graphics.deltatime())

	

	graphics.begindrawing()
		--graphics:startrender()
			camera:attach()
			graphics.clearbackground(graphics.colors.white)
			smgr:draw()
			--body:draw()
			world:draw()
			camera:detach()
			camera:draw()
		--graphics:finishrender()
		graphics:drawcanvas()
	graphics.enddrawing()
end

smgr:unload()
res:unload()
graphics:unload()
graphics.closewindow()



-- printing all rl
--[[
local _file = io.open('rl.txt', 'a')
io.output(_file)
for k, v in pairs(rl) do io.write(tostring(k) .. " -> " .. tostring(v) .. "\n") end
io.close(_file)
]]