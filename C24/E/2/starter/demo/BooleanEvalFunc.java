package demo;

import booleanoofunc.BooleanExpression;
import booleanoofunc.BooleanExpressions;
import booleanoofunc.BooleanValue;
import booleanoofunc.Conjunction;
import booleanoofunc.Disjunction;
import booleanoofunc.IffExpression;
import booleanoofunc.Implication;
import booleanoofunc.Negation;
import booleanoofunc.UnassignedVariableException;
import booleanoofunc.Variable;
import java.util.Arrays;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Demonstrate the use of the boolean hierarchy.
 */
@SuppressWarnings("serial")
public class BooleanEvalFunc {

  static Map<String, Boolean> context = Collections.unmodifiableMap(new HashMap<String, Boolean>() {
    {
      put("a", true);
      put("b", false);
      put("c", false);
      put("d", true);
    }
  });

  static Map<String, Boolean> context2 = Collections
      .unmodifiableMap(new HashMap<String, Boolean>() {
        {
          put("c", false);
          put("d", true);
        }
      });

  /**
   * Show some examples.
   * 
   * @param args as usual
   */
  public static void main(String[] args) {
    demoHierarchy();
    demoFunctional();
  }

  /**
   * Examples of using lists of Boolean Expressions.
   */
  private static void demoFunctional() {

    List<BooleanExpression> list = Arrays.asList(new BooleanExpression[] { new BooleanValue(true),
        new Variable("a"), new Conjunction(new Variable("b"), new Variable("c")),
        new Implication(new Conjunction(new Variable("a"), new Variable("b")),
            new Implication(new BooleanValue(false), new Variable("d"))) });

    System.out.println(String.format("\n\tOn an expression list %s", list));
    System.out.println(String.format("under context %s", context));
    System.out.println(
        String.format("evaluateAll returns %s", BooleanExpressions.evaluateAll(list, context)));
    System.out.println(String.format("evaluateAndReduce returns %s",
        BooleanExpressions.evaluateAndReduce(list, context)));
    System.out.println(String.format("evaluateAndMapReduce returns %s",
        BooleanExpressions.evaluateAndMapReduce(list, context)));
    System.out.println(String.format("evaluateOrMapReduce returns %s",
        BooleanExpressions.evaluateOrMapReduce(list, context)));
    System.out.println(String.format("evaluateMapReduce with and/true returns %s",
        BooleanExpressions.evaluateMapReduce((x, y) -> x && y, true, list, context)));
    System.out.println(String.format("evaluateMapReduce with or/false returns %s",
        BooleanExpressions.evaluateMapReduce((x, y) -> x || y, false, list, context)));
  }

  /**
   * Examples of using the hierarchy of Boolean Expressions.
   */
  private static void demoHierarchy() {

    // ((a iff (not b)) implies ((true and c) iff ((not b) and c)))
    BooleanExpression expr = new Implication(
        new IffExpression(new Variable("a"), new Negation(new Variable("b"))),
        new IffExpression(new Conjunction(new BooleanValue(true), new Variable("c")),
            new Conjunction(new Negation(new Variable("b")), new Variable("c"))));

    System.out.println(String.format("\n\tExpression %s", expr));
    System.out.println(String.format("under context %s", context));
    try {
      System.out.println(String.format("evaluates to %s", expr.evaluate(context)));
    } catch (UnassignedVariableException exn) {
      System.out.println("I should not be here.");
    }
    System.out.println(String.format("and simplifies to %s", expr.simplify(context)));

    // ((not (not (a and c))) or b)
    BooleanExpression expr2 = new Disjunction(
        new Negation(new Negation(new Conjunction(new Variable("a"), new Variable("c")))),
        new Variable("b"));

    System.out.println(String.format("\n\tExpression %s", expr2));
    System.out.println(String.format("under context %s", context2));
    try {
      System.out.println(expr2.evaluate(context2));
    } catch (UnassignedVariableException exn) {
      System.out.println(String.format("when evaluated raises an exception: %s", exn));
    }
    System.out.println(String.format("and simplifies to %s", expr2.simplify(context2)));

    // (not (a implies false))
    BooleanExpression expr3 = new Negation(
        new Implication(new Variable("a"), new BooleanValue(false)));

    System.out.println(String.format("\n\tExpression %s", expr3));
    System.out.println(String.format("under context %s", context2));
    try {
      System.out.println(expr3.evaluate(context2));
    } catch (UnassignedVariableException exn) {
      System.out.println(String.format("when evaluated raises an exception: %s", exn));
    }
    System.out.println(String.format("and simplifies to %s", expr3.simplify(context2)));
  }
}
