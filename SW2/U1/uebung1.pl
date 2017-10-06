% HSLU I, Modul PCP, carla.iten@stud.hlsu.ch

% ------ facts --------
% all females
female(mary). female(liz). female(mia). female(tina). female(ann). female(sue).
% all males
male(mike). male(jack). male(fred). male(tom). male(joe). male(jim).
% all children of mary
parent(mary, mia). parent(mary, fred). parent(mary, tina).
% all children of mike
parent(mike, mia). parent(mike, fred). parent(mike, tina).
% all children of liz
parent(liz, tom). parent(liz, joe).
% all children of jack
parent(jack, tom). parent(jack, joe).
% all children of mia
parent(mia, ann).
% all children of tina
parent(tina, sue). parent(tina, jim).
% all children of tom
parent(tom, sue). parent(tom, jim).

% ------ uebung 1a) --------
% find out who's the mother/father of s/o. (mother(X, tina), father(X,sue))
% wenn parent(X, sue) und female(X)
mother(X,Y) :- parent(X,Y), female(X).
father(X,Y) :- parent(X,Y), male(X).

% ------ uebung 1b) --------
% sibling/2: are two persons siblings?
sibling(X,Y) :- parent(Z,X), parent(Z,Y).

% ------ uebung 1c) --------
grandmother(X,Y) :- mother(Z,Y), mother(X,Z).
