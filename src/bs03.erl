%%%-------------------------------------------------------------------
%%% @author serzh
%%% @copyright (C) 2015, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 28. May 2015 18:54
%%%-------------------------------------------------------------------
-module(bs03).
-author("serzh").

%% API
-export([split/2]).

split(BS, Sep) ->
  split(BS, << <<X>> || X <- Sep >>, length(Sep),<<>>, []).

split(BS, Sep, SZ, W, A) ->
  case BS of
    <<Sep:SZ/binary, R/binary>> -> split(R, Sep, SZ, <<>>, [W|A]);
    <<H, R/binary>> -> split(R, Sep, SZ, <<W/binary, H>>, A);
    <<>> -> lists:reverse([W|A])
  end.