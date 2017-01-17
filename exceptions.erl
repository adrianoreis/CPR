-module(exceptions).
-compile(export_all).

throws(F) ->
  try F() of
    _ -> ok
  catch
    throw:test -> {throw, caught,"My test"};
    error:Error   -> {Error};
    exit:Reason   -> {exit, Reason}
  end.
