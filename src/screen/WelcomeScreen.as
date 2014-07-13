package screen
{
    import feathers.controls.Button;
    import feathers.controls.Screen;

    import starling.animation.Transitions;

    import starling.core.Starling;

    import starling.display.Image;
    import starling.events.Event;
    import starling.textures.Texture;
    import starling.utils.AssetManager;

    public class WelcomeScreen extends Screen
    {
        private var _asset:AssetManager;

        public function WelcomeScreen()
        {
        }

        override protected function initialize():void
        {
            var buttonDefaultTexture:Texture = assets.getTexture("BT_UP");
            var buttonDownTexture:Texture = assets.getTexture("BT_DOWN");
            var buttonDefaultImage:Image = new Image(buttonDefaultTexture);
            var buttonDownImage:Image = new Image(buttonDownTexture);

            var button:Button = new Button();
            button.width = 160;
            button.height = 40;
            button.defaultSkin = buttonDefaultImage;
            button.downSkin = buttonDownImage;
            button.x = (_originalWidth - button.width) / 2;
            button.y = _originalHeight - button.height - 50;
            button.addEventListener(Event.TRIGGERED, _onStartButtonTriggered)
            this.addChild(button);

            // moving ikemen.
            var ikemenImage:Image = new Image(assets.getTexture("IKEMEN"));
            ikemenImage.x = ikemenImage.width * -1 - 100;
            this.addChild(ikemenImage);

            Starling.juggler.tween(ikemenImage, 0.5, {
                transition: Transitions.EASE_OUT_BOUNCE,
                x: _originalWidth - ikemenImage.width
            })
        }

        override protected function draw():void
        {
        }

        private function _onStartButtonTriggered(event:Event):void
        {
            dispatchEventWith(Event.COMPLETE);
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
