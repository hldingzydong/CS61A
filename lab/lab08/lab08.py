def make_generators_generator(g):
    """Generates all the "sub"-generators of the generator returned by
    the generator function g.

    >>> def every_m_ints_to(n, m):
    ...     i = 0
    ...     while (i <= n):
    ...         yield i
    ...         i += m
    ...
    >>> def every_3_ints_to_10():
    ...     for item in every_m_ints_to(10, 3):
    ...         yield item
    ...
    >>> for gen in make_generators_generator(every_3_ints_to_10):
    ...     print("Next Generator:")
    ...     for item in gen:
    ...         print(item)
    ...
    Next Generator:
    0
    Next Generator:
    0
    3
    Next Generator:
    0
    3
    6
    Next Generator:
    0
    3
    6
    9
    """

    def count_g(n):
        count = 0
        g_g = g()
        while count < n:
            yield next(g_g)
            count = count + 1

    cnt = 0         # calculate how many items will generate max
    for item in g():
        cnt = cnt + 1

    out_count = 1
    while out_count <= cnt:
        yield count_g(out_count)
        out_count = out_count + 1
