package booleanoofunc;

import java.util.Map;

public class Conjunction extends BinaryExpression {
    public Conjunction(BooleanExpression left, BooleanExpression right) {
        super((x, y) -> x && y, left, right, (operands, context) -> {
            BooleanExpression leftExpr = operands.get(0);
            BooleanExpression rightExpr = operands.get(1);

            if (leftExpr instanceof BooleanValue && rightExpr instanceof BooleanValue) {
              boolean leftValue = ((BooleanValue) leftExpr).evaluate(context);
              boolean rightValue = ((BooleanValue) rightExpr).evaluate(context);
              return new BooleanValue(leftValue && rightValue);
            }

            // Either operand == false -> false //
            if (leftExpr instanceof BooleanValue && !((BooleanValue) leftExpr).evaluate(context)) {
              return leftExpr;
            }
                
            if (rightExpr instanceof BooleanValue && !((BooleanValue) rightExpr).evaluate(context)) {
              return rightExpr;
            }

            // An operand == true -> otherOperand //
            if (leftExpr instanceof BooleanValue && ((BooleanValue) leftExpr).evaluate(context)) {
              return rightExpr;
            }
              
            if (rightExpr instanceof BooleanValue && ((BooleanValue) rightExpr).evaluate(context)) {
              return leftExpr;
            }

            // Both operands equal -> Return any one of them //
            if (leftExpr.equals(rightExpr)) {
              return leftExpr;
            }

            return new Conjunction(leftExpr, rightExpr);
        });
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
    protected String toStringOp() {
        return Constants.AND;
    }
}
