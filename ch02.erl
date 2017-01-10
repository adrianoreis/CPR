-module(ch02).
-export([listlen/1, listlen2/1, index/2]).

listlen([]) -> 0;
listlen([_|Xs]) -> 1 + listlen(Xs).

listlen2(X) ->
  case X of
    []      -> 0;
    [_|Xs]  -> 1 + listlen2(Xs)
  end.

index(0,[X|_])              -> X;
index(N,[_|Xs]) when N>0    -> index(N-1, Xs).

