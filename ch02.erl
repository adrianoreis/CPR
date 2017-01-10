-module(ch02).
-export([listlen/1, listlen2/1, index/2, index2/1, id/1, factorial/1, even/1, number/1,bump/1]).

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

even(Int) when Int rem 2 == 0 -> true;
even(Int) when Int rem 2 == 1 -> false.

number(Num) when is_integer(Num)  -> integer;
number(Num) when is_float(Num)  -> float;
number(_Other)                  -> false.


%test(X)  ->
%  boolean:b_not(X).
%
bump([])  -> [];
bump([H|T]) -> [ H + 1 | bump(T)].
