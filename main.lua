
controller = require("control")
player = require("player")
movement = require("movement")
bullet = require("bullet")
enemy = require("enemy")
bloom=require "bloom"(love.graphics.getWidth()/4,love.graphics.getHeight()/4)
local shine = require 'shine'

function love.load()
	love.graphics.setBackgroundColor( 0x0a, 0x08, 0x06 )
	love.math.setRandomSeed( 6173420+love.timer.getTime( ) )
	enemy:init()
	player:init()

	player.create({x=800,y=450,w=30,h=30,
		angle=0,	-- 位移矢量角度
		fangle=0,	-- 朝向
		hp=3,maxspeed=400,speed=0})

	enemy.create("ALEXAR",40,10,800,250)

	controller:init()
	movement.bond(player)

	bloom:setIntensity(0,1.2)

	local desaturate2 = shine.desaturate()
	desaturate2.tint={0xff,0xa8,0x55}
	desaturate2.strength=0.8
	local gaussianblur2 = shine.gaussianblur()
	gaussianblur2.sigma = 20
	local boxblur2 = shine.boxblur()
	boxblur2.radius_h = 30
	boxblur2.radius_v = 10
	post_effect2 = boxblur2:chain(gaussianblur2):chain(desaturate2)
end

function love.update( dt )
	controller:update(dt)
	enemy:update(dt)
	movement.update(dt)
	bullet.update(dt)
	player:limit()
end

function love.draw( ... )
	bloom:predraw()
	bloom:enabledrawtobloom()
	bullet:draw()
	bullet:draw()
	bullet:draw()
	bloom:postdraw()

	post_effect2:draw(function()
		bullet:draw()
	end)
	post_effect2:draw(function()
		bullet:draw()
	end)

	love.graphics.setColor(0xbd, 0xa1, 0x83)
	enemy.draw()

	love.graphics.setColor(255, 255, 255)
	player:draw()
	bullet:draw()
end
