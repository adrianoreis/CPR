-module(ring2).
-compile(export_all).

send(Msg, []) -> Msg;
send(Msg, [H | T])  -> H ! send(Msg, T).

fwd(N) ->
  receive
    stop  -> io:format("[~p] stopped", [N]);
    Msg -> io:format("[~p] received ~p~n", [N, Msg])
         %  fwd(N)
  end.

create(N, N) -> [spawn(?MODULE, fwd, [N])];
create(X, N) ->
  Pid = spawn(?MODULE, fwd, [X]),
  [Pid | create(X+1, N)].

send(_M, N, Msg) ->
  Pids = create(N, N),
  self() ! send(Msg, Pids),
  receive
    stop  -> io:format("SENDER stoped~n");
    Msg -> io:format("SENDER received ~p~n", [Msg])
  end.
