package booleanoo.operators;

import booleanoo.Constants;

/**
 * Unary operator "not" used for negation.
 */
public class Not {

  @Override
  public boolean equals(Object other) {
    return other != null && other.getClass().equals(Not.class);
  }

  @Override
  public String toString() {
    return Constants.NOT;
  }
}
