
cs=require("collision")
mm=require("movement")
local bullet={}

local btypelist={}
local btable={}

function bullet.addtype(drawfunc,w,h)
	table.insert(btypelist,{draw=drawfunc,w=w,h=h})
	return #btypelist
end

function bullet.add( self,b )
	table.insert(btable,b)
	mm.bond(btable[#btable])
end

function bullet.draw( self )
	for _,v in ipairs(btable) do
		btypelist[v.type].draw(v)
	end
end

function bullet.update( dt )
	for i=#btable,1,-1 do
		if btable[i].gc then
			table.remove(btable,i)
		end
	end
end


return bullet
