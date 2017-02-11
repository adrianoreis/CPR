-module(ch03ex).
%-export([sum/1, sum/2, sum2/2, reverse_create/1, reverse/1]).
-compile(export_all).
% 3.1
sum(1)  ->  1;
sum(N) when N > 0  ->  N + sum(N-1).

sum(N, N) -> N;
sum(N, M) when N =< M -> N + sum(N+1, M).

sum2(N, M)  -> sum_acc(N, M, 0).

sum_acc(N, N, Sum) -> N + Sum;
sum_acc(N, M, Sum) when N =< M -> sum_acc(N+1, M, N+Sum).

% 3.2
reverse_create(0)   -> [];
reverse_create(N)   -> [N | reverse_create(N-1)].

reverse_list([])  -> [];
reverse_list([H | T]) -> reverse_list(T) ++ [H].

create(N) -> L = reverse_create(N),
             reverse_list(L).

create2(N)  -> create(1, N).


create(N, N)              -> [N];
create(N, M)  when N =< M -> [ N | create(N+1, M)]. 

create(N, M, Xs) when N =< M -> create(N+1, M, [N|Xs]);
create(_, _, Xs) -> Xs.

createR(N, M, Xs) when N =< M -> createR(N, M-1, [M|Xs]);
createR(_, _, Xs) -> Xs.

print(X, Y) when X < Y -> io:format("~p~n",[X]),
               print(X+1, Y);
print(X, X) -> io:format("~p~n", [X]).

print(N)  -> print(1,N).

%printEven(X,X) -> io:format("Number:~p~n", [X]);
%printEven(X, Y) when X rem 2 == 0 -> io:format("Number:~p~n",[X]),
%                                     print(X+1, Y);
%printEven(X, Y) -> print(X+1, Y).


printEven(X, Y) when 2*X =< Y -> io:format("Number:~p~n", [2*X]),
                                printEven(X+1, Y);
printEven(_,_)  -> ok.

