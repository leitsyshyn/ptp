:- module(section_ii_task2_tests, [section_ii_task2_tests/1]).

:- use_module('../../src/SectionII/task2').

section_ii_task2_tests(
    test_group('Section II, task 2', [
        test_case('empty list', [], Runs1, section_ii_task2:split_increasing_runs([], Runs1)),
        test_case(
            'statement example',
            [[5], [4], [2, 8], [3], [1, 6, 9], [5]],
            Runs2,
            section_ii_task2:split_increasing_runs([5, 4, 2, 8, 3, 1, 6, 9, 5], Runs2)
        ),
        test_case(
            'strictly increasing list stays whole',
            [[1, 2, 3, 4]],
            Runs3,
            section_ii_task2:split_increasing_runs([1, 2, 3, 4], Runs3)
        ),
        test_case(
            'equal adjacent values start new run',
            [[3], [3, 4], [4, 5]],
            Runs4,
            section_ii_task2:split_increasing_runs([3, 3, 4, 4, 5], Runs4)
        )
    ])
).
