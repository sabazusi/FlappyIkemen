/*
 * @Auther sabazusi
 */
package screen
{
    import feathers.controls.Screen;

    import game.GravityManager;

    import starling.display.Image;
    import starling.events.Event;
    import starling.events.Touch;
    import starling.events.TouchEvent;
    import starling.events.TouchPhase;

    import starling.utils.AssetManager;

    public class GameScreen extends Screen
    {
        private static const GROUND_HEIGHT:Number = 45;

        private var _asset:AssetManager;

        private var _backGroundFront:Image;
        private var _backGroundBack:Image;

        private var _deviceWidth:Number;

        private var _ikemen:Image;
        private var _underPositionLimit:Number;

        private var _gravityManager:GravityManager;

        private var _maintainCount:Number = 300;
        private var _gameEnabled:Boolean = false;

        public function GameScreen()
        {
        }

        override protected function initialize():void
        {
            trace("initialized game");
            _backGroundFront = new Image(assets.getTexture("MAP"));
            _backGroundBack = new Image(assets.getTexture("MAP"));
            _ikemen = new Image(assets.getTexture("IKEMEN"));
            _deviceWidth = this.stage.width;

            _ikemen.scaleX = _ikemen.scaleY = 0.3;
            _ikemen.x = 40;
            _ikemen.y = 50;
            _backGroundFront.x = 0;
            _backGroundBack.x = _backGroundFront.width;
            _underPositionLimit =_backGroundFront.height - GROUND_HEIGHT - _ikemen.height;

            _gravityManager = new GravityManager(_ikemen.y);

            this.addChild(_backGroundFront);
            this.addChild(_backGroundBack);
            this.addChild(_ikemen);
            this.addEventListener(Event.ENTER_FRAME, _onEnterFrame);
            this.addEventListener(TouchEvent.TOUCH,  _onTouch);

            _gameEnabled = true;
        }

        override protected function draw():void
        {
            trace("draw game");
        }

        public function get assets():AssetManager
        {
            return _asset;
        }

        public function set assets(value:AssetManager):void
        {
            _asset = value;
        }

        private function _onEnterFrame(event:Event):void
        {
            if (!_gameEnabled) return;
            // scroll background.
            this.x -= 2;
            var pos:Number = this.x * -1;
            if (pos > stage.width)
            {
                this.x = 0;
            }
            _ikemen.x = this.x * -1 + 40;

            if(_maintainCount > 0)
            {
                _ikemen.visible = (_maintainCount % 10 == 0) ?
                                    false : true;
                _maintainCount--;
            }
            else
            {
                _ikemen.visible = true;
                _ikemen.y = _gravityManager.getNextPos(_ikemen.y);
            }

            if (_ikemen.y > _underPositionLimit)
            {
                trace("dead");
                _gameEnabled = false;
            }
        }

        private function _onTouch(event:TouchEvent):void
        {
            var touch:Touch = event.getTouch(stage);
            if (touch && touch.phase == TouchPhase.BEGAN)
            {
                trace("touched!");
                _gravityManager.hop();
            }
        }
    }
}
