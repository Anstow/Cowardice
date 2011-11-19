package  
{
	import net.flashpunk.World;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;
	
	/**
	 * ...
	 * @author David
	 */
	public class TitleScreen extends World
	{
		
		// The background image of stars
		[Embed (source = '../Assets/Stars.png')]
		private static const BACKGROUND:Class
		private var background:Image = new Image(BACKGROUND);
		
		public function TitleScreen() 
		{
			// Add's the background
			addGraphic(background);
			// TODO: In final version either increase alarm or change to on click
			FP.alarm(0.5, moveToMenu);
		}
		
		// Disposes of the element's in the world then set's the world to the menu (or game if the menu doesn't exist)
		public function moveToMenu():void
		{
			// Removes all the entities from the world
			removeAll();

			// TODO: Move on to the menu rather than the game
			FP.world = new CampainSpace();
		}
		
		
		
	}
	
}