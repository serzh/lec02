%%%-------------------------------------------------------------------
%%% @author serzh
%%% @copyright (C) 2015, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 26. May 2015 16:25
%%%-------------------------------------------------------------------
-module(bs01).
-author("serzh").

%% API
-export([first_word/1]).

first_word(B) ->
  first_word(B, <<>>).

first_word(<<$ , _/binary >>, A) ->
  A;

first_word(<<H, Rest/binary>>, A) ->
  first_word(Rest, <<A/binary, H>>);

first_word(<<>>, A) ->
  A.
