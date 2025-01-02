local queue = libs.classic:extend()

function queue:new()
	self.list = {}
end

function queue:push(_item)
	table.insert(self.list, _item)
end

function queue:pop()
	local _return = self.list[1]
	assert(_return, "[Queue] Error: Nothing to serve in the list.")
	table.remove(self.list, 1)
	return _return
end

function queue:length() return #self.list end

return queue