/*
 * @Auther sabazusi
 */
package
{
    import events.ScreenInitializeEvent;

    import feathers.controls.ScreenNavigator;

    import feathers.motion.transitions.ScreenSlidingStackTransitionManager;

    import screen.ScreenInitializer;

    import starling.display.Sprite;
    import starling.events.Event;
    import starling.utils.AssetManager;

    public class GameController extends Sprite
    {
        private var _assetManager:AssetManager = new AssetManager();
        private var _sceenInitializer:ScreenInitializer = new ScreenInitializer();

        public function GameController()
        {
            this.addEventListener(Event.ADDED_TO_STAGE, _onAddedToStage);
            _sceenInitializer.addEventListener(ScreenInitializeEvent.INITIALIZE_COMPLETE, _onScreenInitializeComplete)
        }

        private function _onAddedToStage(event:Event):void
        {
            _loadAssets();
        }

        private function _loadAssets():void
        {
            _assetManager.enqueue(GameAssets);
            _assetManager.loadQueue(_onLoadAssetsProgress);
        }

        private function _onLoadAssetsProgress(ratio:Number):void
        {
            // completed load assets.
            if (ratio == 1.0)
            {
                _sceenInitializer.initialize(_assetManager);
            }
        }

        private function _onScreenInitializeComplete(event:ScreenInitializeEvent):void
        {
            var navigator:ScreenNavigator = event.navigator;
            var transitionManager:ScreenSlidingStackTransitionManager = new ScreenSlidingStackTransitionManager(navigator);
            transitionManager.duration = 0.4;

            navigator.showScreen("welcome");
        }
    }
}
