type
  fbCoord* = object
    x*: int
    y*: int
  
  Vector* = object
    x* : float32
    y* : float32
    z* : float32

  Texture* = object
    u* : float32
    v* : float32
    w* : float32
  
  Triangle* = object
    v1*   : Vector
    vt1*  : Texture
    vn1*  : Vector
    v2*   : Vector
    vt2*  : Texture
    vn2*  : Vector
    v3*   : Vector
    vt3*  : Texture
    vn3*  : Vector

proc `-`*(lhs, rhs: fbCoord) : fbCoord = 
  result.x = lhs.x - rhs.x
  result.y = lhs.y - rhs.y

proc `+`*(lhs, rhs: fbCoord) : fbCoord = 
  result.x = lhs.x + rhs.x
  result.y = lhs.y + rhs.y

proc `*`*(lhs : float32, rhs: fbCoord) : fbCoord = 
  result.x = (lhs * rhs.x.toFloat).toInt
  result.y = (lhs * rhs.y.toFloat).toInt

proc vertices*(triangle : Triangle): seq[Vector] = 
  return @[triangle.v1, triangle.v2, triangle.v3]

proc textures*(triangle : Triangle): seq[Texture] = 
  return @[triangle.vt1, triangle.vt2, triangle.vt3]

proc normals*(triangle : Triangle): seq[Vector] = 
  return @[triangle.vn1, triangle.vn2, triangle.vn3]