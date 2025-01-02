local audio = {
	prefix = {
		'sfx'
	},
	sounds = {
		shot = {},
		hit = {},
		expolosion = {},
		ss = {}
	},
	alias = {
		shot = {},
		hit = {},
		expolosion = {},
		ss = {}
	}
}

function audio:load()
	-- loading the sounds from the resources utls
	for _resname, _resobject in pairs(res) do
		if string.find(_resname, self.prefix[1]) then
			for _soundname, _soundtable in pairs(self.sounds) do
				if string.find(_resname, _soundname) then
					table.insert(_soundtable, _resobject)
					print('[Audio] Inserting ..' .. _resname ..' in the ' .. _soundname ..' table.')
				end
			end
		end
	end

	-- creating sound alias for multi use sfx
	
end

function audio:update(_dt)
	--rl.UpdateAudioDevice(_dt)
end

function audio:play(_sfxname)
	assert(self.sounds[_sfxname], "[Audio] Error: No sound was found with the following name " .. _sfxname ..'.')
	print(self.sounds[_sfxname][1])
	self.playsound(self.sounds[_sfxname][1])
end

function audio:unload()
	self.closeaudiodevice()
end
setmetatable(audio, {__index = require'utls.audio.binding' })
return audio