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
		
		override public function rotate(angle:Number):void 
		{			
			super.rotate(angle);
			
			rocket.angle = 180 - facing * (180 / Math.PI);			
			rocketSelect.angle = 180 - facing * (180 / Math.PI);			
			rocketTarget.angle = 180 - facing * (180 / Math.PI);
		}
		
		//}
		
		public function EnemyShip(xPos:Number, yPos:Number) 
		{
			player = false;
			
			rocket.centerOO();
			rocketSelect.centerOO();
			rocketTarget.centerOO();
			
			player = true;
			
			graphic = rocket;			
			graphic.x = rocket.width / 2;
			graphic.y = rocket.height / 2;
			
			super(xPos, yPos);
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