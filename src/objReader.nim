# a very simple OBJ reader that assumes no w coordinates
import parseutils, strutils, sequtils, macros
import print
import sugar

type
    Vector* = object
        x* : float64
        y* : float64
        z* : float64


proc stripWhiteSpace(str : var string) =
    var index = skipWhile(str, Whitespace)
    str = str[index..^1]


proc stripWord(str : var string) : string =
    stripWhiteSpace(str)
    var index = skipWhile(str, Letters)
    ## finds the first word, n the supplied string,
    ## strips the word from the original
    ## string thus mutating it, and returns the word
    result = str[0..index - 1]
    str = str[index..^1]

var line_no = 0

proc stripFloat(str : var string) : float32 =
    stripWhiteSpace(str)
    var index = skipWhile(str, Digits + {'-', '.','e'})
    ## finds the first float, n the supplied string,
    ## strips the float from the original
    ## string thus mutating it, and returns the float
    try:
        result = parseFloat(str[0..index - 1])
    except Exception:
        echo "caught on line: ", line_no
        echo "couldn't parse ", '\'' ,str[0..index-1], '\''
        quit()
    str = str[index..^1]


var vertices* = newSeq[Vector](0)
let f = open("resources/african_head.obj")
for line in f.lines():
    var mut_line = dup(line)
    var dtype = stripWord(mut_line)
    if dtype == "v":
        vertices.add(Vector(
            x : stripFloat(mut_line),
            y : stripFloat(mut_line),
            z : stripFloat(mut_line)
        ))
    line_no += 1

# dump(print(vertices[4]))
print(vertices[4])
print(vertices.len)