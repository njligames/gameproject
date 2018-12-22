require "NJLIC.util"

local BitmapFont = require 'NJLIC.BitmapFont'
local TexturePacker = require "NJLIC.TexturePacker"

local StateMachine = {
  new = function(...)
    local sm = {
      states = {},
      currentStateName = nil,
    }
    
    function sm:addState(name, state)
      assert(self.states[name] == nil, "State must be nil")
      
      self.states[name] = state
    end
  
    function sm:switchStates(name)
      assert(name, "state name is nil")
      assert(self.states[name] ~= nil, "State is nil")
      
      if currentStateName then
        self.states[currentStateName].exit()
      end
      
      currentStateName = name
      self.states[currentStateName].enter()
    end
    
    function sm:update(timeStep)
      if currentStateName then
        self.states[currentStateName].update(timeStep)
      end      
    end
    
    function sm:collide(node, otherNode, collisionPoint)
      if currentStateName then
        self.collide[currentStateName].update(node, otherNode, collisionPoint)
      end
    end
    
    return sm
  end
}

local Bird = {
  new = function(...)
    local arg=... or {}
    
--    local STATEMACHINE_STATES={fly="fly",grabbed="grabbed",grabbing="grabbing",hit="hit",pursue="pursue",spawn="spawn"}
    
    
    
    
--    ELIA.frameIndex =
--    {
--      [STATE_GAMEPLAY] = 1,
--      [STATE_SPLASH] = 2,
--      [STATE_RESULT] = 3,
--      [STATE_LEADERBOARD] = 4,
--    }
--    function ELIA:getFrameIndex(name)
--      return self.frameIndex[name];
--    end

--    function SwitchStates(newState)
--    ELIA.states[ELIA:getFrameIndex(currentStateName)].exit()
--    currentStateName = newState
--    ELIA.states[ELIA:getFrameIndex(currentStateName)].enter()
--    end
--    local switchStates = function(newState)
--    end
    
--    local states = 
--    {
--      {
--        name=STATEMACHINE_STATES.fly,
--        vars = {},
--        enter = function() end,
--        exit = function() end,
--        update = function(timeStep) end,
--        nodeCollide = function(node, otherNode, collisionPoint) end,
--      },
--      {
--        name=STATEMACHINE_STATES.grabbed,
--        vars = {},
--        enter = function() end,
--        exit = function() end,
--        update = function(timeStep) end,
--        nodeCollide = function(node, otherNode, collisionPoint) end,
--      },
--      {
--        name=STATEMACHINE_STATES.grabbing,
--        vars = {},
--        enter = function() end,
--        exit = function() end,
--        update = function(timeStep) end,
--        nodeCollide = function(node, otherNode, collisionPoint) end,
--      },
--      {
--        name=STATEMACHINE_STATES.hit,
--        vars = {},
--        enter = function() end,
--        exit = function() end,
--        update = function(timeStep) end,
--        nodeCollide = function(node, otherNode, collisionPoint) end,
--      },
--      {
--        name=STATEMACHINE_STATES.pursue,
--        vars = {},
--        enter = function() end,
--        exit = function() end,
--        update = function(timeStep) end,
--        nodeCollide = function(node, otherNode, collisionPoint) end,
--      },
--      {
--        name=STATEMACHINE_STATES.spawn,
--        vars = {},
--        enter = function() end,
--        exit = function() end,
--        update = function(timeStep) end,
--        nodeCollide = function(node, otherNode, collisionPoint) end,
--      },
--    }
    
    local texturePacker=arg.texturePacker or {}
    local perspectiveCamera=arg.perspectiveCamera or nil
    local index = arg.index or 0
    local params = arg.params or nil
    local birdName = arg.birdName or nil
    local dogs = arg.dogs or nil
    
    assert(texturePacker, "The texturePacker is nil")
    assert(perspectiveCamera, "The perspectiveCamera is nil")
    assert(params, "The params is nil")
    assert(birdName, "The birdName is nil")
    assert(dogs, "The dogs is nil")
 
    local bird = {
      inplay=false,
      texturePacker=texturePacker,
      perspectiveCamera=perspectiveCamera,
      color = nil,
      node = nil,
      action = nil,
      index = index,
      currentFrame = 0,
      animationClock = nil,
      fps=30,
      params = params,
      ANIMATION_STATES={grab="grab",hit="hit",idle="idle"},
      birdName=birdName,
      dogs=dogs,
      STATEMACHINE_STATES={fly="fly",grabbed="grabbed",grabbing="grabbing",hit="hit",pursue="pursue",spawn="spawn"},
      stateMachine = nil,
    }
    
    function bird:getFrameName()
      local state = self.currentAnimationState
      local birdName = self.birdName
      
      if state == "fly" then
      elseif state == "grabbed" then
      elseif state == "grabbing" then
      elseif state == "hit" then
      elseif state == "pursue" then
      elseif state == "spawn" then
      end
      
      local name = string.format("character_%sBird_%s_front/character_%sBird_%s_front_%05d", birdName, state, birdName, state, self.currentFrame)
      return name
    end
    
    function bird:load(...)
      local arg=... or {}
      
      print("loaded the bird - start")
      
      local origin = bullet.btVector3(0.0, 0.0, 0.0)
      
      self.currentAnimationState=self.ANIMATION_STATES.idle
      
      local name = self:getFrameName()
      
      if self.texturePacker[1]:has({name=name}) then
        self.node = njlic.Node.create()
        self.node = self.texturePacker[1]:draw({name=name, node=self.node, updateDimensions=false})
      elseif self.texturePacker[2]:has({name=name}) then
        self.node = njlic.Node.create()
        self.node = self.texturePacker[2]:draw({name=name, node=self.node, updateDimensions=false})
      end
      
      if self.node then
        self.node:setName(string.format("%sbird_node_%05d", self.birdName, self.index))
      
        self.node:setOrigin(origin)
        self.node:enableTagged(false)
        self:hide()
        
        self.action = njlic.Action.create()
        self.action:setRepeatForever()
        self.action:setName(string.format("%sbird_action_%05d", self.birdName, self.index))
        
        self.animationClock = njlic.Clock.create()
        
        njlic.World.getInstance():getScene():getRootNode():addChildNode(self.node)
        
        self.physicsBody = njlic.PhysicsBodyRigid.create()
        assert(self.physicsBody, "physicsBody is null")
        
        self.physicsShape = njlic.PhysicsShapeCylinder.create()
        assert(self.physicsShape, "physicsShape is null")
        
        self.physicsShape:setMargin(1)
        self.physicsBody:setPhysicsShape(self.physicsShape)   
        self.physicsBody:setKinematicPhysics()
        
        self.sound = njlic.Sound.create()
        self.sound:setName(string.format("%sbird_sound_%05d", self.birdName, self.index))
        local soundName = "sounds/projectile_balloon_water-splash.ogg"
        njlic.World.getInstance():getWorldResourceLoader():load(soundName, self.sound)
        
        
        print("start steering behaviour for bird")
        self.steeringBehaviourMachine = njlic.SteeringBehaviorMachineDithered.create()
        self.steeringBehaviourMachine:setMaxSpeed(self.params.Bird[self.birdName].MaxSpeed)
        self.steeringBehaviourMachine:setMaxForce(self.params.Bird[self.birdName].MaxForce)
        
        self.steeringBehaviourOffsetPursuit = njlic.SteeringBehaviorOffsetPursuit.create()
        self.steeringBehaviourOffsetPursuit:setOffsetPosition(bullet.btVector3(0,20,0))
        self.steeringBehaviourOffsetPursuit:setWeight(1.0)
        self.steeringBehaviourOffsetPursuit:setProbability(0.5)
--        self.steeringBehaviourOffsetPursuit = njlic.SteeringBehaviorArrive.create()

        self.steeringBehaviorSeparation = njlic.SteeringBehaviorSeparation.create()
        self.steeringBehaviorSeparation:setWeight(60.0)
        self.steeringBehaviorSeparation:setProbability(0.5)
        
        self.steeringBehaviorEvade = njlic.SteeringBehaviorEvade.create()
        self.steeringBehaviorEvade:setWeight(600.0)
        self.steeringBehaviorEvade:setProbability(1.0)
        
        self.steeringBehaviourMachine:addSteeringBehavior(self.steeringBehaviourOffsetPursuit)
        self.steeringBehaviourMachine:addSteeringBehavior(self.steeringBehaviorSeparation)
        self.steeringBehaviourMachine:addSteeringBehavior(self.steeringBehaviorEvade)
        
        
        self.node:setSteeringBehaviorMachine(self.steeringBehaviourMachine)
        
        print("end steering behaviour for bird")
        
      else
        print("couldn't load the bird")
      end
      
--      {fly="fly",grabbed="grabbed",grabbing="grabbing",hit="hit",pursue="pursue",spawn="spawn"}
      local stateMachine = StateMachine.new(self)
      
      stateMachine:addState(self.STATEMACHINE_STATES.fly, {
          enter = function() print("enter") end,
          exit = function() print("exit") end,
          update = function(timeStep) print("update") end,
          nodeCollide = function(node, otherNode, collisionPoint) print("nodeCollide") end,
        })
      stateMachine:addState(self.STATEMACHINE_STATES.grabbed, {
          enter = function() print("enter") end,
          exit = function() print("exit") end,
          update = function(timeStep) print("update") end,
          nodeCollide = function(node, otherNode, collisionPoint) print("nodeCollide") end,
        })
      stateMachine:addState(self.STATEMACHINE_STATES.grabbing, {
          enter = function() print("enter") end,
          exit = function() print("exit") end,
          update = function(timeStep) print("update") end,
          nodeCollide = function(node, otherNode, collisionPoint) print("nodeCollide") end,
        })
      stateMachine:addState(self.STATEMACHINE_STATES.hit, {
          enter = function() print("enter") end,
          exit = function() print("exit") end,
          update = function(timeStep) print("update") end,
          nodeCollide = function(node, otherNode, collisionPoint) print("nodeCollide") end,
        })
      stateMachine:addState(self.STATEMACHINE_STATES.pursue, {
          enter = function() print("enter") end,
          exit = function() print("exit") end,
          update = function(timeStep) print("update") end,
          nodeCollide = function(node, otherNode, collisionPoint) print("nodeCollide") end,
        })
      stateMachine:addState(self.STATEMACHINE_STATES.spawn, {
          enter = function() print("enter") end,
          exit = function() print("exit") end,
          update = function(timeStep) print("update") end,
          nodeCollide = function(node, otherNode, collisionPoint) print("nodeCollide") end,
        })
      self.stateMachine = stateMachine
      
      
      
      print("loaded the bird - end")
    end
  
    function bird:unload()
      self.stateMachine = nil
      
      njlic.SteeringBehaviorSeparation.destroy(self.steeringBehaviorSeparation)
      njlic.SteeringBehaviorOffsetPursuit.destroy(self.steeringBehaviourOffsetPursuit)
      njlic.SteeringBehaviorMachineDithered.destroy(self.steeringBehaviourMachine)
      
      njlic.Sound.destroy(self.sound)
      
      njlic.PhysicsBodyRigid.destroy(self.physicsBody)
      njlic.PhysicsShapeCylinder.destroy(self.physicsShape) 
      
      njlic.Clock.destroy(self.animationClock)
      njlic.Action.destroy(self.action)
      njlic.Node.destroy(self.node)
      
      print("unloaded the bird")
    end
  
    function bird:setup(...)
      local arg=... or {}
      
      local origin = arg.origin or bullet.btVector3(0.0, 0.0, 0.0)
      local dimensions = arg.dimensions or bullet.btVector2(256.0, 256.0)
      local debug = arg.debug or false
      
      self.inplay=true

      self.node:setOrigin(origin)
      self.node:getGeometry():setDimensions(self.node, dimensions)
      
      print("setup the balloon")
      
    end
    
    function bird:spawn(...)
      local arg=... or {}
      
      print("spawn bird")
      
      self.inplay=true
      
      self:show()
      self.node:runAction(self.action)
      self.node:setPhysicsBody(self.physicsBody)
      self.node:enableTagged()
      
      self.steeringBehaviourMachine:enable()
      
      self.currentAnimationState=self.ANIMATION_STATES.idle
      self.stateMachine:switchStates(self.STATEMACHINE_STATES.spawn)
    end

    function bird:kill(...)
      local arg=... or {}
      
      self.inplay=false

      self.steeringBehaviourMachine:enable(false)
      
      self.node:removeAction(self.node:getName())
      
      self.node:removePhysicsBody()
      self.node:enableTagged(false)
      self:hide()
      
      print("killed bird")

      -- put back to hiding values
    end
    
    function bird:hide()
      self.node:hide(self.perspectiveCamera)
    end
    
    function bird:show()
      self.node:show(self.perspectiveCamera)
    end
  
    function bird:incrementAnimationFrame()
      self.currentFrame = self.currentFrame + 1
      if(self.currentFrame > 8) then self.currentFrame = 0 end
      
      local name = self:getFrameName()
      
      if self.texturePacker[1]:has({name=name}) then
        self.node = self.texturePacker[1]:draw({name=name, node=self.node, updateDimensions=false})
      elseif self.texturePacker[2]:has({name=name}) then
        self.node = self.texturePacker[2]:draw({name=name, node=self.node, updateDimensions=false})
      end
    end
    
    function bird:update(timeStep)
      
      for i = 1, #self.dogs do
        local dogEntity = self.dogs[i]
        
        if dogEntity.inplay then
          self.steeringBehaviourOffsetPursuit:addTarget(dogEntity.node)
        else
          self.steeringBehaviourOffsetPursuit:removeTarget(dogEntity.node)
        end
      end
      
      self.stateMachine:update(timeStep)
      
--      print("bird")
    end
  
    function bird:addNeighbors(birds)
      for i = 1, #birds do
        local node = birds[i].node
        if node ~= nil then
          self.steeringBehaviorSeparation:addTarget(node)
        end
      end
    end
    
    function bird:addBalloonsToEvade(balloons)
      for i = 1, #balloons do
        local node = balloons[i].node
        if node ~= nil then
          self.steeringBehaviorEvade:addTarget(node)
        end
      end
    end
    

    return bird
  end
}

