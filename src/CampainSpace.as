package  
{
	import flash.geom.Point;
	
	/**
	 * ...
	 * @author David
	 */
	public class CampainSpace extends Space
	{
		
		public function CampainSpace() 
		{
			
		}
		
		
		override public function realToCampainCoordinates(spaceX:Number, spaceY:Number):Point 
		{
			return super.realToCampainCoordinates(spaceX, spaceY);
		}
		
	}
	
}