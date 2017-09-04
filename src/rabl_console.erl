%%% @author Russell Brown <russell@wombat.me>
%%% @copyright (C) 2017, Russell Brown
%%% @doc
%%% console funs
%%% @end
%%% Created : 18 Jul 2017 by Russell Brown <russell@wombat.me>

-module(rabl_console).

-compile(export_all).

-ifdef(TEST).
-include_lib("eunit/include/eunit.hrl").
-endif.

-spec show_config() -> list().
show_config() ->
    application:get_all_env(rabl).

-spec add_hook(binary()) -> list().
add_hook(BinBucket) ->
    rabl_util:add_hook(BinBucket),
    rabl_util:get_bucket(BinBucket).

-spec load() -> ok.
load() ->
    rabl_util:load().

start() ->
    rabl_app:start().

setup() ->
    rabl_util:setup_local_smoke().

stop() ->
    application:stop(rabl).

status() ->
    case whereis(rabl_sup) of
        undefined ->
            rabl_not_running;
        Pid when is_pid(Pid) ->
            rabl_app:status()
    end.

stats() ->
    rabl_util:get_flat_stats().
