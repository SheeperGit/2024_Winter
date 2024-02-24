package booleanoofunc;

/**
 * A variable does not have a value in a truth assignment when this value is
 * needed for evaluation.
 */
public class UnassignedVariableException extends RuntimeException {

  private static final long serialVersionUID = 1L;

  public UnassignedVariableException() {
  }

  public UnassignedVariableException(String message) {
    super(message);
  }
}
