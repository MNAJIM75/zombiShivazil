local intersection = {}

function intersection.circles(_ca, _cb)
	return math.abs(
		(_ca.position.x - _cb.position.x)*(_ca.position.x - _cb.position.x) + 
		(_ca.position.y - _cb.position.y)*(_ca.position.y - _cb.position.y)
	) < (_ca.radius + _cb.radius)*(_ca.radius + _cb.radius)
end

function intersection._circles(x1, y1, radius1, x2, y2, radius2)
	return math.abs(
		(x1 - x2)*(x1 - x2) + 
		(y1 - y2)*(y1 - y2)
	) < (radius1 + radius2)*(radius1 + radius2)
end


return intersection