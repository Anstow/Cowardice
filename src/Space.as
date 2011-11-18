package  
{
	import net.flashpunk.World;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;
	
	/**
	 * ...
	 * @author David
	 */
	public class Space extends World
	{
		
		// The background image with side board
		[Embed (source = '../Assets/StarsBoard150.png')]
		private static const BACKGROUND:Class
		private var background:Image = new Image(BACKGROUND);
		
		public function Space() 
		{
			// Add's the background
			addGraphic(background);
		}
		
		// Disposes of the element's in the world then set's the world to the menu (or game if the menu doesn't exist)
		public function moveToMenu():void
		{
			// Removes all the entities from the world
			removeAll();

			// TODO: Move on to the menu rather than the game
			FP.world = new Space();
		}
		
	}
	
}