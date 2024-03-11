"""Exercise 3."""


def interleave(lst1, lst2):
    """Return a list of corresponding elements from lst1 and lst2,
    interleaved. The remaining elements of the longer list are ignored.

    This function should use zip and list comprehension, and no recursion.

    >>> interleave([1, 2, 3], ['a', 'b', 'c'])
    [1, 'a', 2, 'b', 3, 'c']
    >>> interleave([1, 2, 3, 4], ['a', 'b', 'c'])
    [1, 'a', 2, 'b', 3, 'c']
    >>> interleave([1, 2, 3], ['a', 'b', 'c', 'd'])
    [1, 'a', 2, 'b', 3, 'c']
    >>> interleave([], ['a', 'b', 'c'])
    []
    >>> interleave([1, 2, 3], [])
    []
    >>> interleave([], [])
    []

    """

    return [elem for pair in zip(lst1, lst2) for elem in pair]


def to_pairs(lst1, lst2):
    """Return a list of pairs of corresponding elements from lst1 and lst2,
    interleaved. The remaining elements of the longer list are ignored.

    This function should use list comprehension and no recursion.

    >>> to_pairs([1, 2, 3], ['a', 'b', 'c'])
    [(1, 'a'), (2, 'b'), (3, 'c')]
    """

    return [pair for pair in zip(lst1, lst2)]

def repeat(func, value, num):
    """Return a list
    [value, func(value), func(func(value)), ..., func ^ num(value)].
    Pre: n >= 0

    This function should use map and recursion.

    >>> repeat(lambda x: 2 * x, 3, 5)
    [3, 6, 12, 24, 48, 96]
    >>> repeat(lambda x: 2 * x, 3, 0)
    [3]
    """

    if (num == 0):
        return [value]
    return [value] + list(map(func, repeat(func, value, num - 1)))


def num_neg(lst1):
    """Return a number of negative elements in lst1.

    This function should use list comprehension, no recursion, and no
    map or higher-order functions.

    >>> num_neg([1, -2, 3, -4, -5])
    3

    """

    return len([x for x in lst1 if x < 0])


def gen_squares(low, high):
    """Return a list of squares of even integers between low and high, inclusive.

    This function should use list comprehension, no recursion, and no
    map or other higher-order functions.
    >>> gen_squares(5, 20)
    [36, 64, 100, 144, 196, 256, 324, 400]
    """

    return [x**2 for x in range(low, high + 1) if (x > low and x <= high and x % 2 == 0)]


def triples(num):
    """Return a list of triples (x, y, z) of positive numbers all less
    than or equal to num, such that x ^ 2 + y ^ 2 == z ^ 2, with no
    duplicate triples or premutations of ealier triples.

    This function should use list comprehension, no recursion, and no
    map or other higher-order functions.

    Pre: num > 0.

    >>> triples(5)
    [(3, 4, 5)]
    >>> triples(15)
    [(3, 4, 5), (5, 12, 13), (6, 8, 10), (9, 12, 15)]

    """

    return [(x,y,z) for x in range(1, num + 1) if (x <= num) for y in range(x, num + 1) if (y <= num) for z in range(y, num + 1) if (x**2 + y**2 == z**2)]


if __name__ == '__main__':
    import doctest
    doctest.testmod()
