package set;

import java.util.Collection;
import java.util.Set;
import java.util.stream.Collectors;

/**
 * A partially ordered Set.
 */
public class PartiallyOrderedSet<E extends Eq<E> & Show> implements Show<E>, PartiallyOrdered<PartiallyOrderedSet<E>> {
    private Set<E> elements;

    public PartiallyOrderedSet(Collection<E> elts) {
        this.elements = Set.copyOf(elts); // Note: Set.copyOf creates an IMMUTABLE set
    }

    public PartialOrdering pcompare(PartiallyOrderedSet<E> other) {
        if (this.elements.equals(other.elements)) {
            return PartialOrdering.EQ;
        } else if (this.elements.containsAll(other.elements)) {
            return PartialOrdering.LT;
        } else if (other.elements.containsAll(this.elements)) {
            return PartialOrdering.GT;
        } else {
            return PartialOrdering.INC;
        }
    }

    @Override
    public boolean eq(PartiallyOrderedSet<E> other) {
        return this.elements.equals(other.elements);
    }

    @Override
    public String show() {
        return "{" + elements.stream()
                             .map(Object::toString)
                             .collect(Collectors.joining(","))
                + "}";
    }
}
