
% ------ uebung 1 --------

:- use_module(library(clpfd)).
:- use_module(library(clpr)).

fib_clp(N, F) :- { N = 0, F = 0 }.
fib_clp(N, F) :- { N = 1, F = 1 }.
fib_clp(N, F) :-
	{ N >= 2,
	  F = F1+F2,
	  N1 = N-1,
	  N2 = N-2 },
	fib_clp(N1, F1),
	fib_clp(N2, F2).

% funktioniert gar ned?


% ------ uebung 2 --------
% in SetDifference: alle Elemente, welche in Set1 sind, aber nicht in
% Set2.
%
% set_difference([a,b,c,d], [b,d,e,f], [a,c]).

% check if Head from Set1 is part of Set2. if not, check next.
set_difference([H|Set1], Set2, [H|SetDifference]) :-
   \+ member(H, Set2),
   set_difference(Set1, Set2, SetDifference).

% check if Head from Set1 is part of Set2. if yes, add to SetDifference.
set_difference([H|Set1], Set2, SetDifference):-
    member(H,Set2),
    set_difference(Set1, Set2, SetDifference).

set_difference([], _, []).



% ------ uebung 3a) --------
% Tocher ist 15, Mutter 3x so alt. In wievielen Jahren wird die Mutter
% nur noch doppelt so alt sein wie ihre Tochter?

% use_module(library(clpr)).
% {T=15, M=3*T, (M=2*T+X)}


% ------ uebung 3b) --------
% DONALD + GERALD = ROBERT

:- use_module(library(clpfd)).

roebi([D,O,N,A,L,D] + [G,E,R,A,L,D] = [R,O,B,E,R,T]) :-
        Vars = [D,O,N,A,L,G,E,R,B,T],
        Vars ins 0..9,
        all_distinct(Vars),
             D*100000 + O*10000 + N*1000 + A*100 + L*10 + D +
             G*100000 + E*10000 + R*1000 + A*100 + L*10 + D #=
             R*100000 + O*10000 + B*1000 + E*100 + R*10 + T,
        D #\= 0, G #\= 0, R #\= 0,
        label(Vars).

% roebi(As + Bs = Cs).


% ------ uebung 4 --------

female(mary). female(liz). female(mia). female(tina). female(ann). female(sue).
male(mike). male(jack). male(fred). male(tom). male(joe). male(jim).
parent(mary, mia). parent(mary, fred). parent(mary, tina).
parent(mike, mia). parent(mike, fred). parent(mike, tina).
parent(liz, tom). parent(liz, joe).
parent(jack, tom). parent(jack, joe).
parent(mia, ann).
parent(tina, sue). parent(tina, jim).
parent(tom, sue). parent(tom, jim).

mother(X, Y) :-
	parent(X, Y),
	female(X).

father(X, Y) :-
	parent(X, Y),
	male(X).

sibling(X, Y) :-
	parent(Z, X),
	parent(Z, Y).

grandmother(X, Y) :-
	parent(Z, Y),
	mother(X, Z).

grandfather(X, Y) :-
	parent(Z, Y),
	mother(X, Z).

offspring(X, Y) :- parent(Y, X).
offspring(X, Y) :- parent(Z, X),
	parent(Z, Y).


:- use_module(library(http/json_convert)).
:- use_module(library(http/http_json)).
:- use_module(library(http/http_client)).
:- json_object
        relationship(problemKey:integer, relationship:atom, firstPerson:atom, secondPerson:atom),
	solution(solution:atomic, problemKey:integer).

solve(relationship, Id) :-
	atom_concat('http://localhost:16316/problem/relationship/', Id, Url),
	http_get(Url, Json, []),
	json_to_prolog(Json, relationship(Problemkey, Relationship, FirstPerson, SecondPerson)),
	writeln(Relationship),
	writeln(Problemkey),
	writeln(FirstPerson),
	writeln(SecondPerson),
	callRelationship(Problemkey, Relationship, FirstPerson, SecondPerson).

callRelationship(Problemkey, Relationship, FirstPerson, SecondPerson) :-
	\+call(Relationship, FirstPerson, SecondPerson),
	prolog_to_json(solution(false, Problemkey), Json),
	http_post('http://localhost:16316/problem/relationship/', json(Json), _, []).

callRelationship(Problemkey, Relationship, FirstPerson, SecondPerson) :-
	call(Relationship, FirstPerson, SecondPerson),
	prolog_to_json(solution(true, Problemkey), Json),
	http_post('http://localhost:16316/problem/relationship/', json(Json), _, []).

