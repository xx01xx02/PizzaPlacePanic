package;

import flixel.FlxState;
import flixel.FlxG;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.text.FlxText;
import flixel.FlxSprite;
import flixel.util.FlxColor;
import flixel.addons.effects.chainable.FlxEffectSprite;
import flixel.addons.effects.chainable.FlxRainbowEffect;

class UcnScreen extends MusicBeatState
{

    var pToken:Int = 0;
    var intThing:Int = 0;
    var goToState:String = "";
    var theFuckingTween:FlxTween;
    var texty:FlxText;
    var check:Bool = false;
    var rainbow = new FlxRainbowEffect(0);
	var effectSprite:FlxEffectSprite;
    var didSFX:Bool = false;

    override public function create():Void
    {
        super.create();

        FlxG.sound.playMusic(Paths.music('ucnwaiting'));
        Conductor.changeBPM(120);

        if (PlayState.isStoryMode && !PlayState.isSecretSong){
            goToState = "story";
            pToken = Std.int(PlayState.campaignScore/1000);
            // :) :):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):) I LOVE CODEIN :):):):):):):):):):):):)
        }
        else {
            goToState = "freeplay";
            pToken = Std.int(PlayState.ucnFreeplayScore/1000);
            //pToken = 1000;
        }
        texty = new FlxText(0, 0, 0, "0", 28);
        texty.screenCenter();
        theFuckingTween = FlxTween.num(0, 1000, 58.8, {type: FlxTweenType.PERSIST, ease: FlxEase.linear, onComplete: tweenDone}, doTheThing);
        add(texty);
        effectSprite = new FlxEffectSprite(texty);
		effectSprite.x = texty.x;
		effectSprite.y = texty.y;
        effectSprite.effectsEnabled = true;
		add(effectSprite);
		effectSprite.effects = [rainbow];
    }

    override function beatHit(){

        super.beatHit();
        //trace("Hi");

        if ((intThing >= pToken-34 || intThing >= 966) && !didSFX) {
            if (pToken >= 200) {
                didSFX = true;
                doJingle(true);
            }
            else {
                didSFX = true;
                doJingle(false);
            }
        }
    }

    public function doTheThing(value:Float){
        intThing = Std.int(value);
        texty.text = Std.string(intThing);

        if (intThing >= 1000) {
            texty.text = "ITS OVER 1000!!!";    
        }

        if (intThing >= pToken) {
            theFuckingTween.cancel();
            check = true;
        }

        rainbow.alpha = (intThing/1000)*0.8;
        texty.size = Std.int((intThing/1000)*40+28);
        texty.screenCenter();
        effectSprite.x = texty.x;
		effectSprite.y = texty.y;
    }

    function tweenDone(tween:FlxTween):Void
    {
        //didSFX = true;
        check = true;
        //texty.text = "ITS OVER 1000!!!";
        //doJingle(true);
    }

    function doJingle(good:Bool)
    {
        FlxG.sound.music.volume = 0;
        if (good) {
            FlxG.sound.play(Paths.sound('ucncount2'), 1.1); 
        }
        else {
            FlxG.sound.play(Paths.sound('ucncount1'), 1.1); 
        }
        
    }

    override public function update(elapsed:Float):Void
    {
        super.update(elapsed);

        if (FlxG.sound.music != null)
			Conductor.songPosition = FlxG.sound.music.time;

        if (controls.ACCEPT && check){
            FlxG.sound.playMusic(Paths.music('freakyMenu'));
            Conductor.changeBPM(102);
            switch (goToState)
				{
				case 'freeplay':
					MusicBeatState.switchState(new FreeplayState());
				case 'story':
					MusicBeatState.switchState(new StoryMenuState());
			}
        }
    }
}