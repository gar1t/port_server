-module(example_app).

-behaviour(application).

-export([start/2, stop/1]).

start(normal, []) ->
    example_sup:start_link().

stop(_State) ->
    ok.
