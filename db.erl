-module(db).
-export([new/0,destroy/1,write/3, delete/2, read/2, match/2]).

new() -> [].

destroy(_) -> ok.

write(Key, Element, DbRef)  -> [{Key, Element}| DbRef].

delete(_, []) -> [];
delete(Key, [{Key,_}|T]) -> T;
delete(Key, [H|T]) -> [H| delete(Key, T)].

read(_, [])  -> [];
read(Key, [{Key, Value}|_])  -> {Key, Value};
read(Key, [_|T])  -> read(Key, T).

match(_, [])  -> [];
match(Value, [{Key, Value}|T])  -> [{Key, Value}| match(Value, T)];
match(Value, [_ |T])  -> match(Value, T).
