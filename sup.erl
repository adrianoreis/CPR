-module(sup).
-compile(export_all).

start(SupName)  -> Pid = spawn(?MODULE, supervisor, [[]]),
                   register(SupName, Pid),
                   {ok, Pid}.

start_child(Sup, Mod, Func, Args) -> Sup ! {start, Mod, Func, Args,self()},
                                     receive
                                       Msg -> Msg
                                     end.

stop(Sup) -> Sup ! stop,
             receive
               Msg -> Msg
             end.

supervisor(List)  ->
  receive
    {start, Mod, Func, Args, From}  ->  Pid = spawn(Mod, Func, Args),
                                        Ref = erlang:monitor(process, Pid),
                                        From ! {ok, Pid},
                                        supervisor([{Ref, {Mod, Func, Args, 1}} | List]);
    stop                      ->        ok;
    {'DOWN',Ref,process,_Pid,_} -> {value, {Ref, Tuple}, NewList} = lists:keytake(Ref, 1, List),
                                  case Tuple of
                                    {M,F,_,0} -> io:format("Cannot restart ~p:~p,.~n", [M,F]),
                                                 supervisor(NewList);
                                    {M,F,A,N} -> io:format("Trying to restart ~p:~p.~n", [M,F]),
                                                 Ref1 = spawn(M,F,A),
                                                 erlang:monitor(process,Ref1),
                                                 supervisor([{Ref1,{M,F,A,N-1}}|NewList])
                                  end

  end.

