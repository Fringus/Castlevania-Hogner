package entities;

import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.util.FlxColor;

/**
 * ...
 * @author ...
 */
class Enemigo01 extends FlxSprite 
{

	public function new(?X:Float=0, ?Y:Float=0, ?SimpleGraphic:FlxGraphicAsset) 
	{
		super(X, Y, SimpleGraphic);
		makeGraphic(32, 32, FlxColor.PURPLE);
	}
	override public function update(elapsed:Float):Void 
	{
		moverX();
		moverY();
		saltar();
		super.update(elapsed);
	}
	
	function saltar() 
	{
		if (isTouching(FlxObject.LEFT)) 
		{
			velocity.y = -3000;
		}
	}
	
	function moverY() 
	{
		if (!isTouching(FlxObject.FLOOR)) 
			velocity.y = 100;
		if (velocity.y > 0) 
		{
			velocity.x = -50;
		}
	}
	
	function moverX() 
	{
		if (isTouching(FlxObject.FLOOR))
			velocity.x = -60;
			
	}
}