:- module(section_ib_task65, [split_prime_nonprime/3]).

split_prime_nonprime([], [], []).
split_prime_nonprime([Head|Tail], [Head|Primes], NonPrimes) :-
    is_prime(Head),
    split_prime_nonprime(Tail, Primes, NonPrimes).
split_prime_nonprime([Head|Tail], Primes, [Head|NonPrimes]) :-
    \+ is_prime(Head),
    split_prime_nonprime(Tail, Primes, NonPrimes).

is_prime(2).
is_prime(Number) :-
    integer(Number),
    Number > 2,
    Number mod 2 =\= 0,
    has_no_odd_divisor_from(Number, 3).

has_no_odd_divisor_from(Number, Divisor) :-
    Divisor * Divisor > Number.
has_no_odd_divisor_from(Number, Divisor) :-
    Number mod Divisor =\= 0,
    NextDivisor is Divisor + 2,
    has_no_odd_divisor_from(Number, NextDivisor).
