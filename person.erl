-module(person).
-include("person.hrl").
-compile(export_all).

make_p_without_phone(Name, Age) ->
  #person{name=Name, age=Age,
          dict=[{computer_knowledge, excellent},
                {drinks, coke}]}.


print(#person{name = Name, age = Age,
              phone = Phone, dict = Dict})  ->
  io:format("Name: ~s, Age: ~w, Phone: ~w ~n"
            "Dictionary: ~w.~n", [Name, Age, Phone, Dict]).

birthday(P) when is_record(P, person) ->
  P#person{age = P#person.age + 1}.

