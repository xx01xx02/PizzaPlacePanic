package;

#if desktop
import Discord.DiscordClient;
#end

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.text.FlxText;
import flixel.addons.text.FlxTypeText;
import flixel.util.FlxColor;
import flixel.FlxSubState;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxCamera;
import flixel.util.FlxSave;
import flixel.math.FlxRandom;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.util.FlxTimer;
import flixel.input.keyboard.FlxKey;
import flixel.graphics.FlxGraphic;
import flixel.system.FlxSound;
import Controls;
import Achievements;
import flixel.tweens.FlxTween;
import haxe.Json;
import haxe.format.JsonParser;
import lime.utils.Assets;

#if sys
import sys.io.File;
import sys.FileSystem;
#end

using StringTools;

typedef DialLines =
{
	var anim:String;
	var line:String;
}

typedef TalkTopic = 
{
	var topic:String;
	var dialogue:Array<DialLines>;
}

class ShopState2 extends MusicBeatState
{
	public var camOther:FlxCamera;
	var coinText:FlxText;
	var menuText:FlxText;
	var optionsCurSelected:Int;
	var dialogueOptions:Array<TalkTopic>;
	var random:FlxRandom = new FlxRandom();
	var dialHelperCount:Int;

	var standardOptions:FlxTypedGroup<FlxText>;
	var talkingOptions:FlxTypedGroup<FlxText>;
	var buyingOptions:FlxTypedGroup<FlxText>;
	var priceOptions:FlxTypedGroup<FlxText>;
	
	var shopUi2:FlxSprite;

	var currentThing:String = 's';

	var standardopts:Array<String> = [
		'BUY',
		'SELL',
		'TALK',
		'LEAVE'
	];
	var dialogueNumbahs:Array<Int> = [];
	var talkingopts:Array<String> = [
		'YOU',
		'WHAT',
		'WHERE',
		'STOP'
	];
	public static var achieveCoins:Int;
	var dieText:FlxTypeText;
	var guytalkingsound:FlxSound;
	var items:Array<String> = [
		'TESTITEM1',
		'TESTITEM2',
		'prizedNFT.png'
	];
	var prices:Array<Int> = [
		1,
		3,
		10
	];
	public static var hasBought:Array<Bool> = [
		false,
		false,
		false
	];
	
	

