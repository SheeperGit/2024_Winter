package booleanoofunc;

import java.util.Map;
import java.util.function.BiFunction;
import java.util.function.BinaryOperator;
import java.util.List;

public abstract class BinaryExpression extends BooleanExpression {
    protected BooleanExpression left;
    protected BooleanExpression right;
    protected BinaryOperator<Boolean> operator;
    protected BiFunction<List<BooleanExpression>, Map<String, Boolean>, BooleanExpression> simplifier;

    public BinaryExpression(BinaryOperator<Boolean> operator, BooleanExpression left, BooleanExpression right, BiFunction<List<BooleanExpression>, Map<String, Boolean>, BooleanExpression> simplifier) {
      this.operator = operator;
      this.left = left;
      this.right = right;
      this.simplifier = simplifier;
    }

    @Override
    public boolean evaluate(Map<String, Boolean> context) {
        boolean leftVal = left.evaluate(context);
        boolean rightVal = right.evaluate(context);
        return operator.apply(leftVal, rightVal);
    }

    @Override
    public BooleanExpression simplify(Map<String, Boolean> context) {
        return simplifier.apply(List.of(left, right), context);
    }

    @Override
    public BooleanExpression simplifyOnce(Map<String, Boolean> context) {
        return simplifier.apply(List.of(left, right), context);
    }

    @Override
    public boolean equals(Object other) {
        if (this == other) {
          return true;
        }
        if (other == null || getClass() != other.getClass()) {
          return false;
        }
        BinaryExpression that = (BinaryExpression) other;
        return left.equals(that.left) && right.equals(that.right) && operator.equals(that.operator);
    }

    protected abstract String toStringOp();

    @Override
    public String toString() {
        return String.format("(%s %s %s)", left, toStringOp(), right);
    }

    protected final BooleanExpression getLeft() {
        return left;
    }

    protected final BooleanExpression getRight() {
        return right;
    }
}
