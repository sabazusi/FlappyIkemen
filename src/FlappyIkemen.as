package {
    import flash.display.Sprite;

    import starling.core.Starling;

    [SWF(frameRate="60", width="640", height="360")]
    public class FlappyIkemen extends Sprite {
        public function FlappyIkemen() {
            var starling:Starling = new Starling(GameController, stage);
            starling.start();
        }
    }
}
