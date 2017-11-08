package states;

import entities.Arma;
import entities.Enemigo01;
import entities.Player;
import flixel.FlxCamera.FlxCameraFollowStyle;
import flixel.FlxObject;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.tile.FlxTilemap;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.util.FlxColor;
import flixel.addons.editors.ogmo.FlxOgmoLoader;

class PlayState extends FlxState
{
	private var player:Player;

	public var loader:FlxOgmoLoader;
	private var tilemapPiso:FlxTilemap;
	private var enemyGroup:FlxTypedGroup<Enemigo01>;
	
	override public function create():Void
	{
		super.create();
		FlxG.camera.bgColor = FlxColor.GREEN;
		player = new Player(40, 0);
		FlxG.camera.follow(player, FlxCameraFollowStyle.PLATFORMER);
		enemyGroup = new FlxTypedGroup<Enemigo01>();
		loadTileMap();
		add(tilemapPiso);
		add(player);
		add(enemyGroup);
		
	}
	
	public function loadTileMap()
	{
		loader = new FlxOgmoLoader(AssetPaths.level__oel);
		tilemapPiso = loader.loadTilemap(AssetPaths.tilesPiso__png, 32, 32, "tiles");
		tilemapPiso.setTileProperties(0, FlxObject.NONE);
		
		FlxG.worldBounds.set(0, 0, tilemapPiso.width, tilemapPiso.height);
		loader.loadEntities(entityCreator, "enemigos");
	}
	
	private function entityCreator(entityName:String, entityData:Xml)
	{
		var x:Int = Std.parseInt(entityData.get("x"));
		var y:Int = Std.parseInt(entityData.get("y"));
		
		switch (entityName) 
		{
			case "enemigo1":
				var enemigo1:Enemigo01 = new Enemigo01(x, y, AssetPaths.bandido1__png);
				enemyGroup.add(enemigo1);
		}
	}

	function checkColision() 
	{
		if (FlxG.collide(player, enemyGroup))
		{
			player.kill();
			player.arma.kill();
			FlxG.resetState();
		}
		FlxG.collide(player, tilemapPiso);
		FlxG.collide(enemyGroup, tilemapPiso);
		FlxG.overlap(player.arma, enemyGroup, collideEspadaEnemigo);
	}
	

	
	function collideEspadaEnemigo(s:Arma, e:FlxSprite) 
	{
		e.kill();
	}
	
	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
		checkColision();
	}
}