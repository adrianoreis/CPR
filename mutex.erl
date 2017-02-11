-module(mutex).
-export([start/0, init/0, signal/0, wait/0]).


start() ->
  register(mutex, spawn( ?MODULE, init, [])).

init()  ->
  free().

wait()  ->
  mutex ! {wait, self()},
  receive
    ok  -> ok
  end.

signal()  ->
  mutex ! {signal, self()},
  ok.

free() -> 
  process_flag(trap_exit, true),
  receive
    {wait, Pid}           -> link(Pid),
                             Pid  ! ok, busy(Pid)
  end.

busy(Pid) ->
  receive
    {signal, Pid} -> unlink(Pid), 
                     Pid ! ok,
                     free();
    {'EXIT', Pid, Reason} -> io:format("Trapped exit ~p~n", [Reason]),
                             unlink(Pid),
                             free()
  end.
