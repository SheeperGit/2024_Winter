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
cruise(X,Y) :-
    boat(X,Y);                  %% There exists a (direct) boat trip from X to Y
    boat(X,Z), boat(Z,Y).       %% OR there exists a Z s.t. (...)

% trip(X,Y) -- there is a possible journey (using plane or boat) from X to Y.
trip(X,Y) :-
(   boat(X,Y);                          %% Direct boat
    plane(X,Y);                         %% Direct plane
    cruise(X,Y);                        %% Indirect boat
    (plane(X,Z), plane(Z,Y))    ).      %% Indirect plane

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
trip(X, Y, C) :-
    (plane(X, Y, C); boat(X, Y, C)).         % Base Case

trip(X, Y, TotalCost) :-
    (   (plane(X, Z, Cost1), trip(Z, Y, Cost2)) ;  % Plane trip
        (boat(X, Z, Cost1), trip(Z, Y, Cost2))),   % Boat trip
    TotalCost is Cost1 + Cost2.

trip(X, Y, TotalCost) :-
    (   (plane(X, Z, Cost1), boat(Z, Y, Cost2)) ;  % Plane-2-boat transfer
        (boat(X, Z, Cost1), plane(Z, Y, Cost2))),  % Boat-2-plane transfer
    TotalCost is Cost1 + Cost2.

% cost(X,Y,C) -- there is a trip from X to Y that costs less than C.
cost(X,Y,C) :-
    trip(X,Y,ActualCost),
    ActualCost < C.

% Practise working with lists in Prolog.

% reverse(?L, ?R) iff R is the reverse of list L.
% hint: use append/3.

% complexity of reverse?

% linear-time reverse with an accumulator

% intersect(+X,+Y,?Z) iff Z is the intersection of X and Y
% hint: there is a built-in member/2.

% union(+X,+Y,?Z) iff Z is the union of X and Y

% Now what if we want to know not only whether there is a trip from X to Y, but what
% the trip is?
% full_trip(X,Y,T,C) iff there is a trip T from X to Y with the cost of C. T is a list
%  locations, in order, visited on this trip, beginning with X and ending with Y.
