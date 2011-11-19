package  
{
	import net.flashpunk.graphics.Image;
	
	/**
	 * ...
	 * @author David
	 */
	public class PlayerShip extends Ship
	{
		//{ region Images
		
		// The background image with side board
		[Embed (source = '../Assets/rocketBlue.png')]
		private static const ROCKET:Class
		private var rocket:Image = new Image(ROCKET);
		
		// The background image with side board
		[Embed (source = '../Assets/rocketBlueGlow.png')]
		private static const ROCKET_SELECT:Class
		private var rocketSelect:Image = new Image(ROCKET_SELECT);
		
		// The background image with side board
		[Embed (source = '../Assets/rocketBlueRedGlow.png')]
		private static const ROCKET_TARGET:Class
		private var rocketTarget:Image = new Image(ROCKET_TARGET);
		
		override public function rotate(angle:Number):void 
		{			
			super.rotate(angle);
			
			rocket.angle = 180 - facing * (180 / Math.PI);			
			rocketSelect.angle = 180 - facing * (180 / Math.PI);			
			rocketTarget.angle = 180 - facing * (180 / Math.PI);
		}
		
		//}

		public function PlayerShip(xPos:Number, yPos:Number) 
		{
			rocket.centerOO();
			rocketSelect.centerOO();
			rocketTarget.centerOO();
			
			player = true;
			
			graphic = rocket;			
			graphic.x = rocket.width / 2;
			graphic.y = rocket.height / 2;
			
			super(xPos, yPos);
		}
		
		override public function click(mouseX:Number, mouseY:Number):void 
		{				
			// Area you clicking on a ship
			var e : Ship = (world.collidePoint("Ship", mouseX, mouseY) as Ship);
			if (e)
			{
				// Clicked on a ship
				if (!e.player)
				{
					// it's not you ship so target it
					orders.addTarget(e);
					e.target();
				}
			}
			else
			{
				// Move to the position
				orders.addMove(mouseX, mouseY);
			}
			
			super.click(mouseX, mouseY);
		}
		
		
		//{ region Select and target set functions
		
		override public function select():void 
		{
			graphic = rocketSelect;			
			graphic.x = rocketSelect.width / 2;
			graphic.y = rocketSelect.height / 2;
			super.select();
		}
		
		override public function unselect():void 
		{
			graphic = rocket;			
			graphic.x = rocket.width / 2;
			graphic.y = rocket.height / 2;
			super.unselect();
		}
		
		override public function target():void 
		{
			graphic = rocketTarget;			
			graphic.x = rocketTarget.width / 2;
			graphic.y = rocketTarget.height / 2;
			super.target();
		}
		
		override public function untarget():void 
		{
			graphic = rocket;			
			graphic.x = rocket.width / 2;
			graphic.y = rocket.height / 2;
			super.untarget();
		}
		
		//}
		
	}
	
}