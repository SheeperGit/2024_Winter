% -*- Mode : Prolog -*- 

:- module(prop, [formula/1, eval/3, sub/3]).

same_set(Xs, Ys) :- subset(Xs, Ys), subset(Ys, Xs).

% formula(?F) iff F is a formula
formula(tru).
formula(fls).
formula(variable(F)) :- atom(F).
formula(neg(F)) :- formula(F).
formula([F|_]) :- formula(F).
formula(and([Head|Tail])) :- formula(Head), formula(Tail).
formula(or([Head|Tail])) :- formula(Head), formula(Tail).
formula(implies(F0, F1)) :- formula(F0), formula(F1).

% sub(?F, ?Asst, ?G) iff G is the formula that results from substituting the variables in F with the corresponding values in Asst
sub(tru, _, tru).
sub(variable(tru), _, tru).
sub(fls, _, fls).
sub(variable(fls), _, fls).
sub(F, Asst, G) :- member(F/G, Asst).
sub(variable(F), Asst, variable(G)) :- sub(F, Asst, G).
sub(variable(F), Asst, G) :- sub(F, Asst, G).
sub(neg(F), Asst, neg(G)) :- sub(F, Asst, G).
sub([F|_], Asst, [G|_]) :- sub(F, Asst, G).
sub(and([FH|FT]), Asst, and([GH|GT])) :- sub(FH, Asst, GH), sub(FT, Asst, GT).
sub(or([FH|FT]), Asst, and([GH|GT])) :- sub(FH, Asst, GH), sub(FT, Asst, GT).
sub(implies(F0, F1), Asst, implies(G0, G1)) :- sub(F0, Asst, G0), sub(F1, Asst, G1).

% eval(?F, ?Asst, ?V) iff the formula F equals V when each variable has the truth assignment in Asst
eval(tru, _, tru).
eval(fls, _, fls).

eval(variable(tru), _, tru).
eval(variable(fls), _, fls).

eval(neg(tru), _, fls).
eval(neg(fls), _, tru).

eval(and([tru, tru]), _, tru).
eval(and([_, fls]), _, fls).
eval(and([fls, _]), _, fls).

eval(or([tru, _]), _, tru).
eval(or([_, tru]), _, tru).
eval(or([fls, fls]), _, fls).

eval(implies([tru, fls]), _, fls).
eval(implies([tru, tru]), _, tru).
eval(implies([fls, fls]), _, tru).
eval(implies([fls, tru]), _, tru).

eval(variable(F), Asst, V) :- 
    member(F/V, Asst), !.

eval([F|_], Asst, V) :- 
    eval(F, Asst, V).

eval(neg(F), Asst, tru) :- 
    eval(F, Asst, fls).
eval(neg(F), Asst, fls) :- 
    eval(F, Asst, tru).

eval(and([H|T]), Asst, tru) :- 
    eval(H, Asst, tru), eval(T, Asst, tru).
eval(and([H|_]), Asst, fls) :- 
    eval(H, Asst, fls).
eval(and([_|T]), Asst, fls) :- 
    eval(T, Asst, fls).

eval(or([H|T]), Asst, fls) :- 
    eval(H, Asst, fls), eval(T, Asst, fls).
eval(or([H|_]), Asst, tru) :- 
    eval(H, Asst, tru).
eval(or([_|T]), Asst, tru) :- 
    eval(T, Asst, tru).

eval(implies(F0, F1), Asst, fls) :- 
    eval(F0, Asst, tru), eval(F1, Asst, fls).
eval(implies(F0, F1), Asst, tru) :- 
    eval(F0, Asst, tru), eval(F1, Asst, tru).
eval(implies(F0, F1), Asst, tru) :- 
    eval(F0, Asst, fls), eval(F1, Asst, fls).
eval(implies(F0, F1), Asst, tru) :- 
    eval(F0, Asst, fls), eval(F1, Asst, tru).