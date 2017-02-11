-module(ch04).
-compile(export_all).


go2() ->
  register(echo, spawn(ch04, loop1, [])),
  echo ! {self(), hello},
  receive
    {_Pid, Msg}  -> io:format("~w~n", [Msg])
  end.

loop1() ->
  receive
    {From, Msg} -> From ! {self(), Msg},
                   loop();
    stop  -> true
  end.

go() ->
  Pid = spawn(ch04, loop, []),
  Pid ! {self(), hello},
  receive
    {Pid, Msg}  -> io:format("~w~n", [Msg])
  end,
  Pid ! stop.

loop() ->
  receive
    {From, Msg} -> From ! {self(), Msg},
                   loop();
    stop  -> true
  end.


send_after(Time, Msg) ->
  spawn(?MODULE, send, [self(), Time, Msg]).

send(Pid, Time, Msg) ->
  receive
  after
    Time -> Pid ! Msg
  end.
