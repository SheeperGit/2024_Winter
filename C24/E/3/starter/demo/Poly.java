package demo;

import java.util.Arrays;
import java.util.List;
import poly.Interleaver;
import poly.Pair;

public class Poly {

  private static void demoPair() {
    System.out.println(String.format("Pairing %s and %s gives %s", "AAA", "BBB",
        new Pair<String, String>("AAA", "BBB")));

    System.out.println(String.format("Pairing %s and %s gives %s", 111, 222,
        new Pair<Integer, Integer>(111, 222)));

    System.out.println(String.format("Pairing %s and %s gives %s", "AAA", 111,
        new Pair<String, Integer>("AAA", 111)));

    List<String> strs = Arrays.asList(new String[] { "AAA", "BBB", "CCC" });
    List<Integer> ints = Arrays.asList(new Integer[] { 111, 222, 333 });

    System.out.println(String.format("Pairing %s and %s gives %s", strs, ints,
        new Pair<List<String>, List<Integer>>(strs, ints)));
  }

  private static void demoInterleave() {

    List<String> xs1 = Arrays.asList(new String[] { "aaa", "bbb", "ccc" });
    List<String> ys1 = Arrays.asList(new String[] { "ddd", "eee", "fff" });

    System.out.println(String.format("Interleaving %s and %s produces:\n\t%s", xs1, ys1,
        Interleaver.interleave(xs1, ys1)));

    List<Integer> xs2 = Arrays.asList(new Integer[] { 1, 3, 5 });
    List<Integer> ys2 = Arrays.asList(new Integer[] { 42, 47, 50 });

    System.out.println(String.format("Interleaving %s and %s produces:\n\t%s", xs2, ys2,
        Interleaver.interleave(xs2, ys2)));
  }

  private static void demoToPairs() {

    List<String> xs3 = Arrays.asList(new String[] { "AAA", "BBB", "CCC" });
    List<Integer> ys3 = Arrays.asList(new Integer[] { 1, 2, 3 });

    System.out.println(String.format("Calling toPairs on %s and %s produces:\n\t%s", xs3, ys3,
        Interleaver.toPairs(xs3, ys3)));

    List<Integer> xs4 = Arrays.asList(new Integer[] { 111, 222, 333 });
    List<String> ys4 = Arrays.asList(new String[] { "aaa", "bbb", "ccc" });

    System.out.println(String.format("Calling toPairs on %s and %s produces:\n\t%s", xs4, ys4,
        Interleaver.toPairs(xs4, ys4)));

    List<List<String>> xs5 = Arrays.asList(xs3, ys4);
    List<List<Integer>> ys5 = Arrays.asList(ys3, xs4);

    System.out.println(String.format("Calling toPairs on %s and %s produces:\n\t%s", xs5, ys5,
        Interleaver.toPairs(xs5, ys5)));
  }

  /**
   * Demo the use of the required classes.
   *
   * @param args the usual
   */
  public static void main(String[] args) {
    demoPair();
    demoInterleave();
    demoToPairs();
  }
}