	override function create() {
		#if desktop
		DiscordClient.changePresence("Buying shit at SPECIAL DEALS HERE BUY NOW", null);
		#end
		FlxG.sound.playMusic(Paths.music('shopMenu'));
		camOther = new FlxCamera();
		FlxG.cameras.add(camOther);

		var rawJson = null;
		#if sys
		rawJson = File.getContent(Paths.json('shop2dial')).trim();
		#else
		rawJson = Assets.getText(Paths.json('shop2dial')).trim();
		#end

		dialogueOptions = Json.parse(rawJson);
		
		trace(dialogueOptions[0].topic);
		trace(dialogueOptions[1].topic);

		for (i in 0...3){
			var funny = random.int(0, dialogueOptions.length-1);
			talkingopts[i] = dialogueOptions[funny].topic;
			dialogueNumbahs.push(funny);
		}

		talkingOptions = new FlxTypedGroup<FlxText>();
		add(talkingOptions);
		buyingOptions = new FlxTypedGroup<FlxText>();
		add(buyingOptions);
		standardOptions = new FlxTypedGroup<FlxText>();
		add(standardOptions);
		priceOptions = new FlxTypedGroup<FlxText>();
		add(priceOptions);

		guytalkingsound = FlxG.sound.load(Paths.sound('shoptext'));

		var textsounds:Array<FlxSound> = [
			guytalkingsound
		];

		if(FlxG.save.data != null) {
			if (FlxG.save.data.achCoins != null)
				achieveCoins = FlxG.save.data.achCoins;
        }


		var bg:FlxSprite = new FlxSprite();
		bg.loadGraphic(Paths.image("shop2_funnyBG"));
		bg.screenCenter();
		add(bg);

		var shopUi1:FlxSprite = new FlxSprite(0, 0);
		shopUi1.frames = Paths.getSparrowAtlas('shop2_HUD1');
        shopUi1.animation.addByPrefix('idle', "idle", 8);
		shopUi1.animation.play('idle');
		shopUi1.screenCenter();
		add(shopUi1);

        shopUi2 = new FlxSprite();
		shopUi2.loadGraphic(Paths.image("shop2_HUD2"));
		shopUi2.screenCenter();
		add(shopUi2);

		dieText = new FlxTypeText(60, 416, 756, "welcome.", 38);
		dieText.prefix = "* ";
		dieText.sounds = textsounds;
		dieText.setFormat("Madou Futo Maru Gothic", 32, FlxColor.WHITE);
		add(dieText);
		dieText.start();

		/*var tokenSprite:FlxSprite = new FlxSprite();
		tokenSprite.loadGraphic(Paths.image("pizza_token_color_still"));
		tokenSprite.x = 860;
		tokenSprite.y = 630;
		tokenSprite.scale.x = 0.6;
		tokenSprite.scale.y = 0.6;*/

		coinText = new FlxText(935, 665, 1000, Std.string(achieveCoins), 38);
		coinText.setFormat("Madou Futo Maru Gothic", 32, FlxColor.WHITE);
		add(coinText);

		for (i in 0...items.length){
			var itemText:FlxText = new FlxText(925, 342 + 72 * i, 310, items[i]);
			itemText.setFormat("Madou Futo Maru Gothic", 42, FlxColor.WHITE);
			itemText.ID = i;
			buyingOptions.add(itemText);
			add(itemText);
			var priceText:FlxText;
			priceText = new FlxText(925, 384 + 72 * i, 310, Std.string(prices[i]) + " Coins");
			priceText.setFormat("Madou Futo Maru Gothic", 28, FlxColor.WHITE);
			priceText.ID = 100 + i;
			priceOptions.add(priceText);
			add(priceText);
		}

		var buyLEAVEText:FlxText = new FlxText(925, 342 + 72 * items.length , 310, "NO BUY");
			buyLEAVEText.setFormat("Madou Futo Maru Gothic", 42, FlxColor.WHITE);
			buyLEAVEText.ID = items.length;
			buyingOptions.add(buyLEAVEText);
			add(buyLEAVEText);

		for (i in 0...talkingopts.length){
			var talkText:FlxText = new FlxText(925, 342 + 72 * i, 310, talkingopts[i]);
			talkText.setFormat("Madou Futo Maru Gothic", 42, FlxColor.WHITE);
			talkText.ID = 200 + i;
			talkingOptions.add(talkText);
			add(talkText);
		}

		for (i in 0...standardopts.length){
			var stanText:FlxText = new FlxText(925, 342 + 72 * i, 310, standardopts[i]);
			stanText.setFormat("Madou Futo Maru Gothic", 42, FlxColor.WHITE);
			stanText.ID = 300 + i;
			standardOptions.add(stanText);
			add(stanText);
		}

		newOptiontotalk(currentThing);
		changeSelection(0, true);
		updateItemThings();
		super.create();
	}

