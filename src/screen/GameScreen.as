/*
 * @Auther sabazusi
 */
package screen
{
    import feathers.controls.Screen;

    import starling.display.Image;
    import starling.events.Event;

    import starling.utils.AssetManager;

    public class GameScreen extends Screen
    {
        private var _asset:AssetManager;

        private var _deviceWidth:Number;

        private var _ikemen:Image;

        public function GameScreen()
        {
        }

        override protected function initialize():void
        {
            trace("initialized game");
            var mapImage:Image = new Image(assets.getTexture("MAP"));
            var mapImage2:Image = new Image(assets.getTexture("MAP"));
            _ikemen = new Image(assets.getTexture("IKEMEN"));
            _ikemen.scaleX = _ikemen.scaleY = 0.3;
            _ikemen.x = 40;
            _ikemen.y = 50;
            mapImage.x = 0;
            mapImage2.x = mapImage.width;
            _deviceWidth = this.stage.width;
            this.addChild(mapImage);
            this.addChild(mapImage2);
            this.addChild(_ikemen);
            this.addEventListener(Event.ENTER_FRAME, _onEnterFrame)
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
         //   } else if(int(pos) == 320 || int(pos) == 321)
         //   {
            }
            _ikemen.x = this.x * -1 + 40;
            _ikemen.y = 50;
        }
    }
}
