type
  fbCoord* = object
    x*: int
    y*: int
  
  Vectorf* = object
    x* : float32
    y* : float32
    z* : float32

  Vectori* = object
    x* : int
    y* : int
    z* : int

  TexCoord* = object
    u* : float32
    v* : float32
    w* : float32

  Vertices* = object
    a* : Vectorf
    b* : Vectorf
    c* : Vectorf

  Normals* = object
    a* : Vectorf
    b* : Vectorf
    c* : Vectorf

  Textures* = object
    a* : TexCoord
    b* : TexCoord
    c* : TexCoord
  
  Triangle* = object
    vertices* : Vertices
    normals*  : Normals
    textures* : Textures

proc `-`*(lhs, rhs: fbCoord) : fbCoord = 
  result.x = lhs.x - rhs.x
  result.y = lhs.y - rhs.y

proc `-`*(lhs, rhs: Vectorf) : Vectorf = 
  result.x = lhs.x - rhs.x
  result.y = lhs.y - rhs.y
  result.z = lhs.z - rhs.z

proc `+`*(lhs, rhs: Vectorf) : Vectorf = 
  result.x = lhs.x + rhs.x
  result.y = lhs.y + rhs.y
  result.z = lhs.z + rhs.z

proc `-`*(lhs, rhs: Vectori) : Vectori = 
  result.x = lhs.x - rhs.x
  result.y = lhs.y - rhs.y
  result.z = lhs.z - rhs.z

proc `+`*(lhs, rhs: Vectori) : Vectori = 
  result.x = lhs.x + rhs.x
  result.y = lhs.y + rhs.y
  result.z = lhs.z + rhs.z

proc `+`*(lhs, rhs: fbCoord) : fbCoord = 
  result.x = lhs.x + rhs.x
  result.y = lhs.y + rhs.y

proc `*`*(lhs : float32, rhs: fbCoord) : fbCoord = 
  result.x = (lhs * rhs.x.toFloat).toInt
  result.y = (lhs * rhs.y.toFloat).toInt

proc toInt(vectorf : Vectorf) : Vectori = 
  result.x = vectorf.x.toInt
  result.y = vectorf.y.toInt
  result.z = vectorf.z.toInt

# proc verticesf*(triangle : Triangle): seq[Vectorf] = 
#   return @[triangle.v1, triangle.v2, triangle.v3]

# proc verticesi*(triangle : Triangle): seq[Vectori] = 
#   return @[triangle.v1.toInt, triangle.v2.toInt, triangle.v3.toInt]

# proc texturesf*(triangle : Triangle): seq[Texture] = 
#   return @[triangle.vt1, triangle.vt2, triangle.vt3]

# proc normalsf*(triangle : Triangle): seq[Vectorf] = 
#   return @[triangle.vn1, triangle.vn2, triangle.vn3]