local Balloon = {
  new = function(...)
    local arg=... or {}
    
    local texturePacker=arg.texturePacker or {}
    local perspectiveCamera=arg.perspectiveCamera or nil
    local index = arg.index or 0
    local params = arg.params or nil
    
    assert(texturePacker, "The texturePacker is nil")
    assert(perspectiveCamera, "The perspectiveCamera is nil")
    assert(params, "The params is nil")
    
    local balloon = {
      inplay=false,
      texturePacker=texturePacker,
      perspectiveCamera=perspectiveCamera,
      color = nil,
      node = nil,
      action = nil,
      index = index,
      currentFrame = 0,
      animationClock = nil,
      fps=30,
      params = params
    }
    
    function balloon:getFrameName()
      local name = string.format("projectile_waterBalloon%s_thrown_front/projectile_waterBalloon%s_thrown_front_%05d", self.color, self.color, self.currentFrame)
      return name
    end
    
    function balloon:load(...)
      local arg=... or {}
      
      print("loaded the balloon - start")
      
      self.color = arg.color or "?"
      
      local origin = bullet.btVector3(0.0, 0.0, 0.0)

      local name = self:getFrameName()
      
      self.node = njlic.Node.create()
      self.node:enableTagged(false)
      
      if self.texturePacker[1]:has({name=name}) then
        self.node = self.texturePacker[1]:draw({name=name, node=self.node, updateDimensions=false})
      elseif self.texturePacker[2]:has({name=name}) then
        self.node = self.texturePacker[2]:draw({name=name, node=self.node, updateDimensions=false})
      end
      self.node:setName("balloon_"..self.index)
      
      self.node:setOrigin(origin)
      self:hide()
      
      self.action = njlic.Action.create()
      self.action:setRepeatForever()
      self.action:setName("balloon_"..self.index)
      
      self.animationClock = njlic.Clock.create()
      
      njlic.World.getInstance():getScene():getRootNode():addChildNode(self.node)
      
      self.physicsBody = njlic.PhysicsBodyRigid.create()
      assert(self.physicsBody, "physicsBody is null")
      
      self.physicsShape = njlic.PhysicsShapeCylinder.create()
      assert(self.physicsShape, "physicsShape is null")
      
      self.physicsShape:setMargin(1)
      self.physicsBody:setPhysicsShape(self.physicsShape)   
      self.physicsBody:setDynamicPhysics()
      
      self.sound = njlic.Sound.create()
      self.sound:setName("balloonsound_"..self.index)
      local soundName = "sounds/projectile_balloon_water-splash.ogg"
      njlic.World.getInstance():getWorldResourceLoader():load(soundName, self.sound)
      
      
      
      print("loaded the balloon - end")
    end
  
    function balloon:unload()
      njlic.Sound.destroy(self.sound)
      
      njlic.PhysicsBodyRigid.destroy(self.physicsBody)
      njlic.PhysicsShapeCylinder.destroy(self.physicsShape) 
      
      njlic.Clock.destroy(self.animationClock)
      njlic.Action.destroy(self.action)
      njlic.Node.destroy(self.node)
      
      print("unloaded the balloon")
    end
    
    function balloon:setup(...)
      local arg=... or {}
      
      local origin = arg.origin or bullet.btVector3(0.0, 0.0, 0.0)
      local dimensions = arg.dimensions or bullet.btVector2(256.0, 256.0)
      local direction = arg.direction or bullet.btVector3(0.0, 1.0, 0.0)
      local debug = arg.debug or false
      
      self.inplay=true

      self.node:setOrigin(origin)
      self.node:getGeometry():setDimensions(self.node, dimensions)
      self.direction = direction
      
      print("setup the balloon")
      
    end

    function balloon:spawn(...)
      local arg=... or {}
      
      print("spawn balloon")
      
      self.inplay=true
      
      self:show()
      self.node:enableTagged()
      self.node:runAction(self.action)
      self.node:setPhysicsBody(self.physicsBody)
      
      local azimuth = self.params.Projectile.WaterBalloon.Azimuth
      local magnitude = self.params.Projectile.WaterBalloon.Magnitude
      local mass = self.params.Projectile.WaterBalloon.Mass
      local direction = self.direction
      
      local x = self.node:getWorldTransform():getOrigin():x()
      local y = self.node:getWorldTransform():getOrigin():y()
      local z = self.node:getWorldTransform():getOrigin():z()
      direction = direction:rotate(bullet.btVector3(-1,0,0), math.atan(azimuth, z))
      direction = direction:rotate(bullet.btVector3(0,1,0), math.atan(x, z))
      direction = direction:rotate(bullet.btVector3(-1,0,0), math.atan(y, z))
      
      self.node:getPhysicsBody():setMass(mass)
      self.node:getPhysicsBody():applyForce(direction * magnitude, true)
      
    end

    function balloon:kill(...)
      local arg=... or {}
      
      local playSound = arg.playSound or false
      
      self.inplay=false
      
      if playSound then
        self.sound:play()
      end

      self.node:removeAction(self.node:getName())
      
      
      self.node:removePhysicsBody()
      self.node:enableTagged(false)
      self:hide()
      
      print("killed balloon")
      -- put back to hiding values
    end
    
    function balloon:hide()
      self.node:hide(self.perspectiveCamera)
    end
    
    function balloon:show()
      self.node:show(self.perspectiveCamera)
    end
  
    function balloon:incrementAnimationFrame()
      self.currentFrame = self.currentFrame + 1
      if(self.currentFrame > 2) then self.currentFrame = 0 end
      
      local name = self:getFrameName()
      
      if self.texturePacker[1]:has({name=name}) then
        self.node = self.texturePacker[1]:draw({name=name, node=self.node, updateDimensions=false})
      elseif self.texturePacker[2]:has({name=name}) then
        self.node = self.texturePacker[2]:draw({name=name, node=self.node, updateDimensions=false})
      end
      
    end
    
    function balloon:update(timeStep)
      local origin = self.node:getOrigin()

      local die = self.params.Projectile.WaterBalloon.DieY
      if self.node:getOrigin():y() < die then
        self:kill()
      end
    end

    return balloon
  end
}
--smb = njlic.SteeringBehaviorMachineWeighted.create()
--followPathSB = njlic.SteeringBehaviorFollowPath.create()
--offsetPursuitSB = njlic.SteeringBehaviorOffsetPursuit.create()
--pursuitSB = njlic.SteeringBehaviorPursuit.create()
--evadeSB = njlic.SteeringBehaviorEvade.create()

