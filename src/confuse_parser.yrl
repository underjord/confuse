Nonterminals config statements statement kv value tuple tuple_items tuple_item block label function_call args arg.

Terminals string integer identifier '=' '{' '}' '(' ')' ','.

Rootsymbol config.

config -> statements : '$1'.

statements -> statement statements : ['$1' | '$2'].
statements -> '$empty' : [].

statement -> kv : '$1'.
statement -> block : '$1'.
statement -> function_call : '$1'.

kv -> identifier '=' value : {kv, val('$1'), '$3'}.

value -> string : {string, val('$1')}.
value -> integer : {integer, val('$1')}.
value -> identifier : {string, val('$1')}.
value -> tuple : '$1'.

tuple -> '{' tuple_items '}' : {tuple, '$2'}.
tuple -> '{' '}' : {tuple, []}.

tuple_item -> string : val('$1').
tuple_item -> identifier : val('$1').
tuple_item -> integer : erlang:integer_to_binary(val('$1')).

tuple_items -> tuple_item : ['$1'].
tuple_items -> tuple_item ',' tuple_items : ['$1' | '$3'].

block -> identifier label '{' statements '}' : {block, val('$1'), '$2', '$4'}.
block -> identifier '{' statements '}' : {block, val('$1'), <<>>, '$3'}.

label -> string : val('$1').
label -> identifier : val('$1').
label -> integer : erlang:integer_to_binary(val('$1')).

function_call -> identifier '(' args ')' : {function_call, val('$1'), '$3'}.
function_call -> identifier '(' ')' : {function_call, val('$1'), []}.

args -> arg ',' args : ['$1' | '$3'].
args -> arg : ['$1'].

arg -> string : val('$1').
arg -> integer : val('$1').
arg -> identifier : val('$1').

Erlang code.

val({_, _, V}) -> V.
