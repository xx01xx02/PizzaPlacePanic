function onCreate()
	makeLuaSprite('ground','GrounDEEZNUTS', -90, -195)
	scaleObject('ground', 1.3, 1.3);
	addLuaSprite('ground', false)
	setScrollFactor('ground', 1, 1)
	updateHitbox('ground')

	makeLuaSprite('walls', 'NOTground', -90, -195)
	scaleObject('walls', 1.3, 1.3);
	addLuaSprite('walls', false)
	setScrollFactor('walls', 1, 1)
	updateHitbox('walls')

	makeAnimatedLuaSprite('theguys', 'Amongus_squad')
	scaleObject('theguys', 1.3, 1.3);
	addAnimationByPrefix('theguys', 'idle', 'Amongus squad', 24, false)
	addLuaSprite('theguys', false)
	updateHitbox('theguys')
end

function onBeatHit()
	-- i know this is deprecated, but for some fucking reason the sprites change position with playAnim altough they stay in place with objectPlayAnimation
	-- if youre bothered by this, i dont care.
	if curBeat % 2 == 0 then
		objectPlayAnimation('theguys', 'idle', false)
	end
end

function onCountdownTick(counter)
	-- counter = 0 -> "Three"
	-- counter = 1 -> "Two"
	-- counter = 2 -> "One"
	-- counter = 3 -> "Go!"
	-- counter = 4 -> Nothing happens lol, tho it is triggered at the same time as onSongStart i think
	if counter % 2 == 0 then
		objectPlayAnimation('theguys', 'idle', false)
	end
end