package screen
{
    import events.ScreenInitializeEvent;

    import feathers.controls.ScreenNavigator;
    import feathers.controls.ScreenNavigatorItem;

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
            _screenNavigator.addScreen(ScreenIdList.GAME,  new ScreenNavigatorItem(GameScreen,
                    {
                        complete: ScreenIdList.WELCOME
                    },
                    {
                        assets: assetManager
                    }
            ));

            _screenNavigator.addScreen(ScreenIdList.WELCOME,  new ScreenNavigatorItem(WelcomeScreen,
                    {
                        complete: ScreenIdList.GAME
                    },
                    {
                        assets: assetManager
                    }
            ));

            dispatchEvent(new ScreenInitializeEvent(ScreenInitializeEvent.INITIALIZE_COMPLETE, _screenNavigator));
        }
    }
}
