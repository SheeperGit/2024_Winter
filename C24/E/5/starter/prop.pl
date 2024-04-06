% -*- Mode : Prolog -*- 

:- module(prop, [formula/1, eval/3, sub/3]).

same_set(Xs, Ys) :- subset(Xs, Ys), subset(Ys, Xs).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%% FORMULA %%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

formula(tru).
formula(fls).

% variable(V) is a formula iff V is a suitable identifier (in this question we will use “if V is an atom”.
% You can check in Prolog with atom(V)).
formula(variable(V)) :-
    atom(V).

% neg(F) is a formula iff F is a formula.
formula(neg(F)) :- 
    formula(F).

% and(FList) is a formula iff every element in the list FList is a formula.
formula(and([])).           % Empty conjunction is *technically* a valid formula w/ only conjunctions

formula(and([F | Rest])) :-
    formula(F),             % Base Case
    formula(and(Rest)).     % Recursive Case

% or(FList) is a formula iff every element in the list FList is a formula.
formula(or([])).            % Empty disjunction is *technically* a valid formula w/ only disjunctions

formula(or([F | Rest])) :-
    formula(F),             % Base Case
    formula(or(Rest)).      % Recursive Case

% implies(F0,F1) is a formula iff both F0 and F1 are formulae.
formula(implies(F0,F1)) :-
    formula(F0), formula(F1).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%% SUB %%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

sub(tru, _, tru).   % Truth value `tru` is unchanged after substitution.
sub(fls, _, fls).   % Truth value `fls` is unchanged after substitution.

% If Var appears in Asst, its corresponding value is returned.
sub(Var, Asst, Value) :-
    memberchk(Var/Value, Asst), !.

% If Var is not found in the assignment or is not an atom, it doesn't change.
sub(Var, _, Var) :-
    atom(Var),
    \+ Var = tru,
    \+ Var = fls.

% Substituting in a negation means substituting its corresponding inner formula F.
sub(neg(F), Asst, neg(SubF)) :-
    sub(F, Asst, SubF).

% Substituting in a conjunction means substituting each of its components.
sub(and([]), _, and([])).
sub(and([F | Rest]), Asst, and([SubF | SubRest])) :-
    sub(F, Asst, SubF),
    sub(and(Rest), Asst, and(SubRest)).

% Substituting in a disjunction means substituting each of its components.
sub(or([]), _, or([])).
sub(or([F | Rest]), Asst, or([SubF | SubRest])) :-
    sub(F, Asst, SubF),
    sub(or(Rest), Asst, or(SubRest)).

% Substituting in an implication means substituting both of its components.
sub(implies(F0, F1), Asst, implies(SubF0, SubF1)) :-
    sub(F0, Asst, SubF0),
    sub(F1, Asst, SubF1).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%% EVAL %%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%% Base Cases / Truth Tables %%%%%%%%%%%%%%%%%
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

imp_val(fls, fls, tru).
imp_val(tru, fls, fls).
imp_val(fls, tru, tru).
imp_val(tru, tru, tru).

% eval(implies([tru, fls]), _, fls).
% eval(implies([tru, tru]), _, tru).
% eval(implies([fls, fls]), _, tru).
% eval(implies([fls, tru]), _, tru).

eval(variable(F), Asst, V) :- 
    member(F/V, Asst), !.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

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

eval(implies(F0, F1), Asst, Value) :-
    eval(F0, Asst, V0),
    eval(F1, Asst, V1),
    imp_val(V0, V1, Value).

%%%%%%%%%%%% Old Implementation %%%%%%%%%%%%%%%%

% eval(implies(F0, F1), Asst, fls) :- 
%     eval(F0, Asst, tru), eval(F1, Asst, fls).
% eval(implies(F0, F1), Asst, tru) :- 
%     eval(F0, Asst, tru), eval(F1, Asst, tru).
% eval(implies(F0, F1), Asst, tru) :- 
%     eval(F0, Asst, fls), eval(F1, Asst, fls).
% eval(implies(F0, F1), Asst, tru) :- 
%     eval(F0, Asst, fls), eval(F1, Asst, tru).

% eval(tru, _, tru).
% eval(fls, _, fls).

% eval(Var, Asst, Value) :-
%     memberchk(Var/Value, Asst), !.

% eval(Var, _, _) :-
%     atom(Var),
%     \+ Var = tru,
%     \+ Var = fls,
%     fail.

% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% eval(neg(F), Asst, tru) :-
%     eval(F, Asst, fls).

% eval(neg(F), Asst, fls) :-
%     eval(F, Asst, tru).
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% eval(and([], _), _, tru).

% eval(and([F|Rest]), Asst, Value) :-
%     eval(F, Asst, tru),
%     eval(and(Rest), Asst, Value).

% eval(and([F|_]), Asst, fls) :-
%     eval(F, Asst, fls).
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% eval(or([], _), _, fls).
% eval(or([A|_]), [A/tru|_], tru).

% eval(or([F|Rest]), Asst, Value) :-
%     eval(F, Asst, tru),
%     eval(or(Rest), Asst, Value).

% eval(or([F|_]), Asst, tru) :-
%     eval(F, Asst, tru).
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% imp_val(fls, fls, tru).
% imp_val(tru, fls, fls).
% imp_val(fls, tru, tru).
% imp_val(tru, tru, tru).

% eval(implies(F0, F1), Asst, Value) :-
%     eval(F0, Asst, V0),
%     eval(F1, Asst, V1),
%     imp_val(V0, V1, Value).

% % imp_val(_, _, tru).
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

