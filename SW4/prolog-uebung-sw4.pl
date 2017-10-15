
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
