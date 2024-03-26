package set;

/**
 * Things that can be compared for equality using method eq.
 */
public interface Eq<T> {
    boolean eq(T other);
}