--node = njlic.Node.create()
--path = njlic.Path()
local Dog = {
  new = function(...)
    local arg=... or {}
    
    local texturePacker=arg.texturePacker or {}
    local perspectiveCamera=arg.perspectiveCamera or nil
    local index = arg.index or 0
    local params = arg.params or nil

    assert(texturePacker, "The texturePacker is nil")
    assert(perspectiveCamera, "The perspectiveCamera is nil")
    assert(params, "The params is nil")
    
    local dog = {
      inplay=false,
      texturePacker=texturePacker,
      perspectiveCamera=perspectiveCamera,
      color = nil,
      node = nil,
      action = nil,
      index = index,
      currentFrame = 0,
      animationClock = nil,
      fps=1.0,
      params = params,
      ANIMATION_STATES={fall="fall",grabbed="grabbed",idle="idle",run="run"},
      left = false
      
    }
    
    function dog:getFrameName()
      local state = self.currentAnimationState
      
      local l = ""
      if(self.left)then
        l = "_left"
      end
      
      local name = string.format("character_dog_%s_side%s/character_dog_%s_side%s_%05d", state, l, state, l, self.currentFrame)
      
      return name
    end
    
    function dog:load(...)
      local arg=... or {}
      
      print("loaded the dog - start")
      
      local origin = bullet.btVector3(0.0, 0.0, 0.0)
      
      self.currentAnimationState=self.ANIMATION_STATES.idle 
      
      local name = self:getFrameName()
      
      if self.texturePacker[1]:has({name=name}) then
        self.node = njlic.Node.create()
        self.node = self.texturePacker[1]:draw({name=name, node=self.node, updateDimensions=false})
      elseif self.texturePacker[2]:has({name=name}) then
        self.node = njlic.Node.create()
        self.node = self.texturePacker[2]:draw({name=name, node=self.node, updateDimensions=false})
      end
      
      if self.node then
        self.node:setName("dog_node_"..self.index)
      
        self.node:setOrigin(origin)
        self:hide()
        
        self.action = njlic.Action.create()
        self.action:setRepeatForever()
        self.action:setName("dog_action_"..self.index)
        
        self.animationClock = njlic.Clock.create()
        
        njlic.World.getInstance():getScene():getRootNode():addChildNode(self.node)
        
        self.physicsBody = njlic.PhysicsBodyRigid.create()
        assert(self.physicsBody, "physicsBody is null")
        
        self.physicsShape = njlic.PhysicsShapeCylinder.create()
        assert(self.physicsShape, "physicsShape is null")
        
        self.physicsShape:setMargin(1)
        self.physicsBody:setPhysicsShape(self.physicsShape)   
        self.physicsBody:setKinematicPhysics()
        
        self.sound = njlic.Sound.create()
        self.sound:setName("dog_sound_"..self.index)
        local soundName = "sounds/projectile_balloon_water-splash.ogg"
        njlic.World.getInstance():getWorldResourceLoader():load(soundName, self.sound)
        
        print("start steering behaviour for dog")
        self.steeringBehaviourMachine = njlic.SteeringBehaviorMachineWeighted.create()
        self.steeringBehaviourFollowPath = njlic.SteeringBehaviorFollowPath.create()
        
        self.steeringBehaviourMachine:setMaxSpeed(self.params.Dog.MaxSpeed)
        self.steeringBehaviourMachine:setMaxForce(self.params.Dog.MaxForce)
        
        self.steeringBehaviourMachine:addSteeringBehavior(self.steeringBehaviourFollowPath)
        
        self.node:setSteeringBehaviorMachine(self.steeringBehaviourMachine)
        
        print("end steering behaviour for dog")
      else
        print("couldn't load the dog")
      end
      
      print("loaded the dog - end")
      
    end
    
--    function dog:setWaypointPath(...)
--      local arg=... or {}
      
--      assert(self.steeringBehaviourFollowPath, "The follow path steering behaviour can't be  nil")
      
--      local numWaypoints = 0
      
--      if numWaypoints > 0 then
--        local path = njlic.Path()
        
--        for i = 1, numWaypoints do
--          local point = nil
--          if point then
--            self.path:addWayPoint(point)
--          end
--        end
        
--        self.steeringBehaviourFollowPath:setPath(path)
        
--        return path
--      end
--      return nil
--    end
    
  
    function dog:unload()
      njlic.Sound.destroy(self.sound)
      
      njlic.PhysicsBodyRigid.destroy(self.physicsBody)
      njlic.PhysicsShapeCylinder.destroy(self.physicsShape) 
      
      njlic.Clock.destroy(self.animationClock)
      njlic.Action.destroy(self.action)
      njlic.Node.destroy(self.node)
      
      print("unloaded the dog")
    end
    
    function dog:setup(...)
      local arg=... or {}
      
--      local origin = arg.origin or bullet.btVector3(0.0, 0.0, 0.0)
      local dimensions = arg.dimensions or bullet.btVector2(256.0, 256.0)
      local path = arg.path or nil
      local debug = arg.debug or false
      
      self.inplay=true

      
      self.node:getGeometry():setDimensions(self.node, dimensions)
      
      assert(path, "The path is nil")
      
      local origin = path:currentWaypoint()
      self.node:setOrigin(origin)
      self.steeringBehaviourFollowPath:setPath(path)
      
      -- local avg = path:averageDistanceBetweenPoints()
      
      self.steeringBehaviourFollowPath:setWaypointSeekDist(1.0)
      
      print("setup the dog")
      
    end

    function dog:spawn(...)
      local arg=... or {}
      
      print("spawn dog")
      
      self.inplay=true
      
      self:show()
      self.node:runAction(self.action)
      self.node:setPhysicsBody(self.physicsBody)
      self.steeringBehaviourMachine:enable()
      
      
      self.currentAnimationState=self.ANIMATION_STATES.run
      self.left = false
    end

    function dog:kill(...)
      local arg=... or {}
      
      self.inplay=false

      self.steeringBehaviourMachine:enable(false)
      self.node:removeAction(self.node:getName())
      
      self.node:removePhysicsBody()
      self:hide()
      self.steeringBehaviourMachine:enable(false)
      
      print("killed balloon")
      -- put back to hiding values
    end
    
    function dog:hide()
      self.node:hide(self.perspectiveCamera)
    end
    
    function dog:show()
      self.node:show(self.perspectiveCamera)
    end
  
    function dog:incrementAnimationFrame()
      self.currentFrame = self.currentFrame + 1
      if(self.currentFrame > 8) then self.currentFrame = 0 end
      
      local name = self:getFrameName()
      
      if self.texturePacker[1]:has({name=name}) then
        self.node = self.texturePacker[1]:draw({name=name, node=self.node, updateDimensions=false})
      elseif self.texturePacker[2]:has({name=name}) then
        self.node = self.texturePacker[2]:draw({name=name, node=self.node, updateDimensions=false})
      end
    end
    
    function dog:update(timeStep)
      self.left = self.steeringBehaviourMachine:getCurrentVelocity():normalized():x() < 0.0
      
      local MAXVEL = 62.0
      local MAXFPS = 30.0
      local MINFPS = 5.0
      
      local vel = math.abs(self.steeringBehaviourMachine:getCurrentVelocity():x())
      
      -- x/30 == vel/maxvel
      -- vel * 30 = x * maxvel
      -- x = vel * 30 / maxvel
      local x = (vel * MAXFPS) / MAXVEL
      if x < MINFPS then x = MINFPS end
      if x > MAXFPS then x = MAXFPS end
      
      if self.currentAnimationState==self.ANIMATION_STATES.run then self.fps = x end
      
      
    end

    return dog
  end
}

