% -*- Mode: Prolog -*-
:- module(lab10, [trip/2, trip/3, cost/3, reverse/2, intersect/3, union/3, full_trip/4]).

% Planning trips in Prolog.
% plane(A,B) means it is possible to travel from A to B on a plane.
% boat(A,B) means  it is possible to travel from A to B on a boat.
plane(to, ny).
plane(ny, london).
plane(london, bombay).
plane(london, oslo).
plane(bombay, katmandu).
boat(oslo, stockholm).
boat(stockholm, bombay).
boat(bombay, maldives).

% cruise(X,Y) -- there is a possible boat journey from X to Y.
cruise(X, Y) :-
    boat(X, Y).                  % Direct boat trip from X to Y

cruise(X, Y) :-
    boat(X, Z), cruise(Z, Y).      % Indirect boat trip from X to Y via Z


flight(X, Y) :-
    plane(X, Y).                  % Direct boat trip from X to Y

flight(X, Y) :-
    plane(X, Z), flight(Z, Y).      % Indirect boat trip from X to Y via Z

% trip(X,Y) -- there is a possible journey (using plane or boat) from X to Y.
trip(X, Y) :-
    (
        cruise(X,Y);                      % Indirect boat trip from X to Y
        flight(X,Y);                      % Indirect plane trip from X to Y
        (plane(X,Z), cruise(Z,Y));        % Indirect trip involving plane and boat
        (cruise(X,Z), plane(Z,Y));        % Indirect trip involving boat and plane
        (boat(X,Z), flight(Z,Y));
        (flight(X,Z), boat(Z,Y))
    ).


% Now, let's add costs to out trips.
plane(to, ny, 100).
plane(ny, london, 200).
plane(london, bombay, 500).
plane(london, oslo, 50).
plane(bombay, katmandu, 100).
boat(oslo, stockholm, 100).
boat(stockholm, bombay, 1000).
boat(bombay, maldives, 1000).

% trip(X,Y,C) -- there is a trip from X to Y that costs C.
% trip(X, Y, C) :-
%     (plane(X, Y, C); boat(X, Y, C)).                    % Base Case

% trip(X, Y, TotalCost) :-
%     (   (plane(X, Z, Cost1), trip(Z, Y, Cost2));        % Plane trip
%         (boat(X, Z, Cost1), trip(Z, Y, Cost2))      ),  % Boat trip
%     TotalCost is Cost1 + Cost2.

% trip(X, Y, TotalCost) :-
%     (   (plane(X, Z, Cost1), boat(Z, Y, Cost2));        % Plane-2-boat transfer
%         (boat(X, Z, Cost1), plane(Z, Y, Cost2))     ),  % Boat-2-plane transfer
%     TotalCost is Cost1 + Cost2.

%% Alt. Implementation %%
trip(X,Y,C) :- boat(X,Y,C), Cost < C.
trip(X,Y,C) :- plane(X,Y,C), Cost < C.
trip(X,Y,C) :- trip(X,Y,C1), trip(X,Y,C2), C1 + C2 < C.

% length([],0).
% length(L,N) :-
% length([_|Rest], M), M is N -1.

% cost(X,Y,C) -- there is a trip from X to Y that costs less than C.
cost(X,Y,C) :-
    trip(X,Y,ActualCost),
    ActualCost < C.

% Practise working with lists in Prolog.

% reverse(?L, ?R) iff R is the reverse of list L.
% hint: use append/3.
% reverse([],[]).                 % Base Case

% reverse([X|Xs],R) :-            % Recursive Case
%     reverse(Xs,T),              % Reverse tail, and
%     append(T,[X],R)             % Append head to the now-reversed tail
% complexity of reverse?

% linear-time reverse with an accumulator
reverse(List, Rev) :-
    reverse_acc(List, [], Rev).

reverse_acc([], Acc, Acc).
reverse_acc([H|T], Acc, Rev) :-
    reverse_acc(T, [H|Acc], Rev).


% intersect(+X,+Y,?Z) iff Z is the intersection of X and Y
% hint: there is a built-in member/2.
intersect([], _, []).

intersect([H|T], L2, L3) :-
    member(H, L2), !,
    L3 = [H|T3],
    intersect(T, L2, T3).

intersect([_|T], L2, L3) :-
    intersect(T, L2, L3).


% union(+X,+Y,?Z) iff Z is the union of X and Y
union([], Y, Y).            % Base Case

union([X|Xs], Y, Z) :-
    member(X, Y),           % If X is in Y,
    union(Xs, Y, Z).        % then skip X.

union([X|Xs], Y, [X|Z]) :-
    not(member(X, Y)),      % If X is not in Y,
    union(Xs, Y, Z).        % then skip X. (Why does this work?)


% Now what if we want to know not only whether there is a trip from X to Y, but what
% the trip is?
% full_trip(X,Y,T,C) iff there is a trip T from X to Y with the cost of C. T is a list
%  locations, in order, visited on this trip, beginning with X and ending with Y.
full_trip(X, Y, [X,Y], C) :-
    trip(X, Y, C).                  % Base case: direct trip from X to Y

full_trip(X, Y, [X|Rest], C) :-
    trip(X, Z, Cost1),              % Direct/indirect trip from X to Z
    full_trip(Z, Y, Rest, Cost2),   % Recursively find trip from Z to Y
    C is Cost1 + Cost2.