import core

proc projection*(triangle : VectorTriangle, width, height : int) : RasterTrianglei = 
    var verts = triangle.vertices
    var a_x = ((verts.a.x + 1.0) * ((width - 1)/2)).toInt
    var a_y = ((verts.a.y + 1.0) * ((height - 1)/2)).toInt
    var b_x = ((verts.b.x + 1.0) * ((width - 1)/2)).toInt
    var b_y = ((verts.b.y + 1.0) * ((height - 1)/2)).toInt
    var c_x = ((verts.c.x + 1.0) * ((width - 1)/2)).toInt
    var c_y = ((verts.c.y + 1.0) * ((height - 1)/2)).toInt
    RasterTrianglei(
        a : Vector2i(x : a_x, y : a_y),
        b : Vector2i(x : b_x, y : b_y),
        c : Vector2i(x : c_x, y : c_y)
    )

# proc scaleToFB(triangle : RasterTrianglef) : RasterTrianglei = 