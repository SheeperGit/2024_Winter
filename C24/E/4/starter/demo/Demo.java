package demo;

import java.util.Arrays;
import java.util.stream.Collectors;
import set.Eq;
import set.PartiallyOrderedSet;
import set.Show;

/**
 * Demonstrate the intended use of Show, Eq, PartiallyOrdered, and Partially
 * OrderedSet.
 *
 * @author anya
 *
 */
public class Demo {

  /**
   * Demos use of required classes of E5.
   *
   * @param args ignored
   */
  public static void main(String[] args) {
    demoIntegerSets();
    demoStringSets();
  }

  private static void demoIntegerSets() {
    final PartiallyOrderedSet<Int> emptyset = makeSet(new Integer[] {});
    final PartiallyOrderedSet<Int> singleton = makeSet(new Integer[] { 42 });
    final PartiallyOrderedSet<Int> three = makeSet(new Integer[] { 1, 2, 3 });
    final PartiallyOrderedSet<Int> four = makeSet(new Integer[] { 1, 2, 3, 4 });

    printResults(emptyset, singleton, three, four);

    // EXPECTED OUTPUT:
    // {} < {42}? true
    // {42} <= {2,3,1}? false
    // {1,3,4,2} >= {2,3,1}? true
    // {2,3,1} ? {1,3,4,2}? LT
    // {2,3,1} ? {42}? INC
  }

  private static void demoStringSets() {
    final PartiallyOrderedSet<Str> emptyset = makeSet(new String[] {});
    final PartiallyOrderedSet<Str> singleton = makeSet(new String[] { "One" });
    final PartiallyOrderedSet<Str> three = makeSet(new String[] { "one", "TwO", "tHRee" });
    final PartiallyOrderedSet<Str> four = makeSet(new String[] { "ONE", "ThrEe", "tWo", "four" });

    printResults(emptyset, singleton, three, four);

    // OUTPUT:
    // {} < {"One"}? true
    // {"One"} <= {"one","TwO","tHRee"}? true
    // {"ThrEe","ONE","tWo","four"} >= {"one","TwO","tHRee"}? true
    // {"one","TwO","tHRee"} ? {"ThrEe","ONE","tWo","four"}? LT
    // {"one","TwO","tHRee"} ? {"One"}? GT
  }

  private static <E extends Eq<E> & Show> void printResults(PartiallyOrderedSet<E> emptyset,
      PartiallyOrderedSet<E> singleton, PartiallyOrderedSet<E> three, PartiallyOrderedSet<E> four) {
    System.out.println(
        String.format("%s < %s? %s", emptyset.show(), singleton.show(), emptyset.lt(singleton)));
    System.out.println(
        String.format("%s <= %s? %s", singleton.show(), three.show(), singleton.lte(three)));
    System.out.println(String.format("%s >= %s? %s", four.show(), three.show(), four.gte(three)));
    System.out
        .println(String.format("%s ? %s? %s", three.show(), four.show(), three.pcompare(four)));
    System.out.println(
        String.format("%s ? %s? %s", three.show(), singleton.show(), three.pcompare(singleton)));
  }

  private static PartiallyOrderedSet<Int> makeSet(Integer[] elts) {
    return new PartiallyOrderedSet<Int>(
        Arrays.asList(elts).stream().map(Int::new).collect(Collectors.toList()));
  }

  /**
   * A wrapper class for Integer, created to demonstrate PartiallyOrderedSet.
   */
  static class Int implements Eq<Int>, Show {
    private Integer myInt;

    public Int(Integer myInt) {
      this.myInt = myInt;
    }

    public Integer getInt() {
      return myInt;
    }

    @Override
    public boolean eq(Int other) {
      return myInt.equals(other.getInt());
    }

    @Override
    public String show() {
      return String.valueOf(myInt);
    }
  }

  private static PartiallyOrderedSet<Str> makeSet(String[] elts) {
    return new PartiallyOrderedSet<Str>(
        Arrays.asList(elts).stream().map(Str::new).collect(Collectors.toList()));
  }

  /**
   * A wrapper class for String, with case-insensitive comparison (eq). Created to
   * demonstrate PartiallyOrderedSet.
   */
  static class Str implements Eq<Str>, Show {
    private String myStr;

    public Str(String myStr) {
      this.myStr = myStr;
    }

    public String getStr() {
      return myStr;
    }

    @Override
    public boolean eq(Str other) {
      return myStr.toLowerCase().equals(other.getStr().toLowerCase());
    }

    @Override
    public String show() {
      return String.format("\"%s\"", myStr);
    }
  }
}
