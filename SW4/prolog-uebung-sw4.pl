
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
