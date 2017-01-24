-module(boolean).
-export([b_not/1,b_and/2,b_or/2, test/0]).

b_not(false)  -> true;
b_not(true)   -> false.

b_and(false,_)  -> false;
b_and(true,A1)   -> A1.

b_or(false,A1) -> A1;
b_or(true,_) -> true.

%b_nand(A,A1) ->  b_not(b_and(A,A1)).
%
test()  -> b_and(b_not(b_and(true,false)),true).
