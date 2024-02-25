package booleanoofunc;

import java.util.Arrays;
import java.util.Map;

public class IffExpression extends BinaryExpression {

    public IffExpression(BooleanExpression left, BooleanExpression right) {
    //          pass op                   create & pass simplifier  
      super((x, y) -> x == y, left, right, (expressions, context) -> {
          BooleanExpression leftExpr = expressions.get(0).simplify(context);
          BooleanExpression rightExpr = expressions.get(1).simplify(context);
          if (leftExpr instanceof BooleanValue && rightExpr instanceof BooleanValue) {
              boolean leftVal = ((BooleanValue) leftExpr).evaluate(context);
              boolean rightVal = ((BooleanValue) rightExpr).evaluate(context);
              return new BooleanValue(leftVal == rightVal); // Simplification found! //
          }
          return new IffExpression(leftExpr, rightExpr);    // No simplification found... //
      });
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
    protected String toStringOp() {
        return Constants.IFF;
    }
}
