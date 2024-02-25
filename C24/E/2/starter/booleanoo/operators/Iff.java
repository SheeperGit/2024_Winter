package booleanoo.operators;

import booleanoo.Constants;

/**
 * Binary "if and only if" operator.
 */
public class Iff implements BinaryOperator {
  @Override
  public boolean apply(boolean left, boolean right){
    return left == right;
  }
  
  @Override
  public boolean equals(Object other) {
    return other != null && other.getClass().equals(Iff.class);
  }

  @Override
  public String toString() {
    return Constants.IFF;
  }
}
