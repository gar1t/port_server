-module(example).

-export([start/0]).

start() ->
    application:start(sasl),
    application:start(example).
