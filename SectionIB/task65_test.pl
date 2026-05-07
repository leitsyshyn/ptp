:- module(section_ib_task65_test, [section_ib_task65_tests/1]).

:- use_module('../test_runner').
:- use_module(task65_solution).

:- initialization(main, main).

main :-
    section_ib_task65_tests(Tests),
    run_test_main(Tests).

section_ib_task65_tests(
    test_group('Section I-b, task 65', [
        test_case('input [] -> expected primes=[], non-primes=[]', []-[], Primes1-NonPrimes1, section_ib_task65:split_prime_nonprime([], Primes1, NonPrimes1)),
        test_case(
            'input [11,4,5,0,17,18,-3,19,20,1] -> expected primes=[11,5,17,19], non-primes=[4,0,18,-3,20,1]',
            [11, 5, 17, 19]-[4, 0, 18, -3, 20, 1],
            Primes2-NonPrimes2,
            section_ib_task65:split_prime_nonprime([11, 4, 5, 0, 17, 18, -3, 19, 20, 1], Primes2, NonPrimes2)
        ),
        test_case('input [2] -> expected primes=[2], non-primes=[]', [2]-[], Primes3-NonPrimes3, section_ib_task65:split_prime_nonprime([2], Primes3, NonPrimes3)),
        test_case(
            'input [0,1,-5] -> expected primes=[], non-primes=[0,1,-5]',
            []-[0, 1, -5],
            Primes4-NonPrimes4,
            section_ib_task65:split_prime_nonprime([0, 1, -5], Primes4, NonPrimes4)
        )
    ])
).
