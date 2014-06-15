/*
 * @Auther sabazusi
 */
package screen
{
    import feathers.controls.Button;
    import feathers.controls.Screen;

    import org.osflash.signals.ISignal;

    import org.osflash.signals.Signal;

    import starling.display.Image;
    import starling.events.Event;

    import starling.utils.AssetManager;

    public class GameScreen extends Screen
    {
        private var _asset:AssetManager;

        private var _onBack:Signal = new Signal(GameScreen);

        private var _deviceWidth:Number;

        public function get onBack():ISignal
        {
            return _onBack;
        }

        public function GameScreen()
        {
        }

        override protected function initialize():void
        {
            trace("initialized game");
            var mapImage:Image = new Image(assets.getTexture("MAP"));
            var mapImage2:Image = new Image(assets.getTexture("MAP"));
            mapImage.x = 0;
            mapImage2.x = mapImage.width;
            _deviceWidth = this.stage.width;
            this.addChild(mapImage);
            this.addChild(mapImage2);
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
            if (this.x * -1 > stage.width)
            {
                this.x = 0;
            }
        }
    }
}
