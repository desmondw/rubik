package  
{
	import net.flashpunk.graphics.*;
	
	/**
	 * Button on the edge of the screen used to affect whole columns/rows of tiles.
	 */
	public class EdgeButton extends Button
	{
		public var index:int;	//what index the edge button is at in the array for an edge
		
		/**
		 * Constructor.
		 * @param	x			X location of button.
		 * @param	y			Y location of button.
		 * @param	width		Width of button.
		 * @param	height		Height of button.
		 */
		public function EdgeButton(x:Number = 0, y:Number = 0, width:Number = 0, height:Number = 0)
		{
			var rect:Image = Image.createRect(width, height);
			super(rect, x, y, width, height);
		}
	}
}