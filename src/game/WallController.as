package game
{
    import flash.events.Event;
    import flash.events.EventDispatcher;
    import flash.geom.Rectangle;

    import starling.display.DisplayObjectContainer;
    import starling.display.Image;
    import starling.textures.Texture;

    public class WallController extends EventDispatcher
    {
        private static const _WALL_DISTANCE:int = 300;

        private var _currentWallDistance = 1000;
        private var _stage:DisplayObjectContainer
        private var _wallTex:Texture;
        private var _wallQueue:Vector.<Image> = Vector.<Image>([]);

        public function WallController(stage:DisplayObjectContainer, wallTex:Texture)
        {
            _stage = stage;
            _wallTex = wallTex;
        }

        public function initialize():void
        {
            // create 2 wall.
            _wallQueue = Vector.<Image>([]);
            var wall1:Image = new Image(_wallTex);
            wall1.x = -100;
            wall1.y = 30;
            var wall2:Image = new Image(_wallTex);
            wall2.x = -100;
            wall2.y = 30;
            _stage.addChild(wall1);
            _stage.addChild(wall2);
            _wallQueue.push(wall1);
            _wallQueue.push(wall2);
        }

        public function updateByCurrentCharacterStatus(currentCharacter:Image):void
        {
            _currentWallDistance -= 3;
            var disposeLen:int = 0;
            for(var i:int= 0; i < _wallQueue.length; i++)
            {
                var newDistance:Number = _currentWallDistance + (_WALL_DISTANCE * i);
                if (newDistance < 0)
                {
                    _stage.removeChild(_wallQueue[i]);
                    disposeLen++;
                }
                else
                {
                    _wallQueue[i].x = currentCharacter.x + newDistance;
                }
            }
            if (isCollision(_wallQueue[0], currentCharacter))
            {
                _exitGame();
            }
            if (disposeLen > 0)
            {
                for(var i:int=0; i<disposeLen; i++)
                {
                    _wallQueue.shift();
                    var newWall:Image = new Image(_wallTex);
                    newWall.x = currentCharacter.x + 1000;
                    newWall.y = 30;
                    _wallQueue.push(newWall);
                    _stage.addChild(newWall);
                }
                _currentWallDistance += _WALL_DISTANCE;
            }
        }

        private function isCollision(wall:Image, character:Image):Boolean
        {
            var wallRect:Rectangle = wall.getBounds(wall);
            var charaRect:Rectangle = character.getBounds(character);
            wallRect.x = wall.x;
            wallRect.y = wall.y;
            wallRect.width *= wall.scaleX;
            wallRect.height *= wall.scaleY;
            charaRect.x = character.x;
            charaRect.y = character.y;
            charaRect.width *= character.scaleX;
            charaRect.height *= character.scaleY;
            return wallRect.intersects(charaRect);
        }

        private function _exitGame():void
        {
            this.dispatchEvent(new Event(Event.CLOSE));
        }
    }
}
