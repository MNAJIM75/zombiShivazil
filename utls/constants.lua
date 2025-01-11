local const = {}

-- bullet constants
const.bullet_maxspeed = 1000
const.bullet_aimrange = 3
const.bullet_maxlife = 3

-- player constants
const.player_maxspeed = 100

-- enemy constants
const.enemy_maxspeed = 50


-- Gamepad buttons
const.gamepad_button_unknown			= 0		-- Unknown button, just for error checking
const.gamepad_button_left_face_up		= 1		-- Gamepad left DPAD up button
const.gamepad_button_left_face_right	= 2		-- Gamepad left DPAD right button
const.gamepad_button_left_face_down		= 3		-- Gamepad left DPAD down button
const.gamepad_button_left_face_left		= 4		-- Gamepad left DPAD left button
const.gamepad_button_right_face_up		= 5		-- Gamepad right button up (i.e. PS3: Triangle, Xbox: Y)
const.gamepad_button_right_face_right	= 6		-- Gamepad right button right (i.e. PS3: Circle, Xbox: B)
const.gamepad_button_right_face_down	= 7		-- Gamepad right button down (i.e. PS3: Cross, Xbox: A)
const.gamepad_button_right_face_left	= 8		-- Gamepad right button left (i.e. PS3: Square, Xbox: X)
const.gamepad_button_left_trigger_1		= 9		-- Gamepad top/back trigger left (first), it could be a trailing button
const.gamepad_button_left_trigger_2		= 10	-- Gamepad top/back trigger left (second), it could be a trailing button
const.gamepad_button_right_trigger_1	= 11	-- Gamepad top/back trigger right (first), it could be a trailing button
const.gamepad_button_right_trigger_2	= 12	-- Gamepad top/back trigger right (second), it could be a trailing button
const.gamepad_button_middle_left		= 13	-- Gamepad center buttons, left one (i.e. PS3: Select)
const.gamepad_button_middle				= 14	-- Gamepad center buttons, middle one (i.e. PS3: PS, Xbox: XBOX)
const.gamepad_button_middle_right		= 15	-- Gamepad center buttons, right one (i.e. PS3: Start)
const.gamepad_button_left_thumb			= 16	-- Gamepad joystick pressed button left
const.gamepad_button_right_thumb		= 17	-- Gamepad joystick pressed button right
-- Gamepad axis
const.gamepad_axis_left_x				= 0		-- Gamepad left stick X axis
const.gamepad_axis_left_y				= 1		-- Gamepad left stick Y axis
const.gamepad_axis_right_x				= 2		-- Gamepad right stick X axis
const.gamepad_axis_right_y				= 3		-- Gamepad right stick Y axis
const.gamepad_axis_left_trigger			= 4		-- Gamepad back trigger left, pressure level: [1..-1]
const.gamepad_axis_right_trigger		= 5		-- Gamepad back trigger right, pressure level: [1..-1]

-- Quadtree
const.quadtree_capacity = 4
const.quadtree_subdivision = 4

return const