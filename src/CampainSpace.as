package  
{
	import flash.geom.Point;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	
	/**
	 * ...
	 * @author David
	 */
	public class CampainSpace extends Space
	{
		public static var shifted : Boolean = false;
		
		public function CampainSpace() 
		{			
			add(new PlayerShip(300, 300));
			add(new EnemyShip(100, 100));	
		}
		
		override public function checkKeys():void 
		{
			// Has shift been pressed
			shifted = Input.check(Key.SHIFT);
			
			if (Input.check(Key.SPACE))
			{
				if (selectedShips)
				{
					for each(var selectedShip : Ship in selectedShips)
					{
						selectedShip.unselect()
					}
					selectedShips = null;
				}
			}
		}
		
		override public function checkClick(): void
		{
			if (Input.mouseReleased)
			{
				if (!realToCampainCoordinates(mouseX, mouseY))
				{
					// Clicked on the HUD
					
					// TODO: Add hud functionality
					return;
				}
				else
				{
					// Clicked in main play area
					var e : Ship = (collidePoint("Ship", mouseX, mouseY) as Ship);					
					if(e && shifted && e.player)
					{
						// Else if you clicked on a ship, select the ship.
						if (!selectedShips)
						{
							selectedShips = new Vector.<Ship>();
						}
						selectedShips.push(e);
						e.select();
						selectedShips.push(e);
					}
					else if (selectedShips)
					{
						// If there is a selected ship execute the seclected
						// ships click function and in move mode
						for each(selectedShip in selectedShips)
						{
							selectedShip.click(mouseX, mouseY);
						}
					}
					else if(e)
					{
						// Else if you clicked on a ship, select the ship.
						if (selectedShips)
						{
							for each(var selectedShip : Ship in selectedShips)
							{
								selectedShip.unselect();
							}
						}
						e.select();
						selectedShips = new Vector.<Ship>();
						selectedShips.push(e);
					}
					
				}
			}
		}
		
	}
	
}