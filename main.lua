setmetatable(_G, {__index = rl})
rad2deg = 180/math.pi

libs = require'libs'
phy = require'utls.jxphy'
graphics = require'utls.graphics'
config = require'utls.config'
types = require"types"
const = require'utls.constants'
eventsystem = require'utls.eventsystem'
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

particlesystem = types.particlesystem('blood', 20)
local camera = libs.camera()
camera.scale = 2
camera:setFollowStyle("TOPDOWN_TIGHT")

--for i = 1, 10 do world:addbody(phy.circle(i * 21, 0, 0, 0, 0, 0, 10, phy.getid())) end
local body = types.entity(100, 100, "dummy")
body.static = true
body.nobody = true
world:addbody(body)

local gun = entities.weapon(50, 50, "gun1")

print(particlesystem)
while graphics.windowopen() do
	input:update()
	smgr:update(graphics.deltatime())
	camera:update(graphics.deltatime())
	camera:follow(herox, heroy) 
	gun:update(graphics.deltatime())
	world:update(graphics.deltatime())
	--particlesystem:update(graphics.deltatime())
	

	graphics.begindrawing()
		--graphics:startrender()
			camera:attach()
			graphics.clearbackground(graphics.colors.white)
			smgr:draw()
			--body:draw()
			gun:draw()
			--particlesystem:draw()
			--world:draw()
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