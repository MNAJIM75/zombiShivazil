local audio = {
	prefix = {
		'sfx'
	},
	sounds = {
		shot = {},
		hit = {},
		explosion = {},
		ss = {}
	},
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

	self.setmastervolume(0.4)

	-- creating sound alias for multi use sfx
	self.master = require'utls.audio.master'
	self.master:load()
end

function audio:update(_dt)
	self.master:update(_dt)
end

function audio:play(_sfxname)
	assert(self.sounds[_sfxname], "[Audio] Error: No sound was found with the following name " .. _sfxname ..'.')
	self.master:add(self.sounds[_sfxname][1])
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