setmetatable(_G, {__index = rl})
rad2deg = 180/math.pi

libs		=	require'libs'
phy			=	require'utls.jxphy'
graphics	=	require'utls.graphics'
loader		=	require'utls.loader'
config		=	require'utls.config'
types		=	require"types"
const		=	require'utls.constants'
eventsystem =	require'utls.eventsystem'
res			=	require"res"
audio		=	require'utls.audio'
input		=	require'utls.input'
entities	=	require'entities'
heros		=	require'heros'
smgr		=	require'utls.scene_manager'
funcs		=	require'utls.funcs'


gamerun = true
graphics.initwindow(
	config.graphics.window.width,
	config.graphics.window.height,
	config.graphics.window.title
)
audio.initaudio()

graphics:load(
	config.graphics.window.vwidth,
	config.graphics.window.vheight
)
world = phy.world(0, 0)
res:load()
audio:load()
input:load()
smgr:load()

local gridRect = graphics.objects.rectangle(0, 0, 1920, 1080)

--particlesystem = types.particlesystem('blood', 20)
camera = libs.camera()
camera.scale = 1.5
camera:setFollowStyle("TOPDOWN_TIGHT")

-- konoyaro
psys = types.kono_emitter(5, {WHITE, RAYWHITE, LIGHTGRAY})

local _90drgree = math.pi / 2
local _mapradius = 1000
for i = 1, 4 do
	local _px = math.cos(_90drgree * i) * _mapradius *2 
	local _py = math.sin(_90drgree * i) * _mapradius *2
	local _wall = types.entity(_px, _py, "wall")
	_wall.radius = _mapradius
	_wall.static = true
	world:addbody(_wall)
end
local body = types.entity(100, 100, "dummy")
body.static = true
world:addbody(body)

local gun = entities.weapon(50, 50, "gun1")

local enemy = entities.enemy(100, 200, "tader", 0)
local dt = 0
while graphics.windowopen() and gamerun do
	dt = graphics.deltatime()
	input:update(dt)
	smgr:update(dt)
	gun:update(dt)
	--enemy:update(dt)
	world:update(dt)
	audio:update(dt)
	psys:update(dt)
	camera:update(dt)
	camera:follow(herox, heroy)
	--particlesystem:update(graphics.deltatime())
	

	graphics.begindrawing()
		--graphics:startrender()
			graphics.clearbackground(graphics.colors.background)
			camera:attach()
			smgr:draw()
			psys:draw()
			--body:draw()
			enemy:draw()
			gun:draw()
			--particlesystem:draw()
			world:draw()
			camera:detach()
			camera:draw()
		--graphics:finishrender()
		--graphics:drawcanvas()
		rl.DrawFPS(10,10)
	graphics.enddrawing()
end

smgr:unload()
audio:unload()
res:unload()
graphics:unload()

audio.closeaudio()
graphics.closewindow()



-- printing all rl
--[[
local _file = io.open('rl.txt', 'a')
io.output(_file)
for k, v in pairs(rl) do io.write(tostring(k) .. " -> " .. tostring(v) .. "\n") end
io.close(_file)
]]