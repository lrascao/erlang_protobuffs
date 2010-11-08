Definitions.
L = [A-Za-z_\.]
D = [0-9]
F = (\+|-)?[0-9]+\.[0-9]+((E|e)(\+|-)?[0-9]+)?
WS  = ([\000-\s]|%.*)
S = [\(\)\]\[\{\};=]

TYPE = (double|float|int32|int64|uint32|uint64|sint32|sint64|fixed32|fixed64|sfixed32|sfixed64|bool|string|bytes)
KEYWORD = (package|option|message|enum|default|pack)
REQUIREMENT = (required|optional|repeated)

Rules.
{KEYWORD} : {token, {list_to_atom(TokenChars), TokenLine}}.
{REQUIREMENT} : {token, {requirement, TokenLine, list_to_atom(TokenChars)}}.

{TYPE} : {token, {type, TokenLine,list_to_atom(TokenChars)}}.

{L}({L}|{D})+ : {token, {var, TokenLine,list_to_atom(TokenChars)}}.
'({L}|{D})+' : S = strip(TokenChars,TokenLen),
         {token,{string,TokenLine,S}}.
"({L}|{D})+" : S = strip(TokenChars,TokenLen),
         {token,{string,TokenLine,S}}.
{S} : {token, {list_to_atom(TokenChars),TokenLine}}.
{WS}+  : skip_token.
//.* : skip_token.
{D}+ : {token, {integer, TokenLine, list_to_integer(TokenChars)}}.
{F} : {token, {float, TokenLine, list_to_float(TokenChars)}}.

Erlang code.
strip(TokenChars,TokenLen) -> 
    lists:sublist(TokenChars, 2, TokenLen - 2).
