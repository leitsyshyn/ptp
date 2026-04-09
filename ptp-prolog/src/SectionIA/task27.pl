:- module(section_ia_task27, [keep_odd_frequency_elements/2]).

keep_odd_frequency_elements(List, Result) :-
    keep_odd_frequency_elements(List, List, Result).

keep_odd_frequency_elements(_, [], []).
keep_odd_frequency_elements(FullList, [Head|Tail], [Head|ResultTail]) :-
    count_occurrences(FullList, Head, Count),
    Count mod 2 =:= 1,
    keep_odd_frequency_elements(FullList, Tail, ResultTail).
keep_odd_frequency_elements(FullList, [Head|Tail], Result) :-
    count_occurrences(FullList, Head, Count),
    Count mod 2 =:= 0,
    keep_odd_frequency_elements(FullList, Tail, Result).

count_occurrences([], _, 0).
count_occurrences([Value|Tail], Value, Count1) :-
    count_occurrences(Tail, Value, Count),
    Count1 is Count + 1.
count_occurrences([Head|Tail], Value, Count) :-
    Head \= Value,
    count_occurrences(Tail, Value, Count).
