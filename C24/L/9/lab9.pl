% -*- Mode: Prolog -*-
:- module(lab9, [nat/1, sum/3, prod/3]).

female(alice).
female(eve).
female(ida).

male(bob).
male(charlie).
male(frank).
male(gary).
male(harry).

parent(charlie,bob).
parent(eve,bob).
parent(charlie,alice).
parent(eve,alice).
parent(frank,charlie).
parent(gary,frank).
parent(frank, harry).
parent(harry, ida).

%% write the following queries (not in this file!):

% -- is alice female?
% -- Ans: female(alice)

% -- is alice male?
% -- Ans: male(alice)

% -- who is female?
% -- Ans: female(Female)

% -- who is a parent of bob?
% -- Ans: parent(bobParent,bob)

% -- who is a parent?
% -- Ans: parent(Parent,_)

% -- who are the children of eve?
% -- Ans: parent(eve,Child)

%% write the following in first order logic first, and then in Prolog.
%% make sure to ask several queries for each of these predicates.

% isaParent(?X) iff X is a parent.
isaParent(X) :-     % Note: `:-` means True if ()...)
    parent(X, _).

% isaChild(?X) iff X is a child.
isaChild(X) :-
    parent(_, X).

% isaSon(?X) iff X is a son.
isaSon(X) :-
    male(X), parent(_,X).

% isaMother(?X) iff X is a mother.
isaMother(X) :-
    female(X), parent(X,_).

% grandparent(?X,?Y) iff X is a grandparent of Y.
grandparent(X,Y) :-
    parent(X,Z), parent(Z,Y).

% sibling(?X,?Y) iff X is a sibling of Y.
sibling(X,Y) :-
    parent(Z,X), parent(Z,Y).

% cousin(?X, ?Y) iff X is a cousin of Y.
cousin(X,Y) :-
    sibling(X_parent,Y_parent), parent(X_parent,X), parent(Y_parent,Y), X_parent \= Y_parent.

% person(?X) iff X is a person (male or female).
person(X) :-
    male(X); female(X).

% ancestor(?X,?Y) iff X is an ancestor of Y.
ancestor(X,Y) :-
    parent(X,Z), ancestor(Z,Y).     % Note: Recursive query. Goes down the family tree (i.e., child to child)

% related(?X,?Y) iff X and Y share an ancestor.
related(X,Y) :-
    ancestor(Z,X), ancestor(Z,Y).

% Represent all natural numbers as follows:
%  zero, s(zero), s(s(zero)), ...

nat(zero).              % Define zero.
nat(s(X)) :- nat(X).    % s(X) is a natural number, if X is a natural number

% nat(?X) iff X is a natural number represented as above.
nat(X) :-
    X = zero;           % X is either 0
    X = s(Y), nat(Y).   % Or X is the successor of some natural number

% sum(+X, +Y, ?Z) iff Z is the sum of X and Y
sum(X,Y,Z) :-       % Note: +X, +Y means that X and Y must be given before calling the predicate, while ?Z is optional to define (e.g., `_` can be used)
    Z is X + Y.

% prod(+X, +Y, ?Z) iff Z is the product of X and Y.
prod(X,Y,Z) :-
    Z is X * Y.
