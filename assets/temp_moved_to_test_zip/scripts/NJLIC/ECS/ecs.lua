-- from [LÖVE tutorial, part 2](http://www.headchant.com/2010/12/31/love2d-%E2%80%93-tutorial-part-2-pew-pew/)

local World = require "world"
local Component = require "component"
local System = require "system"

function new_body(x, y)
  local body = Component.new "body"
  body.x = x
  body.y = y
  return body
end

function new_rectangle_component()
  return Component.new "rect"
end

function new_renderer_system()
  local renderer = System.new {"body", "rect"}
  
  function renderer:load(entity)
    print "found one"
  end
  
  function renderer:draw(entity)
    local body = entity:get "body"
    love.graphics.rectangle("fill", body.x, body.y, 32, 32)
  end
  
  return renderer
end


function love.load(arg)
  if arg and arg[#arg] == "-debug" then require("mobdebug").start() end
  
  World:register(new_renderer_system())
  local entity = World:create()
  entity:add(new_body(100, 100))
  entity:add(new_rectangle_component())
  
end

function love.update(dt)
  World:udpate(dt)
end

function love.draw()
  World:draw()
end
