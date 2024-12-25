local graphics = {
	canvas = nil,
	virtual_width = 0, virtual_height = 0,
	scale = 1,
	canvas_filter = {
		point = rl.TEXTURE_FILTER_POINT
	}
}

-- Texture Handler
function graphics.loadcanvas(_w, _h) return rl.LoadRenderTexture(_w, _h) end
function graphics.unloadcanvas(_canvas) rl.UnloadRenderTexture(_canvas) end
function graphics.canvasfilter(_texture, _filter) rl.SetTextureFilter(_texture, _filter) end

function graphics:load(_vwidth, _vheight)
	assert(_vwidth ~= nil or _vheight ~= nil, "[Graphics] Error: virtual scale is not set correctly.")
	self.virtual_width = _vwidth
	self.virtual_height = _vheight
	self.canvas = self.loadcanvas(self.virtual_width, self.virtual_height)
	self.canvasfilter(self.canvas.texture, self.canvas_filter.point)
end
function graphics:startrender() rl.BeginTextureMode(self.canvas) end
function graphics:finishrender() rl.EndTextureMode() end
function graphics:unload() self.unloadcanvas(self.canvas) end


return graphics