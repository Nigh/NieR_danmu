
local player={}

pp = {
love.graphics.newImage("res/player/hp1.png"),
love.graphics.newImage("res/player/hp2.png"),
love.graphics.newImage("res/player/hp3.png")
}

function player.create(tab)
	for k,v in pairs(tab) do
		player[k] = v
	end
end

function player.draw(self)
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

return player
