package entities;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.util.FlxColor;

/**
 * ...
 * @author Hogner
 */

enum Estados
{
	IDLE;
	JUMP;
	RUN;
	CROUCH;
}
 
class Player extends FlxSprite 
{
	private var estadoActual(get, null):Estados;

	public function new(?X:Float=0, ?Y:Float=0, ?SimpleGraphic:FlxGraphicAsset) 
	{
		super(X, Y, SimpleGraphic);
		makeGraphic(24, 48, FlxColor.CYAN);
		
		acceleration.y = 1200;
		estadoActual = Estados.IDLE;
	}
	
	override public function update(elapsed:Float):Void 
	{
		stateMachine();
		super.update(elapsed);
	}
	
	private function stateMachine():Void
	{
		switch (estadoActual)
		{
			case Estados.IDLE:
				moverX();
				moverY();				
				if (velocity.y != 0) 
					estadoActual = Estados.JUMP;
				if (velocity.x != 0) 
					estadoActual = Estados.RUN;
				if (FlxG.keys.pressed.DOWN)
					estadoActual = Estados.CROUCH;
			case Estados.RUN:
				moverX();
				moverY();
				if (velocity.y != 0)
					estadoActual = Estados.JUMP;
				if (velocity.x == 0) 
					estadoActual = Estados.IDLE;
				if (FlxG.keys.pressed.DOWN)
					estadoActual = Estados.CROUCH;
			case Estados.JUMP:
				if (velocity.y == 0 && isTouching(FlxObject.FLOOR))
				{
					if (velocity.x == 0)
						estadoActual = Estados.IDLE;
					else
						estadoActual = Estados.RUN;
				}
			case Estados.CROUCH:
				moverX();
				moverY();
				
				if (velocity.y > 0)
					estadoActual = Estados.JUMP;
				if (velocity.x != 0)
					estadoActual = Estados.RUN;
				else if (velocity.x == 0)
					estadoActual = Estados.IDLE;
		}
	}
	
	private function moverX():Void
	{
		velocity.x = 0;
		
		if (FlxG.keys.pressed.RIGHT)
			velocity.x = 120;
		if (FlxG.keys.pressed.LEFT) 
			velocity.x = -120;
		
		if (velocity.x < 0) 
			facing = FlxObject.LEFT;
		if (velocity.x > 0) 
			facing = FlxObject.RIGHT;
	}
	
	private function moverY():Void
	{
		if (FlxG.keys.pressed.UP && isTouching(FlxObject.FLOOR))
			velocity.y = -320;
	}
	
	function get_estadoActual():Estados 
	{
		return estadoActual;
	}
}