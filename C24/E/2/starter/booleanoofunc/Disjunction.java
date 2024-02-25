package booleanoofunc;

import java.util.Map;

public class Disjunction extends BinaryExpression {
    public Disjunction(BooleanExpression left, BooleanExpression right) {
        super((x, y) -> x || y, left, right, (operands, context) -> {
            BooleanExpression leftExpr = operands.get(0);
            BooleanExpression rightExpr = operands.get(1);

            if (leftExpr instanceof BooleanValue && rightExpr instanceof BooleanValue) {
                boolean leftValue = ((BooleanValue) leftExpr).evaluate(null);
                boolean rightValue = ((BooleanValue) rightExpr).evaluate(null);
                return new BooleanValue(leftValue || rightValue);
            }

            // Either operand == true -> true //
            if (leftExpr instanceof BooleanValue && ((BooleanValue) leftExpr).evaluate(context)) {
              return leftExpr;
            }
              
            if (rightExpr instanceof BooleanValue && ((BooleanValue) rightExpr).evaluate(context)) {
              return rightExpr;
            }

            // Either operand == false -> Return otherOperand //
            if (leftExpr instanceof BooleanValue && !((BooleanValue) leftExpr).evaluate(context)) {
              return rightExpr;
            }
              
            if (rightExpr instanceof BooleanValue && !((BooleanValue) rightExpr).evaluate(context)) {
              return leftExpr;
            }

            // Both operands equal -> Return any of them //
            if (leftExpr.equals(rightExpr))
                return leftExpr;

            return new Disjunction(leftExpr, rightExpr);
        });
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
    protected String toStringOp() {
        return Constants.OR;
    }
}
