function onCreate()
	--to make my life easier
	fuckx = -320;
	fucky = -250;

	makeLuaSprite('sky','ppOutsideNew1', fuckx, fucky)
	addLuaSprite('sky',false)
	setScrollFactor('sky', 1, 1)
	--scaleObject('sky', 2.1, 2.1);

	makeLuaSprite('place','ppOutsideNew2', fuckx, fucky)
	addLuaSprite('place',false)
	setScrollFactor('place', 1, 1)
	--scaleObject('place', 2.1, 2.1);

	makeLuaSprite('crowd','ppOutsideNew4', fuckx+170, fucky+200)
	addLuaSprite('crowd',true)
	setScrollFactor('crowd', 0.9, 0.9)
	scaleObject('crowd', 0.9, 0.9);

	makeLuaSprite('light lmaoooo','ppOutsideNew3', fuckx, fucky)
	addLuaSprite('light lmaoooo',true)
	setScrollFactor('light lmaoooo', 1, 1)
	--scaleObject('light lmaoooo', 2.1, 2.1);
end

function onBeatHit()
	-- triggered 4 times per section
	if curBeat % 2 == 0 then
		crowdBounce()
	end
end

function onCountdownTick(counter)
	-- counter = 0 -> "Three"
	-- counter = 1 -> "Two"
	-- counter = 2 -> "One"
	-- counter = 3 -> "Go!"
	-- counter = 4 -> Nothing happens lol, tho it is triggered at the same time as onSongStart i think
	if counter % 2 == 0 then
		crowdBounce()
	end
end

function crowdBounce()
	setProperty('crowd.y', 0)
	doTweenY('crodisbumpy', 'crowd', fucky+200, 0.35, 'circInOut')
end