local funcs = {}

-- limit the for loop index to value of length
function funcs.limit(_length, _index)
	return _length - _index % _length
end

function funcs.clamp(_value, _min, _max)
	return _value < _min and _min or _value > _max and _max or _value
end

return funcs
