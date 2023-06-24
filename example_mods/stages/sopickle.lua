function onCreate()
	-- background shit
	makeLuaSprite('sopickle', 'sopickle', -500, -300);
	setLuaSpriteScrollFactor('sans', 0.9, 0.9);
	


	-- sprites that only load if Low Quality is turned off
	if not lowQuality then
		makeLuaSprite('stagelight_lft', 'stag_light', -125, -100);
		setLuaSpriteScrollFactor('stageligt_left', 0.9, 0.9);
		scaleObject('stagelight_left', 1.1, 1.1);
		
		makeLuaSprite('stageliht_right', 'stge_light', 1225, -100);
		setLuaSpriteScrollFactor('stgelight_right', 0.9, 0.9);
		scaleObject('stagelght_right', 1.1, 1.1);
		setPropertyLuaSprite('staelight_right', 'flipX', true); --mirror sprite horizontally

		makeLuaSprite('stagecurtans', 'stagurtains', -500, -300);
		setLuaSpriteScrollFactor('stagecrtains', 1.3, 1.3);
		scaleObject('stagecurtains', 0.9, 0.9);
	end

	addLuaSprite('sopickle', false);
	addLuaSprite('stagefront', false);
	addLuaSprite('stagelight_left', false);
	addLuaSprite('stagelight_right', false);
	addLuaSprite('stagecurtains', false);

	addWavyShader("sopickle")

	close(true); --For performance reasons, close this script once the stage is fully loaded, as this script won't be used anymore after loading the stage
end