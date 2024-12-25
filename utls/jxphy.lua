local phy = {
	_currentID = 10
}
phy.circle = require'utls.jxphy.circle'
phy.world = require'utls.jxphy.world'
phy.intersection = require'utls.jxphy.intersection'
phy.resolve = require'utls.jxphy.resolve'


function phy.getid()
	phy._currentID = phy._currentID + 1
	return phy._currentID
end
return phy