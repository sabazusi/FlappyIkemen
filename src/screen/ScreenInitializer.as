/*
 * @Auther sabazusi
 */
package screen
{
    import events.ScreenInitializeEvent;

    import feathers.controls.ScreenNavigator;
    import feathers.controls.ScreenNavigatorItem;
    import feathers.motion.transitions.ScreenSlidingStackTransitionManager;

    import flash.events.EventDispatcher;

    import starling.utils.AssetManager;

    public class ScreenInitializer extends EventDispatcher
    {
        private var _screenNavigator:ScreenNavigator = new ScreenNavigator();

        public function ScreenInitializer()
        {
        }

        public function initialize(assetManager:AssetManager):void
        {
            _screenNavigator.addScreen("welcome",  new ScreenNavigatorItem(WelcomeScreen,
                    {
                        onNext: "game"
                    },
                    {
                        assets: assetManager
                    }
            ));

            _screenNavigator.addScreen("game",  new ScreenNavigatorItem(GameScreen,
                    {
                        onBack: "welcome"
                    },
                    {
                        assets: assetManager
                    }
            ));

            dispatchEvent(new ScreenInitializeEvent(ScreenInitializeEvent.INITIALIZE_COMPLETE, _screenNavigator));
        }
    }
}
