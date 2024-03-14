package poly;
import java.util.List;
import java.util.stream.Collectors;
import java.util.stream.IntStream;
import java.util.stream.Stream;


/**
 * Some methods that work with Lists and Pairs.
 */
public class Interleaver {

  /**
   * Returns a List of corresponding elements from xs and ys, interleaved. The
   * remaining elements of the longer List are ignored.
   *
   * This method should not use loops. Use Streams and Stream methods instead!
   *
   */
  // We'll cheat by making the return type a list of Objects, since every obj is a subclass of class Object :p //
  // This ensures this function will work on any object type! I suppose Java *can* be cool sometimes :/        //
  public static <X,Y> List<Object> interleave(List<X> xs, List<Y> ys) {
    int minLen = Math.min(xs.size(), ys.size());
      return IntStream.range(0, minLen)                                 // Suppose xs = [1, 2, 3], ys = [4, 5, 6]
        .mapToObj(i -> new Pair<>(xs.get(i), ys.get(i)))                // (1, 4), (2, 5), (3, 6)
        .flatMap(pair -> Stream.of(pair.getFirst(), pair.getSecond()))  // (1, 4, 2, 5, 3, 6)
        .collect(Collectors.toList());                                  // [1, 4, 2, 5, 3, 6]
  }

  /**
   * Returns a List of Pairs of corresponding elements from xs and ys,
   * interleaved. The remaining elements of the longer List are ignored.
   *
   * This method should not use loops. Use Streams and Stream methods instead!
   *
   */
  public static <X,Y> List<Pair<X, Y>> toPairs(List<X> xs, List<Y> ys) {
    int minLen = Math.min(xs.size(), ys.size());
    return IntStream.range(0, minLen)                   // Suppose xs = [1, 2, 3], ys = [4, 5, 6]
      .mapToObj(i -> new Pair<>(xs.get(i), ys.get(i)))  // (1, 4), (2, 5), (3, 6)
      .collect(Collectors.toList());                    // [(1, 4), (2, 5), (3, 6)]
  }
}
