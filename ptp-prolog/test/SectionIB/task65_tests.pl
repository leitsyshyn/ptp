:- module(section_ib_task65_tests, [section_ib_task65_tests/1]).

:- use_module('../../src/SectionIB/task65').

section_ib_task65_tests(
    test_group('Section I-b, task 65', [
        test_case('empty list', []-[], Primes1-NonPrimes1, section_ib_task65:split_prime_nonprime([], Primes1, NonPrimes1)),
        test_case(
            'splits prime and non-prime numbers',
            [11, 5, 17, 19]-[4, 0, 18, -3, 20, 1],
            Primes2-NonPrimes2,
            section_ib_task65:split_prime_nonprime([11, 4, 5, 0, 17, 18, -3, 19, 20, 1], Primes2, NonPrimes2)
        ),
        test_case('handles single prime', [2]-[], Primes3-NonPrimes3, section_ib_task65:split_prime_nonprime([2], Primes3, NonPrimes3)),
        test_case(
            'treats numbers less than two as non-prime',
            []-[0, 1, -5],
            Primes4-NonPrimes4,
            section_ib_task65:split_prime_nonprime([0, 1, -5], Primes4, NonPrimes4)
        )
    ])
).
