type
  Point* = object
    x*: int
    y*: int

proc `-`*(lhs, rhs: Point) : Point = 
  result.x = lhs.x - rhs.x
  result.y = lhs.y - rhs.y

proc `+`*(lhs, rhs: Point) : Point = 
  result.x = lhs.x + rhs.x
  result.y = lhs.y + rhs.y

proc `*`*(lhs : float32, rhs: Point) : Point = 
  result.x = (lhs * rhs.x.toFloat).toInt
  result.y = (lhs * rhs.y.toFloat).toInt