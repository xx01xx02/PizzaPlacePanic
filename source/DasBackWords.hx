package;

import flixel.FlxText;
import flixel.FlxG;
import flixel.math.FlxRandom;

class Player extends FlxText
{
    var isLeft:Bool = false;
    var speed:Int;
    public function new(pText:String = "nothing much")
    {
        super(0, 0, 0, pText);
        wordWrap = false;
        autoSize = true;
        size = FlxRandom.int(8, 24);
        isLeft = FlxRandom.bool();
        speed = FlxRandom.int(5, 20);
        if(!isLeft){
            this.x = FlxG.width + this.width + 10;
        }
        else{
            this.x = -this.width;
        }
        this.y = FlxRandom.int(0, FlxG.height - this.size);
    }
    
    public function startSchmooving()
    {
        if(isLeft){
            if(this.x > FlxG.width){
                this.destroy();
            }
            else{
                this.x += speed;
            }
        }
        else{
            if(this.x < 0 - this.width){
                this.destroy();
            }
            else{
                this.x -= speed;
            } 
        }
    }
}