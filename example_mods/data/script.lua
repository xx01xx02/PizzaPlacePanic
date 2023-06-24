function onCreate()
	triggerEvent('Apply Sustain Patch', '', '');
	triggerEvent('Character Camera Zoom', 'dad', '0.5');
	triggerEvent('Character Camera Zoom', 'bf', '0.6');
	triggerEvent('NPS Camera Zoom', 'on', 'hit=0.11|miss=0.2|decay=1.0');
	triggerEvent('Camera Anchor', 'dad', '450,420');
	triggerEvent('Camera Anchor', 'bf', '750,480');
	triggerEvent('Camera Sway', '20', '');
	triggerEvent('Load Song Tag', 'name', 'edit');
	--debugPrint(string.sub(debug.getinfo(1).source, 2));
	--debugPrint(scriptName);
	--debugPrint(scriptName:sub(1, scriptName:match('^.*()/')));
end

function onBeatHit()
	if (curBeat == 352) then
		triggerEvent('Camera Anchor', 'dad', '450,460');
		triggerEvent('Camera Anchor', 'bf', '750,520');
	elseif (curBeat == 416) then
		triggerEvent('Camera Anchor', 'dad', '450,420');
		triggerEvent('Camera Anchor', 'bf', '750,480');
	end
end

function onStepHit()
	if curStep == 1 then
		triggerEvent('Show Song Tag', '', '');
	end
end