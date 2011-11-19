package  
{
	import net.flashpunk.graphics.Image;
	
	/**
	 * ...
	 * @author David
	 */
	public class EnemyShip extends Ship
	{
		//{ region Images
		
		// The background image with side board
		[Embed (source = '../Assets/rocketRed.png')]
		private static const ROCKET:Class
		private var rocket:Image = new Image(ROCKET);
		
		// The background image with side board
		[Embed (source = '../Assets/rocketRedGlow.png')]
		private static const ROCKET_SELECT:Class
		private var rocketSelect:Image = new Image(ROCKET_SELECT);
		
		// The background image with side board
		[Embed (source = '../Assets/rocketRedRedGlow.png')]
		private static const ROCKET_TARGET:Class
		private var rocketTarget:Image = new Image(ROCKET_TARGET);
		
		//}
		
		public function EnemyShip(xPos:Number, yPos:Number) 
		{
			player = false;
			addGraphic(rocket);
			super(xPos, yPos);
		}
		
		//{ region Select and target set functions
		
		override public function select():void 
		{
			graphic = rocketSelect;
			super.select();
		}
		
		override public function unselect():void 
		{
			graphic = rocket;
			super.unselect();
		}
		
		override public function target():void 
		{
			graphic = rocketTarget;
			super.target();
		}
		
		override public function untarget():void 
		{
			graphic = rocket;
			super.untarget();
		}
		
		//}
	}
	
}