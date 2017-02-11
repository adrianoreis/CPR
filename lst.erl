-module(lst).
%-export([filter/2, reverse/1, reverse1/1, quicksort/1]).
-compile(export_all).

%ADVANCED: Manipulating lists
% A
filter([], _) -> [];
filter([H | T], X) when H =< X -> [H | filter(T, X)];
filter([_ | T], X)  -> filter(T, X).

% B
reverse([]) -> [];
reverse([H | T])  -> reverse(T) ++ [H].

reverse1(List)  -> reverse_acc(List, []).

reverse_acc([H|T], Acc)   -> reverse_acc(T, [H|Acc]);
reverse_acc([], Acc)      -> Acc.

% Quick sort
%
quicksort([]) ->  [];
quicksort([X]) -> [X];
quicksort([X|T])  ->  quicksort(lt(X, T)) ++ [X| quicksort(gt(X, T))].

gt(X, List) -> [Y || Y <- List, Y > X].
lt(X, List) -> [Y || Y <- List, Y < X].
%greater_than(_, []) -> [];
%greater_than(X, [H|T]) when H > X -> [H |greater_than(X, T)];
%greater_than(X, [_|T])  -> greater_than(X, T).
%
%less_than(_, []) -> [];
%less_than(X, [H|T]) when H < X -> [H | less_than(X, T)];
%less_than(X, [_|T])  -> less_than(X, T).

%mergesort([]) -> [];
%mergesort([X])  -> [X];
%mergesort(List) -> X = length1(List) div 2,
%                   {L, R} = lists:split(X, List),
%                   mergesort(L) ++ mergesort(R).
%
%split([X], _, _, _)  -> {[X],[]};
%split(List, L, R, Pos) ->

length1(List)  -> length1(List, 0).

length1([], Acc)  -> Acc;
length1([_|T], Acc) -> length1(T, 1+ Acc).
