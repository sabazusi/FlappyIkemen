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
            var button:Button = new Button();
            var btTex:Image = new Image(assets.getTexture("BUTTON_UP"));
            button.label = "click to game start.";
            button.defaultSkin = btTex;
            button.addEventListener(Event.TRIGGERED, function(event:Event):void
            {
                dispatchEventWith(Event.COMPLETE);
            })
            this.addChild(button);
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
    }
}