    override function update(elapsed:Float) {

        if (controls.ACCEPT) {
			switch(currentThing)
			{
				case "s":
					var daChoice:String = standardopts[optionsCurSelected];

					switch (daChoice)
						{
							case 'BUY':
								dieText.resetText("What are you buying?");
								dieText.start();
								currentThing = 'b';
								newOptiontotalk(currentThing);
								changeSelection(0, true);
								FlxTween.tween(shopUi2, { x: shopUi2.x, y: shopUi2.y-300 }, 0.2);
								buyingOptions.forEach(function(text:FlxText)
									{
										FlxTween.tween(text, { x: text.x, y: text.y-300 }, 0.2);
									});
								priceOptions.forEach(function(text:FlxText)
									{
										FlxTween.tween(text, { x: text.x, y: text.y-300 }, 0.2);
									});
							case 'SELL':
								dieText.resetText("Im not buying your shit");
								dieText.start();
							case 'TALK':
								dieText.resetText("I dont mind talking");
								dieText.start();
								currentThing = 't';
								newOptiontotalk(currentThing);
								changeSelection(0, true);
							case 'LEAVE':
								FlxG.sound.play(Paths.sound('cancelMenu'));
								FlxG.sound.playMusic(Paths.music('freakyMenu'));
								MusicBeatState.switchState(new ExtrasMenuState());
						}

				case "b":
					if(optionsCurSelected == items.length){
						dieText.resetText("changed your mind, eh?");
						dieText.start();
						currentThing = 's';
						FlxTween.tween(shopUi2, { x: shopUi2.x, y: shopUi2.y+300 }, 0.2);
								buyingOptions.forEach(function(text:FlxText)
									{
										FlxTween.tween(text, { x: text.x, y: text.y+300 }, 0.2);
									});
								priceOptions.forEach(function(text:FlxText)
									{
										FlxTween.tween(text, { x: text.x, y: text.y+300 }, 0.2);
									});
						newOptiontotalk(currentThing);
						changeSelection(0, true);
					}
					else if (!hasBought[optionsCurSelected] && achieveCoins >= prices[optionsCurSelected]){
						achieveCoins -= prices[optionsCurSelected];
						hasBought[optionsCurSelected] = true;
						FlxG.sound.play(Paths.sound('shopbuy'));
						dieText.resetText("Cool, you bought " + items[optionsCurSelected] + " with your coins. neato.");
						dieText.start();
						//saveWhatYouBoughtPlease();
						updateItemThings();
					}
					else if (!hasBought[optionsCurSelected] && achieveCoins < prices[optionsCurSelected]) {
						dieText.resetText("test text no money bitch.");
						dieText.start();
					}
					else {
						dieText.resetText("test text no item whore.");
						dieText.start();
					}

				case "t":
					if (talkingopts[optionsCurSelected] == "STOP"){
						dieText.resetText("Anything else?");
						dieText.start();
						currentThing = 's';
						newOptiontotalk(currentThing);
						changeSelection(0, true);
					}
					else {
						doDialogue(dialogueNumbahs[optionsCurSelected]);
						currentThing = 'dial';
						newOptiontotalk(currentThing);
					}
			
				
				case "dial":
					doDialogue(dialogueNumbahs[optionsCurSelected]);

					/*
						"Who is that behind you? The one with that creepy smile?"
						"Hey, why is your face melting off?"
						"Scream into the void, you'll get an answer eventually."
						"You're disgusting to look at, you one eyed fr-..."
						"Back again to spend those coins?"
						"Those coins? Yeah I don't know where they come from. Altough they seem to be pretty metaphysical..."
						"Capitalism. Truly, the definitive icebreaker."
						"If you ever see a purple hoodied guy, tell him I said hello"
						"If you ever see a monochrome being, tell him I said hello"
						"Hitting the griddy, for ████████"
						* You stop talking to the shopkeeper.
						* There's no one behind the register, anyway.
					*/
			}
        }

		if (currentThing != "dial"){
			if (controls.UI_UP_P)
			{
				FlxG.sound.play(Paths.sound('scrollMenu'));
				changeSelection(-1, false);
			}

			if (controls.UI_DOWN_P)
			{
				FlxG.sound.play(Paths.sound('scrollMenu'));
				changeSelection(1, false);
			}
		}
		

		if (controls.BACK){
		}

		if (FlxG.keys.justPressed.P)
			{
				achieveCoins += 1;
				coinText.text = Std.string(achieveCoins);
			}
		

        super.update(elapsed);
    }

