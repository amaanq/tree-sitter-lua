;; Preproc

(shebang) @preproc

;; Keywords

[
  "goto"
  "in"
  "local"
] @keyword

(break_statement) @keyword

(do_statement
[
  "do"
  "end"
] @keyword)

(while_statement
[
  "while"
  "do"
  "end"
] @repeat)

(repeat_statement
[
  "repeat"
  "until"
] @repeat)

(if_statement
[
  "if"
  "elseif"
  "else"
  "then"
  "end"
] @conditional)

(elseif_statement
[
  "elseif"
  "then"
  "end"
] @conditional)

(else_statement
[
  "else"
  "end"
] @conditional)

(for_statement
[
  "for"
  "do"
  "end"
] @repeat)

(function_declaration
[
  "function"
  "end"
] @keyword.function)

(function_definition
[
  "function"
  "end"
] @keyword.function)

"return" @keyword.return

;; Operators

[
  "and"
  "not"
  "or"
] @keyword.operator

[
  "+"
  "-"
  "*"
  "/"
  "%"
  "^"
  "#"
  "=="
  "~="
  "<="
  ">="
  "<"
  ">"
  "="
  "&"
  "~"
  "|"
  "<<"
  ">>"
  "//"
  ".."
] @operator

;; Punctuations

[
  ";"
  ":"
  "::"
  ","
  "."
] @punctuation.delimiter

;; Brackets

[
  "("
  ")"
  "["
  "]"
  "{"
  "}"
] @punctuation.bracket

;; Variables

(identifier) @variable

((identifier) @variable.builtin
 (#any-of? @variable.builtin "_G" "_VERSION" "debug" "io" "jit" "math" "os" "package" "self" "string" "table" "utf8"))

((identifier) @keyword.coroutine
  (#eq? @keyword.coroutine "coroutine"))

(variable_list
   attribute: (attribute
     (["<" ">"] @punctuation.bracket
      (identifier) @attribute)))

;; Labels

(label_statement (identifier) @label)

(goto_statement (identifier) @label)

;; Constants

((identifier) @constant
 (#lua-match? @constant "^[A-Z][A-Z_0-9]*$"))

;; Tables

(field name: (identifier) @field)

(dot_index_expression field: (identifier) @field)

(table_constructor
[
  "{"
  "}"
] @constructor)

;; Functions

(parameters (identifier) @parameter)

(function_call name: (identifier) @function.call)
(function_declaration name: (identifier) @function)

(function_call name: (dot_index_expression field: (identifier) @function.call))
(function_declaration name: (dot_index_expression field: (identifier) @function))

(method_index_expression method: (identifier) @method.call)

(function_call
  (identifier) @function.builtin
  (#any-of? @function.builtin
    ;; built-in functions in Lua 5.1
    "assert" "collectgarbage" "dofile" "error" "getfenv" "getmetatable" "ipairs"
    "load" "loadfile" "loadstring" "module" "next" "pairs" "pcall" "print"
    "rawequal" "rawget" "rawlen" "rawset" "require" "select" "setfenv" "setmetatable"
    "tonumber" "tostring" "type" "unpack" "xpcall"
    "__add" "__band" "__bnot" "__bor" "__bxor" "__call" "__concat" "__div" "__eq" "__gc"
    "__idiv" "__index" "__le" "__len" "__lt" "__metatable" "__mod" "__mul" "__name" "__newindex"
    "__pairs" "__pow" "__shl" "__shr" "__sub" "__tostring" "__unm"))


;; Literals

(number) @number

(string) @string @spell

(escape_sequence) @string.escape

(boolean) @boolean

[
  (nil)
  (vararg_expression)
] @constant.builtin

;; Others

(comment) @comment @spell

((comment) @comment.documentation
  (#lua-match? @comment.documentation "^[-][-][-]"))

((comment) @comment.documentation
  (#lua-match? @comment.documentation "^[-][-](%s?)@"))

;; Error

(ERROR) @error
