package {
    import flash.display.Sprite;
    import flash.text.TextField;

    public class FlappyIkemen extends Sprite {
        public function FlappyIkemen() {
            var textField:TextField = new TextField();
            textField.text = "Hello, World";
            addChild(textField);
        }
    }
}
