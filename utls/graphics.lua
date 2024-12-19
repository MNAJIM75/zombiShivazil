local graphics = {}
graphics.objects = require"utls.graphics.objects"
graphics.colors = require"utls.graphics.colors"
setmetatable(graphics, {__index = require"utls.graphics.renderer"})

-- window functions
function graphics.initwindow(_width, _height, _title)
	graphics.screen_width = _width
	graphics.screen_height = _height
	rl.InitWindow(_width, _height, _title)
	rl.SetTargetFPS(60)
end
function graphics.windowopen() return not rl.WindowShouldClose() end
function graphics.closewindow()	rl.CloseWindow() end

-- draw functions

function graphics.begindrawing() rl.BeginDrawing() end
function graphics.enddrawing() rl.EndDrawing() end
function graphics.clearbackground(_color) rl.ClearBackground(_color) end

function graphics.drawrect(_x, _y, _w, _h, _c) rl.DrawRectangle(_x, _y, _w, _h, _c) end
function graphics.drawcircle(_x, _y, _r, _c) rl.DrawCircle(_x, _y, _r, _c) end
function graphics.drawline(_x1, _y1, _x2, _y2, _c) rl.DrawLine(_x1, _y1, _x2, _y2, _c) end
function graphics.drawtext(_text, _x, _y, _fs, _c) rl.DrawText(_text, _x, _y, _fs, _c) end


-- DrawTexturePro(Texture2D texture, Rectangle source, Rectangle dest, Vector2 origin, float rotation, Color tint);
function graphics.drawsprite(_sprite, _rectsource, _rectdest, _originvector, _rotation, _c)
	rl.DrawTexturePro(_sprite, _rectsource, _rectdest, _originvector, _rotation, _c)
end

function graphics:drawcanvas()
	self.scale = math.min(self.screen_width / self.virtual_width, self.screen_height / self.virtual_height)
	graphics.drawsprite(
		self.canvas.texture,
		self.objects.rectangle(0, 0, self.canvas.texture.width, -self.canvas.texture.height),
		self.objects.rectangle(
			(self.screen_width - self.virtual_width * self.scale) * 0.5,
			(self.screen_height - self.virtual_height * self.scale) * 0.5,
			self.screen_width * self.scale, self.screen_height * self.scale
		),
		self.objects.vector(), 0, self.colors.white
	)
end

-- camera functions
function graphics.beginmode2d(_cam) rl.BeginMode2D(_cam) end
function graphics.endmode2d() rl.EndMode2D() end



return graphics