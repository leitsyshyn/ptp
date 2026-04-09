:- module(section_ii_task2, [split_increasing_runs/2]).

split_increasing_runs([], []).
split_increasing_runs([Head|Tail], [Run|Runs]) :-
    take_increasing_run(Tail, Head, [Head], Run, Rest),
    split_increasing_runs(Rest, Runs).

take_increasing_run([], _, ReversedRun, Run, []) :-
    reverse_list(ReversedRun, Run).
take_increasing_run([Head|Tail], Previous, ReversedRun, Run, [Head|Tail]) :-
    Head =< Previous,
    reverse_list(ReversedRun, Run).
take_increasing_run([Head|Tail], _, ReversedRun, Run, Rest) :-
    take_increasing_run(Tail, Head, [Head|ReversedRun], Run, Rest).

reverse_list(List, Reversed) :-
    reverse_list(List, [], Reversed).

reverse_list([], Accumulator, Accumulator).
reverse_list([Head|Tail], Accumulator, Reversed) :-
    reverse_list(Tail, [Head|Accumulator], Reversed).
