local resolve = {}

function resolve.circles(_ca, _cb, _dist)
	--local _distance = libs.vector.dist(_ca.position, _cb.position)
	local _distance = _dist or _ca.position:dist(_cb.position)
	local _overlap = (_distance - _ca.radius - _cb.radius)
	if _ca.static or _cb.static then _overlap = _overlap * 0.5 end

	-- 1st circle
	if not _ca.static then
		_ca.position.x = _ca.position.x - _overlap * ((_ca.position.x - _cb.position.x) / _distance)
		_ca.position.y = _ca.position.y - _overlap * ((_ca.position.y - _cb.position.y) / _distance)
	end

	-- _2nd circle
	if not _cb.static then
		_cb.position.x = _cb.position.x + _overlap * ((_ca.position.x - _cb.position.x) / _distance)
		_cb.position.y = _cb.position.y + _overlap * ((_ca.position.y - _cb.position.y) / _distance)
	end
end

-- prefom a dynamic response
function resolve.dynamic(_ca, _cb, _dist)
	local _distance = _dist or _ca.position:dist(_cb.position)
	local _nx, _ny = (_cb.position.x - _ca.position.x) / _distance, (_cb.position.y - _ca.position.y) / _distance
	local _tx, _ty = -_ny, _nx

	-- tangent calc
	local _dtana = _ca.velocity.x * _tx + _ca.velocity.y * _ty
	local _dtanb = _cb.velocity.x * _tx + _cb.velocity.y * _ty

	-- normal calc
	local _dnormala = _ca.velocity.x * _nx + _ca.velocity.y * _ny
	local _dnormalb = _cb.velocity.x * _nx + _cb.velocity.y * _ny

	-- conservation of momentum in 1D
	local _ma = (_dnormala * (_ca.mass - _cb.mass) + 2 * _cb.mass * _dnormalb) / (_ca.mass + _cb.mass)
	local _mb = (_dnormalb * (_cb.mass - _ca.mass) + 2 * _ca.mass * _dnormala) / (_ca.mass + _cb.mass)

	if not _ca.static then _ca.velocity:set(_dtana * _tx + _nx * _ma, _dtana * _ty + _ny * _ma) end
	if not _cb.static then _cb.velocity:set(_dtanb * _tx + _nx * _mb, _dtanb * _ty + _ny * _mb) end
end

return resolve