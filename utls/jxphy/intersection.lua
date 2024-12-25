local intersection = {}

function intersection.circles(_ca, _cb)
	return math.abs(
		(_ca.position.x - _cb.position.x)*(_ca.position.x - _cb.position.x) + 
		(_ca.position.y - _cb.position.y)*(_ca.position.y - _cb.position.y)
	) < (_ca.radius + _cb.radius)*(_ca.radius + _cb.radius)
end

return intersection