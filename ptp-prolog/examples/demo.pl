:- use_module('../src/tasks').

:- initialization(main, main).

main :-
    SectionIATask27Input = [1, 1, 1, 2, 2, 3, 4, 4, 4, 4],
    keep_odd_frequency_elements(SectionIATask27Input, SectionIATask27Result),
    format('Section I-a, task 27~nInput: ~w~nOutput: ~w~n~n', [SectionIATask27Input, SectionIATask27Result]),
    SectionIBTask65Input = [11, 4, 5, 0, 17, 18, -3, 19, 20, 1],
    split_prime_nonprime(SectionIBTask65Input, Primes, NonPrimes),
    format('Section I-b, task 65~nInput: ~w~nPrimes: ~w~nNon-primes: ~w~n~n', [SectionIBTask65Input, Primes, NonPrimes]),
    SectionIITask2Input = [5, 4, 2, 8, 3, 1, 6, 9, 5],
    split_increasing_runs(SectionIITask2Input, Runs),
    format('Section II, task 2~nInput: ~w~nOutput: ~w~n', [SectionIITask2Input, Runs]).
