/*
 * @Auther sabazusi
 */
package screen
{
    import feathers.controls.Screen;

    import org.osflash.signals.ISignal;

    import org.osflash.signals.Signal;

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
