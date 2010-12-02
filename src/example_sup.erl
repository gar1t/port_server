-module(example_sup).

-behavior(supervisor).

-export([start_link/0]).

-export([init/1]).

-define(SERVER, ?MODULE).

start_link() ->
    supervisor:start_link({local, ?SERVER}, ?MODULE, []).

init([]) -> 
    PrivDir = find_privdir(),
    ServiceA = filename:join(PrivDir, "service_a"),
    ServiceB = filename:join(PrivDir, "service_b"),
    {ok, {{one_for_one, 5, 5},
          [{service_a, {port_server, start_link, [service_a, ServiceA]},
            permanent, 5000, supervisor, [port_server]},
           {service_b, {port_server, start_link, [service_b, ServiceB]},
            permanent, 5000, supervisor, [port_server]}]}}.

find_privdir() ->
    filename:join(filename:dirname(code:which(?MODULE)), "../priv").
