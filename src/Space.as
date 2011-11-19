package  
{
	import flash.geom.Point;
	import net.flashpunk.Graphic;
	import net.flashpunk.utils.Input;
	import net.flashpunk.World;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;
	
	/**
	 * ...
	 * @author David
	 */
	public class Space extends World
	{
		public var hud : Hud;
		
		//The selected ship
		public var selectedShips : Vector.<Ship>;
		
		// The background image with side board
		[Embed (source = '../Assets/Stars.png')]
		private static const BACKGROUND:Class
		private var background:Image = new Image(BACKGROUND);
		
		public function Space() 
		{
			// Add's the background
			var temp: Graphic = background;
			temp.scrollX = 0;
			temp.scrollY = 0;
			addGraphic(temp);
			
			hud = new Hud();
			add(hud);
		}
		
		// Disposes of the element's in the world then set's the world to the menu (or game if the menu doesn't exist)
		public function moveToMenu():void
		{
			// Removes all the entities from the world
			removeAll();

			// TODO: Move on to the menu rather than the game
			FP.world = new TitleScreen();
		}
		
		override public function update():void 
		{
			checkKeys();
			checkClick();
			super.update();
		}
		
		public function checkClick(): void
		{
			
		}
		
		public function checkKeys():void
		{
			
		}
		

		public function realToCampainCoordinates(realX : Number, realY : Number):Boolean 
		{
			if (realX >= 650)
			{
				hud.clickLeft(realX - 650, realY);
				return false;
			}
			return true;
		}
		
		//{ region rectangle vector functions
		
		/**
		 * Finds the vector from a point to a rectangle.
		 * @param	px: The x position of the point.
		 * @param	py: The y position of the point.
		 * @param	rx: The x position of the rectangle.
		 * @param	ry: The x position of the rectangle.
		 * @param	rw: The width of the rectangle.
		 * @param	rh: The height of the rectangle.
		 * @return A point class with the vector from the point to the rectangle.
		 */
		public static function vectorPointToRect(px:Number, py:Number, rx:Number, ry:Number, rw:Number, rh:Number):Point
		{
			if (px >= rx && px <= rx + rw)
			{
				if (py >= ry && py <= ry + rh) return new Point(0,0);
				if (py > ry) return new Point(0, (ry + rh) - py);
				return new Point(0, ry - py);
			}
			if (py >= ry && py <= ry + rh)
			{
				if (px > rx) return new Point ((rx + rw) - px, 0);
				return new Point(rx - px, 0);
			}
			if (px > rx)
			{
				if (py > ry) return new Point ((rx + rw) - px, (ry + rh) - py);
				return new Point ((rx + rw) - px, ry - py);
			}
			if (py > ry) return new Point (rx - px, (ry + rh) - py);
			return new Point (rx - px, ry - py);
		}
		
		/**
		 * Finds the vector from a rectagle(1) to a rectangle(2).
		 * @param	x1: The x position of the rectangle(1).
		 * @param	y1: The y position of the rectangle(1).
		 * @param	w1: The width of the rectangle(1).
		 * @param	h1: The height of the rectangle(1).
		 * @param	x2: The x position of the rectangle(2).
		 * @param	y2: The y position of the rectangle(2).
		 * @param	w2: The width of the rectangle(2).
		 * @param	h2: The height of the rectangle(2).
		 * @return
		 */
		public static function vectorRects(x1:Number, y1:Number, w1:Number, h1:Number, x2:Number, y2:Number, w2:Number, h2:Number):Point
		{
			if (x1 < x2 + w2 && x2 < x1 + w1)
			{
				if (y1 < y2 + h2 && y2 < y1 + h1) return new Point(0,0);
				if (y1 > y2) return new Point(0, y1 - (y2 + h2));;
				return new Point(0, y2 - (y1 + h1));
			}
			if (y1 < y2 + h2 && y2 < y1 + h1)
			{
				if (x1 > x2) return new Point(x1 - (x2 + w2), 0);
				return new Point(x2 - (x1 + w1), 0);
			}
			if (x1 > x2)
			{
				if (y1 > y2) return new Point ((x2 + w2) - x1, (y2 + h2) - y1);
				return new Point ((x2 + w2) - x1, y2 - (y1 + h1));
			}
			if (y1 > y2) return new Point (x2 - (x1 + w1), (y2 + h2) - y1);
			return new Point (x2 - (x1 + w1), y2 - (y1 + h1));
		}
		
		//}
		
	}
	
}