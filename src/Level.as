package  
{
	import net.flashpunk.*;
	import net.flashpunk.utils.*;
	import net.flashpunk.graphics.*;

	/**
	 * An individual level for the game.
	 */
	public class Level extends World
	{
		//grid graphical setup
		private const GAME_AREA_WIDTH:Number = 400;												//width of playing area
		private const GAME_AREA_HEIGHT:Number = 400;											//height of playing area
		private const GAME_AREA_X:Number = Main.SCREEN_WIDTH / 2 - GAME_AREA_WIDTH / 2;			//x position of playing area
		private const GAME_AREA_Y:Number = Main.SCREEN_HEIGHT / 2 - GAME_AREA_HEIGHT / 2;		//y position of playing area
		
		//spacing between elements
		private const TILE_SPACING:Number = 5;			//space between tiles
		private const EDGE_BTN_SPACING:Number = 5;		//space between edge buttons and game area
		
		//entities
		private var _tiles:Array;			//level data
		private var _edgeBtnsTop:Array		//buttons along the top that alter columns
		private var _edgeBtnsLeft:Array		//buttons along the left that alter rows
		
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
					//add location
					tileX = GAME_AREA_X + (tileWidth + TILE_SPACING) * i;
					tileY = GAME_AREA_Y + (tileHeight + TILE_SPACING) * j;
					
					//create button, feed grid position and set click event
					tile = new Tile(0, tileX, tileY, tileWidth, tileHeight); //create tile with a default color index of 0
					tile.registerGridPosition(i, j);
					tile.onClick(tileClicked);
					
					//add to array and screen
					tilesColumn.push(tile);
					add(tile);
				}
				
				_tiles.push(tilesColumn);
			}
			
			//}}
			
			//{ EDGE BUTTONS
			
			_edgeBtnsTop = new Array();
			_edgeBtnsLeft = new Array();
			
			//button
			var edgeBtn:EdgeButton;
			var edgeBtnX:Number;
			var edgeBtnY:Number;
			var edgeBtnWidth:Number = tileWidth * .4;
			var edgeBtnHeight:Number = tileHeight * .4;
			
			//origins for the top and left side lists of buttons
			var topX:Number = GAME_AREA_X + (tileWidth - edgeBtnWidth) / 2;
			var topY:Number = GAME_AREA_Y - edgeBtnHeight - EDGE_BTN_SPACING;
			var leftX:Number = GAME_AREA_X - edgeBtnWidth - EDGE_BTN_SPACING;
			var leftY:Number = GAME_AREA_Y + (tileHeight - edgeBtnHeight) / 2;
			
			//create buttons along the top side for columns
			for (var i:int = 0; i < _numTiles; i++)
			{
				//set location
				edgeBtnX = topX + (tileWidth + TILE_SPACING) * i;
				edgeBtnY = topY;
				
				//create button, register index, and set click event
				edgeBtn = new EdgeButton(edgeBtnX, edgeBtnY, edgeBtnWidth, edgeBtnHeight);
				edgeBtn.index = i;
				edgeBtn.onClick(topEdgeBtnClicked);
				
				//add to array and screen
				_edgeBtnsTop.push(edgeBtn);
				add(edgeBtn);
			}
			
			//create buttons along the left side for rows
			for (var i:int = 0; i < _numTiles; i++)
			{
				//set location
				edgeBtnX = leftX;
				edgeBtnY = leftY + (tileHeight + TILE_SPACING) * i;
				
				//create button, register index, and set click event
				edgeBtn = new EdgeButton(edgeBtnX, edgeBtnY, edgeBtnWidth, edgeBtnHeight);
				edgeBtn.index = i;
				edgeBtn.onClick(leftEdgeBtnClicked);
				
				//add to array and screen
				_edgeBtnsLeft.push(edgeBtn);
				add(edgeBtn);
			}
			
			//}
			
			
			//ui
			
		}
		
		override public function update():void 
		{
			super.update();
			
		}
		
		//{ EVENT HANDLERS
		
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
		 * Event handler for clicking edge buttons at the top of the screen.
		 * @param	edgeBtn		The edge button clicked.
		 */
		private function topEdgeBtnClicked(edgeBtn:EdgeButton):void 
		{
			//flip all tiles in the column
			//for (var i:int = 0; i < _tiles.length; i++)
			//{
				//flipTile(_tiles[edgeBtn.index][i]);
			//}
			
			//shift all tiles in the column up
			var firstTileColorIndex:int = _tiles[edgeBtn.index][0].colorIndex;		//color index of first tile, to be moved to last
			for (var i:int = 0; i < _tiles.length; i++)
			{
				if (i == _tiles.length - 1)
					_tiles[edgeBtn.index][i].colorIndex = firstTileColorIndex;
				else
					_tiles[edgeBtn.index][i].colorIndex = _tiles[edgeBtn.index][i + 1].colorIndex;
			}
		}
		
		/**
		 * Event handler for clicking edge buttons at left on the screen.
		 * @param	edgeBtn		The edge button clicked.
		 */
		private function leftEdgeBtnClicked(edgeBtn:EdgeButton):void 
		{
			//flip all tiles in the row
			//for (var i:int = 0; i < _tiles[0].length; i++)
			//{
				//flipTile(_tiles[i][edgeBtn.index]);
			//}
			
			//shift all tiles in the row left
			var firstTileColorIndex:int = _tiles[0][edgeBtn.index].colorIndex;		//color index of first tile, to be moved to last
			for (var i:int = 0; i < _tiles.length; i++)
			{
				if (i == _tiles.length - 1)
					_tiles[i][edgeBtn.index].colorIndex = firstTileColorIndex;
				else
					_tiles[i][edgeBtn.index].colorIndex = _tiles[i + 1][edgeBtn.index].colorIndex;
			}
		}
		
		//}
		
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