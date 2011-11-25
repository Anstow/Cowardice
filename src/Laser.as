package  
{
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.utils.Draw;
	
	/**
	 * ...
	 * @author David
	 */
	public class Laser extends Entity
	{
		private var x1 : Number;
		private var x2 : Number;
		private var y1 : Number;
		private var y2 : Number;
		
		public function Laser(xBegin : Number, yBegin : Number, xEnd : Number, yEnd : Number) 
		{
			x1 = xBegin;
			x2 = xEnd;
			y1 = yBegin;
			y2 = yEnd;
			
			// TODO: Add laser sound affect
			
			FP.alarm(0.1, remove);
		}
		
		public function remove():void 
		{
			FP.world.remove(this);
		}
		
		override public function render():void 
		{
			Draw.linePlus(x1, y1, x2, y2, 0xFFFF0000, 1, 4);
			
			super.render();
		}
		
	}
	
}