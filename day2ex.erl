-module(day2ex).
%-export([echo/0, start/0, print/1, stop/0, fwd/0, tst/0, procs/1]).
-compile(export_all).
echo()  ->
  receive
    {print, Msg}  -> io:format("~p~n",[Msg]) ,
                   echo();
    stop  -> ok
  end.

start() ->
  register(echo, spawn(?MODULE, echo, [])),
  ok.

print(Term) ->
  echo ! {print, Term}.

stop()  ->
  echo ! stop, 
  ok.

fwd() ->
  receive
    {{Msg, 0}, _, _}                      ->  %io:format("~p received ~p~n", [self(), Msg]),
                                              fwd();
    {{Msg, N},[NextPid|NextPids], Pids}   ->  io:format("[~p] ~p received ~p~n", [N, self(), Msg]),
                                              NextPid ! {{Msg, N}, NextPids, Pids},
                                              fwd();
    {{Msg, N},[], [Pid|Pids]}             ->  io:format("[~p] ~p received ~p~n", [N, self(), Msg]),
                                              Pid ! {{Msg, N-1}, Pids, [Pid|Pids]},
                                              fwd();
    {stop, [NextPid|NextPids], Pids}      ->  io:format("~p stopping~n", [self()]),
                                              NextPid ! {stop, NextPids, Pids};
    {stop, _, _}                          ->  io:format("~p stopping~n", [self()]) 
  end.

start(M, N, Msg)  ->
  %M numer of messages, N number of processes
  Pids = create_processes(N),
  send_message(M, Pids, Msg),
  Pids.

create_processes(0) -> [];
create_processes(N) -> [spawn(?MODULE, fwd, []) | create_processes(N-1)].

send_message(0, _, _) ->  io:format("No more messages.~n");
send_message(M, [Pid|Pids], Msg)  -> Pid ! {{Msg, M}, Pids, [Pid|Pids]},
                                     send_message(M-1, [Pid|Pids], Msg).

stop([])          -> io:format("All processes stopped.~n");
stop([Pid|Pids])  -> Pid ! {stop, Pids, [Pid|Pids]},
                     stop(Pids).

