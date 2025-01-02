local bind = {}
function bind.initaudio()
	--libs.sound.init()
	rl.InitAudioDevice()
end

function bind.closeaudio()
	rl.CloseAudioDevice()
end

function bind.playsound(_sound)
	rl.PlaySound(_sound)
end

return bind