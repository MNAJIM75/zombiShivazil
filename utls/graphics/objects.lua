local objs = {}
function objs.rectangle(_x, _y, _w, _h)
	return rl.new("Rectangle", _x, _y, _w, _h)
end

function objs.color(_r, _g, _b, _a)
	return rl.new("Color", _r, _g, _b, _a)
end

function objs.vector(_x, _y)
	return rl.new("Vector2", _x, _y)
end

function objs.camera(_tx, _ty, _ox, _oy, _z, _r)
	local camera = rl.new"Camera2D"
	camera.target = objs.vector( 0, 0)
	camera.offset = objs.vector(
		config.graphics.window.width / 2, 
		config.graphics.window.height / 2
	)
	camera.zoom = 1;
	camera.rotation = 0;
	return camera
end

return objs