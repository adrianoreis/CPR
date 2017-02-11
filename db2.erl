-module(db2).
-export([db/1, start/0, stop/0, write/2, read/1, match/1, delete/1, init/0]).

init() ->
  db(db:new()).

db(Db)  ->
  receive
    {write, Data, From }   -> From ! ok, 
                              db:write([Data | Db]);
    {read, Key, From}     ->  From ! db:read(Key, Db),
                              db(Db);
    {match, Elem, From}   ->  From ! db:match(Elem, Db),
                              db(Db);
    {delete, Key, From}   ->  Db1 = db:delete(Key, Db),
                              From ! ok,
                              db(Db1);
    {stop, From}          ->  From ! ok
  end.


start() ->
  register(database, spawn(?MODULE, init, [])),
  ok.

stop()  ->   database ! {stop, self()},
             receive
              Msg -> Msg
             end.

write(Key, Element)  -> database ! {write, {Key, Element}, self()},
                       receive
                         Msg  -> Msg
                       end.

read(Key) -> database ! {read, Key, self()},
             receive
               []   -> {error, self()};
               Msg  -> {ok, Msg}
             end.

match(Elem) -> database ! {match, Elem, self()},
               receive
                 Msg  -> get_dbkeys(Msg)
               end.

delete(Key) -> database ! {delete, Key, self()},
               receive
                 Msg  -> Msg
               end.

get_dbkeys([]) -> [];
get_dbkeys([{Key,_}|Tail])  -> [Key | get_dbkeys(Tail)].