	function doDialogue(toptop:Int){
		if (dialHelperCount < dialogueOptions[toptop].dialogue.length){
			dieText.resetText(dialogueOptions[toptop].dialogue[dialHelperCount].line);
			dieText.start();
			dialHelperCount += 1;
		}
		else {
			dialHelperCount = 0;
			dieText.resetText("Anything else?");
			dieText.start();
			currentThing = 't';
			newOptiontotalk(currentThing);
			changeSelection(0, true);
		}
	}

	function updateItemThings(){
		coinText.text = Std.string(achieveCoins);
		priceOptions.forEach(function(text:FlxText)
			{
				if (hasBought[text.ID - 100]){
					text.setFormat("Madou Futo Maru Gothic", 28, FlxColor.RED);
					text.text = "SOLD";
				}
			});
		

		coinText.text = Std.string(achieveCoins);
	}

	function newOptiontotalk(mode:String){
		if (mode != 's'){
			standardOptions.forEach(function(text:FlxText)
				{
					text.visible = false;
				});
		}
		else {
			standardOptions.forEach(function(text:FlxText)
				{
					text.visible = true;
				});
		}
		if (mode != 't'){
			talkingOptions.forEach(function(text:FlxText)
				{
					text.visible = false;
				});
		}
		else {
			talkingOptions.forEach(function(text:FlxText)
				{
					text.visible = true;
				});
		}
		if (mode != 'b'){
			buyingOptions.forEach(function(text:FlxText)
				{
					text.visible = false;
				});
			priceOptions.forEach(function(text:FlxText)
					{
						text.visible = false;
					});
		}
		else {
			buyingOptions.forEach(function(text:FlxText)
				{
					text.visible = true;
				});
			priceOptions.forEach(function(text:FlxText)
				{
					text.visible = true;
				});
		}
	}

	/*
		HELLO EVERY !
        THIS NEW [Shopping Experience] SEEMS PRETTY [BIG]
        BUT [Have no worries for this once in a life]
        THAT DARK [Cyclops] ISNT A [!&$?] FREAK LIKE THE REST OF
        OF
        OF
        SO USE THOSE [delicious chocolate coins] AND BUY HIS
        Freedom...
        [Heaven]'S WATCHING, DONT [This train is delayed by]
	*/

	function changeSelection(huh:Int, forced:Bool){
		if (forced){
			optionsCurSelected = huh;
		}
		else {
			optionsCurSelected += huh;
		}
		switch (currentThing)
			{
				case 'b':
					if(optionsCurSelected > items.length){
						optionsCurSelected = 0;
					}
					if(optionsCurSelected < 0){
						optionsCurSelected = items.length;
					}	
					buyingOptions.forEach(function(text:FlxText)
						{
							text.setFormat("Madou Futo Maru Gothic", 42, FlxColor.WHITE);
							if (text.ID == optionsCurSelected){
								text.setFormat("Madou Futo Maru Gothic", 42, FlxColor.YELLOW);
							}
						});
				case 't':
					if(optionsCurSelected >= talkingopts.length){
						optionsCurSelected = 0;
					}
					if(optionsCurSelected < 0){
						optionsCurSelected = talkingopts.length - 1;
					}
					talkingOptions.forEach(function(text:FlxText)
						{
							text.setFormat("Madou Futo Maru Gothic", 42, FlxColor.WHITE);
							if (text.ID == 200 + optionsCurSelected){
								text.setFormat("Madou Futo Maru Gothic", 42, FlxColor.YELLOW);
							}
						});
				case 's':
					if(optionsCurSelected >= standardopts.length){
						optionsCurSelected = 0;
					}
					if(optionsCurSelected < 0){
						optionsCurSelected = standardopts.length - 1;
					}
					standardOptions.forEach(function(text:FlxText)
						{
							text.setFormat("Madou Futo Maru Gothic", 42, FlxColor.WHITE);
							if (text.ID == 300 + optionsCurSelected){
								text.setFormat("Madou Futo Maru Gothic", 42, FlxColor.YELLOW);
							}
						});
			}
	}
}