package entities;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.util.FlxColor;

/**
 * ...
 * @author ...
 */
class Arma extends FlxSprite 
{

	public function new(?X:Float=0, ?Y:Float=0, ?SimpleGraphic:FlxGraphicAsset) 
	{
		super(X, Y, SimpleGraphic);
		loadGraphic(AssetPaths.espada__png, true, 50, 10);
		animation.add("ataca", [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14], 60);
		animation.play("ataca");
	}
	override public function update(elapsed:Float):Void 
	{
		
		super.update(elapsed);
	}
}