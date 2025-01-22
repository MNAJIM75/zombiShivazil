-- Before code execution
collectgarbage("collect")
local memoryBefore = collectgarbage("count")
print("Memory usage before: " .. memoryBefore .. " KB")

-- Your code here


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

assert(config.graphics.enable, "[Game] Error: Faild to Intialize Graphics.")
assert(config.audio.enable, "[Game] Error: Faild to Intialize Audio.")
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
if config.graphics.window.fullscreen then
	if not graphics.isfullscreen() then
		graphics.togglefullscreen()
	end
end

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
camera:follow(0, 0)

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

local dt = 0
while graphics.windowopen() and gamerun do
	dt = graphics.deltatime()
	input:update(dt)
	smgr:update(dt)
	world:update(dt)
	audio:update(dt)
	camera:update(dt)
	

	graphics.begindrawing()
		graphics.clearbackground(graphics.colors.background)
		--camera:attach()
		smgr:draw()
		--world:draw()
		--camera:detach()
		--camera:draw()
		rl.DrawFPS(10,10)
	graphics.enddrawing()
end

smgr:unload()
audio:unload()
res:unload()
graphics:unload()

audio.closeaudio()
graphics.closewindow()



-- After code execution
collectgarbage("collect")
local memoryAfter = collectgarbage("count")
print("Memory usage after: " .. memoryAfter .. " KB")

-- Calculate memory difference
local memoryLeak = memoryAfter - memoryBefore
print("Memory leak: " .. memoryLeak .. " KB")
