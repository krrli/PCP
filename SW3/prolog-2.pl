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