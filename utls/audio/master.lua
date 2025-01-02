local master = {}

function master:load()
	self.toplay = types.queue()
	self.playing = types.queue()
	self.played = types.queue()
end

function master:update()
	if self.toplay:length() > 0 then
		local _sound = self.toplay:pop()
		audio.playsound(_sound)
		self.playing:push(_sound)
		print("[Audio Master] adding to playing.")
	end

	for _i, _v in ipairs(self.playing.list) do
		if not audio.issoundplaying(_v) then
			local _playedsound = _v
			table.remove(self.playing.list, _i)
			self.played:push(_playedsound)
			print("[Audio Master] adding to played.")
		end
	end

	if self.played:length() > 0 then
		audio.unloadsound(self.played:pop())
		print("[Audio Master] removed from the list")
	end
end

function master:add(_wavesource)
	local _sound = audio.loadsoundfromwave(_wavesource)
	self.toplay:push(_sound)
	print("[Audio Master] adding to toplay.")
end

return master