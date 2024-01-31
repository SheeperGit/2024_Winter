"""Review: some simple exercises on recursion. Use Python3.11.  Please
implement ALL of the following RECURSIVELY.  Otherwise it defeats the
purpose of this lab --- we need to freshen up on our recursion skills.

You have until Friday 6p.m. to submit your work on MarkUs.

For full marks, this and every other piece of Python code you submit
must pass flake8 and pylint. See course website for required versions
of the software.

"""


def length(lst: list) -> int:
    """Return the number of elements (top level) in lst.

    >>> length([1, 2, 3, 4, 5])
    5
    """

    if not lst: 
        return 0
    return 1 + length(lst[1:])


def reverse(lst: list) -> list:
    """Return the reverse of lst.
    >>> reverse([1, 2, 3, 4, 5])
    [5, 4, 3, 2, 1]
    >>> reverse([1, 2, 3, 4])
    [4, 3, 2, 1]
    >>> reverse([1])
    [1]
    >>> reverse([1, 2])
    [2, 1]
    """

    if not lst:
        return lst

    return [lst[-1]] + reverse(lst[:-1])


def is_pal(lst: list) -> bool:
    """Return whether lst is a palindrome.

    For fun, do not use an if-statement.
    >>> is_pal(['r', 'a', 'c', 'e', 'c', 'a', 'r'])
    True
    >>> is_pal(['w', 'a', 't', 'e', 'r'])
    False
    >>> is_pal([])
    True
    >>> is_pal(['1'])
    True
    >>> is_pal(['w', 'h', 'e', 'w'])
    False
    """

    return len(lst) <= 1 or lst[0] == lst[-1] and is_pal(lst[1:-1])
    # An alternative solution would be: 
    # return lst == lst[::-1]
    # lst[::-1] returns a reversed list using [start:stop:count] structure


def num_el(lst: list) -> int:
    """Return the number of (non-list) elements of lst, on any nesting
    level.

    >>> num_el([1, 2, 3])
    3
    >>> num_el([])
    0
    >>> num_el([1])
    1
    >>> num_el([[1]])
    1
    >>> num_el([1, [2, 3, 4, 5], 6, [7, [8, 9], [10]]])
    10
    """

    if not lst:
        return 0

    if type(lst[0]) == list:
        return num_el(lst[0]) + num_el(lst[1:])
    
    return 1 + num_el(lst[1:])


def sum_els(lst: list) -> int:
    """Return the sum of all numbers in lst, on any nesting level. Return
    0 on an empty list.

    >>> sum_els([])
    0
    >>> sum_els([2, 2, 2])
    6
    >>> sum_els([2, [2, 2, [2, 2, [2]], 2, [2, 2, 2]]])
    20
    """

    if not lst:
        return 0

    if type(lst[0]) == list:
        return sum_els(lst[0]) + sum_els(lst[1:])
    
    return lst[0] + sum_els(lst[1:])


def repeat_twice(lst: list) -> list:
    """Return a list of elements of lst, each repeated twice, in the same
    order as they appear in lst.

    >>> repeat_twice(['c', '2', '4'])
    ['c', 'c', '2', '2', '4', '4']
    >>> repeat_twice([])
    []
    >>> repeat_twice(['c'])
    ['c', 'c']
    """

    if not lst:
        return lst
    
    p = lst[0:1]    # Slicing returns a list of 1 element, as opposed to just the elem itself
    q = lst[1:]
    return (2 * p) + repeat_twice(q)


def my_filter(func: callable, lst: list) -> list:
    """Return a list of those elements from lst that pass the function
    func (i.e., func(x) is True for element x in lst), in their
    original order.

    func is a boolean-valued function applicable to every element of
    lst.

    >>> my_filter(is_pal, [])
    []
    >>> my_filter(is_pal, [['r', 'a', 'c', 'e', 'c', 'a', 'r']])
    [['r', 'a', 'c', 'e', 'c', 'a', 'r']]
    >>> my_filter(is_pal, [['r', 'a', 'c', 'e', 'c', 'a', 'r'], ['w', 'o', 'w'], ['b', 'a', 'd']])
    [['r', 'a', 'c', 'e', 'c', 'a', 'r'], ['w', 'o', 'w']]
    """
    if not lst:
        return lst
    
    if func(lst[0]):
        return lst[0:1] + my_filter(func, lst[1:])  # Once again, the slicing ensures that a list of 1 elem is returned
    
    lst.pop(0)  # Del first elem, since it didn't pass func
    if not lst:
        return my_filter(func, lst)
    return my_filter(func, lst[0])


def my_map(func: callable, lst: list) -> list:
    """Return a list of results of applying func to each element of lst.

    func is applicable to every element of lst.
    >>> my_map(reverse, [[1, 2, 3], [4, 5], [6]])
    [[3, 2, 1], [5, 4], [6]]
    >>> my_map(reverse, [[1, 2, 3], [4, 5], [6, 7], [8, 9, 10], [11], [12, 13]])
    [[3, 2, 1], [5, 4], [7, 6], [10, 9, 8], [11], [13, 12]]
    >>> my_map(repeat_twice, [['c', '2', '4']])
    [['c', 'c', '2', '2', '4', '4']]
    >>> my_map(repeat_twice, [['c', '2', '4'], ['3', '6']])
    [['c', 'c', '2', '2', '4', '4'], ['3', '3', '6', '6']]
    """

    if not lst:
        return lst
    
    return [func(lst[0])] + my_map(func, lst[1:])


if __name__ == '__main__':

    import doctest
    doctest.testmod()
