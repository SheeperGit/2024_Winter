package booleanoo;

import java.util.Map;
import booleanoo.operators.And;

/**
 * A binary conjunction of BooleanExpressions.
 */
public class Conjunction extends BinaryExpression {
    public Conjunction(BooleanExpression left, BooleanExpression right) {
        super(new And(), left, right);
    }

    @Override
    public BooleanExpression simplify(Map<String, Boolean> context) {
        BooleanExpression simplifiedLeft = left.simplify(context);
        BooleanExpression simplifiedRight = right.simplify(context);

        if (simplifiedLeft instanceof BooleanValue) {
            if (((BooleanValue) simplifiedLeft).evaluate(context)) {
                return simplifiedRight; // (#t and x) == x //
            } else {
                return simplifiedLeft; // (#f and x) == #f
            }
        }

        if (simplifiedRight instanceof BooleanValue) {
            if (((BooleanValue) simplifiedRight).evaluate(context)) {
                return simplifiedLeft; // (x and #t) == x //
            } else {
                return simplifiedRight; // (x and #f) == #f //
            }
        }

        // No simplifications found! //
        return new Conjunction(simplifiedLeft, simplifiedRight);
    }

    @Override
    public BooleanExpression simplifyOnce(Map<String, Boolean> context) {
        if (left.equals(right)) {
            return left; // (x and x) == x
        }

        // No simplifications found! //
        return new Conjunction(left.simplify(context), right.simplify(context));
    }

    @Override
    protected boolean applyOperator(boolean leftValue, boolean rightValue) {
        return leftValue && rightValue;
    }
}
