-module(ch02).
-export([listlen/1, listlen2/1, index/2, index2/1, id/1, factorial/1, even/1, number/1,bump/1,average/1,even2/1,member/2, sumFrom1To/1]).

listlen([]) -> 0;
listlen([_|Xs]) -> 1 + listlen(Xs).

listlen2(X) ->
  case X of
    []      -> 0;
    [_|Xs]  -> 1 + listlen2(Xs)
  end.

index(0,[X|_])              -> X;
index(N,[_|Xs]) when N>0    -> index(N-1, Xs).

index2(Z)  ->
  case Z of
    {0,[X|_]}      -> X;
    {N,[_|Xs]} when N>0 -> index2({N-1,Xs})
  end.

id(X) -> X.

%unsafe1(X) ->
%  case X of
%    one -> Y = true;
%    _   -> Z = two
%  end,
%  Y.

factorial(N) when N > 0 ->
  N * factorial(N-1);
factorial(0)  -> 1.

%even(Int) when Int rem 2 == 0 -> true;
%even(Int) when Int rem 2 == 1 -> false.

number(Num) when is_integer(Num)  -> integer;
number(Num) when is_float(Num)  -> float;
number(_Other)                  -> false.


%test(X)  ->
%  boolean:b_not(X).
%
%bump([])  -> [];
%bump([H|T]) -> [ H + 1 | bump(T)].
%

%average(List)  -> sum(List) / case len(List) of
%                                0 -> 1;
%                                _ -> len(List)
%                              end.
% average(List)  -> X = sum(List),
%                   Y = len(List),
%                   case Y of
%                     0 -> 0;
%                     _ -> X / Y
%                   end.


%sum([]) -> 0;
%sum([Head | Tail])  -> Head + sum(Tail).
%
%len([]) -> 0;
%len([_ | Tail]) -> 1 + len(Tail).

even([])                        -> [];
even([X|Xs]) when X rem 2 == 0  -> [ X | even(Xs)];
even([_|Xs])                   -> even(Xs).

even2([])   -> [];
even2([X|Xs]) -> case X rem 2  of
                   0  -> [ X | even(Xs)];
                   _  -> even(Xs)
                 end.

member(_,[])        -> false;
member(X,[X|_])     -> true;
member(X,[_|Tail])  -> member(X, Tail).


bump(X)           -> bump2(X,[]).

bump2([],X)       -> reverse(X,[]);
bump2([H | T], X) -> bump2(T, [H+1|X]).

reverse([],X)       -> X;
reverse([H | T], X) ->reverse(T, [H|X]).


average(List) -> average_acc(List, 0, 0).

average_acc([], _Sum, 0)           -> 0;
average_acc([], Sum, Length)      -> Sum/Length;
average_acc([X|Xs], Sum, Length)  -> average_acc(Xs, X+Sum, Length+1).

sumFrom1To(Boundary)  -> sum_acc(1, Boundary, 0).

sum_acc(Index, Boundary, Sum) when Boundary >= Index  -> sum_acc(Index +1, Boundary, Sum+Index);
sum_acc(_,_,Sum)                                      -> Sum.



