package poly;

/**
 * A Pair of X and Y.
 */
public class Pair<X, Y> {
    public final X first;
    public final Y second;

    public Pair(X first, Y second) {
        this.first = first;
        this.second = second;
    }

    /* Uncomment to debug */
    // public X getFirst() {
    //     return first;
    // }

    // public Y getSecond() {
    //     return second;
    // }

    @Override
    public String toString() {
        return "(" + first + ", " + second + ")";
    }
}
