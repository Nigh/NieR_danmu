
local keyboard={}

local ktable={a=0,s=0,d=0,w=0,lctrl=0,rctrl=0,[1]=0}
local time = 0	-- 子弹间隔计时器
function keyboard.ctrl( self,player,dt )
	local _dx,_dy=ktable["d"]-ktable["a"],ktable['s']-ktable['w']
	time = time+dt
	if _dx~=0 or _dy~=0 then
		player.angle = math.atan2(_dy,_dx)
		if ktable['lctrl'] + ktable['rctrl']>0 then
			player.speed = 0.3 * player.maxspeed
		else
			player.speed = 1 * player.maxspeed
		end
	else
		player.speed = 0
	end
	player.fangle = math.atan2(love.mouse.getY()-player.y, love.mouse.getX()-player.x)
	if ktable[1]==1 and time>0.16 then
		player:fire();time=math.mod(time*100,10)/100
	end
end

function keyboard.init( self )
	self.ktable = ktable
end

return keyboard
