package  
{
	import net.flashpunk.graphics.*;
	
	/**
	 * Elements on the level's grid that the user interacts with to play the game.
	 */
	public class Tile extends Button
	{
		//colors possible for use
		public static const COLORS:Array = new Array(	0xFFFFFF, 0x000000,
														0xFF0000, 0x00FF00, 0x0000FF);
		
		private var _colorIndex:int;	//index for the color of tile
		
		public var tileX:int;			//x index of tile on grid
		public var tileY:int;			//y index of tile on grid
		
		/**
		 * Index for the color of the tile based on Tile.COLORS.
		 * Tile's graphic updates automatically when this is changed.
		 */
		public function get colorIndex():int { return _colorIndex; }
		public function set colorIndex(value:int):void
		{
			_colorIndex = value;
			updateColorGraphic();
		}
		
		/**
		 * Constructor.
		 * @param	color		Index for the color of the Tile.
		 * @param	x			X position to place the Tile.
		 * @param	y			Y position to place the Tile.
		 * @param	width		Width of the Tile.
		 * @param	height		Height of the Tile.
		 */
		public function Tile(colorIndex:int, x:Number = 0, y:Number = 0, width:Number = 0, height:Number = 0)
		{
			_colorIndex = colorIndex;
			var rect:Image = Image.createRect(width, height, COLORS[colorIndex]);
			super(rect, x, y, width, height);
		}
		
		/**
		 * Add a reference for index of tile on the grid.
		 * @param	tileX		Index of x position on grid.
		 * @param	tileY		Index of y position on grid.
		 */
		public function setGridPosition(tileX:int, tileY:int):void 
		{
			this.tileX = tileX;
			this.tileY = tileY;
		}
		
		/**
		 * Update the tile's graphic to reflect a changed color index.
		 */
		private function updateColorGraphic():void 
		{
			var rect:Image = Image.createRect(width, height, COLORS[colorIndex]);
			setGraphic(rect, width, height);
		}
	}
}