class Obstical {

    // positional data for wall
    int x;
    int y;

    // size data
    int w;
    int h;

    Obstical(int _x, int _y, int _w, int _h) {
        x = _x;
        y= _y;
    }

    // returns true of the projectile hits an obstical
    boolean checkProjectile(PVector projPos) {
        float btmLeft = x + w;
        float topRight = y + h;

        // boolean return if projectile is in the object
        if ((projPos.x >= x && projPos.x <= topRight) && (projPos.y >= y && projPos.y <= btmLeft)) {
            return true;
        }
        return false;
    }
}