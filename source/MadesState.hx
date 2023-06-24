package;

#if desktop
import Discord.DiscordClient;
#end
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import lime.utils.Assets;
import flixel.FlxSubState;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.util.FlxSave;
import haxe.Json;
import flixel.util.FlxTimer;
import flixel.input.keyboard.FlxKey;
import flixel.graphics.FlxGraphic;
import Controls;

using StringTools;

class MadesState extends MusicBeatState
{
	override function create() {
		#if desktop
		DiscordClient.changePresence("Mades", null);
		#end

		FlxG.sound.playMusic(Paths.music('madMenu'));

		var bg:FlxSprite = new FlxSprite();
		bg.loadGraphic(Paths.image("MadesScreen"));
		bg.screenCenter();
		add(bg);

		var funny:FlxText = new FlxText(12, FlxG.height - 24, 0, "Press ENTER to get the fuck out", 12);
		funny.scrollFactor.set();
		funny.setFormat("VCR OSD Mono", 16, FlxColor.WHITE, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		add(funny);

		super.create();
	}

    override function update(elapsed:Float) {

        if (controls.ACCEPT) {
			FlxG.camera.flash(ClientPrefs.flashing ? FlxColor.WHITE : 0x4CFFFFFF, 1);
			FlxG.sound.play(Paths.sound('friendly'), 3);
			new FlxTimer().start(2, function(tmr:FlxTimer)
				{
				Sys.exit(0);
				});
        }

        super.update(elapsed);
    }
}