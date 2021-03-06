% HSLU I, Modul PCP, carla.iten@stud.hlsu.ch
% ------ uebung 1a) --------
fib(0, 0).
fib(1, 1).
fib(N, F) :-
	N > 0,
	N1 is N - 1, N2 is N	- 2,
	fib(N1, F1), fib(N2, F2),
	F is F1 + F2.

fib_tr(N, F) :- fib_tr(N, 0, 1, F).
fib_tr(0, A, _, A).
fib_tr(N, A, B, F) :-
	N1 is N - 1,
	N1 >= 0,
	Sum is A + B,
	fib_tr(N1, B, Sum, F).


io_fib() :-
	write("Gib eine Zahl ein: "),
	read(X),
	fib_tr(X,Y),
	write("Die "), write(X), write(". Fibonacci-Zahl ist " ), write(Y).

% ------ uebung 2 ------
% das da brauchts,
% damit das statische Pr�dikat fak_as zur Laufzeit modifiziert werden darf!
:- dynamic fak_as/2.

fak(0, 1).
fak(N,F):-
	fak_as(N,F),
	write("Hinweis: Fakult�t von "),
	write(N),
	write(" war gespeichert").

fak(N, F) :-
	N > 0,
	N1 is N - 1,
	fak(N1, F1),
	F is N * F1,
	asserta(fak_as(N,F)). % save every fak at the end of calc!

fak_clear() :-
	retractall(fak_as(_,_)),
	write("Hinweis: Alle gespeicherten Werte wurden gel�scht.").

% ------ uebung 3a) ------
% add_tail soll ein Element X am Ende einer Liste L einf�gen ==> L1
% entsteht.
% 1. liste erzeugen mit nur X am Schluss.
% add_tail(X,L,L1):-
%	L9 = X,
%	L8 = L,
%	L1 = [L8 | L9].
%

add(X, L, [X|L]).

% element vorne anh�ngseln
add_tail(X, [], [X]).
add_tail(X,[H|T],[H|L]) :-
	add_tail(X,T,L).

% ------ uebung 3b) ------
% l�scht Element X aus Liste L, L1 entsteht.
% del([a,b,c], c, L).

% Wenn d liste l��r esch.
del([],X,[]).
% Element im Kopf, da wegl�schen.
del([X|T], X,  T).
% Element nicht im Kopf, rest d�reachere & det l�sche
del([H|T], X, [H|L]):-
	del(T,X,L).

% ------ uebung 3c) ------
% mem_d(a,[a,b,c]).
% mem_d(x,[a,b,c]).
% w�ge del([a,b,c], b, L) --> L existiert nur, wenn b in liste drin war!
mem_d(X,L):-
	del(L,X,_).

% ------ uebung 3d) ------
% rev_acc([a,b,c,d], [], L).
% L = [d,c,b,a]

%Initial: Akkumulator = leere Liste
rev_acc([],A,A).
rev_acc([X|L],A,R):-
	rev_acc(L, [X|A], R). % der Liste den Head wegnehmen & henderzi ipacke

% ------ uebung 3e) ------
rev(L,R):-
	rev_acc(L,[], R).

% ------ uebung 4) ------
p_ohni(X):- a(X).  % r1
p_ohni(X):- b(X), c(X). % r2
p_ohni(X):- d(X).  % r3

p(X):- a(X).
p(X):- b(X), !, c(X).
p(X):- d(X).
a(1).
b(2).
b(3).
c(2).
c(3).
d(4).

% ------ uebung 5) ------
warn(T):-
	T < 80,
	write('Temperatur ok').
warn(T):-
	T >= 80,
	T < 100,
	write('Temperatur sehr warm').
warn(T):-
	T >= 100,
	write('Temperatur z heiss!').


% ------ uebung 6) ------
% L = [_, _, _], mem(a, L), mem(b, L), mem(c, L).

mem(X, [X | _]).      % tail doesn�t matter
mem(X, [_| Tail]) :-
	mem(X, Tail). % head doesn�t matter

memp(A, B, C, L):-
	L = [_, _, _],
	mem(A, L),
	mem(B, L),
	mem(C, L),
	!.
