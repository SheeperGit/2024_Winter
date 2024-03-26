package set;

/**
 * Things that have a partial order.
 */
public interface PartiallyOrdered<T> extends Eq<T> {
    default PartialOrdering pcompare(T other) {
        if (eq(other)) {
            return PartialOrdering.EQ;
        } else if (lt(other)) {
            return PartialOrdering.LT;
        } else if (gt(other)) {
            return PartialOrdering.GT;
        } else {
            return PartialOrdering.INC;
        }
    }

    default boolean lt(T other) {
        return pcompare(other) == PartialOrdering.LT;
    }

    default boolean gt(T other) {
        return pcompare(other) == PartialOrdering.GT;
    }

    default boolean lte(T other) {
        return pcompare(other) == PartialOrdering.LT || pcompare(other) == PartialOrdering.EQ;
    }

    default boolean gte(T other) {
        return pcompare(other) == PartialOrdering.GT || pcompare(other) == PartialOrdering.EQ;
    }

    default boolean inc(T other) {
        return pcompare(other) == PartialOrdering.INC;
    }
}
