
local movement={}

local world={}

movement.world=world

function movement.bond( obj )
	table.insert(world, obj)
end

function movement.update( dt )
	for _,v in ipairs(world) do
		v.x = v.x+dt*math.cos(v.angle)*v.speed
		v.y = v.y+dt*math.sin(v.angle)*v.speed
	end
end


return movement
