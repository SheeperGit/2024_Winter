package booleanoofunc;

import java.util.Map;

public class Implication extends BinaryExpression {
    public Implication(BooleanExpression left, BooleanExpression right) {
        super((x, y) -> !x || y, left, right, (operands, context) -> {
            BooleanExpression leftExpr = operands.get(0);
            BooleanExpression rightExpr = operands.get(1);

            if (leftExpr instanceof BooleanValue) {
                // leftOperand is known //
                if (((BooleanValue) leftExpr).evaluate(context)) {
                    // (#t ==> x) == x //
                    return rightExpr;
                } else {
                    // (#f ==> x) == #t //
                    return new BooleanValue(true);
                }
            } else if (rightExpr instanceof BooleanValue) {
                // rightOperand is known //
                if (((BooleanValue) rightExpr).evaluate(context)) {
                    // (x ==> #t) == #t //
                    return new BooleanValue(true);
                } else {
                    // (x ==> #f) == not(x) //
                    return new Negation(leftExpr);
                }
            } else if (leftExpr.equals(rightExpr)) {
                // (x ==> x) == #t //
                return new BooleanValue(true);
            }

            return new Implication(leftExpr, rightExpr);
        });
    }

    @Override
    public BooleanExpression simplify(Map<String, Boolean> context) {
        BooleanExpression simplifiedLeft = left.simplify(context);
        BooleanExpression simplifiedRight = right.simplify(context);

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
    protected String toStringOp() {
        return Constants.IMPLIES;
    }
}
