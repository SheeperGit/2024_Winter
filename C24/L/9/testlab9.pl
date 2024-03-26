% -*- Mode : Prolog -*-

:- use_module(lab9, [nat/1, sum/3, prod/3]).

:- begin_tests(lab9).
:- use_module(library(lists)).

test(nat) :-
    nat(s(s(s(zero)))).

test('2+2=4') :-
    findall(Sum, sum(s(s(zero)),s(s(zero)),Sum), Sums),
    list_to_set(Sums, [s(s(s(s(zero))))]).

test('2*3=6') :-
    findall(Prod, prod(s(s(zero)),s(s(s(zero))),Prod), Prods),
    list_to_set(Prods, [s(s(s(s(s(s(zero))))))]).

:- end_tests(lab9).

?- run_tests.
