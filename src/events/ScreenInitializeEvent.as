/*
 * @Auther sabazusi
 */
package events
{
    import feathers.controls.ScreenNavigator;

    import flash.events.Event;

    public class ScreenInitializeEvent extends Event
    {
        public static const INITIALIZE_COMPLETE:String = "screen_initialize_complete";
        private var _navigator:ScreenNavigator;

        public function ScreenInitializeEvent(type:String, screenNavigator:ScreenNavigator, bubbles:Boolean = false, cancelable:Boolean = false)
        {
            super(type, bubbles, cancelable);
            _navigator = screenNavigator;
        }

        public function get navigator():ScreenNavigator
        {
            return _navigator;
        }
    }
}
