-module(errors).
-compile(export_all).

myproc()  ->
  timer:sleep(5000),
  exit(reason).

chain(0)  ->
  receive
    _ -> ok
  after 20000  -> exit("Chain dies here")
  end;
chain(N)  ->
  Pid = spawn(chain(N-1)),
  link(Pid),
  receive
    _ -> ok
  end.
