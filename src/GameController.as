/*
 * @Auther sabazusi
 */
package
{
    import sceans.SceenInitializer;

    import starling.display.Sprite;
    import starling.events.Event;
    import starling.utils.AssetManager;

    public class GameController extends Sprite
    {
        private var _assetManager:AssetManager = new AssetManager();
        private var _sceenInitializer:SceenInitializer = new SceenInitializer();

        public function GameController()
        {
            this.addEventListener(Event.ADDED_TO_STAGE, _onAddedToStage);
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
    }
}
