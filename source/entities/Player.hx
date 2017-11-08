package entities;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.util.FlxColor;
import entities.Arma;

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
	ATACANDO;
	MUERTO;
}
 
class Player extends FlxSprite 
{
	private var estadoActual(get, null):Estados;
	public var arma(get, null):Arma;
	private var timer:Float;
	
	public function new(?X:Float=0, ?Y:Float=0, ?SimpleGraphic:FlxGraphicAsset) 
	{
		super(X, Y, SimpleGraphic);
		makeGraphic(24, 48, FlxColor.CYAN);
		acceleration.y = 1200;
		estadoActual = Estados.IDLE;
		arma = new Arma(0, 0);
		FlxG.state.add(arma);
		arma.kill();
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
				arma.kill();
				moverX();
				moverY();
				if (velocity.y != 0) 
					estadoActual = Estados.JUMP;
				if (velocity.x != 0) 
					estadoActual = Estados.RUN;
				if (FlxG.keys.pressed.DOWN)
					estadoActual = Estados.CROUCH;
				if (FlxG.keys.justPressed.Z) 
					estadoActual = Estados.ATACANDO;
				if (!this.alive)
					estadoActual = Estados.MUERTO;
			case Estados.RUN:
				moverX();
				moverY();
				if (velocity.y != 0)
					estadoActual = Estados.JUMP;
				if (velocity.x == 0) 
					estadoActual = Estados.IDLE;
				if (FlxG.keys.pressed.DOWN)
					estadoActual = Estados.CROUCH;
				if (FlxG.keys.justPressed.Z) 
					estadoActual = Estados.ATACANDO;
				if (!this.alive)
					estadoActual = Estados.MUERTO;
			case Estados.JUMP:
				if (velocity.y == 0 && isTouching(FlxObject.FLOOR))
				{
					if (velocity.x == 0)
						estadoActual = Estados.IDLE;
					else
						estadoActual = Estados.RUN;
				}
				if (velocity.y != 0) 
				{
					if (FlxG.keys.justPressed.Z)
						estadoActual = Estados.ATACANDO;
				}
				if (!this.alive)
					estadoActual = Estados.MUERTO;
			case Estados.CROUCH:
				moverX();
				moverY();
				
				if (velocity.y > 0)
					estadoActual = Estados.JUMP;
				if (velocity.x != 0)
					estadoActual = Estados.RUN;
				else if (velocity.x == 0)
					estadoActual = Estados.IDLE;
			case Estados.ATACANDO:
				if (!this.alive)
					estadoActual = Estados.MUERTO;
				if (this.facing == FlxObject.LEFT) 
				{	
					arma.flipX = true;
					setWeaponPosition(this.x-this.width-24,this.y+this.height/2);
				}
				if (this.facing == FlxObject.RIGHT) 
				{	
					arma.flipX = false;
					setWeaponPosition(this.x+this.width, this.y+this.height/2);
				}
				arma.revive();
				if (arma.animation.curAnim.curFrame == 13)
					estadoActual = Estados.IDLE;
			case Estados.MUERTO:
				arma.kill();
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
			velocity.y = -450;
	}
	
	function get_estadoActual():Estados 
	{
		return estadoActual;
	}
	
	private function setWeaponPosition(playerX:Float, playerY:Float)
	{
		arma.x = playerX;
		arma.y = playerY;
	}
	
	function get_arma():Arma 
	{
		return arma;
	}
}