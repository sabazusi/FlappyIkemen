/**
 * Created with IntelliJ IDEA.
 * User: sabazusi
 * Date: 2014/06/18
 * Time: 12:35
 * To change this template use File | Settings | File Templates.
 */
package game
{
    public class GravityManager
    {
        private static const G_FORCE:Number = 9.8 / 30;

        private var _velocity:Number = 0;

        private var _position:Number;

        public function GravityManager(startPosition:Number)
        {
            _position = startPosition;
        }

        public function hop():void
        {
            if (_velocity > 0) _velocity = 0;
            _velocity -= G_FORCE * 3;
        }

        public function getNextPos(currentPos:Number):Number
        {
            var newPos:Number = _position + (G_FORCE + _velocity) / 2;
            _velocity += G_FORCE;
            _position = newPos;
            return newPos;
        }
    }
}
