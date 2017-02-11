-module(concurrency2).
-compile(export_all).

important() ->
  receive {Prio, Msg} when Prio > 10 ->
            [ Msg | important()]
  after 0 -> normal()
  end.

normal()  ->
  receive
    {_, Msg} -> [Msg | normal()]
  after 0 -> []
  end.

