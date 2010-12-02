-module(port_server).

-behavior(gen_server).

-export([start_link/2]).

-export([init/1, handle_call/3, handle_cast/2, handle_info/2,
	 terminate/2, code_change/3]).

-record(state, {port}).

start_link(Name, PortCommand) ->
    gen_server:start_link({local, Name}, ?MODULE, PortCommand, []).

init(PortCommand) ->
    process_flag(trap_exit, true),
    Port = open_port({spawn, PortCommand}, [stream, {line, 79}]),
    {ok, #state{port=Port}}.

handle_call(_Request, _From, State) ->
    {noreply, State}.

handle_cast(_Msg, State) ->
    {noreply, State}.

handle_info({'EXIT', _Port, Reason}, State) ->
    {stop, {port_terminated, Reason}, State};
handle_info({_Port, {data, {eol, []}}}, State) ->
    {stop, port_closed, State}.

terminate({port_terminated, _Reason}, _State) ->
    ok;
terminate(_Reason, #state{port=Port}) ->
    port_close(Port).

code_change(_OldVsn, State, _Extra) ->
    {ok, State}.
