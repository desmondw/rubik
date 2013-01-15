package  
{
	import net.flashpunk.World;

	public class Level extends World
	{
		//grid graphical setup
		private const GAME_AREA_WIDTH:Number = 400;												//width of playing area
		private const GAME_AREA_HEIGHT:Number = 400;											//height of playing area
		private const GAME_AREA_X:Number = Main.SCREEN_WIDTH / 2 - GAME_AREA_WIDTH / 2;			//x position of playing area
		private const GAME_AREA_Y:Number = Main.SCREEN_HEIGHT / 2 - GAME_AREA_HEIGHT / 2;		//y position of playing area
		private const TILE_SPACING:Number = 5;													//space between tiles
		
		//tiles
		private var _tiles:Array;		//level data
		private var _numColors:int;		//how many colors the tiles can be
		private var _numTiles:int;		//how many tiles wide/high the game is
		
		public function Level() 
		{
			//TODO: temp
			_numTiles = 6;
			_numColors = 2;
			
			initializeEntities();
		}
		
		//set up game objects / graphics
		private function initializeEntities():void 
		{
			//background
			
			
			//{ GAME ELEMENTS
			
			//{{ TILES
			
			_tiles = new Array();
			
			var tileWidth:Number = (GAME_AREA_WIDTH / _numTiles) - TILE_SPACING; //how wide each tile is
			var tileHeight:Number = (GAME_AREA_HEIGHT / _numTiles) - TILE_SPACING; //how high each tile is
			
			//temp vars
			var tilesColumn:Array;
			var tileX:Number;
			var tileY:Number;
			var tile:Tile;
			
			//generate full grid of tiles
			for (var i:int = 0; i < _numTiles; i++)
			{
				tilesColumn = new Array();
				
				for (var j:int = 0; j < _numTiles; j++)
				{
					tileX = GAME_AREA_X + (tileWidth + TILE_SPACING) * i;
					tileY = GAME_AREA_Y + (tileHeight + TILE_SPACING) * j;
					
					tile = new Tile(0, tileX, tileY, tileWidth, tileHeight); //create tile with a default color index of 0
					tile.setGridPosition(i, j);
					tile.onClick(tileClicked);
					
					tilesColumn.push(tile);
					add(tile);
				}
				
				_tiles.push(tilesColumn);
			}
			
			//}}
			
			//}
			
			
			//ui
			
		}
		
		override public function update():void 
		{
			super.update();
			
		}
		
		/**
		 * Event handler for clicking tiles.
		 * @param	tile		The tile that was clicked.
		 */
		private function tileClicked(tile:Tile):void 
		{
			//flip tile
			flipTile(_tiles[tile.tileX][tile.tileY]);
			
			//flip tile above
			if (tile.tileY > 0)
				flipTile(_tiles[tile.tileX][tile.tileY - 1]);
			
			//flip tile below
			if (tile.tileY < _numTiles - 1)
				flipTile(_tiles[tile.tileX][tile.tileY + 1]);
			
			//flip tile left
			if (tile.tileX > 0)
				flipTile(_tiles[tile.tileX - 1][tile.tileY]);
			
			//flip tile right
			if (tile.tileX < _numTiles - 1)
				flipTile(_tiles[tile.tileX + 1][tile.tileY]);
		}
		
		/**
		 * Changes tile color to the next color in the rotation.
		 * @param	tile		Tile to be flipped.
		 */
		private function flipTile(tile:Tile):void 
		{
			if (tile.colorIndex == _numColors - 1) //last color of rotation
				tile.colorIndex = 0;
			else
				tile.colorIndex++;
		}
	}
}