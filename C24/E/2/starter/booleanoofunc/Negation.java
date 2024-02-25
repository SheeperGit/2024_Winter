package booleanoofunc;

import java.util.Map;

public class Negation extends UnaryExpression {
  public Negation(BooleanExpression operand) {
      super(x -> !x, operand);
  }

  @Override
  public BooleanExpression simplify(Map<String, Boolean> context) {
      BooleanExpression simplifiedOperand = operand.simplify(context);
      return new Negation(simplifiedOperand);
  }

  @Override
  public BooleanExpression simplifyOnce(Map<String, Boolean> context) {
      if (operand instanceof Negation) {
          // (not (not x)) == x //
          return ((Negation) operand).getOperand().simplify(context);
      }
      return new Negation(operand.simplify(context));
  }

  @Override
  protected String toStringOp() {
      return Constants.NOT;
  }
}
