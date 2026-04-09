:- module(section_ia_task27_tests, [section_ia_task27_tests/1]).

:- use_module('../../src/SectionIA/task27').

section_ia_task27_tests(
    test_group('Section I-a, task 27', [
        test_case('empty list', [], Result1, section_ia_task27:keep_odd_frequency_elements([], Result1)),
        test_case(
            'keeps values with odd total frequency',
            [1, 1, 1, 3],
            Result2,
            section_ia_task27:keep_odd_frequency_elements([1, 1, 1, 2, 2, 3, 4, 4, 4, 4], Result2)
        ),
        test_case(
            'preserves original order',
            [4, 3, 4, 4],
            Result3,
            section_ia_task27:keep_odd_frequency_elements([2, 1, 2, 4, 1, 3, 4, 4], Result3)
        ),
        test_case(
            'removes everything when all frequencies are even',
            [],
            Result4,
            section_ia_task27:keep_odd_frequency_elements([5, 5, 6, 6, 7, 7], Result4)
        )
    ])
).