local Billboard = {
  new = function(...)
    local arg=... or {}
    
    local levelTexturePacker=arg.levelTexturePacker or {}
    local perspectiveCamera=arg.perspectiveCamera or nil
    local index = arg.index or 0
    local params = arg.params or nil

    local billboard = {
      inplay=false,
      node = nil,
      levelTexturePacker=levelTexturePacker,
      perspectiveCamera=perspectiveCamera,
      node = nil,
      index = index,
      params = params
    }
    
    function billboard:load(...)
      local arg=... or {}
      
      local name = arg.name or "?"
      local origin = arg.origin or bullet.btVector3(0.0, 0.0, 0.0)
      local dimensions = arg.dimensions or bullet.btVector2(0.0, 0.0)
      
      self.node = njlic.Node.create()
      self.node = self.levelTexturePacker[1]:draw({name=name, node=self.node, updateDimensions=false})
      self.node:setName("Billboard_"..name.."_"..self.index)
      
      self.node:getGeometry():setDimensions(self.node, dimensions)
      self.node:setOrigin(origin)
      self.node:enableTagged(false)
      self:hide()
      
      njlic.World.getInstance():getScene():getRootNode():addChildNode(self.node)
      
      return true
      
    end
  
    function billboard:unload()
      njlic.Node.destroy(self.node)
    end

    function billboard:spawn(...)
      local arg=... or {}
      
      self:show()
      self.node:enableTagged()
      
      self.inplay=true
      print("spawned billboard")
    end

    function billboard:kill(...)
      local arg=... or {}
      
      self.inplay=false
      self.node:enableTagged(false)

      self:hide()
    end
    
    function billboard:hide()
      self.node:hide(self.perspectiveCamera)
    end
    
    function billboard:show()
      self.node:show(self.perspectiveCamera)
    end

    return billboard
  end
}

