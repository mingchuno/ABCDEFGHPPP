#!/usr/bin/env escript
%% -*- erlang -*-
-module(ppp).
-export([main/1]).

main(_) ->
    List = lists:seq(0,9),
    {error, Ret} = pick_one(List, [], [], 0, []),
    lists:foreach(
        fun(Ele) ->
            print_out(Ele)
        end, Ret).

print_out(Ret) ->
    [A, B, C, D, E, F, G, H, P] = lists:reverse(Ret),
    io:format("~n"),
    io:format("  ~p~p~n- ~p~p~n----~n  ~p~p~n+ ~p~p~n----~n ~p~p~p~n", [A,B,C,D,E,F,G,H,P,P,P]).

pick_one([], _, _, _, SoFar) ->
    {error, SoFar};
pick_one([Head | Rest], Acc, Err, Round, SoFar) ->
    Acc2 = [Head | Acc],
    Check = case Round of
                3 ->
                    case eval_ef(Acc2, Rest ++ Err) of
                        error ->
                            error;
                        Ret ->
                            Ret
                    end;
                5 ->
                    check_ppp(Acc2, Rest ++ Err);
                Rounds ->
                    case {Rounds rem 2, Head} of
                        {0, 0} ->
                            error;
                        _ ->
                            {ok, Acc2, Rest ++ Err}
                    end
            end,
    Check2 = case Check of
                 {ok, NewAcc, NewList} ->
                     pick_one(NewList, NewAcc, [], Round + 1, SoFar);
                 Ret2 ->
                     Ret2
             end,
    case Check2 of
        error ->
            pick_one(Rest, Acc, Err ++ [Head], Round, SoFar);
        {error, SoFar2} ->
            pick_one(Rest, Acc, Err ++ [Head], Round, SoFar2);
        {done, New} ->
            pick_one(Rest, Acc, Err ++ [Head], Round, [New | SoFar])
    end.

eval_ef(List, Rest) ->
    [A,B,C,D] = lists:reverse(List),
    AB = A * 10 + B,
    CD = C * 10 + D,
    EF = AB - CD,
    io:format("[EF] AB:~p, CD:~p, EF:~p~n",[AB,CD,EF]),
    case EF of
        EF when EF < 10 ->
            error;
        _ ->
            E = EF div 10,
            F = EF rem 10,
            List2 = lists:subtract(Rest, [E, F]),
            case length(List2) of
                4 ->
                    {ok, [F, E, D, C, B, A], List2};
                _ ->
                    error
            end
    end.

check_ppp(List, Rest) ->
    [_A,_B,_C,_D,E,F,G,H] = lists:reverse(List),
    EF = E * 10 + F,
    GH = G * 10 + H,
    PPP = EF + GH,
    io:format("[PPP] EF:~p, GH:~p, PPP:~p~n",[EF, GH, PPP]),
%% Let's pretend PPP is not 111
%    case PPP of
%        111 ->
    case {PPP div 100, PPP rem 100 div 10, PPP rem 10} of
        {P,P,P} ->
            case lists:member(P, Rest) of
                true ->
                    {done, [P | List]};
                _ ->
                    error
            end;
        _ ->
            error
    end.
