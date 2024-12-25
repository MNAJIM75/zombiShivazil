local objs = {}
function objs.rectangle(_x, _y, _w, _h)
	return rl.new("Rectangle", _x, _y, _w, _h)
end

function objs.color(_r, _g, _b, _a)
	return rl.new("Color", _r, _g, _b, _a)
end

function objs.vector(_x, _y)
	return rl.new("Vector2", _x or 0, _y or 0)
end

function objs.camera(_tx, _ty, _ox, _oy, _z, _r)
	local camera = rl.new"Camera2D"
	camera.target = objs.vector( _tx or 0, _ty or 0)
	camera.offset = objs.vector(
		_ox or config.graphics.window.width / 2, 
		_oy or config.graphics.window.height / 2
	)
	camera.zoom = _z or 0.5;
	camera.rotation = _r or 0;
	return camera
end

return objs