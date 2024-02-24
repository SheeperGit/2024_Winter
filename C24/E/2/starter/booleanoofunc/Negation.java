package booleanoofunc;

/**
 * A unary negation.
 */
public class Negation {

  /**
   * Creates a new "not operand".
   *
   * @param operand the operand of this Negation
   */
  public Negation(BooleanExpression operand) {
    super(x -> !x, operand, Negation::simplifyNot);
  }

  private static BooleanExpression simplifyNot(BooleanExpression expr,
      Map<String, Boolean> context) {
      return null;
  }

  @Override
  public String toStringOp() {
    return Constants.NOT;
  }
}
