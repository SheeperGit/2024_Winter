% -*- Mode : Prolog -*- 

:- use_module(prop, [formula/1, eval/3, sub/3]).

same_set(Xs, Ys) :- subset(Xs, Ys), subset(Ys, Xs).

:- begin_tests(lists).
:- use_module(library(lists)).

test(formula, fail) :-
        formula(x).

test(formula) :- 
	formula(variable(x)).

test(formula) :-
	formula(implies(variable(a), and([variable(b), neg(fls)]))).

test(eval) :-
	findall(V, eval(or([variable(a)]), [a/tru, b/fls], V), Vs),
	Vs == [tru].

test(eval) :-
 	findall([A,B], eval(implies(variable(a), and([variable(b), neg(fls)])),
 	                [a/A, b/B],
 			tru),
		Assts),
	same_set(Assts, [[tru,tru],[fls,tru],[fls,fls]]).

:- end_tests(lists).
