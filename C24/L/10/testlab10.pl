% -*- Mode : Prolog -*-

:- use_module(lab10, [trip/2, trip/3, cost/3, reverse/2, intersect/3, union/3]).

:- begin_tests(lab10).
:- use_module(library(lists)).

test('london->maldives', nondet) :-
    trip(london, maldives).

test('to->') :-
    setof(Dest, trip(to,Dest), [bombay,katmandu,london,maldives,ny,oslo,stockholm]).

test('[1,2,3,4,5]', all(R = [[5,4,3,2,1]])) :-
    reverse([1,2,3,4,5], R).

test('[1,2,3]|[1,2,3,4,5,6]=[1,2,3]') :-
    setof(I, intersect([1,2,3], [1,2,3,4,5,6], I), [I]), sort(I, [1,2,3]).

test('[1,2,3]U[1,2,3,4,5,6]=[1,2,3,4,5,6]') :-
    setof(U, union([1,2,3], [1,2,3,4,5,6], U), [U]), sort(U, [1,2,3,4,5,6]).

:- end_tests(lab10).

?- run_tests.
