function onEvent(name, value1, value2)
    if name == 'megalochangesceneeffects' then
	    cameraFlash("game", "fc03f8", value1, false);
        playSound("scenechangeM");
    end
end