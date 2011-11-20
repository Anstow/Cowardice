package  
{
	import flash.geom.Point;
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.Graphic;
	import net.flashpunk.graphics.Graphiclist;
	import net.flashpunk.graphics.Image;
	
	/**
	 * ...
	 * @author David
	 */
	public class Ship extends Entity
	{
		//{ region Base values
		
		// The Strength of the ship
		public var baseIntegrity : Number;
		// Maximum Crew
		public var maxCrew : Number;
		// The automomy of the system
		public var autonomy : Number;
		// Base cool down in frames
		public var baseCooldown : Number;
		// Base firepower before damage
		public var maxFirepower : Number;
		// Max Range
		public var maxRange: Number;
		// Base repair speed
		public var baseRepair : Number;
		// Players Ship
		public var player : Boolean;
		// Base speed
		public var maxSpeed : Number;
		// Max Rotation
		public var maxAgility : Number;
		// base Accaracy percentage
		public var baseAccuracy : Number;
		
		//}
		
		//{ region Derived Values
		
		// Current Crew actual value
		public var population : Number;
		
		// Strength of the system or damage the ship has sustained between 0,1
		public var systemStrength : Number;
		// Current cool down in frames
		public var coolDown : Number;
		// Current firepower between 0,1
		public var firepower : Number;
		// Current repair Speed between 0,1
		public var repair : Number;
		// Current range
		public var range : Number;
		// speed
		public var Speed : Number;
		// Rotation
		public var agility : Number;
		// Accuracy
		public var accuracy : Number;
		
		//}		
		
		//{ region Running values
		
		// Whether the ship is selected
		protected var selected : Boolean;
		protected var targeted : Boolean;
		public var currentGraphic : Graphiclist;
		
		public var targetedBy : Vector.<Ship>;
		
		public var orders : Order;
		// The facing in radians, 0 left positive (use - sin)
		public var facing : Number;
		
		// Time in frames since last fire
		public var fireTime : Number;
		
		//}
				
		public function Ship(xPos:Number, yPos:Number) 
		{
			baseIntegrity = 1000;
			maxCrew = 1000;
			population = maxCrew;
			autonomy = 0.2;
			baseRepair = 0.001;
			maxFirepower = 100;
			maxSpeed = 1;
			maxAgility = Math.PI / 240; 
			maxRange = 300;
			baseAccuracy = 50;
			baseCooldown = 120;
			
			targeted = false;
			targetedBy = new Vector.<Ship>();
			
			facing = 0;
			rotate(0);
			x = xPos;
			y = yPos;
			type = "Ship";
			
			setHitbox(64, 64, 32, 32);
			
			orders = new Order();
			
			currentGraphic = new Graphiclist();
			currentGraphic.add(new Graphic());
			currentGraphic.children[0].visible = true;
			currentGraphic.add(new Graphic());
			
			updateStrengths();
			
			currentGraphic.children[0].visible = false;
			
			graphic = currentGraphic;
		}
		
		//{ region Update Functions
		
		override public function update():void 
		{
			super.update();
			move();
			Repair();
			fire();
		}
		
		public function Repair():void 
		{
			systemStrength += (1 - systemStrength) * repair;
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
		
		public function fire():void 
		{
			fireTime++;
			if (fireTime > coolDown)
			{
				fireTime = 0;
				
				if (FP.distanceRects(originX, originY, width, height, orders.nextTarget.originX, orders.nextTarget.originY, orders.nextTarget.width, orders.nextTarget.height) < range)
				{
					if (accuracy > FP.rand(100))
					{
						accuracy += 1.002;
						orders.nextTarget.damage(firepower);
					}
				}
			}
		}
		
		public function click(mouseX:Number, mouseY:Number):void 
		{
			
		}
		
		//}
		
		//{ region Movement AI
		
		public function avoidence():void 
		{
			
		}
		
		//}
		
		//{ region Helper Functions
		
		public function updateStrengths() : void
		{
			repair = baseRepair * (autonomy * systemStrength + (1 - autonomy) * (population / maxCrew));
			firepower = maxFirepower * (autonomy * systemStrength + (1 - autonomy) * (population / maxCrew));
			
			// TODO : add dependence on damage
			Speed = maxSpeed;
			agility = maxAgility;
			accuracy = baseAccuracy;
			coolDown = baseCooldown;
			
			var newR : Number = maxRange;
			if (newR != range)
			{
				// If the range has changed
				range = maxRange;
				
				// Make the range circle the correct size
				currentGraphic.children[0] = Image.createCircle(range, 0xFF0000, 0.5);
				currentGraphic.children[0].x = -range;
				currentGraphic.children[0].y = -range;
				
				// Makes sure the visible property is correct
				currentGraphic.children[0].visible = selected;			
			}
		}
		
		public function damage(p:Number):void
		{
			// The amount of damage the ship sustains
			var d : Number = p / baseIntegrity;
			// Hurts the population and system strength
			population *= (1 - d);
			systemStrength *= (1 - d);
			
			if (population < maxCrew / 10 || systemStrength < 0.1)
			{
				Destroy();
				return;
			}
			
			updateStrengths();
		}
		
		public function Destroy():void 
		{
			world.remove(this);
			for each (var t : Ship in targetedBy)
			{
				t.orders.destroyedTarget();
			}
		}
		
		/**
		 * Rotate the ship
		 * @param	angle: Tha angle in radians to rotate by
		 */
		public function rotate(angle:Number):void 
		{
			facing += angle;
			
			facing %= 2 * Math.PI;
			
			if (facing > Math.PI)
			{
				facing = facing - 2 * Math.PI;
			}
			else if (facing < -Math.PI)
			{
				facing = facing + 2 * Math.PI;
			}
		}
		
		//}
		
		//{ region Select and target set functions
		
		public function select():void 
		{
			selected = true;
			currentGraphic.children[0].visible = true;
			
			if (orders.nextTarget)
			{
				orders.nextTarget.target();
			}
		}
		
		public function unselect():void 
		{
			selected = false;
			currentGraphic.children[0].visible = false;
			
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