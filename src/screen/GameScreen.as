package screen
{
    import feathers.controls.Screen;

    import flash.events.Event;

    import game.GravityManager;
    import game.WallController;

    import starling.display.Image;
    import starling.events.Event;
    import starling.events.Touch;
    import starling.events.TouchEvent;
    import starling.events.TouchPhase;
    import starling.textures.Texture;

    import starling.utils.AssetManager;

    public class GameScreen extends Screen
    {
        private static const GROUND_HEIGHT:Number = 45;

        private var _asset:AssetManager;

        private var _backGroundFront:Image;
        private var _backGroundBack:Image;

        private var _ikemen:Image;
        private var _crashGroundYPos:Number;

        private var _gravityManager:GravityManager;

        private var _maintainCount:Number = 300;

        private var _gameEnabled:Boolean = false;
        private var _isTouching:Boolean = false;

        private var _wallController:WallController;

        public function GameScreen()
        {
        }

        override protected function initialize():void
        {
            // initialize background images.
            _backGroundFront = new Image(assets.getTexture("MAP"));
            _backGroundBack = new Image(assets.getTexture("MAP"));
            _backGroundFront.x = 0;
            _backGroundBack.x = _backGroundFront.width;
            this.addChildAt(_backGroundFront, 0);
            this.addChildAt(_backGroundBack, 0);

            // initialize walls to avoid.
            var wallTex:Texture = assets.getTexture("WALL");
            _wallController = new WallController(this, wallTex, _originalHeight - GROUND_HEIGHT);
            _wallController.initialize();

            // initialize controllable ikemen.
            var ikemenTex:Texture = assets.getTexture("IKEMEN")
            _ikemen = new Image(ikemenTex);
            _ikemen.scaleX = _ikemen.scaleY = 0.3;
            _ikemen.x = 40;
            _ikemen.y = 50;
            this.addChild(_ikemen);

            _crashGroundYPos =_originalHeight - GROUND_HEIGHT - _ikemen.height;

            _gravityManager = new GravityManager(_ikemen.y);

            this.addEventListener(TouchEvent.TOUCH,  _onTouch);
            _wallController.addEventListener(flash.events.Event.CLOSE, _onCollision);

            _gameEnabled = true;
            this.addEventListener(starling.events.Event.ENTER_FRAME, _onEnterFrame);
        }

        override protected function draw():void
        {
        }

        public function get assets():AssetManager
        {
            return _asset;
        }

        public function set assets(value:AssetManager):void
        {
            _asset = value;
        }

        private function _onEnterFrame(event:starling.events.Event):void
        {
            if (_gameEnabled)
            {
                // scroll background.
                this.x -= 2;
                if (this.x * -1 > stage.width)
                {
                    this.x = 0;
                }
                _ikemen.x = this.x * -1 + 40;

                // hop with touching.
                if (_isTouching)
                {
                    _gravityManager.hop();
                }

                if(_maintainCount > 0)
                {
                    _ikemen.visible = (_maintainCount % 10) != 0;
                    _maintainCount--;
                }
                else
                {
                    _ikemen.visible = true;
                    // update ikemen position.
                    _ikemen.y = _gravityManager.getNextPos();
                }

                // check collision by ground.
                if (_ikemen.y > _crashGroundYPos)
                {
                    _gameEnabled = false;
                    dispatchEventWith(flash.events.Event.COMPLETE);
                }

                // check collision by walls..
                _wallController.updateByCurrentCharacterStatus(_ikemen);
            }
        }

        private function _onCollision(event:flash.events.Event):void
        {
            _gameEnabled = false;
            dispatchEventWith(flash.events.Event.COMPLETE);
        }

        private function _onTouch(event:TouchEvent):void
        {
            var touch:Touch = event.getTouch(stage);
            if (touch)
            {
                switch(touch.phase)
                {
                    case TouchPhase.BEGAN:
                        _isTouching = true;
                        _maintainCount = 0;
                        break;
                    case TouchPhase.ENDED:
                        _isTouching = false;
                        break;
                    default:
                        break;
                }
            }
        }
    }
}
