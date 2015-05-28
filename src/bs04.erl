%%%-------------------------------------------------------------------
%%% @author serzh
%%% @copyright (C) 2015, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 28. May 2015 20:57
%%%-------------------------------------------------------------------
-module(bs04).
-author("serzh").

%% API
-export([first_tag/1, decode_xml/1]).

first_tag(BS) ->
  first_tag(BS, <<>>).

first_tag(<<$>, R/binary>>, A) ->
  {<<A/binary, $>>>, R};

first_tag(<<H, R/binary>>, A) ->
  first_tag(R, <<A/binary, H>>);

first_tag(<<>>, A) ->
  A.

but_end_tag(<<$<, TR/binary>>, BS) ->
  but_end_tag(TR, BS, <<>>);

but_end_tag(T, <<>>) -> {T, <<>>}.

but_end_tag(<<_,_/binary>>=T, BS, A) ->
  Size = byte_size(T),
  case BS of
    <<"</", T:Size/binary, R/binary>> -> {A, R};
    <<H, R/binary>> -> but_end_tag(T, R, <<A/binary, H>>)
  end;

but_end_tag(_, <<>>, A) -> {A, <<>>}.

parse_tag(BS) ->
  case first_tag(BS) of
    {TagName, Rest} ->
      {Body, Siblings} = but_end_tag(TagName, Rest),
      {TagName, Body, Siblings};
    Body -> {<<>>, Body, <<>>}
  end.

decode_xml(BS) ->
  decode_xml(BS, []).

decode_xml(BS, A) ->
  case parse_tag(BS) of
    {<<>>, Body, <<>>} -> Body;
    {TagName, Body, <<>>} -> lists:reverse([{TagName, [], decode_xml(Body)}|A]);
    {TagName, Body, Siblings} -> decode_xml(Siblings, [{TagName, [], Body}|A])
  end.