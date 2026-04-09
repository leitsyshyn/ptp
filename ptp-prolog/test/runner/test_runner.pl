:- module(test_runner, [run_test/2]).

run_test(Test, Failures) :-
    run_test(Test, 0, Failures).

run_test(test_group(Name, Tests), Indent, Failures) :-
    write_indented_line(Indent, Name),
    NextIndent is Indent + 2,
    run_tests(Tests, NextIndent, Failures),
    nl.
run_test(test_case(Name, Expected, Actual, Goal), Indent, Failures) :-
    (   once(Goal)
    ->  run_case_result(Name, Expected, Actual, Indent, Failures)
    ;   write_indented_line(Indent, ['[FAIL] ', Name, ' -> goal failed']),
        Failures = 1
    ).

run_tests([], _, 0).
run_tests([Test|Tests], Indent, Failures) :-
    run_test(Test, Indent, FirstFailures),
    run_tests(Tests, Indent, RestFailures),
    Failures is FirstFailures + RestFailures.

run_case_result(Name, Expected, Actual, Indent, 0) :-
    Expected == Actual,
    write_indented_line(Indent, ['[PASS] ', Name]).
run_case_result(Name, Expected, Actual, Indent, 1) :-
    Expected \== Actual,
    term_string(Expected, ExpectedString),
    term_string(Actual, ActualString),
    write_indented_line(
        Indent,
        ['[FAIL] ', Name, ' -> expected ', ExpectedString, ', but got ', ActualString]
    ).

write_indented_line(Indent, Parts) :-
    format('~*c', [Indent, 0' ]),
    write_content(Parts),
    nl.

write_content(Parts) :-
    is_list(Parts),
    write_parts(Parts).
write_content(Part) :-
    \+ is_list(Part),
    write(Part).

write_parts([]).
write_parts([Part|Parts]) :-
    write(Part),
    write_parts(Parts).
