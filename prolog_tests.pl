:- use_module(test_runner).
:- use_module('SectionIA/task27_test').
:- use_module('SectionIB/task65_test').
:- use_module('SectionII/task2_test').

:- initialization(main, main).

all_tests(
    test_group('PTP Prolog tests', [Task27Tests, Task65Tests, Task2Tests])
) :-
    section_ia_task27_test:section_ia_task27_tests(Task27Tests),
    section_ib_task65_test:section_ib_task65_tests(Task65Tests),
    section_ii_task2_test:section_ii_task2_tests(Task2Tests).

suite_test('all-tests', Tests) :-
    all_tests(Tests).
suite_test('section-ia-task27-tests', Tests) :-
    section_ia_task27_test:section_ia_task27_tests(Tests).
suite_test('section-ib-task65-tests', Tests) :-
    section_ib_task65_test:section_ib_task65_tests(Tests).
suite_test('section-ii-task2-tests', Tests) :-
    section_ii_task2_test:section_ii_task2_tests(Tests).

first_suite_name([], 'all-tests').
first_suite_name([Name|_], SuiteName) :-
    (   atom(Name)
    ->  SuiteName = Name
    ;   atom_string(SuiteName, Name)
    ).

main :-
    current_prolog_flag(argv, Args),
    first_suite_name(Args, SuiteName),
    (   suite_test(SuiteName, Tests)
    ->  true
    ;   format(user_error, 'Unknown test suite: ~w~n', [SuiteName]),
        halt(1)
    ),
    run_test(Tests, Failures),
    format('Total failures: ~w~n', [Failures]),
    (Failures =:= 0 -> true ; halt(1)).
