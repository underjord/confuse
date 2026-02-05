Definitions.

DIGIT    = [0-9]
IDCHAR   = [-a-zA-Z0-9_.]
WS       = [\s\t\n\r]

Rules.

{WS}+                             : skip_token.
#[^\n]*                           : skip_token.
//[^\n]*                          : skip_token.
/\*([^*]|\*+[^*/])*\*+/          : skip_token.
\"(\\.|[^\\"])*\"                 : {token, {string, TokenLine, dq_str(TokenChars)}}.
'[^']*'                           : {token, {string, TokenLine, sq_str(TokenChars)}}.
\$\{[^}]*\}                       : {token, {identifier, TokenLine, list_to_binary(TokenChars)}}.
{DIGIT}+                          : {token, {integer, TokenLine, list_to_integer(TokenChars)}}.
\+=                               : {token, {'=', TokenLine}}.
=                                 : {token, {'=', TokenLine}}.
\{                                : {token, {'{', TokenLine}}.
\}                                : {token, {'}', TokenLine}}.
\(                                : {token, {'(', TokenLine}}.
\)                                : {token, {')', TokenLine}}.
,                                 : {token, {',', TokenLine}}.
{IDCHAR}+                         : {token, {identifier, TokenLine, list_to_binary(TokenChars)}}.

Erlang code.

dq_str(Chars) ->
    Inner = lists:sublist(Chars, 2, length(Chars) - 2),
    list_to_binary(unescape_dq(Inner, [])).

unescape_dq([], Acc) ->
    lists:reverse(Acc);
unescape_dq([$\\, $" | Rest], Acc) ->
    unescape_dq(Rest, [$" | Acc]);
unescape_dq([C | Rest], Acc) ->
    unescape_dq(Rest, [C | Acc]).

sq_str(Chars) ->
    list_to_binary(lists:sublist(Chars, 2, length(Chars) - 2)).
