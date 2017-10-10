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
grandmother(X,Y) :- mother(X,Z), parent(Z,Y).

% ------ uebung 1d) --------
offspring(X,Y) :- parent(Y,X).
offspring(X,Y) :-
    parent(Z,X),
    offspring(Z,Y).

% ------ uebung 3 --------
word(n,e,u). word(t,o,p). word(t,o,t). word(b,r,o,t).
word(g,r,a,u). word(h,a,l,t). word(a,l,l,e). word(j,e,t,z,t).
word(s,a,g,e,n). word(u,n,t,e,n). word(z,e,c,k,e).

solution(L1,L2,L3,L4,L5,L6,L7,L8,L9,L10,L11,L12):-
    word(L2,L3,L4,L5),
    word(L8,L9,L10,L11,L12),
    word(L1,L3,L6,L8),
    word(L5,L7,L10).

% ------ uebung 4 --------
n(gelb,rot). n(gelb,grün).
n(rot,gelb). n(rot,grün).
n(grün,gelb). n(grün,rot).

colors(LU,NW,OW,SZ,UR,ZG):-
    UR = gelb,
    SZ = rot,
    n(LU,NW), n(LU,OW), n(LU,SZ), n(LU,ZG),
    n(NW,LU), n(NW,OW), n(NW,SZ), n(NW,UR),
    n(OW,LU), n(OW,NW), n(OW,UR),
    n(SZ,LU), n(SZ,NW), n(SZ,UR), n(SZ,UR),
    n(UR,NW), n(UR,OW), n(UR,SZ),
    n(ZG,LU), n(ZG,SZ).

% ------ uebung 5 --------
% xfx operator mother/2
% liz mother X ==> x=tom; X=joe
% op(1150,xfx, mother).
%
% xfx offspring/2
% ann offspring mike ==> true
% op(1150,xfx,offspring).
%

% ------ uebung 7 --------
mult(1,X,X).
mult(X,1,X).
mult(_,0,0).
mult(0,_,0).

mult(X,Y,Z):-
    X >1,
    X2 is X-1,
    mult(X2,Y,Z2),
    Z is Z2 + Y.
