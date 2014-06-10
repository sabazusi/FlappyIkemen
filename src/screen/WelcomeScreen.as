/*
 * @Auther sabazusi
 */
package screen
{
    import feathers.controls.Button;
    import feathers.controls.Label;
    import feathers.controls.Screen;

    import org.osflash.signals.ISignal;

    import org.osflash.signals.Signal;

    import starling.animation.Transitions;

    import starling.core.Starling;

    import starling.display.Image;

    import starling.textures.Texture;

    import starling.utils.AssetManager;

    public class WelcomeScreen extends Screen
    {
        private var _asset:AssetManager;

        private var _onNext:Signal = new Signal(WelcomeScreen);

        public function get onNext():ISignal
        {
            return _onNext;
        }

        public function WelcomeScreen()
        {
        }

        override protected function initialize():void
        {
            trace("initialized");
            var tex:Texture = assets.getTexture("IKEMEN");
            var img:Image = new Image(tex);
            img.x = img.width * -1 - 100;
            this.addChild(img);

            Starling.juggler.tween(img, 0.5, {
                transition: Transitions.EASE_IN,
                x: 640-img.width
            })
        }

        override protected function draw():void
        {
            trace("draw");
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
