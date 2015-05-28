%%%-------------------------------------------------------------------
%%% @author serzh
%%% @copyright (C) 2015, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 28. May 2015 18:45
%%%-------------------------------------------------------------------
-module(bs02).
-author("serzh").

%% API
-export([words/1]).

words(BS) ->
  lists:reverse(words(BS, <<>>, [])).

words(<<$ , R/binary>>, W, A) ->
  words(R, <<>>, [W|A]);

words(<<H, R/binary>>, W, A) ->
  words(R, <<W/binary, H>>, A);

words(<<>>, W, A) ->
  [W|A].