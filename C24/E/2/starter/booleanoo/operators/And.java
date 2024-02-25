package booleanoo.operators;

import booleanoo.Constants;

/**
 * A binary operator "and" used for conjunction.
 */
public class And implements BinaryOperator {
    @Override
    public boolean apply(boolean left, boolean right) {
        return left && right;
    }

    @Override
    public boolean equals(Object other) {
        return other != null && other.getClass().equals(And.class);
    }

    @Override
    public String toString() {
        return Constants.AND;
    }
}
