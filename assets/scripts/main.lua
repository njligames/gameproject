function print_r ( t )
      local print_r_cache={}
      local function sub_print_r(t,indent)
        if (print_r_cache[tostring(t)]) then
          print(indent.."*"..tostring(t))
        else
          print_r_cache[tostring(t)]=true
          if (type(t)=="table") then
            for pos,val in pairs(t) do
              if (type(val)=="table") then
                print(indent.."["..pos.."] => "..tostring(t).." {")
                sub_print_r(val,indent..string.rep(" ",string.len(pos)+8))
                print(indent..string.rep(" ",string.len(pos)+6).."}")
              elseif (type(val)=="string") then
                print(indent.."["..pos..'] => "'..val..'"')
              else
                print(indent.."["..pos.."] => "..tostring(val))
              end
            end
          else
            print(indent..tostring(t))
          end
        end
      end
      if (type(t)=="table") then
        print(tostring(t).." {")
        sub_print_r(t," ")
        print("}")
      else
        sub_print_r(t," ")
      end
      print()
    end
















-- local test = require "tests.newgeo"
-- local test = require "tests.spriteatlas"
local test = require "tests.bitmapfont"

local Create = function()
  -- print("Create")
  test.create()
end

local Destroy = function()
  -- print("Destroy")
  test.destroy()
end

local Update = function(timeStep)
  -- print("Update", timeStep)
  njlic.World.getInstance():setBackgroundColor(1.000, 1.000, 1.000)
  test.update(timeStep)
end

local KeyDown = function(keycodeName, withCapsLock, withControl, withShift, withAlt, withGui)
  -- print("KeyDown", keycodeName, withCapsLock, withControl, withShift, withAlt, withGui)
end

local NodeRayMouseDown = function(rayContact)
  -- print(NodeRayMouseDown)
  -- ELIA.states[ELIA:getFrameIndex(currentStateName)].mouseDown(rayContact)
end

local NodeRayMouseUp = function(rayContact)
  -- print(NodeRayMouseUp)
  -- ELIA.states[ELIA:getFrameIndex(currentStateName)].mouseUp(rayContact)
end

local NodeRayMouseMissed = function(node)
  -- print(NodeRayMouseUp)
  -- ELIA.states[ELIA:getFrameIndex(currentStateName)].mouseMissed(node)
end

RegisterCreate("Create",                                         function() pcall(Create) end)
RegisterDestroy("Destroy",                                       function() pcall(Destroy) end )
RegisterUpdate("Update",                                         function(timeStep) pcall(Update, timeStep) end )
RegisterKeyDown("KeyDown",                                       function(keycodeName, withCapsLock, withControl, withShift, withAlt, withGui) pcall(KeyDown, keycodeName, withCapsLock, withControl, withShift, withAlt, withGui) end )
RegisterNodeRayMouseDown("NodeRayMouseDown",                     function(rayContact) pcall(NodeRayMouseDown, rayContact) end )
RegisterNodeRayMouseUp("NodeRayMouseUp",                         function(rayContact) pcall(NodeRayMouseUp, rayContact) end )
RegisterNodeRayMouseMissed("NodeRayMouseMissed",                 function(node) pcall(NodeRayMouseMissed, node) end )
