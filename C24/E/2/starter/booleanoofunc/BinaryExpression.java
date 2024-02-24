package booleanoofunc;

/**
 * A binary boolean expression.
 */
public class BinaryExpression {

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
