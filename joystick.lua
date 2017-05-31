
local joystick={}

joysticks = love.joystick.getJoysticks( )
local pressed={}	-- 用于遍历有哪些按键被按下
local button={}		-- 用于判断特定按键是否被按下

function joystick.isValid()
	if joysticks[1] then return joysticks[1]:isConnected()
	else return false end
end

function joystick.press(btn)
	button[btn] = true
	table.insert(pressed,btn)
end

function axis_convert( y,x,obj )
	local k
	local angle = math.atan2(y, x)
	if math.abs(x)>0.6 or math.abs(y)>0.6 then
		k = 1
	else
		k = math.sqrt(x*x+y*y)
	end
	obj["angle"] = angle
	obj["k"] = k
end

-- axes x -1~1 y -1~1 lt -1~1 move&lock
-- axes x -1~1 y -1~1 rt -1~1 aim
-- button 6 shoot
local axis={ls={},rs={}}
function joystick.update( self )
	if joysticks[1]~=nil then	-- joystick
		x1,y1,lt,x2,y2,rt = joysticks[1]:getAxes()
		for i=#pressed,1,-1 do
			if not joysticks[1]:isDown(pressed[i]) then
				table.remove(pressed,i)
				button[i] = false
			end
		end
		if not self.isValid() then return end
		axis_convert(y1,x1,axis["ls"])
		axis_convert(y2,x2,axis["rs"])
		axis["lt"] = lt
		axis["rt"] = rt
	end
end

function joystick.ctrl( self,obj )
	obj.angle = self.axis["ls"].angle
	obj.speed = self.axis["ls"].k * obj.maxspeed
	if self.axis["rs"].k>0.1 then
		obj.fangle = self.axis["rs"].angle
	elseif self.axis["ls"].k>0.2 then
		obj.fangle = self.axis["ls"].angle
	end
end

function joystick.init( self )
	self.axis = axis
	self.button = button
	self.pressed = pressed
end

function love.joystickpressed(joystickn,button)
	if joystickn~=joysticks[1] then return end
	joystick.press(button)
end

function love.joystickadded()
	joysticks = love.joystick.getJoysticks( )
	if joysticks[1]:getAxisCount( ) < 6 then
		joysticks[1] = nil
	end
end

function love.joystickremoved()
	joysticks = love.joystick.getJoysticks( )
	if joysticks[1]:getAxisCount( ) < 6 then
		joysticks[1] = nil
	end
end




return joystick
