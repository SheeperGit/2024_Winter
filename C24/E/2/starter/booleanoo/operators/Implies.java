package booleanoo.operators;

import booleanoo.Constants;

/**
 * Binary operator "implies" used for implication.
 */
public class Implies {

  @Override
  public boolean equals(Object other) {
    return other != null && other.getClass().equals(Implies.class);
  }

  @Override
  public String toString() {
    return Constants.IMPLIES;
  }
}
