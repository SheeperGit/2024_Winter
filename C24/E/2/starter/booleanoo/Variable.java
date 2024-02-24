package booleanoo;

/**
 * A boolean-values variable.
 */
public class Variable {
  @Override
  public boolean equals(Object other) {
    return other != null && other.getClass().equals(Variable.class)
        && id.equals(((Variable) other).id);
  }

  @Override
  public String toString() {
    return id;
  }
}
