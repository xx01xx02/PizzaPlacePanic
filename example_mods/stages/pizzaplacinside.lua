function onCreate()
	makeLuaSprite('pizza','pizza_placeinsid', 0, 0)
	addLuaSprite('pizza',false)
	setScrollFactor('pizza', 1, 1)
	scaleObject('pizza', 2.1, 2.1);
	makeLuaSprite('pizza2','ppinsidefor', 70, 1300)
	addLuaSprite('pizza2',true)
	setScrollFactor('pizza2', 0.99, 0.99)
	scaleObject('pizza2', 2.7, 2.7);
	
	makeAnimatedLuaSprite('heaven', 'wegaheaven', 0, 0)
	addAnimationByPrefix('heaven', 'idle', 'wegaheaven', 24, true);
	scaleObject('heaven', 2.1, 2.1);
	addLuaSprite('heaven', false)

	setProperty('heaven.visible', false)
	
	makeLuaSprite('walter','pizza_placeinsid', 0, 0)
	makeGraphic('walter', 4000, 4000, 'ffffff')
	addLuaSprite('walter', false)
	setProperty('walter.visible', false)
end

function onEvent(eventName, value1, value2)
	if eventName == 'PPPEventThing' and value1 == 'gluttony' then
		if value2 == '1' then
			--"Mister max why are some things here crossed out?" Well little timmy, its because it caused lags, so the chars change not in the lua and some of the bgs stay visible, but arent seen because WALTER is over them

			cameraFlash('game', 'ffffff', 1, true)
			--setProperty('pizza.visible', false)
			setProperty('pizza2.visible', false)
			setProperty('walter.visible', true)
			--triggerEvent('Change Character', 'Dad', 'wegablack')
			triggerEvent('Change Character', 'BF', 'glutdesblack')
		else
			-- Random Bullshit! GO!
			cameraFlash('game', 'ffffff', 1, true)
			setProperty('walter.visible', false)
			setProperty('heaven.visible', true)
			--triggerEvent('Change Character', 'Dad', 'wegajuniorMAD')
			triggerEvent('Change Character', 'BF', 'gluttonydes')
		end
	end
end