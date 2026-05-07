:- module(section_ia_task27_test, [section_ia_task27_tests/1]).

:- use_module('../test_runner').
:- use_module(task27_solution).

:- initialization(main, main).

main :-
    section_ia_task27_tests(Tests),
    run_test_main(Tests).

section_ia_task27_tests(
    test_group('Section I-a, task 27', [
        test_case('input [] -> expected []', [], Result1, section_ia_task27:keep_odd_frequency_elements([], Result1)),
        test_case(
            'input [1,1,1,2,2,3,4,4,4,4] -> expected [1,1,1,3]',
            [1, 1, 1, 3],
            Result2,
            section_ia_task27:keep_odd_frequency_elements([1, 1, 1, 2, 2, 3, 4, 4, 4, 4], Result2)
        ),
        test_case(
            'input [2,1,2,4,1,3,4,4] -> expected [4,3,4,4]',
            [4, 3, 4, 4],
            Result3,
            section_ia_task27:keep_odd_frequency_elements([2, 1, 2, 4, 1, 3, 4, 4], Result3)
        ),
        test_case(
            'input [5,5,6,6,7,7] -> expected []',
            [],
            Result4,
            section_ia_task27:keep_odd_frequency_elements([5, 5, 6, 6, 7, 7], Result4)
        )
    ])
).
