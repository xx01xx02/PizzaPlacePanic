function onCreate()
	makeLuaSprite('pizza','pizza_place', 0, 0)
	addLuaSprite('pizza',false)
	setLuaSpriteScrollFactor('pizza', 1, 1)
	scaleObject('pizza', 2.1, 2.1);
	close(true)
end