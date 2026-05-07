:- module(section_ii_task2_test, [section_ii_task2_tests/1]).

:- use_module('../test_runner').
:- use_module(task2_solution).

:- initialization(main, main).

main :-
    section_ii_task2_tests(Tests),
    run_test_main(Tests).

section_ii_task2_tests(
    test_group('Section II, task 2', [
        test_case('input [] -> expected []', [], Runs1, section_ii_task2:split_increasing_runs([], Runs1)),
        test_case(
            'input [5,4,2,8,3,1,6,9,5] -> expected [[5],[4],[2,8],[3],[1,6,9],[5]]',
            [[5], [4], [2, 8], [3], [1, 6, 9], [5]],
            Runs2,
            section_ii_task2:split_increasing_runs([5, 4, 2, 8, 3, 1, 6, 9, 5], Runs2)
        ),
        test_case(
            'input [1,2,3,4] -> expected [[1,2,3,4]]',
            [[1, 2, 3, 4]],
            Runs3,
            section_ii_task2:split_increasing_runs([1, 2, 3, 4], Runs3)
        ),
        test_case(
            'input [3,3,4,4,5] -> expected [[3],[3,4],[4,5]]',
            [[3], [3, 4], [4, 5]],
            Runs4,
            section_ii_task2:split_increasing_runs([3, 3, 4, 4, 5], Runs4)
        )
    ])
).
