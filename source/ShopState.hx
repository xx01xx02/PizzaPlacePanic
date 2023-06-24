package;

#if desktop
import Discord.DiscordClient;
#end
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.text.FlxText;
import flixel.addons.text.FlxTypeText;
import flixel.util.FlxColor;
import lime.utils.Assets;
import flixel.FlxSubState;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxCamera;
import flixel.util.FlxSave;
import flixel.math.FlxRandom;
import haxe.Json;
import flixel.util.FlxTimer;
import flixel.input.keyboard.FlxKey;
import flixel.graphics.FlxGraphic;
import flixel.system.FlxSound;
import Controls;
import Achievements;

using StringTools;

class ShopState extends MusicBeatState
{
	public var camOther:FlxCamera;
	var tokenText:FlxText;
	var menuText:FlxText;
	var arrow:FlxSprite;
	var curSelected:Int;
	public static var menuSelected:Int;
	public static var pizzaTokens:Int;
	var dieText:FlxTypeText;
	var random:FlxRandom = new FlxRandom();
	var shopKeepInt:Int;
	var shopKeepName:String;
	var guytalkingsound:FlxSound;
	public static var unlockedMenus:Array<String> = [
		'Default'
	];
	var items:Array<String> = [
		'GUNSPRAY',
		'Self Insert',
		'Susarray',
		'UTdes Menu',
		'Scott Menu'
	];
	var prices:Array<Int> = [
		250,  //Gunspray
		250,  //Self Insert
		354,  //Susarray
		500,  //UT M
		500   //Scott the WOOOOSE
	];
	public static var hasBought:Array<Bool> = [
		false,
		false,
		false,
		false,
		false
	];
	
	

