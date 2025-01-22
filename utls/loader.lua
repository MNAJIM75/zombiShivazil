local loader = {}

loader.loadimage = rl.LoadImage
loader.unloadimage = rl.UnloadImage
loader.unloadsprite = rl.UnloadTexture
loader.loadwave = rl.LoadWave
loader.unloadwave = rl.UnloadWave

loader.nilint = rl.new("int*")
loader.loadfont = function(_path, _size)
	return rl.LoadFontEx(_path, _size or 300, loader.nilint , 0)
end
loader.unloadfont = rl.UnloadFont

loader.loadsprite = function (_arg)
	if "string" == type(_arg) then
		return rl.LoadTexture(_arg)
	--elseif string.find(tostring(_arg), 'image') then
	else
		return rl.LoadTextureFromImage(_arg)
	end
end

return loader