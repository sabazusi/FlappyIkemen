/*
 * @Auther sabazusi
 */
package screen
{
    import feathers.controls.Screen;

    import game.GravityManager;

    import raix.reactive.IObservable;
    import raix.reactive.Observable;

    import starling.display.Image;
    import starling.events.Event;
    import starling.events.Touch;
    import starling.events.TouchEvent;
    import starling.events.TouchPhase;

    import starling.utils.AssetManager;

    public class GameScreen extends Screen
    {
        private var _asset:AssetManager;

        private var _backGroundFront:Image;
        private var _backGroundBack:Image;

        private var _deviceWidth:Number;

        private var _ikemen:Image;

        private var _gravityManager:GravityManager;

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

            _gravityManager = new GravityManager(_ikemen.y);

            this.addChild(_backGroundFront);
            this.addChild(_backGroundBack);
            this.addChild(_ikemen);
            this.addEventListener(Event.ENTER_FRAME, _onEnterFrame);
            this.addEventListener(TouchEvent.TOUCH,  _onTouch);
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
            // scroll background.
            this.x -= 2;
            var pos:Number = this.x * -1;
            if (pos > stage.width)
            {
                this.x = 0;
            }
            _ikemen.x = this.x * -1 + 40;
            _ikemen.y = _gravityManager.getNextPos(_ikemen.y);
        }

        private function _onTouch(event:TouchEvent):void
        {
            var touch:Touch = event.getTouch(stage);
            if (touch && touch.phase == TouchPhase.BEGAN)
            {
                trace("touched!");
            }
        }
    }
}