	override function create() {
		#if desktop
		DiscordClient.changePresence("Buying shit in the soup store", null);
		#end
		FlxG.sound.playMusic(Paths.music('shopMenu'));
		camOther = new FlxCamera();
		FlxG.cameras.add(camOther);

		guytalkingsound = FlxG.sound.load(Paths.sound('shoptext'));

		var textsounds:Array<FlxSound> = [
			guytalkingsound
		];

		if(FlxG.save.data != null) {
			if (FlxG.save.data.pTokens != null)
				pizzaTokens = FlxG.save.data.pTokens;
			if (FlxG.save.data.currentMenuThemeNumber != null)
				menuSelected = FlxG.save.data.currentMenuThemeNumber;
			if (FlxG.save.data.shopMenusUnlocked != null)
				unlockedMenus = FlxG.save.data.shopMenusUnlocked;
            if (FlxG.save.data.shopBoughtGunspray != null)
                hasBought[0] = FlxG.save.data.shopBoughtGunspray;
            if (FlxG.save.data.shopBoughtSelfInsert != null)
                hasBought[1] = FlxG.save.data.shopBoughtSelfInsert;
			if (FlxG.save.data.shopBoughtSusarray != null)
                hasBought[2] = FlxG.save.data.shopBoughtSusarray;
			if (FlxG.save.data.shopBoughtUTM != null)
                hasBought[3] = FlxG.save.data.shopBoughtUTM;
			if (FlxG.save.data.shopBoughtScottM != null)
                hasBought[4] = FlxG.save.data.shopBoughtScottM;
        }

		shopKeepInt = random.int(1, 15);
		var bg:FlxSprite = new FlxSprite();
		bg.loadGraphic(Paths.image("shop_keep_bg"));
		bg.screenCenter();
		add(bg);

		switch(shopKeepInt)
		{
			case 1:
				shopKeepName = 'des';
			case 2:
				shopKeepName = 'desron';
			case 3:
				shopKeepName = 'destord';
			case 4:
				shopKeepName = 'frog';
			case 5:
				shopKeepName = 'inytor';
			case 6:
				shopKeepName = 'mades';
			case 7:
				shopKeepName = 'morshu';
			case 8:
				shopKeepName = 'orb';
			case 9:
				shopKeepName = 'sans';
			case 10:
				shopKeepName = 'terry';
			case 11:
				shopKeepName = 'das';
			case 12:
				shopKeepName = 'wtf';
			case 13:
				shopKeepName = 'topdes';
			case 14:
				shopKeepName = 'utdes';
			case 15:
				shopKeepName = 'shed';
			default:
				shopKeepName = 'idk';
		}

		var shopKeepSprite:FlxSprite = new FlxSprite();
		shopKeepSprite.loadGraphic(Paths.image("shopkeepers/shop_" + shopKeepName));
		shopKeepSprite.x = 181;
		shopKeepSprite.y = -37;
		add(shopKeepSprite);

		var shopUi:FlxSprite = new FlxSprite();
		shopUi.loadGraphic(Paths.image("shop_ui"));
		shopUi.screenCenter();
		add(shopUi);

		switch(shopKeepName)
				{
					case 'des':
						dieText = new FlxTypeText(60, 416, 756, "Welcome to the PizzaPlace Souvenir Shop! Buy our wares!", 32);
					case 'desron':
						dieText = new FlxTypeText(60, 416, 756, "ayyyyyyy welcome to the funny store. buy my weed dude.", 32);
					case 'destord':
						dieText = new FlxTypeText(60, 416, 756, "Oh, it's you? Back to screw up my plans to make the best self insert ever.", 32);
					case 'frog':
						dieText = new FlxTypeText(60, 416, 756, "Ribbit, Ribbit (Heya Pal! Care to buy something?)", 32);
					case 'inytor':
						dieText = new FlxTypeText(60, 416, 756, "HIYA BROSKI!!! IM TOOTALLY DES' BROTHER!!!", 32);
					case 'mades':
						dieText = new FlxTypeText(60, 416, 756, "WELCOME WELCOME TO INFINITE FUN IN THIS HERE SHOP! HAVE A LOOK AROUND!", 32);
					case 'morshu':
						dieText = new FlxTypeText(60, 416, 756, "Custom Menus? Songs? You want it? It's yours my friend, aslong as you have enough Tokens!", 32);
					case 'orb':
						dieText = new FlxTypeText(60, 416, 756, "", 32);
					case 'sans':
						dieText = new FlxTypeText(60, 416, 756, "come in come in, youre following the dress code for this calcium filled place. maybe its the way your dressed.", 32);
					case 'terry':
						dieText = new FlxTypeText(60, 416, 756, "Hey man. Welcome to the shop. Get whatever you want if you've got the tokens for it. Just don't ask about my old friend.", 32);
					case 'das':
						dieText = new FlxTypeText(60, 416, 756, "Greetings, young one. what would you like to purchase from our fine shoppe?", 32);
					case 'wtf':
						dieText = new FlxTypeText(60, 416, 756, "Hello Silly Guy… I am Desilly Dilbert Johnson and I sell you Widgets? And Gadget", 32);
					case 'topdes':
						dieText = new FlxTypeText(60, 416, 756, "Hello Swagged Cashman... What do you as a Hood Man want to get from this HoodLike SHop", 32);
					case 'utdes':
						dieText = new FlxTypeText(60, 416, 756, "heya kid. good to see ya. need anything from the shop?", 32);
					case 'shed':
						dieText = new FlxTypeText(60, 416, 756, "Doodley doodley dee Boom Chuck Boom Chuck Chunka Chunk", 32);
					default:
						dieText = new FlxTypeText(60, 416, 756, "Test Text. You are in the shop lmao.", 32);
				}
		dieText.prefix = "* ";
		dieText.sounds = textsounds;
		dieText.setFormat("Determination Sans", 32, FlxColor.WHITE);
		add(dieText);
		dieText.start();

		var tokenSprite:FlxSprite = new FlxSprite();
		tokenSprite.loadGraphic(Paths.image("pizza_token_color_still"));
		tokenSprite.x = 860;
		tokenSprite.y = 630;
		tokenSprite.scale.x = 0.6;
		tokenSprite.scale.y = 0.6;

		tokenText = new FlxText(935, 665, 1000, Std.string(pizzaTokens), 32);
		tokenText.setFormat("Determination Sans", 32, FlxColor.WHITE);
		add(tokenText);

		menuText = new FlxText(880, 608, 1000, "Current Menu: " + unlockedMenus[menuSelected], 32);
		menuText.setFormat("Determination Sans", 32, FlxColor.WHITE);
		add(menuText);

		add(tokenSprite);
		
		var funny:FlxText = new FlxText(18, FlxG.height - 30, 0, "Press ESCAPE to go back", 12);
		funny.scrollFactor.set();
		funny.setFormat("Determination Sans", 16, FlxColor.WHITE, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		add(funny);

		arrow = new FlxSprite();
		arrow.loadGraphic(Paths.image("shop_arrow"));
		arrow.x = 929;
		arrow.y = 42 + 72 * curSelected;
		add(arrow);

		for (i in 0...items.length){
				var itemText:FlxText = new FlxText(949, 31 + 72 * i, 310, prices[i] + " - " + items[i]);
				itemText.setFormat("Determination Sans", 32, FlxColor.WHITE);
				add(itemText);
			
			if (hasBought[i]){
				var soldSprite:FlxSprite = new FlxSprite();
				soldSprite.loadGraphic(Paths.image("shop_sold"));
				soldSprite.x = 949;
				soldSprite.y = 31 + 72 * i;
				add(soldSprite);
			}
			
		}

		super.create();
	}

    override function update(elapsed:Float) {

        if (controls.ACCEPT) {
			if (!hasBought[curSelected] && pizzaTokens >= prices[curSelected]){
				pizzaTokens -= prices[curSelected];
				hasBought[curSelected] = true;
				FlxG.sound.play(Paths.sound('shopbuy'));

				switch(curSelected)
				{
					case 3:
						unlockedMenus.push("UTdes");
						saveMenuTheme();
					case 4:
						unlockedMenus.push("Scott");
						saveMenuTheme();
					default:
						//awaaga
				}

				switch(shopKeepName)
				{
					case 'des':
						dieText.resetText("A fresh " + items[curSelected] + " right out of the oven! Enjoy!");
					case 'desron':
						dieText.resetText("thanks for the money m8, heres your " + items[curSelected] + ". have fun.");
					case 'destord':
						dieText.resetText("The profit of this " + items[curSelected] + " will surely help with my plans to kill you when I get out of here.");
					case 'frog':
						dieText.resetText("Ribbit. Ribbit. (Here's your " + items[curSelected] + ".)");
					case 'inytor':
						dieText.resetText("HAVE FUN WITH THAT  " + items[curSelected] + " YOU BOUGHT!!!!!");
					case 'mades':
						dieText.resetText("AWW YEAH! HAVE FUN WITH THIS " + items[curSelected] + ". IT'S VERY COOL AND CASH MONEY.");
					case 'morshu':
						dieText.resetText("This " + items[curSelected] + " is yours, my friend! You had enough Tokens afterall!");
					case 'orb':
						dieText.resetText("Orb (Got " + items[curSelected] + ".)");
					case 'sans':
						dieText.resetText("shiver me bones, take your " + items[curSelected] + ".");
					case 'terry':
						dieText.resetText("That's a good purchase. Hope you like "+ items[curSelected] + ".");
					case 'das':
						dieText.resetText("Have fun with that " + items[curSelected] + ", young one.");
					case 'wtf':
						dieText.resetText("Purchased one of my  " + items[curSelected] + "??? Widget?? Good for yoThe rides:");
					case 'topdes':
						dieText.resetText("Yeaaaaahhhh.... Das Fax...... Hoodlike " + items[curSelected] + ", also..... sorry forgot");
					case 'utdes':
						dieText.resetText("have fun with that " + items[curSelected] + ", kiddo.");
					case 'shed':
						dieText.resetText("YOUR " + items[curSelected] + " IS worse than my GUITAR Boom Chicka Boom Chicka.");
					default:
						dieText.resetText("Cool, you bought " + items[curSelected] + " with your tokens. neato.");
				}
				dieText.start();
				saveWhatYouBoughtPlease();
				updateItemThings();
				
				var achieve:String = checkForAchievements();
				if(achieve != null) {
					startAchievement(achieve);
					return;
				}
			}
			else if (!hasBought[curSelected] && pizzaTokens < prices[curSelected]) {
				switch(shopKeepName)
				{
					case 'des':
						dieText.resetText("Look man, you don't have enough Tokens to buy that.");
					case 'desron':
						dieText.resetText("m8 your cash money cant even buy 1 weed.");
					case 'destord':
						dieText.resetText("Your funds aren't sufficient.");
					case 'frog':
						dieText.resetText("Ribbit. Ribbit. (Not enough Tokens man.)");
					case 'inytor':
						dieText.resetText("CANT BUY THAT THING!!! COME AGAIN BROSKI!!!!");
					case 'mades':
						dieText.resetText("YOUR POCKETS HAVE AN INFINITE SPACE OF NOT ENOUGH MONEY.");
					case 'morshu':
						dieText.resetText("Sorry Boyfriend, I can't give credit. Come back when your'e a bit MMMMMMMMMMM richer!");
					case 'orb':
						dieText.resetText("Orb (Not enough Tokens.)");
					case 'sans':
						dieText.resetText("your amount of money is less than my daily intake of calcium.");
					case 'terry':
						dieText.resetText("You don't have enough Pizza Tokens. Come again, if you still wanna buy that thing.");
					case 'das':
						dieText.resetText("Sincerest apologies, but you do not have enough money.");
					case 'wtf':
						dieText.resetText("not enough cunt");
					case 'topdes':
						dieText.resetText("Not Enough Cash You Dumb Fucking Idiot");
					case 'utdes':
						dieText.resetText("dont got enough cash, kiddo.");
					case 'shed':
						dieText.resetText("Wah wah wah wah Wubwubwubwub");
					default:
						dieText.resetText("test text no money bitch.");
				}
				dieText.start();
			}
			else {
				switch(shopKeepName)
				{
					case 'des':
						dieText.resetText("You already got that. How about something else.");
					case 'desron':
						dieText.resetText("bruhhhh you already bought that.");
					case 'destord':
						dieText.resetText("Out of Stock for this thing.");
					case 'frog':
						dieText.resetText("Ribbit. Ribbit. (Nothing left of this one.)");
					case 'inytor':
						dieText.resetText("ALREADY BOUGHT THAT ONE BROSKI. DID YOU FORGET??");
					case 'mades':
						dieText.resetText("YOU ALREADY HAVE THE OWNERSHIP OF THIS HERE OBJECT.");
					case 'morshu':
						dieText.resetText("Sorry Boyfriend, I don't have that anymore.");
					case 'orb':
						dieText.resetText("Orb (Nothing left.)");
					case 'sans':
						dieText.resetText("i dont have this anymore cause you took it from me.");
					case 'terry':
						dieText.resetText("....You do know you already bought that one, right???");
					case 'das':
						dieText.resetText("You have already purchased this, young one.");
					case 'wtf':
						dieText.resetText("I am muting this game! You already have thaI am muting it");
					case 'topdes':
						dieText.resetText("You Actual Fucking Troglodyte Loser");
					case 'utdes':
						dieText.resetText("its not humerus trying to get what you already bought. please leave me alone.");
					case 'shed':
						dieText.resetText("Feeeeeeeeeeeen Foooooooow! Gobbdleygook.");
					default:
						dieText.resetText("test text no item whore.");
				}
				dieText.start();
			}
        }

		if (controls.UI_UP_P)
			{
				FlxG.sound.play(Paths.sound('scrollMenu'));
				changeSelection(-1);
			}

		if (controls.UI_DOWN_P)
			{
				FlxG.sound.play(Paths.sound('scrollMenu'));
				changeSelection(1);
			}

		if (controls.UI_LEFT_P)
			{
				FlxG.sound.play(Paths.sound('scrollMenu'));
				changeMenuSelection(-1);
			}
		
		if (controls.UI_RIGHT_P)
			{
				FlxG.sound.play(Paths.sound('scrollMenu'));
				changeMenuSelection(1);
			}

		/*if (FlxG.keys.justPressed.P)
			{
				pizzaTokens += 99;
				tokenText.text = Std.string(pizzaTokens);
			}
		*/

		if (controls.BACK){
			saveWhatYouBoughtPlease();
			saveMenuTheme();
			FlxG.sound.play(Paths.sound('cancelMenu'));
			FlxG.sound.playMusic(Paths.music('freakyMenu'));
			MusicBeatState.switchState(new ExtrasMenuState());
		}

        super.update(elapsed);
    }

	function updateItemThings(){
		for (i in 0...items.length){
		if (hasBought[i]){
			var soldSprite:FlxSprite = new FlxSprite();
			soldSprite.loadGraphic(Paths.image("shop_sold"));
			soldSprite.x = 949;
			soldSprite.y = 31 + 72 * i;
			add(soldSprite);
			}
		}

		tokenText.text = Std.string(pizzaTokens);
	}

	/*
		WHAT THE [Heaven] ARE YOU LITTLE [Expired Milk] DOING IN
		IN MY
		MY [50% Off] HUMBLE [Far From Home]?!
		YOU SHOULDN'T BE [Hear] TO LOOK AT MY [Award Winning] !
		THIS [High Quality] SPAGHETTI OF [Ones and Zeros] IS NOT FOR THE AVERAGE [Shmuck] TO WITNESS!
		CLOSE YOUR [kissable] MOUTH, YOUR [kissable] EYES, YOUR , 
		AND GET THE [?$#!] OUT OF HERE!
	*/

	function saveWhatYouBoughtPlease(){
		FlxG.save.data.shopBoughtGunspray = hasBought[0];
        FlxG.save.data.shopBoughtSelfInsert = hasBought[1];
		FlxG.save.data.shopBoughtSusarray = hasBought[2];
		FlxG.save.data.shopBoughtUTM = hasBought[3];
		FlxG.save.data.shopBoughtScottM = hasBought[4];
		FlxG.save.data.shopMenusUnlocked = unlockedMenus;
		FlxG.save.data.pTokens = pizzaTokens;
		FlxG.save.flush();
	}

	function saveMenuTheme(){
		FlxG.save.data.currentMenuThemeNumber = menuSelected;
		FlxG.save.data.shopMenusUnlocked = unlockedMenus;
		FlxG.save.data.currentMenuTheme = unlockedMenus[menuSelected];
		FlxG.save.flush();
	}

	function changeSelection(huh:Int){
		curSelected += huh;
		if(curSelected >= items.length){
			curSelected = 0;
		}
		if(curSelected < 0){
			curSelected = items.length - 1;
		}	

		arrow.y = 42 + 72 * curSelected;
	}

	function changeMenuSelection(huh:Int){
		menuSelected += huh;
		if(menuSelected >= unlockedMenus.length){
			menuSelected = 0;
		}
		if(menuSelected < 0){
			menuSelected = unlockedMenus.length - 1;
		}	
		menuText.text = "Current Menu: " + unlockedMenus[menuSelected];
		saveMenuTheme();
	}

	function checkForAchievements():String{
		var howMuchYouBought:Int;
		howMuchYouBought = 0;
		for (i in 0...items.length) {
			if (hasBought[i]){
				howMuchYouBought += 1;
			}
		}
		if(howMuchYouBought >= 1 && !Achievements.isAchievementUnlocked('shop_first')) {
			Achievements.unlockAchievement('shop_first');
			return "shop_first";
		}
		if(howMuchYouBought >= items.length && !Achievements.isAchievementUnlocked('shop_all')) {
			Achievements.unlockAchievement('shop_all');
			return "shop_all";
		}
		return null;
	}

	#if ACHIEVEMENTS_ALLOWED
	var achievementObj:AchievementObject = null;
	function startAchievement(achieve:String) {
		achievementObj = new AchievementObject(achieve, camOther);
		achievementObj.onFinish = achievementEnd;
		add(achievementObj);
		trace('Giving achievement ' + achieve);
		
	}
	function achievementEnd():Void
	{
		achievementObj = null;
		if (Achievements.giveGoldenCopy()){
			Achievements.unlockAchievement('numero_uno');
			startAchievement("numero_uno");
		}
	}
	#end
}