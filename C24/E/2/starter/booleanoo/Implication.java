package booleanoo;

import java.util.Map;
import booleanoo.operators.Implies;

/**
 * A binary implication of BooleanExpressions.
 */
public class Implication extends BinaryExpression {
    public Implication(BooleanExpression left, BooleanExpression right) {
        super(new Implies(), left, right);
    }

    @Override
    public BooleanExpression simplify(Map<String, Boolean> context) {
        BooleanExpression simplifiedLeft = left.simplify(context);
        BooleanExpression simplifiedRight = right.simplify(context);

        // Apply the simplification rules
        if (simplifiedLeft instanceof BooleanValue && simplifiedRight instanceof BooleanValue) {
            boolean leftBool = ((BooleanValue) simplifiedLeft).evaluate(context);
            boolean rightBool = ((BooleanValue) simplifiedRight).evaluate(context);

            // (#t ==> x) == x , (#f ==> x) == #t
            if (leftBool == true && rightBool == true) {
                return simplifiedRight;
            } else if (leftBool == false && rightBool == true) {
                return new BooleanValue(true);
            }

            // (x ==> #t) == #t
            if (rightBool == true) {
                return new BooleanValue(true);
            }

            // (x ==> #f) == (not x)
            if (rightBool == false) {
                return new Negation(simplifiedLeft);
            }
        }

        // No simplifications found! //
        return new Implication(simplifiedLeft, simplifiedRight);
    }

    @Override
    public BooleanExpression simplifyOnce(Map<String, Boolean> context) {
        // No simplification can be performed just once for an Implication //
        return new Implication(left.simplify(context), right.simplify(context));
    }

    @Override
    protected boolean applyOperator(boolean leftValue, boolean rightValue) {
        return !leftValue || rightValue;    // Implication Law //
    }
}
