package booleanoo;

import java.util.Map;
import booleanoo.operators.Or;

/**
 * A binary disjunction of BooleanExpressions.
 */
public class Disjunction extends BinaryExpression {
    public Disjunction(BooleanExpression left, BooleanExpression right) {
        super(new Or(), left, right);
    }

    @Override
    public BooleanExpression simplify(Map<String, Boolean> context) {
        BooleanExpression simplifiedLeft = left.simplify(context);
        BooleanExpression simplifiedRight = right.simplify(context);

        // Apply the simplification rules
        if (simplifiedLeft instanceof BooleanValue) {
            if (((BooleanValue) simplifiedLeft).evaluate(context)) {
                return simplifiedLeft; // (#t or x) == #t
            } else {
                return simplifiedRight; // (#f or x) == x
            }
        }

        if (simplifiedRight instanceof BooleanValue) {
            if (((BooleanValue) simplifiedRight).evaluate(context)) {
                return simplifiedRight; // (x or #t) == #t
            } else {
                return simplifiedLeft; // (x or #f) == x
            }
        }

        // No simplifications found! //
        return new Disjunction(simplifiedLeft, simplifiedRight);
    }

    @Override
    public BooleanExpression simplifyOnce(Map<String, Boolean> context) {
        if (left.equals(right)) {
            return left; // (x or x) == x
        }

        // No simplifications found! //
        return new Disjunction(left.simplify(context), right.simplify(context));
    }

    @Override
    protected boolean applyOperator(boolean leftValue, boolean rightValue) {
        return leftValue || rightValue;
    }
}
