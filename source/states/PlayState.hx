package states;

import entities.Player;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.util.FlxColor;

class PlayState extends FlxState
{
	private var player:Player;
	private var plataforma:FlxSprite;
	
	
	override public function create():Void
	{
		FlxG.camera.bgColor = FlxColor.ORANGE;
		player = new Player(50, 50);
		plataforma = new FlxSprite(30, 200);
		plataforma.makeGraphic(1000,24);
		plataforma.immovable = true;
		
		add(plataforma);
		add(player);
		super.create();
	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
		FlxG.collide(player, plataforma);
		
	}
}