function onCreate()
	-- background shit
	makeLuaSprite('stageback', 'fooled', -600, -300);
	setLuaSpriteScrollFactor('fooled', 0.9, 0.9);

	addLuaSprite('stageback', false);
	
	close(true); --For performance reasons, close this script once the stage is fully loaded, as this script won't be used anymore after loading the stage
end