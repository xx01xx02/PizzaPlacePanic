package;

#if desktop
import Discord.DiscordClient;
#end
import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.FlxCamera;
import flixel.addons.transition.FlxTransitionableState;
import flixel.effects.FlxFlicker;
import flixel.addons.display.FlxBackdrop;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.text.FlxText;
import flixel.math.FlxMath;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import lime.app.Application;
import Achievements;
import editors.MasterEditorMenu;
import flixel.input.keyboard.FlxKey;

using StringTools;

class MainMenuState extends MusicBeatState
{
	public static var psychEngineVersion:String = '0.6.2'; //This is also used for Discord RPC
	public static var curSelected:Int = 0;

	var menuItems:FlxTypedGroup<FlxSprite>;
	private var camGame:FlxCamera;
	private var camAchievement:FlxCamera;
	
	var optionShit:Array<String> = [
		'start',
		'credits',
		'options',
		'extras'
	];

	var debugKeys:Array<FlxKey>;

	override function create()
	{
		#if MODS_ALLOWED
		Paths.pushGlobalMods();
		#end
		WeekData.loadTheFirstEnabledMod();

		#if desktop
		// Updating Discord Rich Presence
		DiscordClient.changePresence("In the Menus", null);
		#end
		debugKeys = ClientPrefs.copyKey(ClientPrefs.keyBinds.get('debug_1'));

		camAchievement = new FlxCamera();
		camAchievement.bgColor.alpha = 0;

		FlxG.cameras.add(camAchievement);

		transIn = FlxTransitionableState.defaultTransIn;
		transOut = FlxTransitionableState.defaultTransOut;

		persistentUpdate = persistentDraw = true;

		switch(FlxG.save.data.currentMenuTheme)
		{
			case "Scott":
				var back:FlxBackdrop = new FlxBackdrop(Paths.image('mainmenu/scott/scottbackdrop'));
				add(back);
				back.velocity.set(75, 100);

				var bg:FlxSprite = new FlxSprite(-80).loadGraphic(Paths.image('mainmenu/scott/scottmenulogo'));
				bg.setGraphicSize(Std.int(bg.width * 1));
				bg.updateHitbox();
				bg.screenCenter();
				bg.antialiasing = ClientPrefs.globalAntialiasing;
				add(bg);

				menuItems = new FlxTypedGroup<FlxSprite>();
				add(menuItems);

				var scale:Float = 1;

				for (i in 0...optionShit.length)
					{
						var menuItem:FlxSprite;
						if(i == 0){
						menuItem = new FlxSprite(90, 150);
						}
						else if(i == 1){
						menuItem = new FlxSprite(830, 150);
						}
						else if(i == 2){
						menuItem = new FlxSprite(90, 420);
						}
						else {
						menuItem = new FlxSprite(830, 420);
						}
						menuItem.scale.x = scale;
						menuItem.scale.y = scale;
						menuItem.frames = Paths.getSparrowAtlas('mainmenu/scott/menu_' + optionShit[i]);
						menuItem.animation.addByPrefix('idle', optionShit[i] + " basic", 24);
						menuItem.animation.addByPrefix('selected', optionShit[i] + " white", 24);
						menuItem.animation.play('idle');
						menuItem.ID = i;
						menuItems.add(menuItem);
						menuItem.antialiasing = ClientPrefs.globalAntialiasing;
						menuItem.updateHitbox();
					}

			case "UTdes":
				var megaBackdropB:FlxBackdrop = new FlxBackdrop(Paths.image('megaBackdropB'));
				add(megaBackdropB);
				megaBackdropB.velocity.set(-75, 75);

				var megaBackdropA:FlxBackdrop = new FlxBackdrop(Paths.image('megaBackdropA'));
				add(megaBackdropA);
				megaBackdropA.velocity.set(75, 75);
				var bg:FlxSprite = new FlxSprite(-80).loadGraphic(Paths.image('mainmenu/undersnail/PPPut'));
				bg.setGraphicSize(Std.int(bg.width * 1));
				bg.updateHitbox();
				bg.screenCenter();
				bg.antialiasing = ClientPrefs.globalAntialiasing;
				add(bg);
	
				menuItems = new FlxTypedGroup<FlxSprite>();
				add(menuItems);
		
				var scale:Float = 1;
		
				for (i in 0...optionShit.length)
					{
						var menuItem:FlxSprite;
						if(i == 0){
						menuItem = new FlxSprite(150, 150);
						}
						else if(i == 1){
						menuItem = new FlxSprite(830, 150);
						}
						else if(i == 2){
						menuItem = new FlxSprite(150, 420);
						}
						else {
						menuItem = new FlxSprite(830, 420);
						}
						menuItem.scale.x = scale;
						menuItem.scale.y = scale;
						menuItem.frames = Paths.getSparrowAtlas('mainmenu/undersnail/menu_' + optionShit[i]);
						menuItem.animation.addByPrefix('idle', optionShit[i] + " basic", 24);
						menuItem.animation.addByPrefix('selected', optionShit[i] + " white", 24);
						menuItem.animation.play('idle');
						menuItem.ID = i;
						menuItems.add(menuItem);
						menuItem.antialiasing = ClientPrefs.globalAntialiasing;
						menuItem.updateHitbox();
					}

			default:
				var back:FlxBackdrop = new FlxBackdrop(Paths.image('backdrop'));
				add(back);
				back.velocity.set(75, 100);

				var bg:FlxSprite = new FlxSprite(-80).loadGraphic(Paths.image('menucomp'));
				bg.setGraphicSize(Std.int(bg.width * 1));
				bg.updateHitbox();
				bg.screenCenter();
				bg.antialiasing = ClientPrefs.globalAntialiasing;
				add(bg);

				menuItems = new FlxTypedGroup<FlxSprite>();
				add(menuItems);

				var scale:Float = 1;

				for (i in 0...optionShit.length)
					{
						var menuItem:FlxSprite;
						if(i == 0){
						menuItem = new FlxSprite(150, 150);
						}
						else if(i == 1){
						menuItem = new FlxSprite(830, 150);
						}
						else if(i == 2){
						menuItem = new FlxSprite(150, 420);
						}
						else {
						menuItem = new FlxSprite(830, 420);
						}
						menuItem.scale.x = scale;
						menuItem.scale.y = scale;
						menuItem.frames = Paths.getSparrowAtlas('mainmenu/default/menu_' + optionShit[i]);
						menuItem.animation.addByPrefix('idle', optionShit[i] + " basic", 24);
						menuItem.animation.addByPrefix('selected', optionShit[i] + " white", 24);
						menuItem.animation.play('idle');
						menuItem.ID = i;
						menuItems.add(menuItem);
						menuItem.antialiasing = ClientPrefs.globalAntialiasing;
						menuItem.updateHitbox();
					}
		}

		var versionShit:FlxText = new FlxText(12, FlxG.height - 44, 0, "Psych Engine v" + psychEngineVersion, 12);
		versionShit.scrollFactor.set();
		versionShit.setFormat("VCR OSD Mono", 16, FlxColor.WHITE, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		add(versionShit);
		var versionShit:FlxText = new FlxText(12, FlxG.height - 24, 0, "Friday Night Funkin' v" + Application.current.meta.get('version'), 12);
		versionShit.scrollFactor.set();
		versionShit.setFormat("VCR OSD Mono", 16, FlxColor.WHITE, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		add(versionShit);

		// NG.core.calls.event.logEvent('swag').send();

		changeItem();

		/*#if ACHIEVEMENTS_ALLOWED
		Achievements.loadAchievements();
		var leDate = Date.now();
		if (leDate.getDay() == 5 && leDate.getHours() >= 18) {
			var achieveID:Int = Achievements.getAchievementIndex('friday_night_play');
			if(!Achievements.isAchievementUnlocked(Achievements.achievementsStuff[achieveID][2])) { //It's a friday night. WEEEEEEEEEEEEEEEEEE
				Achievements.achievementsMap.set(Achievements.achievementsStuff[achieveID][2], true);
				giveAchievement();
				ClientPrefs.saveSettings();
			}
		}
		#end*/

		super.create();
	}

	/*#if ACHIEVEMENTS_ALLOWED
	// Unlocks "Freaky on a Friday Night" achievement
	function giveAchievement() {
		add(new AchievementObject('friday_night_play', camAchievement));
		FlxG.sound.play(Paths.sound('confirmMenu'), 0.7);
		trace('Giving achievement "friday_night_play"');
	}
	#end*/

	var selectedSomethin:Bool = false;

	override function update(elapsed:Float)
	{
		if (FlxG.sound.music.volume < 0.8)
		{
			FlxG.sound.music.volume += 0.5 * FlxG.elapsed;
			if(FreeplayState.vocals != null) FreeplayState.vocals.volume += 0.5 * elapsed;
		}

		var lerpVal:Float = CoolUtil.boundTo(elapsed * 7.5, 0, 1);

		if (!selectedSomethin)
		{
			if (controls.UI_LEFT_P)
			{
				FlxG.sound.play(Paths.sound('scrollMenu'));
				changeItem(-1);
			}

			if (controls.UI_RIGHT_P)
			{
				FlxG.sound.play(Paths.sound('scrollMenu'));
				changeItem(1);
			}

			if (controls.UI_UP_P)
			{
				FlxG.sound.play(Paths.sound('scrollMenu'));
				changeItem(-2);
			}

			if (controls.UI_DOWN_P)
			{
				FlxG.sound.play(Paths.sound('scrollMenu'));
				changeItem(2);
			}

			if (controls.BACK)
			{
				selectedSomethin = true;
				FlxG.sound.play(Paths.sound('cancelMenu'));
				MusicBeatState.switchState(new TitleState());
			}

			if (FlxG.keys.justPressed.P)
				{
					selectedSomethin = true;
					MusicBeatState.switchState(new PasswordState());
				}

			if (controls.ACCEPT)
			{
				if (optionShit[curSelected] == 'donate')
				{
					CoolUtil.browserLoad('https://ninja-muffin24.itch.io/funkin');
				}
				else
				{
					selectedSomethin = true;
					FlxG.sound.play(Paths.sound('confirmMenu'));


					menuItems.forEach(function(spr:FlxSprite)
					{
						if (curSelected != spr.ID)
						{
							FlxTween.tween(spr, {alpha: 0}, 0.4, {
								ease: FlxEase.quadOut,
								onComplete: function(twn:FlxTween)
								{
									spr.kill();
								}
							});
						}
						else
						{
							FlxFlicker.flicker(spr, 1, 0.06, false, false, function(flick:FlxFlicker)
							{
								var daChoice:String = optionShit[curSelected];

								switch (daChoice)
								{
									case 'start':
										MusicBeatState.switchState(new StartMenuState());
									case 'extras':
										MusicBeatState.switchState(new ExtrasMenuState());
									case 'credits':
										MusicBeatState.switchState(new CreditsState());
									case 'options':
										LoadingState.loadAndSwitchState(new options.OptionsState());
								}
							});
						}
					});
				}
			}
			#if desktop
			else if (FlxG.keys.anyJustPressed(debugKeys))
			{
				selectedSomethin = true;
				MusicBeatState.switchState(new MasterEditorMenu());
			}
			#end
		}

		super.update(elapsed);

	}

	function changeItem(huh:Int = 0)
	{
		curSelected += huh;

		if (curSelected >= menuItems.length)
			curSelected = 0;
		if (curSelected < 0)
			curSelected = menuItems.length - 1;

		menuItems.forEach(function(spr:FlxSprite)
		{
			spr.animation.play('idle');
			spr.updateHitbox();

			if (spr.ID == curSelected)
			{
				spr.animation.play('selected');
				var add:Float = 0;
				if(menuItems.length > 4) {
					add = menuItems.length * 8;
				}
				spr.centerOffsets();
			}
		});
	}
}
