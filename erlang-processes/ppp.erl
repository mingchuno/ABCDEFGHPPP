#!/usr/bin/env escript
%% -*- erlang -*-
%%! -smp enable
-module(ppp).
-export([main/1]).

main(_) ->
    Pid = self(),
    spawn_layer(Pid),
    collect_result().

print_out(Ret) ->
    [A, B, C, D, E, F, G, H, P] = (Ret),
    io:format("~n"),
    io:format("  ~p~p~n- ~p~p~n----~n  ~p~p~n+ ~p~p~n----~n ~p~p~p~n",
                [A,B,C,D,E,F,G,H,P,P,P]).

collect_result() ->
    receive
        {ok, Acc} ->
            print_out(Acc),
            collect_result();
        {error, _} ->
            collect_result()
    after 
        1000 ->
            ok
    end.
           
spawn_layer(Pid) ->
    lists:foreach(
    fun(Ele) ->
        spawn(fun() ->
                  spawn_layer(Pid, [Ele], 8)
              end)
    end, lists:seq(1, 9)).
    
spawn_layer(Pid, RAcc, 0) ->
    Set = sets:from_list(RAcc),
    Acc = lists:reverse(RAcc),
    case sets:size(Set) of
        9 ->
            [A, B, C, D, E, F, G, H, P] = Acc,
            AB = A * 10 + B,
            CD = C * 10 + D,
            EF = E * 10 + F,
            GH = G * 10 + H,
            PPP = P * 100 + P * 10 + P,
            ZeroCheck = lists:any(fun(Ele) ->
                                      case Ele of
                                          0 ->
                                              true;
                                          _ ->
                                              false
                                       end
                                  end, [A, C, E, G]),
            case {ZeroCheck, AB - CD, EF + GH} of
                {false, EF, PPP} ->
                    Pid ! {ok, Acc};
                _ ->
                    Pid ! {error ,Acc}
            end;
        _ ->
            Pid ! {error, Acc}
    end;
spawn_layer(Pid, [_, C, _, A] = Acc, 5) when A =< C ->
    Pid ! {error, Acc};
spawn_layer(Pid, [D, C, B, A] = Acc, 5) ->
    AB = A * 10 + B,
    CD = C * 10 + D,
    EF = AB - CD,
    E = EF div 10,
    F = EF rem 10,
    spawn_layer(Pid, [F] ++ [E] ++ Acc, 3);
spawn_layer(Pid, Acc, Layer) ->
    lists:foreach(
    fun(Ele) ->
        spawn_layer(Pid, [Ele | Acc], Layer - 1)
    end, lists:subtract(lists:seq(0, 9), Acc)).
