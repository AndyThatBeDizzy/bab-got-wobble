local music_source = nil

music_volume = 1
music_fading = false
local sound_data = {}

function registerSound(sound)
  sound_data[sound] = love.sound.newSoundData("assets/audio/" .. sound .. ".wav")
end

function playSound(sound, volume)
  if sound_data[sound] then
    local source = love.audio.newSource(sound_data[sound], "static")
    source:setVolume(volume or 1)
    source:play()
  end
end

function playMusic(music, volume)
  if music_source ~= nil then
    music_source:stop()
  end

  music_volume = volume or 1

  music_source = love.audio.newSource("assets/audio/" .. music .. ".wav", "stream")
  music_source:setVolume(music_volume)
  music_source:setLooping(true)
  music_source:play()
end

function updateMusic()
  if music_source ~= nil then
    music_source:setVolume(music_volume)
  end
  if music_fading and music_volume > 0 then
    music_volume = math.max(0, music_volume - 0.01)
  end
end

function hasMusic()
  return music_source ~= nil
end