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

        public function getNextPos():Number
        {
            var newPos:Number = _position + (G_FORCE + _velocity) / 2;
            _velocity += G_FORCE;
            _position = newPos;
            return newPos;
        }
    }
}
