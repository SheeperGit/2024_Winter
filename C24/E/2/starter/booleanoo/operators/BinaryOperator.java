package booleanoo.operators;

/**
 * A binary boolean operator.
 */
public interface BinaryOperator extends BooleanOperator {
    boolean apply(boolean left, boolean right);
}
