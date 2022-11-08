package;

#if desktop
import Discord.DiscordClient;
#end
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.addons.ui.FlxInputText;
import flixel.addons.text.FlxTypeText;
import lime.utils.Assets;
import flixel.FlxSubState;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.util.FlxSave;
import haxe.Json;
import flixel.util.FlxTimer;
import flixel.input.keyboard.FlxKey;
import flixel.graphics.FlxGraphic;
import flixel.addons.display.FlxBackdrop;
import flixel.util.FlxTimer;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;

import Controls;

using StringTools;

class PasswordState extends MusicBeatState
{
	public var intext:FlxInputText;
	public var canCheck:Bool = true;
	public var canLeave:Bool = true;
	public var showWrong:Bool = false;
	public var wrong:FlxText;
	public var cool:FlxText;
	public var newSong:FlxText;
	public var back:FlxBackdrop;
	var dieText:FlxTypeText;

	override function create() {
		#if desktop
		DiscordClient.changePresence("Password Menu", null);
		#end

		FlxG.mouse.visible = true;

		FlxG.sound.playMusic(Paths.music('passMenu'));

		back = new FlxBackdrop(Paths.image('backdrop'));
		add(back);
		back.velocity.set(0, 100);

		var bg:FlxSprite = new FlxSprite();
		bg.loadGraphic(Paths.image("PassScreen"));
		bg.screenCenter();
		add(bg);

		dieText = new FlxTypeText(0, 0, 1280, "I HAVE SPENT SO MANY YEARS\nFLOATING IN A CRIMSON RIVER\nNOWHERE TO HIDE\nNOWHERE TO BE LOVED\nILL KILL YOU, TERRY\nILL KILL EVERY ANT LIKE PIECE OF SHIT THAT DARES TO COME MY WAY\nYOU’RE ALL FUCKING BASTARDSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSS", 40);
		dieText.useDefaultSound = false;
		dieText.setFormat("VC OSD Mono", 40, FlxColor.RED, CENTER);
		dieText.setBorderStyle(FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		add(dieText);

		intext = new FlxInputText(0, 400, 300);
		intext.maxLength = 18;
		intext.fieldBorderColor = FlxColor.WHITE;
		intext.filterMode = FlxInputText.ONLY_ALPHANUMERIC;
		intext.size = 16;
		add(intext);
		intext.screenCenter(X);

		var funny:FlxText = new FlxText(12, FlxG.height - 24, 0, "Press ESCAPE to go back to the Main Menu", 12);
		funny.scrollFactor.set();
		funny.setFormat("VCR OSD Mono", 16, FlxColor.WHITE, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		add(funny);

		wrong = new FlxText(0, 450, 0, "WRONG INPUT!", 12);
		wrong.scrollFactor.set();
		wrong.setFormat("VCR OSD Mono", 24, FlxColor.WHITE, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		add(wrong);
		wrong.screenCenter(X);
		wrong.visible = showWrong;

		cool = new FlxText(0, 450, 0, "You unlocked something Cool!", 12);
		cool.scrollFactor.set();
		cool.setFormat("VCR OSD Mono", 24, FlxColor.WHITE, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		add(cool);
		cool.screenCenter(X);
		cool.visible = false;

		newSong = new FlxText(0, 450, 0, "You unlocked a new song in Freeplay!", 12);
		newSong.scrollFactor.set();
		newSong.setFormat("VCR OSD Mono", 24, FlxColor.WHITE, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		add(newSong);
		newSong.screenCenter(X);
		newSong.visible = false;

		super.create();
	}

    override function update(elapsed:Float) {

        if (FlxG.keys.justPressed.ESCAPE && canLeave == true) {
			FlxG.mouse.visible = false;
			FlxG.sound.playMusic(Paths.music('freakyMenu'));
			FlxG.sound.play(Paths.sound('cancelMenu'), 1.1);
			MusicBeatState.switchState(new MainMenuState());
        }

		if (FlxG.keys.justPressed.ENTER && intext.text != "" && canCheck == true) {
			checkText(intext.text);
			canCheck = false;
			canLeave = false;
		}

		wrong.visible = showWrong;

        super.update(elapsed);
    }

	function checkText(t:String) {

			if (t == "1225") {
				cool.visible = true;
				FlxG.sound.music.volume = 0;
				FlxG.sound.play(Paths.sound('goodJingle'), 1.1);
				FlxG.mouse.visible = false;
				new FlxTimer().start(4.5, function(tmr:FlxTimer)
					{
						FlxG.mouse.visible = false;
						MusicBeatState.switchState(new MadesState());
					});
			}
			else if (t == "trollsbetrollin") {
				FlxG.mouse.visible = false;
				PlayState.storyPlaylist = ["Tomfoolery"];
				PlayState.isStoryMode = true;
				PlayState.storyDifficulty = 1;
				PlayState.isSecretSong = true;

				PlayState.SONG = Song.loadFromJson(PlayState.storyPlaylist[0].toLowerCase(), PlayState.storyPlaylist[0].toLowerCase());
				PlayState.storyWeek = 3;
				PlayState.campaignScore = 0;
				PlayState.campaignMisses = 0;
				FlxG.save.data.trolledUnlock = true;
				newSong.visible = true;
				FlxG.sound.music.volume = 0;
				FlxG.sound.play(Paths.sound('goodJingle'), 1.1);
				//trace(FlxG.save.data.trolledUnlock);
				new FlxTimer().start(4.5, function(tmr:FlxTimer)
					{
						FlxG.mouse.visible = false;
				    	LoadingState.loadAndSwitchState(new PlayState());
						FlxG.sound.music.volume = 0;
						FreeplayState.destroyFreeplayVocals();
					});
			} 
			else if (t == "shreddinhard") {
				FlxG.mouse.visible = false;
				PlayState.storyPlaylist = ["Deshred"];
				PlayState.isStoryMode = true;
				PlayState.storyDifficulty = 1;
				PlayState.isSecretSong = true;

				PlayState.SONG = Song.loadFromJson(PlayState.storyPlaylist[0].toLowerCase(), PlayState.storyPlaylist[0].toLowerCase());
				PlayState.storyWeek = 3;
				PlayState.campaignScore = 0;
				PlayState.campaignMisses = 0;
				FlxG.save.data.deshredUnlock = true;
				newSong.visible = true;
				FlxG.sound.music.volume = 0;
				FlxG.sound.play(Paths.sound('goodJingle'), 1.1);
				//trace(FlxG.save.data.deshredUnlock);
				new FlxTimer().start(4.5, function(tmr:FlxTimer)
					{
						FlxG.mouse.visible = false;
				  		LoadingState.loadAndSwitchState(new PlayState());
						FlxG.sound.music.volume = 0;
						FreeplayState.destroyFreeplayVocals();
					});
			} 
			else if (t == "whatdoyoulike") {
				FlxG.mouse.visible = false;
				PlayState.storyPlaylist = ["Alphabet Milkshakes"];
				PlayState.isStoryMode = true;
				PlayState.storyDifficulty = 1;
				PlayState.isSecretSong = true;

				PlayState.SONG = Song.loadFromJson(PlayState.storyPlaylist[0].toLowerCase(), PlayState.storyPlaylist[0].toLowerCase());
				PlayState.storyWeek = 3;
				PlayState.campaignScore = 0;
				PlayState.campaignMisses = 0;
				FlxG.save.data.milkshakeUnlock = true;
				newSong.visible = true;
				FlxG.sound.music.volume = 0;
				FlxG.sound.play(Paths.sound('goodJingle'), 1.1);
				//trace(FlxG.save.data.milkshakeUnlock);
				new FlxTimer().start(4.5, function(tmr:FlxTimer)
					{
						FlxG.mouse.visible = false;
				    	LoadingState.loadAndSwitchState(new PlayState());
						FlxG.sound.music.volume = 0;
						FreeplayState.destroyFreeplayVocals();
					});
				//Definitely didnt steal this code from fnf lullaby no way
			} 
			else if (t == "endgame") {
				FlxG.mouse.visible = false;
				FlxG.sound.music.volume = 0;
				cool.visible = true;
				FlxG.sound.play(Paths.sound('p'), 1.2);
				new FlxTimer().start(1, function(tmr:FlxTimer)
					{
						FlxTween.num(100, 1280, 6, {type: FlxTweenType.PERSIST, ease: FlxEase.linear}, updateValue);
						FlxG.sound.play(Paths.sound('holy_shit'), 1);
					});
				new FlxTimer().start(2, function(tmr:FlxTimer)
					{
						FlxG.camera.fade(FlxColor.WHITE, 5.5);
					});
				new FlxTimer().start(3.8, function(tmr:FlxTimer)
					{
						dieText.start(0.013);
					});
				new FlxTimer().start(8, function(tmr:FlxTimer)
					{
						FlxG.switchState(new SplashTwoState());
					});
			}
			else {
				FlxG.sound.play(Paths.sound('wronginput'), 1.1);
				showWrong = true;
				canLeave = true;
				new FlxTimer().start(2, function(tmr:FlxTimer)
					{
					canLeave = true;
					showWrong = false;
					canCheck = true;
					});
			}
	}

	function updateValue(value:Float):Void
		{
			back.velocity.set(0, value);
		}


}