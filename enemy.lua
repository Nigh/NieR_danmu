
local bt = require("bullet")
local player = require("player")


local enemy={}

default_txt_size = 120

local function drawbullet1(v)
	love.graphics.setColor(255, 255, 255, 255)
	love.graphics.draw(bimg1, v.x, v.y, v.angle, 1, 1, 24, 24)
	love.graphics.rectangle("line", v.x-12, v.y-12, 24, 24)
end

local function drawbullet2(v)
	love.graphics.setColor(255, 255, 255, 255)
	love.graphics.draw(bimg2, v.x, v.y, v.angle, 1, 1, 30, 30)
	love.graphics.rectangle("line", v.x-15, v.y-15, 30, 30)
end

function enemy.create( txt,size,hp,x,y )
	local text = love.graphics.newText( font, txt )
	local w,h = text:getDimensions()
	table.insert(etable,{t=love.graphics.newText( font, txt ),hp=hp,size=size,x=x,y=y,w=w*size/default_txt_size,h=h*size/default_txt_size})
end

function enemy.draw( self )
	for _,v in ipairs(etable) do
		love.graphics.draw(v.t, v.x, v.y, 0, v.size/default_txt_size, v.size/default_txt_size)
		love.graphics.rectangle("line", v.x, v.y, v.w, v.h)
	end
end

function enemy.fire(self,x,y,angle)
	bt:add({x=x,y=y,angle=angle,speed=500,type=love.math.random(enemy_bullet_type1,enemy_bullet_type2)})
end

local time = 0
function enemy.update( self,dt )
	time = time+dt
	if time>0.3 then
		time = time-0.3
		local sx,sy=etable[1].x+etable[1].w/2,etable[1].y+etable[1].h/2
		enemy:fire(sx,sy,math.atan2(player.y-sy,player.x-sx))
	end
end

function enemy.init(self)
	enemy_bullet_type1 = bt.addtype(drawbullet1,24,24)
	enemy_bullet_type2 = bt.addtype(drawbullet2,30,30)
	bimg1 = love.graphics.newImage("res/bullet_48_48.png")
	bimg2 = love.graphics.newImage("res/bullet_60_60.png")
	font = love.graphics.newFont( "res/msgothic.ttc",default_txt_size )
	etable = {}
end

return enemy
