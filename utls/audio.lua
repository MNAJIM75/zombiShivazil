local audio = {
	prefix = {
		'sfx'
	},
	sounds = {
		shoot = {},
		hit = {},
		death = {},
		grab = {},
		tader = {}
	},
	mixer = {
		shoot = 1,
		hit = 0.1,
		death = 0.3,
		grab = 0.6,
		tader = 1
	}
}

function audio:load()
	-- loading the sounds from the resources utls
	for _resname, _resobject in pairs(res) do
		if string.find(_resname, self.prefix[1]) then
			for _soundkey, _soundtable in pairs(self.sounds) do
				if string.find(_resname, _soundkey) then
					table.insert(_soundtable, _resobject)
					print('[Audio] Inserting ..' .. _resname ..' in the ' .. _soundkey ..' table.')
				end
			end
		end
	end

	self.setmastervolume(0.9)

	-- creating sound alias for multi use sfx
	self.master = require'utls.audio.master'
	self.master:load()
end

function audio:update(_dt)
	self.master:update(_dt)
end

function audio:play(_sfxname, _pan)
	assert(self.sounds[_sfxname], "[Audio] Error: No sound was found with the following name " .. _sfxname ..'.')
	self.master:add(self.sounds[_sfxname][1], function(_sound)
		audio.setsoundvolume(_sound, self.mixer[_sfxname])
		if _pan then audio.setsoundpan(_sound, _pan) end
	end)
end

function audio:unload()
	-- unload sound data
	for _soundname, _soundtable in pairs(self.sounds) do
		for _aliasindex, _aliasdata in pairs(_soundtable) do
			--rl.UnloadWave(_aliasdata)
			--print('[Audio] Destroying alias ..'.. tostring(_aliasindex) .. ' in table '.._soundname..'.')
		end
	end

	self.closeaudio()
end
setmetatable(audio, {__index = require'utls.audio.binding' })
return audio