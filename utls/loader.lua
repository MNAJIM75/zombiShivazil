local loader = {}

loader.loadimage = rl.LoadImage
loader.unloadimage = rl.UnloadImage
loader.unloadsprite = rl.UnloadTexture
loader.loadwave = rl.LoadWave
loader.unloadwave = rl.UnloadWave

loader.loadsprite = function (_arg)
	if "string" == type(_arg) then
		return rl.LoadTexture(_arg)
	--elseif string.find(tostring(_arg), 'image') then
	else
		return rl.LoadTextureFromImage(_arg)
	end
end

return loader