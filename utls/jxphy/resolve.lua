local resolve = {}

function resolve.circles(_ca, _cb)
	--local _distance = libs.vector.dist(_ca.position, _cb.position)
	local _distance = _ca.position:dist(_cb.position)
	local _overlap = 0.5 * (_distance - _ca.radius - _cb.radius)

	-- 1st circle
	_ca.position.x = _ca.position.x - _overlap * ((_ca.position.x - _cb.position.x) / _distance)
	_ca.position.y = _ca.position.y - _overlap * ((_ca.position.y - _cb.position.y) / _distance)

	-- _2nd circle
	_cb.position.x = _cb.position.x + _overlap * ((_ca.position.x - _cb.position.x) / _distance)
	_cb.position.y = _cb.position.y + _overlap * ((_ca.position.y - _cb.position.y) / _distance)
end

return resolve