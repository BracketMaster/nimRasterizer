# a very simple OBJ reader that only supports 
# v, vt, vn, and f satements of the form
# ===============================
# v  <float>x, <float>y, <float>z
# vt <float>u, <float>v, <float>w
# vn <float>x, <float>y, <float>z
# f v/vt/vn v/vt/vn v/vt/vn v/vt/vn
# ===============================
import parseutils, strutils, sequtils, macros
import print, sugar
import core

proc stripWhiteSpace(str : var string) =
    var index = skipWhile(str, Whitespace)
    str = str[index..^1]

proc stripSlash(str : var string) =
    var index = skipWhile(str, {'/'})
    str = str[index..^1]

proc stripWord(str : var string, line_no : int) : string =
    stripWhiteSpace(str)
    var index = skipWhile(str, Letters)
    ## finds the first word, n the supplied string,
    ## strips the word from the original
    ## string thus mutating it, and returns the word
    result = str[0..index - 1]
    str = str[index..^1]

proc stripFloat(str : var string, line_no : int) : float32 =
    stripWhiteSpace(str)
    var index = skipWhile(str, Digits + {'-', '.','e'})
    ## finds the first float, n the supplied string,
    ## strips the float from the original
    ## string thus mutating it, and returns the float
    try:
        result = parseFloat(str[0..index - 1])
    except Exception:
        echo "caught in stripFloat on line: ", line_no
        echo "couldn't parse ", '\'' ,str[0..index-1], '\''
        quit()
    str = str[index..^1]

proc stripFaceInt(str : var string, line_no : int) : int =
    stripWhiteSpace(str)
    stripSlash(str)
    var index = skipWhile(str, Digits)
    ## finds the first float, n the supplied string,
    ## strips the float from the original
    ## string thus mutating it, and returns the float
    try:
        result = parseInt(str[0..index - 1])
    except Exception:
        echo "caught in stripFaceInt on line: ", line_no
        echo "couldn't parse ", '\'' ,str[0..index-1], '\''
        quit()
    str = str[index..^1]

proc readOBJ*(f : File) : seq[Triangle] = 
    var vertices            = newSeq[Vectorf](0)
    var textures            = newSeq[TexCoord](0)
    var normals             = newSeq[Vectorf](0)
    var triangles_to_parse  = newSeq[string](0)
    var triangles           = newSeq[Triangle](0)

    # first, parse all the vertices, normals, and textures from
    # the file

    # we can't parse the faces until we've got the vertices, normals,
    # and textures, so we'll just store them to a Seq for now

    var line_no = 0
    # we'll need this later for error tracking when building triangles
    var line_begin_faces_offset  = -1 
    for line in f.lines():
        var mut_line = dup(line)
        var dtype = stripWord(mut_line, line_no)

        case dtype:

            of "v":
                vertices.add(Vectorf(
                    x : stripFloat(mut_line, line_no),
                    y : stripFloat(mut_line, line_no),
                    z : stripFloat(mut_line, line_no)
                ))

            of "vn":
                normals.add(Vectorf(
                    x : stripFloat(mut_line, line_no),
                    y : stripFloat(mut_line, line_no),
                    z : stripFloat(mut_line, line_no)
                ))

            of "vt":
                textures.add(TexCoord(
                    u : stripFloat(mut_line, line_no),
                    v : stripFloat(mut_line, line_no),
                    w : stripFloat(mut_line, line_no)
                ))
            of "f":
                if (line_begin_faces_offset == -1):
                    line_begin_faces_offset = line_no
                triangles_to_parse.add(mut_line)
        line_no += 1
    
    # now assemble the faces
    for line_no, triangle in triangles_to_parse:
        var triangle_mut = dup(triangle)
        # substract 1 to form index as obj wavefront format by spec is 1-indexed
        # whilst nim Seq is 0-indexed
        var getIndex = () => stripFaceInt(triangle_mut, line_begin_faces_offset + line_no) - 1
        var (i_v1, i_t1, i_n1) = (getIndex(), getIndex(), getIndex())
        var (i_v2, i_t2, i_n2) = (getIndex(), getIndex(), getIndex())
        var (i_v3, i_t3, i_n3) = (getIndex(), getIndex(), getIndex())
        triangles.add(Triangle(
            vertices : Vertices(a : vertices[i_v1], b : vertices[i_v2], c : vertices[i_v3]),
            normals  : Normals(a : normals[i_n1], b : normals[i_n2], c : normals[i_n3]),
            textures : Textures(a : textures[i_t1], b : textures[i_t2], c : textures[i_t3]),
            )
        )
    
    result = triangles

proc test() = 
    let african_head = "resources/african_head.obj".open
    var triangles = african_head.readOBJ

    print(triangles.len)
    print(triangles[13])

if isMainModule:
    test()