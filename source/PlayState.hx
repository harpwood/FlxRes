package;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.tweens.FlxTween;

/**
 * Feel free to complete remove or replace this Class with your own.
 * This file does not contain any FlxRes code
 */
class PlayState extends FlxState
{
	private final TILE_SIZE:Int = 32;
	private var statusText:FlxText;
	private var character:FlxSprite;

	var c = -1;

	override public function create()
	{
		super.create();

		statusText = new FlxText(0, 0, FlxG.width, "Hello from HaxeFlixel");
		statusText.alignment = "center";
		add(statusText);

		placeBackGround();
		placeGround();
		placeCharacter();
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);
	}

	function placeBackGround()
	{
		var bg1:FlxSprite = new FlxSprite();
		bg1.loadGraphic("assets/images/bg1.png");
		bg1.offset.y = bg1.height;
		bg1.y = FlxG.height - TILE_SIZE;
		add(bg1);

		// if the bg1 does not cover the stage add another bg next to bg1
		if (bg1.width < FlxG.width)
		{
			var bg2:FlxSprite = new FlxSprite();
			bg2.loadGraphic("assets/images/bg2.png");
			bg2.offset.y = bg2.height;
			bg2.x = bg1.width;
			bg2.y = FlxG.height - TILE_SIZE;
			add(bg2);

			// for sake of an exaggerated example lets add another bg after bg1 and bg2 (crazy wide aspect ratio)
			if ((bg1.width + bg2.width) < FlxG.width)
			{
				var bg3:FlxSprite = new FlxSprite();
				bg3.loadGraphic("assets/images/bg1.png");
				bg3.offset.y = bg3.height;
				bg3.x = bg1.width + bg2.width;
				bg3.y = FlxG.height - TILE_SIZE;
				add(bg3);
			}
		}
	}

	function placeGround()
	{
		var numberOfTiles:Int = Math.ceil(FlxG.width / TILE_SIZE);

		var asset:String = "assets/images/ground.png";

		for (i in 0...numberOfTiles)
		{
			var tile:FlxSprite = new FlxSprite(i * TILE_SIZE, FlxG.height - TILE_SIZE - 1, asset);
			add(tile);
		}
	}

	function placeCharacter()
	{
		character = new FlxSprite();
		character.loadGraphic("assets/images/walk.png", true, 45, 51);
		character.animation.add("walk", [0, 1, 2, 3], 5);
		character.animation.play("walk");
		character.offset.y = character.height;
		character.x = 0;
		character.y = FlxG.height - TILE_SIZE - 1;
		character.setFacingFlip(FlxObject.LEFT, false, false);
		character.setFacingFlip(FlxObject.RIGHT, true, false);
		add(character);

		forward();
	}

	function backward(tween:FlxTween)
	{
		character.facing = FlxObject.RIGHT;
		FlxTween.tween(character, {x: 0}, 6, {onComplete: forward});
	}

	function forward(?tween:FlxTween)
	{
		character.facing = FlxObject.LEFT;
		FlxTween.tween(character, {x: FlxG.width - character.width}, 6, {onComplete: backward});
	}
}
