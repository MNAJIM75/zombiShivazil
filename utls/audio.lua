local audio = {
	prefix = {
		'sfx'
	},
	sounds = {
		shot = {},
		hit = {},
		expolosion = {},
		ss = {}
	}
}

function audio:load()
	-- TODO: change the functions to universal onces
	rl.InitAudioDevice()
	--rl.SetMasterVolume(1)
	for _resname, _resobject in pairs(res) do
		if string.find(_resname, self.prefix[1]) then
			for _soundname, _soundtable in pairs(self.sounds) do
				if string.find(_resname, _soundname) then
					table.insert(_soundtable, _resobject)
				end
			end
		end
	end
end

function audio:update(_dt)
	--rl.UpdateAudioDevice(_dt)
end

function audio:play(_sfxname)
	assert(self.sounds[_sfxname], "[Audio] Error: No sound was found with the following name " .. _sfxname ..'.')
	print(self.sounds[_sfxname][1])
	rl.PlaySound(self.sounds[_sfxname][1])
end

function audio:unload()
	rl.CloseAudioDevice()
end

return audio