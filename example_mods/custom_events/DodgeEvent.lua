function onCreate()
    --variables
	Dodged = false;
    canDodge = false;
    DodgeTime = 0;
	
    precacheImage('blasterwarn');
	precacheSound('BlasterStart');
	precacheSound('BlasterAlarm');
	precacheSound('BlasterShoot');
	precacheSound('BlasterDodged');
end

function onEvent(name, value1, value2)
    if name == "DodgeEvent" then
    --Get Dodge time
    DodgeTime = (value1);
	
    --Make Dodge Sprite
	makeAnimatedLuaSprite('blasterwarn', 'blasterwarn', 505, 150);
    luaSpriteAddAnimationByPrefix('blasterwarn', 'blasterwarn', 'blasterwarn', 36, true);
	luaSpritePlayAnimation('blasterwarn', 'blasterwarn');
	setObjectCamera('blasterwarn', 'other');
	scaleLuaSprite('blasterwarn', 0.75, 0.75); 
    addLuaSprite('blasterwarn', true); 
	
	--Set values so you can dodge
	playSound('BlasterStart', 0.6);
	playSound('BlasterAlarm', 1, 'alarm');
	canDodge = true;
	runTimer('Died', DodgeTime);
	
	end
end

function onUpdate()
   if canDodge == true and keyJustPressed('space')then
   
   Dodged = true;
   stopSound('alarm');
   playSound('BlasterDodged', 1);
   cameraFlash('game', 'ffffff', '1.5', true);
   --characterPlayAnim('boyfriend', 'dodge', true);
   --setProperty('boyfriend.specialAnim', true);
   removeLuaSprite('blasterwarn');
   canDodge = false;
   
   end
end

function onTimerCompleted(tag, loops, loopsLeft)
   if tag == 'Died' and Dodged == false then
   canDodge = false;
   stopSound('alarm');
   playSound('BlasterShoot', 1);
   cameraFlash('game', 'ffffff', '1.5', true);
   setProperty('health', 0);
   
   elseif tag == 'Died' and Dodged == true then
   Dodged = false;
   
   end
end