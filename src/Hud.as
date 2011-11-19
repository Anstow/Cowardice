package  
{
	import net.flashpunk.Entity;
	import net.flashpunk.Graphic;
	import net.flashpunk.graphics.Image;
	
	/**
	 * ...
	 * @author David
	 */
	public class Hud extends Entity
	{
		
		// The background image with side board
		[Embed (source = '../Assets/hud.png')]
		private static const HUD:Class
		private var hud:Image = new Image(HUD);
		
		public function Hud() 
		{
			layer = -5;
			var temp: Graphic = hud;
			temp.scrollX = 0;
			temp.scrollY = 0;
			addGraphic(temp);
		}
		
		public function clickLeft(xPos:Number, yPos:Number):void
		{
			
		}
		
		public function clickRight(xPos:Number, yPos:Number):void 
		{
			
		}
	}
	
}