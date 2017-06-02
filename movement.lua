
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
	for i=#world,1,-1 do
		if world[i].x>love.graphics.getWidth()+50
			or world[i].x<-50
			or world[i].y>love.graphics.getHeight()+50
			or world[i].y<-50 then
			world[i].gc = true
			table.remove(world,i)
		end
	end
end


return movement
