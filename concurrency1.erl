-module(concurrency1).
-compile(export_all).


dolphin1()  ->
  receive
    do_a_flip -> io:format("How about no?~n");
    fish      -> io:format("Thanks!~n");
    _         -> io:format("Bleh...anything else.~n")
  end.

dolphin2()  ->
  receive
    {From, do_a_flip}  -> From ! "How about you?";
    {From, fish}      -> From ! "Thanks for the fish";
    _         -> io:format("Bleh...~n")
  end.

fridge1() ->
  receive
    {From, {store, _Food}}  -> From ! {self(), ok},
                               fridge1();
    {From, {take, _Food}}   -> From ! {self(), not_found},
                               fridge1();
    terminate               -> ok
  end.

fridge2(FoodList) ->
  receive
    {From, {store, Food}}  -> From ! {self(), ok},
                              fridge2([Food|FoodList]);
    {From, {take, Food}}   ->
      case lists:member(Food, FoodList) of
        true ->  From ! {self(), {ok, Food}},
                 fridge2(lists:delete(Food, FoodList));
        false -> From ! {self(), {ok, not_found}},
                 fridge2(FoodList)
      end;
    terminate               -> ok
  end.

store(Pid, Food)  ->
  Pid ! {self(), {store, Food}},
  receive
    {Pid, Msg}  -> Msg
  end.

take(Pid, Food) ->
  Pid ! {self(), {take, Food}},
  receive
    {Pid, Msg}  -> Msg
  end.

