/*
 * @Auther sabazusi
 */
package screen
{
    import feathers.controls.Button;
    import feathers.controls.Screen;
    import feathers.display.Scale9Image;
    import feathers.textures.Scale9Textures;

    import flash.geom.Rectangle;


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
            trace("initialized");
            var upTexture:Texture = assets.getTexture("BT_UP");
            var downTexture:Texture = assets.getTexture("BT_DOWN");
            var scale9Image:Scale9Image = new Scale9Image(new Scale9Textures(upTexture, new Rectangle(0,0,160,40)));
            var scale9Imaged:Scale9Image = new Scale9Image(new Scale9Textures(downTexture, new Rectangle(0,0,160,40)));

            var button:Button = new Button();
            button.width = 160;
            button.height = 40;
            button.defaultSkin = scale9Image;
            button.downSkin = scale9Imaged;
            button.x = (_originalWidth - button.width) / 2;
            button.y = _originalHeight - button.height - 50;

            button.addEventListener(Event.TRIGGERED, function(event:Event):void
            {
                dispatchEventWith(Event.COMPLETE);
            })
            this.addChild(button);

            var img:Image = new Image(assets.getTexture("IKEMEN"));
            img.x = img.width * -1 - 100;
            this.addChild(img);

            Starling.juggler.tween(img, 0.5, {
                transition: Transitions.EASE_OUT_BOUNCE,
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
