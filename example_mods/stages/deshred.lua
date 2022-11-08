function onCreate()
	-- background shit
	makeLuaSprite('deshred bg', 'deshred bg', -600, -300);
	scaleObject('deshred bg', 1.1, 1.1);
	
	makeLuaSprite('deshred curtains', 'deshred curtains', -600, -300);
	scaleObject('deshred curtains', 1.1, 1.1);


	addLuaSprite('deshred bg', false);
	addLuaSprite('deshred curtains', false);
	
	close(true); --For performance reasons, close this script once the stage is fully loaded, as this script won't be used anymore after loading the stage
end