import math

type
  Vector = ref object of RootObj
  
  Vector3i* = object of Vector
    x* : int
    y* : int
    z* : int

  Vector3f* = object of Vector
    x* : float32
    y* : float32
    z* : float32

  Vector2i* = object of Vector
    x* : int
    y* : int

  Vector2f* = object of Vector
    x* : float32
    y* : float32

  TexCoord* = object
    u* : float32
    v* : float32
    w* : float32

  Vertices* = object
    a* : Vector3f
    b* : Vector3f
    c* : Vector3f

  Normals* = object
    a* : Vector3f
    b* : Vector3f
    c* : Vector3f

  Textures* = object
    a* : TexCoord
    b* : TexCoord
    c* : TexCoord

  RasterTrianglei* = object
    a*  : Vector2i
    b*  : Vector2i
    c*  : Vector2i
  
  VectorTriangle* = object
    vertices* : Vertices
    normals*  : Normals
    textures* : Textures

template `-`*[T : Vector2i](lhs, rhs: T) : T = 
  T(
    x : lhs.x - rhs.x,
    y : lhs.y - rhs.y
  )

template `+`*[T : Vector2i](lhs, rhs: T) : T = 
  T(
    x : lhs.x + rhs.x,
    y : lhs.y + rhs.y
  )

template `*`*[T : Vector2i](scalar : int, rhs: T) : T = 
  T(
    x : scalar * rhs.x,
    y : scalar * rhs.y
  )

template `-`*[T : Vector3f or Vector3i](lhs, rhs : T) : T = 
    T(
      x : lhs.x - rhs.x,
      y : lhs.y - rhs.y,
      z : lhs.z - rhs.z,
    )

template `+`*[T : Vector3f or Vector3i](lhs, rhs : T) : T = 
    T(
      x : lhs.x + rhs.x,
      y : lhs.y + rhs.y,
      z : lhs.z + rhs.z,
    )

template cross*[T : Vector3i or Vector3f](a, b : T) : T = 
    var a1 = a.x; var a2 = a.y; var a3 = a.z
    var b1 = b.x; var b2 = b.y; var b3 = b.z
    T(
      x : a2*b3 - a3*b2,
      y : -(a1*b3  - a3*b1),
      z : (a1*b2 - a2*b1),
    )

proc dot*(a, b : Vector3f) : float = 
  result = (a.x * b.x) + (a.y * b.y) + (a.z * b.z)

proc toVector2i*(vector : Vector2f) : Vector2i = 
  Vector2i(
    x : vector.x.toInt,
    y : vector.y.toInt
  )

proc normalize(vector : Vector3f) : Vector3f= 
  var factor = sqrt( (vector.x^2) + (vector.y^2) + (vector.z^2) )
  Vector3f(
    x : vector.x/factor,
    y : vector.y/factor,
    z : vector.z/factor
  )

proc unitNormal*(triangle : VectorTriangle) : Vector3f = 
  var factor = 1.0
  var verts = triangle.vertices

  var A = verts.a
  var B = verts.b
  var C = verts.c

  var vAC = verts.c - verts.a
  var vAB = verts.b - verts.a
  return vAC.cross(vAB).normalize