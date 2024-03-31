package set;

import java.util.Collection;
import java.util.Set;
import java.util.stream.Collectors;

/**
 * A partially ordered Set.
 */
public class PartiallyOrderedSet<E extends Eq<E> & Show> 
    implements PartiallyOrdered<PartiallyOrderedSet<E>>, Show {

    private Set<E> elements;

    public PartiallyOrderedSet(Collection<E> elts) {
        this.elements = Set.copyOf(elts); // Note: Set.copyOf creates an IMMUTABLE set
    }

    // Helper Function //
    public boolean subset(PartiallyOrderedSet<E> other) {
        return this.elements.stream().allMatch(elem -> other.elements.stream()
                                                                     .anyMatch(otherElem -> elem.eq(otherElem)));
    }
    

    public PartialOrdering pcompare(PartiallyOrderedSet<E> other) {
        if (this.eq(other)) {
            return PartialOrdering.EQ;
        } else if (this.subset(other)) {
            return PartialOrdering.LT;
        } else if (other.subset(this)) {
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
                             .map(E::show)
                             .collect(Collectors.joining(","))
                + "}";
    }
}
