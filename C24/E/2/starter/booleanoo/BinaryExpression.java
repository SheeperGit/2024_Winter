package booleanoo;
import java.util.Map;
import booleanoo.operators.BinaryOperator;;
/**
 * A binary boolean expression.
 */
public abstract class BinaryExpression extends BooleanExpression {
    protected BinaryOperator operator;
    protected BooleanExpression left;
    protected BooleanExpression right;

    public BinaryExpression(BinaryOperator operator, BooleanExpression left, BooleanExpression right) {
        this.operator = operator;
        this.left = left;
        this.right = right;
    }

    public final BooleanExpression getLeft() {
        return left;
    }

    public final BooleanExpression getRight() {
        return right;
    }

    public final BinaryOperator getOperator() {
        return operator;
    }

    @Override
    public boolean evaluate(Map<String, Boolean> context) {
        boolean leftVal = left.evaluate(context);
        boolean rightVal = right.evaluate(context);
        return applyOperator(leftVal, rightVal);
    }

    protected abstract boolean applyOperator(boolean leftValue, boolean rightValue);

    @Override
    public boolean equals(Object other) {
        if (other == null || getClass() != other.getClass()){
          return false;
        }
        BinaryExpression otherExpr = (BinaryExpression) other;
        return operator.equals(otherExpr.operator) && left.equals(otherExpr.left) && right.equals(otherExpr.right);
    }

    @Override
    public String toString() {
        return String.format("(%s %s %s)", left, operator, right);
    }
}