local YappyBirds = {
  new = function()
    print("YappyBirds.new() - start")
  
    local Params = require "YAPPYBIRDS.Params"
    local SpawnMachine = require "YAPPYBIRDS.SpawnMachine"
    local LevelLoader = require "YAPPYBIRDS.LevelLoader"

    local game = {
      CHUBI = "chubi",
      GARU = "garu",
      MOMI = "momi",
      PUFFY = "puffy",
      WEBO = "webo",
      ZURU = "zuru",
      params = Params,

      levelLoader = LevelLoader({ params = Params }),
      spawnMachine = SpawnMachine(),
      levelTexturePacker = {},
      gameplayTexturePacker = {},
      debugTexturePacker = {},
      shader = nil,
      chubiBirdPool = {},
      garuBirdPool = {},
      momiBirdPool = {},
      puffyBirdPool = {},
      weboBirdPool = {},
      zuruBirdPool = {},
      allBirdPool = {},
      balloonPool = {},
      dogPool = {},
      billboardPool = {},
      
      perspectiveCameraNode = nil,
      perspectiveCamera = nil,
      
      orthographicCameraNode = nil,
      orthographicCamera = nil,
      
      run = false,
      
    }

    function game:load()
      print("game:load() - start")
      
      local debug = false

      self.levelLoader:loadLevel({debug=debug, loc="country", levelNum=0, mode="arcade"})

      local shader = njlic.ShaderProgram.create()
      assert(njlic.World.getInstance():getWorldResourceLoader():load("shaders/StandardShader.vert", "shaders/StandardShader.frag", shader))
      self.shader = shader
      
      -- ###################################################################################################

      table.insert(self.levelTexturePacker, TexturePacker({file=string.format("%s0", self.levelLoader.location)}))
      table.insert(self.gameplayTexturePacker, TexturePacker({file="gameplay0"}))
      table.insert(self.gameplayTexturePacker, TexturePacker({file="gameplay1"}))
      if debug then
        table.insert(self.debugTexturePacker, TexturePacker({file="debug0"}))
      end
      
      -- ###################################################################################################

      
      
      for i = 1, self.levelLoader:numSpawnPoints() do
        local point = self.levelLoader:getSpawnPoint(i)
        self.spawnMachine:addArcadeSpawnPoint(point)
      end
      
      -- ###################################################################################################
      
      local scene = njlic.Scene.create()

      local rootNode = njlic.Node.create()
      rootNode:setOrigin(bullet3.btVector3(0,0,0))
      
      scene:setRootNode(rootNode)
      
      njlic.World.getInstance():setScene(scene)

      -- ###################################################################################################
      
      self.perspectiveCameraNode = njlic.Node.create()
      self.perspectiveCameraNode:setName("perspectiveCamera")

      self.perspectiveCamera = njlic.Camera.create()
      self.perspectiveCamera:enableOrthographic(false)
      self.perspectiveCamera:setRenderCategory(RenderCategories.perspective)
      self.perspectiveCamera:setName("perspectiveCamera")

      self.perspectiveCameraNode:setCamera(self.perspectiveCamera)
      
      rootNode:addChildNode(self.perspectiveCameraNode)
      njlic.World.getInstance():enableDebugDraw(self.perspectiveCamera)
      
      -- ###################################################################################################
      
      local orthographicCameraNode = njlic.Node.create()
      orthographicCameraNode:setName("perspectiveCamera")

      self.orthographicCamera = njlic.Camera.create()
      self.orthographicCamera:enableOrthographic(true)
      self.orthographicCamera:setRenderCategory(RenderCategories.orthographic)
      self.orthographicCamera:setName("perspectiveCamera")

      orthographicCameraNode:setCamera(self.orthographicCamera)
      
      rootNode:addChildNode(orthographicCameraNode)
      
      -- ###################################################################################################
      
      self.physicsWorld = njlic.PhysicsWorld.create()
      self.physicsWorld:setGravity(self.params.World.Gravity)
      
      njlic.World.getInstance():getScene():setPhysicsWorld(self.physicsWorld)

      -- ###################################################################################################
      
      for i = 1, self.levelLoader:numTiles() do
        local billboardParams = self.levelLoader:getBillboardParams(i)

        local billboard = Billboard.new({
            levelTexturePacker=self.levelTexturePacker,
            perspectiveCamera=self.perspectiveCamera, 
            index=i,
            params=self.params,
          })
        
        if billboard:load(billboardParams) then
          table.insert(self.billboardPool, billboard)
        end
        
      end

      local numberOfBirdsEach = 10
      local numberOfDogs = 1
      local numberOfBalloons = 100
      
      local dog = nil
      for i = 1, numberOfDogs do
        dog = Dog.new({
            texturePacker=self.gameplayTexturePacker,
            perspectiveCamera=self.perspectiveCamera,
            index=i,
            params=self.params
            })
        dog:load()
        table.insert(self.dogPool, dog)
      end

      local bird = nil
      for i = 1, numberOfBirdsEach do

        bird = Bird.new({
            texturePacker=self.gameplayTexturePacker,
            perspectiveCamera=self.perspectiveCamera,
            birdName=self.CHUBI, 
            index=i, 
            params=self.params,
            dogs = self.dogPool,
            })
        bird:load()
        table.insert(self.chubiBirdPool, bird)
        table.insert(self.allBirdPool, bird)

        
        bird = Bird.new({
            texturePacker=self.gameplayTexturePacker,
            perspectiveCamera=self.perspectiveCamera,
            birdName=self.GARU, 
            index=i, 
            params=self.params,
            dogs = self.dogPool,
            })
        bird:load()
        table.insert(self.garuBirdPool, bird)
        table.insert(self.allBirdPool, bird)
        
        bird = Bird.new({
            texturePacker=self.gameplayTexturePacker,
            perspectiveCamera=self.perspectiveCamera,
            birdName=self.MOMI, 
            index=i, 
            params=self.params,
            dogs = self.dogPool,
            })
        bird:load()
        table.insert(self.momiBirdPool, bird)
        table.insert(self.allBirdPool, bird)
        
        bird = Bird.new({
            texturePacker=self.gameplayTexturePacker,
            perspectiveCamera=self.perspectiveCamera,
            birdName=self.PUFFY,
            index=i, 
            params=self.params,
            dogs = self.dogPool,
            })
        bird:load()
        table.insert(self.puffyBirdPool, bird)
        table.insert(self.allBirdPool, bird)
        
        bird = Bird.new({
            texturePacker=self.gameplayTexturePacker,
            perspectiveCamera=self.perspectiveCamera,
            birdName=self.WEBO, 
            index=i, 
            params=self.params,
            dogs = self.dogPool,
            })
        bird:load()
        table.insert(self.weboBirdPool, bird)
        table.insert(self.allBirdPool, bird)
        
        bird = Bird.new({
            texturePacker=self.gameplayTexturePacker,
            perspectiveCamera=self.perspectiveCamera,
            birdName=self.ZURU, 
            index=i, 
            params=self.params,
            dogs = self.dogPool,
            })
        bird:load()
        table.insert(self.zuruBirdPool, bird)
        table.insert(self.allBirdPool, bird)
      end
      
      for i = 1, #self.allBirdPool do
        self.allBirdPool[i]:addNeighbors(self.allBirdPool)
      end
      
      
      local balloon = nil
      local colors = {"Blue", "Green", "Purple", "Red", "Yellow"}
      for i = 1, numberOfBalloons do
        
        local color = colors[math.random(5)]

        balloon = Balloon.new({
            texturePacker=self.gameplayTexturePacker,
            perspectiveCamera=self.perspectiveCamera,
            index=i,
            params=self.params
            })
        balloon:load({color=color})
        table.insert(self.balloonPool, balloon)
      end
      
      for i = 1, #self.allBirdPool do
        self.allBirdPool[i]:addBalloonsToEvade(self.balloonPool)
      end
      
      
    
      print("game:load() - end")
    end

    function game:unload()
      print("game:unload() - start")
      
      self.run = false
      
      njlic.PHysicsWorld.destroy(self.physicsWorld)
      
      njlic.Camera.destroy(self.orthographicCamera)
      njlic.Node.destroy(self.orthographicCameraNode)
      
      njlic.Camera.destroy(self.perspectiveCamera)
      njlic.Node.destroy(self.perspectiveCameraNode)
      
      local scene = njlic.World.getInstance():getScene()
      local rootNode = scene:getRootNode()
      njlic.Node.destroy(rootNode)
      njlic.Scene.destroy(njlic.World.getInstance():getScene())
      
      for i = 1, #self.levelTexturePacker do
        self.levelTexturePacker[i]:_destroy()
      end
      self.levelTexturePacker = {}
      
      for i = 1, #self.gameplayTexturePacker do
        self.gameplayTexturePacker[i]:_destroy()
      end
      self.gameplayTexturePacker = {}
      
      for i = 1, #self.debugTexturePacker do
        self.debugTexturePacker[i]:_destroy()
      end
      self.debugTexturePacker = {}
      
      njlic.ShaderProgram.destroy(self.shader)
      
      for i = 1, #self.chubiBirdPool do
        local bird = self.chubiBirdPool[i]
        bird:unload()
      end
      self.chubiBirdPool = {}

      for i = 1, #self.garuBirdPool do
        local bird = self.garuBirdPool[i]
        bird:unload()
      end
      self.garuBirdPool = {}

      for i = 1, #self.momiBirdPool do
        local bird = self.momiBirdPool[i]
        bird:unload()
      end
      self.momiBirdPool = {}

      for i = 1, #self.puffyBirdPool do
        local bird = self.puffyBirdPool[i]
        bird:unload()
      end
      self.puffyBirdPool = {}

      for i = 1, #self.weboBirdPool do
        local bird = self.weboBirdPool[i]
        bird:unload()
      end
      self.weboBirdPool = {}

      for i = 1, #self.zuruBirdPool do
        local bird = self.zuruBirdPool[i]
        bird:unload()
      end
      self.zuruBirdPool = {}
      
      self.allBirdPool = {}

      for i = 1, #self.dogPool do
        local dog = self.dogPool[i]
        dog:unload()
      end
      self.dogPool = {}

      for i = 1, #self.balloonPool do
        local balloon = self.balloonPool[i]
        balloon:unload()
      end
      self.balloonPool = {}
    
      print("game:unload() - end")
    end

    function game:update(timeStep)
      
      if self.run then
        
        self.spawnMachine:tick(self, timeStep)

        if self.spawnMachine.done then
  --        print("spawn machine is finished")
        end
      end
      
      if not self.run then
        self:start()
      end
    end
    
    function game:updateAction(action, timeStep)
      local node = action:getParent()
      
      local gameEntity = self.spawnMachine:gameEntity(node:getName())
      
      if gameEntity then
        local animationClock = gameEntity.animationClock
        if (animationClock:getTimeMilliseconds() / 1000) > (1.0 / gameEntity.fps) then
          animationClock:reset()
          gameEntity:incrementAnimationFrame()
        end
        
      end
    end

    function game:click(x, y)
--      print("game:click("..x..","..y..")")

      if self.run then
        
        local origin = self.params:originForLayer({x=x, y=y}, 10)
--        print("originForLayer")
--        print(origin)
--        origin = self.levelLoader:getDogWayPointParams(1).origin
--        print("origin for index 1 ")
--        print(origin)
        
        local dimensions = self.params:dimensionForLayer()
--        print("dimensions)
--        print(dimensions)

        local queued = self.spawnMachine:queueBalloon({
            origin = origin,
            dimensions = dimensions,
            direction = self.perspectiveCamera:getForwardVector(),
          })
        if not queued then
          print("couldn't queue the balloon")
        end
        
      end
      
    end

    function game:pause()
    end
  
    function game:unpause()
    end
  
    function game:start()
      if not self.run then
        
        self.spawnMachine.gameplay = self
        
        for i = 1, #self.billboardPool do
          local billboard = self.billboardPool[i]
          billboard:spawn()
        end
        
        njlic.World.getInstance():setBackgroundColor(self.levelLoader.backgroundColor)
        
        local numDogsInLevel = 1
        
        local numWayPoints = self.levelLoader:numDogWayPoints()
        assert(numWayPoints > 0, "There are no way points")
        
        for i=1, numDogsInLevel do
          
          local index = math.random(numWayPoints)
          local wayPoint = self.levelLoader:getDogWayPointParams(1)
          
          local path = self.levelLoader:createWaypointPath()
          
          assert(path, "The path is nil")
          
          local queued = self.spawnMachine:queueDog({
              path=path,
              dimensions = wayPoint.dimensions,
            })
          if not queued then
            print("couldn't queue the dog")
          else
            print("queued the dog")
          end
        end
        
        self.run = true
      end
    end

    function game:_availableBird(...)
      local arg=... or {}

      local origin = arg.origin or nil
      local dimensions = arg.dimensions or nil
      local debug = arg.debug or true
      
      assert(origin, "origin is nil")
      assert(dimensions, "dimensions is nil")

      if arg.name == self.CHUBI then
        for i, v in ipairs(self.chubiBirdPool) do
          if not v.inplay then
            v:setup({
              origin=origin,
              dimensions=dimensions,
              debug=debug
              })
            return v 
          end
        end
      elseif arg.name == self.GARU then
        for i, v in ipairs(self.garuBirdPool) do
          if not v.inplay then
            v:setup({
              origin=origin,
              dimensions=dimensions,
              debug=debug
              })
            return v 
          end
        end
      elseif arg.name == self.MOMI then
        for i, v in ipairs(self.momiBirdPool) do
          if not v.inplay then
            v:setup({
              origin=origin,
              dimensions=dimensions,
              debug=debug
              })
            return v 
          end
        end
      elseif arg.name == self.PUFFY then
        for i, v in ipairs(self.puffyBirdPool) do
          if not v.inplay then
            v:setup({
              origin=origin,
              dimensions=dimensions,
              debug=debug
              })
            return v 
          end
        end
      elseif arg.name == self.WEBO then
        for i, v in ipairs(self.weboBirdPool) do
          if not v.inplay then
            v:setup({
              origin=origin,
              dimensions=dimensions,
              debug=debug
              })
            return v 
          end
        end
      elseif arg.name == self.ZURU then
        for i, v in ipairs(self.zuruBirdPool) do
          if not v.inplay then
            v:setup({
              origin=origin,
              dimensions=dimensions,
              debug=debug
              })
            return v 
          end
        end
      end

      return nil
    end

    function game:_availableBalloon(...)
      local arg=... or {}
      
      local origin = arg.origin or bullet.btVector3(0.0, 0.0, 0.0)
      local dimensions = arg.dimensions or bullet.btVector2(256.0, 256.0) 
      local direction = arg.direction or bullet.btVector3(0.0, 1.0, 0.0)
      local debug = arg.debug or true
      
      for i, v in ipairs(self.balloonPool) do
        if not v.inplay then
          v:setup({
              origin=origin,
              dimensions=dimensions,
              direction=direction,
              debug=false
              })
          return v 
        end
      end

      return nil
    end

    function game:_availableDog(...)
      local arg=... or {}

--      local origin = arg.origin or bullet.btVector3(0.0, 0.0, 0.0)
      local dimensions = arg.dimensions or bullet.btVector2(256.0, 256.0)
      local path = arg.path or nil
      local debug = arg.debug or false
      
      for i, v in ipairs(self.dogPool) do
        if not v.inplay then
          v:setup({
              path=path,
--              origin=origin,
              dimensions=dimensions,
              debug=debug
              })
          return v 
        end
      end

      return nil
    end

    return game
  end
}

njlic.World.getInstance():setBackgroundColor(1.000, 0.000, 1.000)

local Create = function()
  yappyBirds = YappyBirds.new()
  yappyBirds:load()
end

local Destroy = function()
  yappyBirds:unload()
  yappyBirds = nil
end

local Update = function(timeStep)
  yappyBirds:update(timeStep)
end

local Render = function()
  -- print("Render")
end

local Resize = function(width, height, orientation)
  print("Resize", width, height, orientation)
end

local TouchesDown = function(touches)
  print("TouchesDown")
end

local TouchesUp = function(touches)
  print("TouchesUp")
end

local TouchesMove = function(touches)
  print("TouchesMove")
end

local TouchesCancelled = function(touches)
  print("TouchesCancelled")
end

local TouchDown = function(touch)
  print("TouchDown")
end

local TouchUp = function(touch)
  print("TouchUp")
end

local TouchMove = function(touch)
  print("TouchMove")
end

local TouchCancelled = function(touches)
  print("TouchCancelled")
end

local MouseDown = function(mouse)
--  print("MouseDown")
  yappyBirds:click(mouse:getPosition():x(), mouse:getPosition():y())
end

local MouseUp = function(mouse)
--  print("MouseUp")
end

local MouseMove = function(mouse)
--  print("MouseMove")
end

local KeyDown = function(keycodeName, withCapsLock, withControl, withShift, withAlt, withGui)
  print("KeyDown", keycodeName, withCapsLock, withControl, withShift, withAlt, withGui)
end

local KeyUp = function(keycodeName, withCapsLock, withControl, withShift, withAlt, withGui)
  print("KeyUp", keycodeName, withCapsLock, withControl, withShift, withAlt, withGui)
end

local NodeCollide = function(node, otherNode, collisionPoint)
  print("NodeCollide")
end

local NodeNear = function(node, otherNode)
  print("NodeNear")
end

local NodeActionUpdate = function(action, timeStep)
  
  yappyBirds:updateAction(action, timeStep)
  
  
end

local NodeActionComplete = function(action)
  print("NodeActionComplete")
end

local NodeRayTouchesDown = function(rayContact)
  print("NodeRayTouchesDown")
end

local NodeRayTouchesUp = function(rayContact)
  print("NodeRayTouchesUp")
end

local NodeRayTouchesMove = function(rayContact)
  print("NodeRayTouchesMove")
end

local NodeRayTouchesCancelled = function(rayContact)
  print("NodeRayTouchesCancelled")
end

local NodeRayTouchesMissed = function(node)
  print("NodeRayTouchesMissed")
end

local NodeRayTouchDown = function(rayContact)
  print("NodeRayTouchDown")
end

local NodeRayTouchUp = function(rayContact)
  print("NodeRayTouchUp")
end

local NodeRayTouchMove = function(rayContact)
  print("NodeRayTouchMove")
end

local NodeRayTouchCancelled = function(rayContact)
  print("NodeRayTouchCancelled")
end

local NodeRayMouseDown = function(rayContact)
  print("NodeRayMouseDown")
end

local NodeRayMouseUp = function(rayContact)
  print("NodeRayMouseUp")
end

local NodeRayMouseMove = function(rayContact)
  print("NodeRayMouseMove")
end
 
local NodeRayTouchMissed = function(node)
  print("NodeRayTouchMissed")
end

local NodeRayMouseMissed = function(node)
  print("NodeRayMouseMissed")
end

RegisterCreate("Create",                                         function() pcall(Create) end)
RegisterDestroy("Destroy",                                       function() pcall(Destroy) end )
done = nil
RegisterUpdate("Update",
  function(timeStep)
    
    if njlic.World.usingZeroBrane then
      if done == nil then done = false return end
      if not done then

        require("mobdebug").on()
        require("mobdebug").start()
 
        pcall(Destroy)
        collectgarbage();
        pcall(Create)

        done = true
      end
    end
   
    pcall(Update, timeStep)
  end
)
RegisterRender("Render",                                         function() pcall(Render) end )
RegisterResize("Resize",                                         function(width, height, orientation) pcall(Resize, width, height, orientation) end )
RegisterTouchesDown("TouchesDown",                               function(touches) pcall(TouchesDown, touches) end )
RegisterTouchesUp("TouchesUp",                                   function(touches) pcall(TouchesUp, touches) end )
RegisterTouchesMove("TouchesMove",                               function(touches) pcall(TouchesMove, touches) end )
RegisterTouchesCancelled("TouchesCancelled",                     function(touches) pcall(TouchesCancelled, touches) end )
RegisterTouchDown("TouchDown",                                   function(touch) pcall(TouchDown, touch) end )
RegisterTouchUp("TouchUp",                                       function(touch) pcall(TouchUp, touch) end )
RegisterTouchMove("TouchMove",                                   function(touch) pcall(TouchMove, touch) end )
RegisterTouchCancelled("TouchCancelled",                         function(touch) pcall(TouchCancelled, touch) end )
RegisterMouseDown("MouseDown",                                   function(mouse) pcall(MouseDown, mouse) end )
RegisterMouseUp("MouseUp",                                       function(mouse) pcall(MouseUp, mouse) end )
RegisterMouseMove("MouseMove",                                   function(mouse) pcall(MouseMove, mouse) end )
RegisterKeyDown("KeyDown",                                       function(keycodeName, withCapsLock, withControl, withShift, withAlt, withGui) pcall(KeyDown, keycodeName, withCapsLock, withControl, withShift, withAlt, withGui) end )
RegisterKeyUp("KeyUp",                                         function(keycodeName, withCapsLock, withControl, withShift, withAlt, withGui) pcall(KeyUp, keycodeName, withCapsLock, withControl, withShift, withAlt, withGui) end )



RegisterNodeCollide("NodeCollide",                               function(node, otherNode, collisionPoint) pcall(NodeCollide, node, otherNode, collisionPoint) end )
RegisterNodeNear("NodeNear",                                     function(node, otherNode) pcall(NodeNear, node, otherNode) end )
RegisterNodeActionUpdate("NodeActionUpdate",                     function(action, timeStep) pcall(NodeActionUpdate, action, timeStep) end )
RegisterNodeActionComplete("NodeActionComplete",                 function(action, timeStep) pcall(NodeActionComplete, action, timeStep) end )
RegisterNodeRayTouchesDown("NodeRayTouchesDown",                 function(rayContact) pcall(NodeRayTouchesDown, rayContact) end )
RegisterNodeRayTouchesUp("NodeRayTouchesUp",                     function(rayContact) pcall(NodeRayTouchesUp, rayContact) end )
RegisterNodeRayTouchesMove("NodeRayTouchesMove",                 function(rayContact) pcall(NodeRayTouchesMove, rayContact) end )
RegisterNodeRayTouchesCancelled("NodeRayTouchesCancelled",       function(rayContact) pcall(NodeRayTouchesCancelled, rayContact) end )
RegisterNodeRayTouchesMissed("NodeRayTouchesMissed",             function(node) pcall(NodeRayTouchesMissed, node) end )
RegisterNodeRayTouchDown("NodeRayTouchDown",                     function(rayContact) pcall(NodeRayTouchDown, rayContact) end )
RegisterNodeRayTouchUp("NodeRayTouchUp",                         function(rayContact) pcall(NodeRayTouchUp, rayContact) end )
RegisterNodeRayTouchMove("NodeRayTouchMove",                     function(rayContact) pcall(NodeRayTouchMove, rayContact) end )
RegisterNodeRayTouchCancelled("NodeRayTouchCancelled",           function(rayContact) pcall(NodeRayTouchCancelled, rayContact) end )
RegisterNodeRayMouseDown("NodeRayMouseDown",                     function(rayContact) pcall(NodeRayMouseDown, rayContact) end )
RegisterNodeRayMouseUp("NodeRayMouseUp",                         function(rayContact) pcall(NodeRayMouseUp, rayContact) end )
RegisterNodeRayMouseMove("NodeRayMouseMove",                     function(rayContact) pcall(NodeRayMouseMove, rayContact) end )
RegisterNodeRayTouchMissed("NodeRayTouchMissed",                 function(node) pcall(NodeRayTouchMissed, node) end )
RegisterNodeRayMouseMissed("NodeRayMouseMissed",                 function(node) pcall(NodeRayMouseMissed, node) end )
