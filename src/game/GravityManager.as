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

        private var _maintainCount:int = 300;
        public function GravityManager(startPosition:Number)
        {
            _position = startPosition;
        }

        public function getNextPos(currentPos:Number):Number
        {
            if (_maintainCount > 0){
                _maintainCount--;
                return _position;
            }
            var newPos:Number = _position + (G_FORCE + _velocity) / 2;
            _velocity += G_FORCE;
            _position = newPos;
            return newPos;
        }
    }
}
