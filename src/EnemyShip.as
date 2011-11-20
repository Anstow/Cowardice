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
			
			player = false;
			
			super(xPos, yPos);
			
			currentGraphic.children[1] = rocket;
		}
		
		//{ region Select and target set functions
		
		override public function select():void 
		{
			currentGraphic.children[1] = rocketSelect;
			super.select();
		}
		
		override public function unselect():void 
		{
			currentGraphic.children[1] = rocket;
			super.unselect();
		}
		
		override public function target():void 
		{
			currentGraphic.children[1] = rocketTarget;
			super.target();
		}
		
		override public function untarget():void 
		{
			currentGraphic.children[1] = rocket;
			super.untarget();
		}
		
		//}
		
	}
	
}