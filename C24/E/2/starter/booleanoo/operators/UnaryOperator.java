package booleanoo.operators;

/**
 * A unary boolean operator.
 */
public interface UnaryOperator extends BooleanOperator {
    boolean apply(boolean operand);
}
