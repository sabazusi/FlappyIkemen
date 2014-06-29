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
        private var _splitWallQueue:Vector.<SplitWall> = Vector.<SplitWall>([]);
        private var _flyableSpaceHeight:Number;

        public function WallController(stage:DisplayObjectContainer, wallTex:Texture, groundHeight:Number)
        {
            _stage = stage;
            _wallTex = wallTex;
            _flyableSpaceHeight = stage.height - groundHeight;
        }

        public function initialize():void
        {
            var wall1:SplitWall = new SplitWall(_wallTex, _flyableSpaceHeight);
            var wall2:SplitWall = new SplitWall(_wallTex, _flyableSpaceHeight);
            _splitWallQueue.push(wall1);
            _splitWallQueue.push(wall2);
            for (var i:int = 0; i < _splitWallQueue.length; i++)
            {
                _splitWallQueue[i].setVisibility(false);
                _stage.addChild(_splitWallQueue[i].up);
                _stage.addChild(_splitWallQueue[i].down);
            }
        }

        public function updateByCurrentCharacterStatus(currentCharacter:Image):void
        {
            _currentWallDistance -= 3;
            var disposeLen:int = 0;
            for(var i:int= 0; i < _splitWallQueue.length; i++)
            {
                var newDistance:Number = _currentWallDistance + (_WALL_DISTANCE * i);
                if (newDistance < 0)
                {
                    _splitWallQueue[i].removeFromStage(_stage);
                    disposeLen++;
                }
                else
                {
                    _splitWallQueue[i].wallX = currentCharacter.x + newDistance;
                }

                _splitWallQueue[i].setVisibility(true);
            }
            if (isCollision(_splitWallQueue[0].up, currentCharacter) ||
                    isCollision(_splitWallQueue[0].down, currentCharacter))
            {
                _exitGame();
            }
            if (disposeLen > 0)
            {
                for(var i:int=0; i<disposeLen; i++)
                {
                    _splitWallQueue.shift();
                    var newWall:SplitWall = new SplitWall(_wallTex, _flyableSpaceHeight);
                    newWall.setVisibility(false);
                    _splitWallQueue.push(newWall);
                    newWall.addToStage(_stage);
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

import flash.geom.Point;

import starling.display.DisplayObjectContainer;

import starling.display.Image;
import starling.textures.Texture;


internal class SplitWall
{
    private static const FLYABLE_SPACE_PER_STAGE:Number = 30;

    private var _upWall:Image;
    private var _downWall:Image;

    private var _stageHeight:Number;

    private var _flyableSpaceHeight:Number;

    public function SplitWall(wallTex:Texture, stageHeight:Number)
    {
        _upWall = new Image(wallTex);
        _downWall = new Image(wallTex);
        _stageHeight = stageHeight;

        _flyableSpaceHeight = _stageHeight * FLYABLE_SPACE_PER_STAGE / 100;

        _setWallStatus();
    }

    private function _setWallStatus():void
    {
        var flyablePoint:Point = _createFlyableHeight();

        trace("飛べる領域：", flyablePoint.x, flyablePoint.y);
        var upScale:Number = flyablePoint.x / _upWall.height;
        var downScale:Number = (_stageHeight - flyablePoint.y) / _downWall.height;
        trace("縦に伸ばす", upScale);
        trace("横に伸ばす", downScale);


        _upWall.scaleY = upScale;
        _upWall.y = 0;

        _downWall.scaleY = downScale;
        _downWall.y = flyablePoint.y;
    }
    private function _createFlyableHeight():Point
    {
        var maxPoint:Number = _stageHeight - (_upWall.height + _flyableSpaceHeight);
        var minPoint:Number = 0 + _upWall.height;
        var startPoint:Number = Math.floor(Math.random()*(maxPoint-minPoint+1))+minPoint;
        return new Point(startPoint, startPoint + _flyableSpaceHeight);
    }

    public function get up():Image
    {
        return _upWall;
    }

    public function get down():Image
    {
        return _downWall;
    }

    public function setVisibility(visible:Boolean):void
    {
        _upWall.visible = visible;
        _downWall.visible = visible;
    }

    public function addToStage(stage:DisplayObjectContainer):void
    {
        stage.addChild(_upWall);
        stage.addChild(_downWall);
    }

    public function removeFromStage(stage:DisplayObjectContainer):void
    {
        stage.removeChild(_upWall);
        stage.removeChild(_downWall);
    }

    public function set wallX(pos:Number):void
    {
        _upWall.x = pos;
        _downWall.x = pos;

 //       trace("[up]", _upWall.x, _upWall.y, _upWall.height);
  //      trace("[down]", _downWall.x, _downWall.y, _downWall.height);
    }
}
