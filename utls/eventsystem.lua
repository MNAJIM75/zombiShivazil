local evs = {}
evs.triggers = {}

function evs:subscripe(_evtname, _obj)
	if not self:exist(_evtname) then
		self.triggers[_evtname] = {}
	end
	table.insert(self.triggers[_evtname], _obj)
end

function evs:exist(_evtname) return not (self.triggers[_evtname] == nil) end

function evs:call(_evtname, ...)
	--assert(self.triggers[_evtname], '[Event System] Error: no event of name ' .. _evtname .. ' was registered.')
	if not self:exist(_evtname) then return end
	for _i, _c in pairs(self.triggers[_evtname]) do
		_c[_evtname](_c, ...)
	end
end

return evs