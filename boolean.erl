-module(boolean).
-export([b_not/1,b_and/2,b_or/2,b_nand/2]).

b_not(false)  -> true;
b_not(true)   -> false.

b_and(false,_)  -> false;
b_and(true,A1)   -> A1.

b_or(false,A1) -> A1;
b_or(true,_) -> true.

b_nand(A,A1) ->  b_not(b_and(A,A1)).
