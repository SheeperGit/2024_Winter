package booleanoo;

import java.util.Map;
import booleanoo.operators.Iff;

/**
 * A binary if and only if expression of BooleanExpressions.
 */
public class IffExpression extends BinaryExpression {
    public IffExpression(BooleanExpression left, BooleanExpression right) {
        super(new Iff(), left, right);
    }

    @Override
    public BooleanExpression simplify(Map<String, Boolean> context) {
        BooleanExpression simplifiedLeft = left.simplify(context);
        BooleanExpression simplifiedRight = right.simplify(context);

        if (simplifiedLeft instanceof BooleanValue && simplifiedRight instanceof BooleanValue) {
            boolean leftBool = ((BooleanValue) simplifiedLeft).evaluate(context);
            boolean rightBool = ((BooleanValue) simplifiedRight).evaluate(context);

            // (#t <==> x) == x , (#f <==> x) == (not x)
            if (leftBool == true && rightBool == true) {
                return simplifiedRight;
            } else if (leftBool == false && rightBool == true) {
                return new Negation(simplifiedRight);
            } else if (leftBool == true && rightBool == false) {
                return simplifiedLeft;
            } else if (leftBool == false && rightBool == false) {
                return new Negation(simplifiedLeft);
            }

            // (x <==> x) == #t
            if (simplifiedLeft.equals(simplifiedRight)) {
                return new BooleanValue(true);
            }
        }

        // No simplifications found! //
        return new IffExpression(simplifiedLeft, simplifiedRight);
    }

    @Override
    public BooleanExpression simplifyOnce(Map<String, Boolean> context) {
        // No simplification can be performed just once for an IffExpression //
        return new IffExpression(left.simplify(context), right.simplify(context));
    }

    @Override
    protected boolean applyOperator(boolean leftValue, boolean rightValue) {
        return leftValue == rightValue;
    }
}
