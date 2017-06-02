

bt = require("bullet")
local player={}


-- bcanvas = love.graphics.newCanvas( 20, 70 )
-- bcanvas:renderTo(function()
-- 		love.graphics.setColor(255, 255, 255)
-- 		love.graphics.rectangle("fill", 1, 1, 19, 69)
-- 	end);

local function drawbullet(v)
	love.graphics.setColor(255, 255, 255, 255)
	love.graphics.draw(bimg, v.x, v.y, v.angle, 0.54, 0.17, -20, 50)
	-- love.graphics.setColor(255, 0, 0, 255)
	-- love.graphics.rectangle("line",v.x,v.y,10,10)
end

function player.create(tab)love.graphics.setColor(255, 255, 255, 255)
	for k,v in pairs(tab) do
		player[k] = v
	end
end

function player.fire(self,x,y)
	bt:add({x=self.x,y=self.y,angle=self.fangle,speed=600,type=player_bullet_type})
end

function player.draw(self)
	love.graphics.setColor(150, 150, 150, 255)
	local k,ox,oy=0.97,3*(1-2*self.x/love.graphics.getWidth()),3*(1-2*self.y/love.graphics.getHeight())
	love.graphics.draw(pp[self.hp],self.x+ox,self.y+oy,self.fangle+math.pi/2,0.44*k,0.44*k,37,89)
	local k,ox,oy=0.98,2*(1-2*self.x/love.graphics.getWidth()),2*(1-2*self.y/love.graphics.getHeight())
	love.graphics.draw(pp[self.hp],self.x+ox,self.y+oy,self.fangle+math.pi/2,0.44*k,0.44*k,37,89)
	local k,ox,oy=0.99,1*(1-2*self.x/love.graphics.getWidth()),1*(1-2*self.y/love.graphics.getHeight())
	love.graphics.draw(pp[self.hp],self.x+ox,self.y+oy,self.fangle+math.pi/2,0.44*k,0.44*k,37,89)
	love.graphics.setColor(255, 255, 255, 255)
	love.graphics.draw(pp[self.hp],self.x,self.y,self.fangle+math.pi/2,0.44,0.44,37,89)
	-- love.graphics.line(self.x, self.y, self.x+100*math.cos(self.fangle), self.y+100*math.sin(self.fangle))
end

function player.limit(self)
	self.x = math.min(self.x, love.graphics.getWidth()-5)
	self.x = math.max(self.x, 5)
	self.y = math.min(self.y, love.graphics.getHeight()-5)
	self.y = math.max(self.y, 5)
end

function player.init(self)
	player_bullet_type = bt.addtype(drawbullet,10,10)
	pp = {
	love.graphics.newImage("res/player/hp1.png"),
	love.graphics.newImage("res/player/hp2.png"),
	love.graphics.newImage("res/player/hp3.png")
	}
	bimg = love.graphics.newImage("res/100_100.png")
end

return player
