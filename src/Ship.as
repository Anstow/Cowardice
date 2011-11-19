package  
{
	import flash.geom.Point;
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
	
	/**
	 * ...
	 * @author David
	 */
	public class Ship extends Entity
	{
		//{ region Base values
		
		// Maximum Crew
		public var maxCrew : Number;
		// The automomy of the system
		public var autonomy : Number;
		// Base firepower before damage
		public var maxFirepower : Number;
		// Base repair speed
		public var baseRepair : Number;
		// Players Ship
		public var player : Boolean;
		// Base speed
		public var Speed : Number;
		
		//}
		
		//{ region Derived Values
		
		// Current Crew actual value
		public var population : Number;
		
		// Strength of the system or damage the ship has sustained between 0,1
		public var systemStrength : Number;
		// Current firepower between 0,1
		public var firepower : Number;
		// Current repair Speed between 0,1
		public var repair : Number;
		
		//}		
		
		//{ region Running values
		
		// Whether the ship is selected
		protected var selected : Boolean;
		protected var targeted : Boolean;
		public var orders : Order;
		
		//}
		
		public function Ship(xPos:Number, yPos:Number) 
		{
			maxCrew = 1000;
			population = maxCrew;
			autonomy = 0.2;
			baseRepair = 0.001;
			maxFirepower = 100;
			Speed = 1;
			targeted = false;
			
			x = xPos;
			y = yPos;
			type = "Ship";
			
			setHitbox(64, 64, 0, 0);
			
			orders = new Order();
			
			updateStrengths();
		}
		
		override public function update():void 
		{
			super.update();
			updateStrengths();
			move();
		}
		
		public function move():void 
		{
			if (orders.nextMove != null)
			{
				var dirX : Number = orders.nextMove.x - x;
				var dirY : Number = orders.nextMove.y - y;
				
				var abs : Number = Math.sqrt(dirX * dirX + dirY * dirY);
				if (abs <= Speed)
				{
					orders.reachedMoveTarget();
					return;
				}
				else
				{
					dirX *= Speed / abs;
					dirY *= Speed / abs;
					
					x += dirX;
					y += dirY;
				}
				
			}
		}
		
		public function updateStrengths() : void
		{
			repair = baseRepair * (autonomy * systemStrength + (1 - autonomy) * (population / maxCrew));
			firepower = maxFirepower * (autonomy * systemStrength + (1 - autonomy) * (population / maxCrew));
			systemStrength = systemStrength * repair * (autonomy * systemStrength + (1 - autonomy) * (population / maxCrew));
		}
		
		public function click(mouseX:Number, mouseY:Number):void 
		{
			
		}
		
		//{ region Movement AI
		
		public function avoidence():void 
		{
			
		}
		
		//}
		
		//{ region Select and target set functions
		
		public function select():void 
		{
			selected = true;
			if (orders.nextTarget)
			{
				orders.nextTarget.target();
			}
		}
		
		public function unselect():void 
		{
			selected = false;
			if (orders.nextTarget)
			{
				orders.nextTarget.untarget();
			}
		}
		
		public function target():void 
		{
			targeted = true;
		}
		
		public function untarget():void 
		{
			targeted = false;
		}
		
		//}
		
	}
	
}