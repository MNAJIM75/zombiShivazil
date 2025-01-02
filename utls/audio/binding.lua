local bind = {}
function bind.initaudio() rl.InitAudioDevice() end
function bind.closeaudio()	rl.CloseAudioDevice() end
function bind.playsound(_sound)	rl.PlaySound(_sound) end
function bind.loadsoundfromwave(_sound) return rl.LoadSoundFromWave(_sound) end -- this aims to not create so many sound data
function bind.issoundplaying(_sound) return rl.IsSoundPlaying(_sound) end
function bind.unloadsound(_sound) rl.UnloadSound(_sound) end
function bind.setmastervolume(_value) rl.SetMasterVolume(_value > 1 and 1 or _value < 0 and 0 or _value) end

return bind