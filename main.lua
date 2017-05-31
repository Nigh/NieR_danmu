
controller = require("control")
player = require("player")
movement = require("movement")

function love.load()
	love.graphics.setBackgroundColor( 0x0a, 0x08, 0x06 )
	love.math.setRandomSeed( 6173420+love.timer.getTime( ) )
	player.create({x=800,y=450,w=30,h=30,
		angle=0,	-- 位移矢量角度
		fangle=0,	-- 朝向
		hp=3,maxspeed=500,speed=0})
	controller:init()
	movement.bond(player)
end

function love.update( dt )
	controller:update()
	movement.update(dt)
	player:limit()
end

function love.draw( ... )
	player:draw()
end
