
joystick = require("joystick")
keyboard = require("keyboard")

local controller = {}

function controller.update(self,dt)
	joystick:update()
	-- 控制器优先级高于键鼠
	if self.use_cursor == true
		and joystick.isValid()
		and (joystick.axis["ls"].k>0 
		or joystick.axis["rs"].k>0) then
		love.mouse.setCursor(self.cursor[2])
		self.use_cursor = false
	end

	if not self.use_cursor then
		joystick:ctrl(player,dt)
	else
		keyboard:ctrl(player,dt)
	end
end

function controller.init( self )
	self.use_cursor = true	-- 是否使用光标
	self.cursor = {love.mouse.newCursor("res/aim_21_24.png",21,24),love.mouse.newCursor("res/_.png")}
	love.mouse.setCursor(self.cursor[1])
	joystick:init()
	keyboard:init()
end

function love.keypressed( key, scancode, isrepeat )
	if controller.use_cursor == false
		and joystick.axis["ls"].k==0 
		and joystick.axis["rs"].k==0 then
		love.mouse.setCursor(controller.cursor[1])
		controller.use_cursor = true
	end
	if not isrepeat then
		if keyboard.ktable[key]~=nil then
			keyboard.ktable[key]=1
		end
	end
end

function love.keyreleased( key, scancode )
	if keyboard.ktable[key]~=nil then
		keyboard.ktable[key]=0
	end
end

function love.mousepressed( x, y, button, istouch )
	if controller.use_cursor == false
		and joystick.axis["ls"].k==0 
		and joystick.axis["rs"].k==0 then
		love.mouse.setCursor(controller.cursor[1])
		controller.use_cursor = true
	end
	if keyboard.ktable[button]~=nil then
		keyboard.ktable[button]=1
	end
end

function love.mousereleased( x, y, button, istouch )
	if keyboard.ktable[button]~=nil then
		keyboard.ktable[button]=0
	end
end

return controller
