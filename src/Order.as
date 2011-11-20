package  
{
	import flash.geom.Point;
	
	/**
	 * ...
	 * @author David
	 */
	public class Order 
	{
		public var nextMove : Point;
		public var nextTarget : Ship;
		
		public function Order() 
		{
			nextMove = null;
			nextTarget = null;
		}
		
		public function move(x : Number, y : Number): void
		{
			nextMove = new Point(x, y);
		}
		
		public function reachedMoveTarget():void 
		{
			nextMove = null;
		}
		
		public function destroyedTarget():void
		{
			nextTarget = null;
		}
		
		public function addMove(tx : Number, ty : Number):void 
		{
			nextMove = new Point(tx, ty);
		}
		
		public function addTarget(t : Ship, aimer: Ship):void 
		{
			nextTarget = t;
			t.targetedBy.push(aimer);
		}
		
	}
	
}