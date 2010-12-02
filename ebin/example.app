%%% -*-erlang-*-
{application, example, 
  [{description, "Example."},
   {vsn, "0.0.1"},
   {modules, []},
   {registered, []},
   {applications, [kernel, stdlib, sasl]},
   {mod, {example_app, []}},
   {start_phases, []}]}.
