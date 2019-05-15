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

      if self.currentStateName then
          local status, err = pcall(self.states[self.currentStateName].exit)
          if not status then error(err) end
      end

      self.currentStateName = name

      local status, err = pcall(self.states[self.currentStateName].enter)
      if not status then error(err) end
    end

    function sm:update(timeStep)

      if self.currentStateName then
          local status, err = pcall(self.states[self.currentStateName].update, timeStep)
          if not status then error(err) end
      end

    end

    function sm:collide(colliderEntity, collisionPoint)
      if self.currentStateName then
          local status, err = pcall(self.states[self.currentStateName].collide, colliderEntity, collisionPoint)
          if not status then error(err) end
      end
    end

    return sm
  end
}





local Beak = {
  new = function(...)
    local arg=... or {}

    local texturePacker=arg.texturePacker or {}
    local perspectiveCamera=arg.perspectiveCamera or nil
    local index = arg.index or 0
    local params = arg.params or nil
    local birdName = arg.birdName or nil

    assert(texturePacker, "The texturePacker is nil")
    assert(perspectiveCamera, "The perspectiveCamera is nil")
    assert(params, "The params is nil")
    assert(birdName, "The birdName is nil")

    local beak = {
      inplay=false,
      texturePacker=texturePacker,
      perspectiveCamera=perspectiveCamera,
      node = nil,
      action = nil,
      index = index,
      currentFrame = 0,
      animationClock = nil,
      fps=30,
      params = params,
      ANIMATION_STATES={grab="grab",hit="hit",idle="idle"},
      birdName=birdName,
      STATEMACHINE_STATES={grab="grab",hit="hit",idle="idle",yap="yap"},
      currentAnimationState=nil
    }

    function beak:getFrameName()
      local state = self.currentAnimationState
      local birdName = self.birdName

      local name = string.format("character_%sBird_mouth_%s_front/character_%sBird_mouth_%s_front_%05d", birdName, state, birdName, state, self.currentFrame)
      return name
    end

    function beak:load(...)
      local arg=... or {}


      local bird = arg.bird or nil

      assert(bird, "The bird is nil")

      local origin = bullet.btVector3(0.0, 0.0, 0.0)

      self.currentAnimationState=self.ANIMATION_STATES.idle

      local name = self:getFrameName()
      self.node = njlic.Node.create()
      if self.texturePacker[1]:has({name=name}) then
        self.node = self.texturePacker[1]:draw({name=name, node=self.node, updateDimensions=false})
      elseif self.texturePacker[2]:has({name=name}) then
        self.node = self.texturePacker[2]:draw({name=name, node=self.node, updateDimensions=false})
      end

      if self.node then
        self.node:setName(string.format("%sbird_beak_node_%05d", self.birdName, self.index))

        self.node:setOrigin(origin)
        self.node:enableTagged(false)
        self:hide()

        self.action = njlic.Action.create()
        self.action:setRepeatForever()
        self.action:setName(string.format("%sbird_beak_action_%05d", self.birdName, self.index))

        self.animationClock = njlic.Clock.create()

        bird.node:addChildNode(self.node)
----        njlic.World.getInstance():getScene():getRootNode():addChildNode(self.node)

        self.sound = njlic.Sound.create()
        self.sound:setName(string.format("%sbird_beak_sound_%05d", self.birdName, self.index))
        local soundName = "sounds/projectile_balloon_water-splash.ogg"
        njlic.World.getInstance():getWorldResourceLoader():load(soundName, self.sound)

      else
      end

    end

    function beak:unload()

      njlic.Sound.destroy(self.sound)

      njlic.Clock.destroy(self.animationClock)
      njlic.Action.destroy(self.action)
      njlic.Node.destroy(self.node)

    end

    function beak:setup(...)
      local arg=... or {}

      local origin = bullet.btVector3(0.0, 0.0, -0.01)
      local dimensions = arg.dimensions or bullet.btVector2(256.0, 256.0)
      local debug = arg.debug or false
      local spawnMachine = arg.spawnMachine or nil

      self.spawnMachine = spawnMachine

      self.inplay=true

      self.node:setOrigin(origin)
      self.node:getGeometry():setDimensions(self.node, dimensions)


    end

    function beak:spawn(...)
      local arg=... or {}


      self.inplay=true

      self:show()
      self.node:runAction(self.action)
      self.currentAnimationState=self.ANIMATION_STATES.idle
    end

    function beak:kill(...)
      local arg=... or {}


      self.inplay=false

      self.node:removeAction(self.node:getName())

      self:hide()


    end

    function beak:hide()
      self.node:hide(self.perspectiveCamera)
    end

    function beak:show()
      self.node:show(self.perspectiveCamera)
    end

    function beak:incrementAnimationFrame()
      self.currentFrame = self.currentFrame + 1
      if(self.currentFrame > 8) then self.currentFrame = 0 end

      local name = self:getFrameName()
      if self.texturePacker[1]:has({name=name}) then
        self.node = self.texturePacker[1]:draw({name=name, node=self.node, updateDimensions=false})
      elseif self.texturePacker[2]:has({name=name}) then
        self.node = self.texturePacker[2]:draw({name=name, node=self.node, updateDimensions=false})
      end
    end

    function beak:update(timeStep)

    end

    return beak
  end
}

local Bird = {
  new = function(...)
    local arg=... or {}

    local texturePacker=arg.texturePacker or {}
    local perspectiveCamera=arg.perspectiveCamera or nil
    local index = arg.index or 0
    local params = arg.params or nil
    local game = arg.game or nil
    local birdName = arg.birdName or nil
    local dogs = arg.dogs or nil

    assert(texturePacker, "The texturePacker is nil")
    assert(perspectiveCamera, "The perspectiveCamera is nil")
    assert(params, "The params is nil")
    assert(game, "The game is nil")
    assert(birdName, "The birdName is nil")
    assert(dogs, "The dogs is nil")

   local beak = Beak.new({
          texturePacker=texturePacker,
          perspectiveCamera=perspectiveCamera,
          birdName=birdName,
          index=index,
          params=params,
          game=game,
          })

    local bird = {
      inplay=false,
      texturePacker=texturePacker,
      perspectiveCamera=perspectiveCamera,
      node = nil,
      action = nil,
      index = index,
      currentFrame = 0,
      animationClock = nil,
      fps=30,
      params = params,
      game = game,
      ANIMATION_STATES={grab="grab",hit="hit",idle="idle"},
      birdName=birdName,
      dogs=dogs,
      STATEMACHINE_STATES={fly="fly",grabbed="grabbed",grabbing="grabbing",hit="hit",pursue="pursue",spawn="spawn", release="release"},
      stateMachine = nil,
      beak = beak,
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


      local origin = bullet.btVector3(0.0, 0.0, 0.0)

      self.currentAnimationState=self.ANIMATION_STATES.idle

      local name = self:getFrameName()
      self.node = njlic.Node.create()
      if self.texturePacker[1]:has({name=name}) then
        self.node = self.texturePacker[1]:draw({name=name, node=self.node, updateDimensions=false})
      elseif self.texturePacker[2]:has({name=name}) then
        self.node = self.texturePacker[2]:draw({name=name, node=self.node, updateDimensions=false})
      end

      if self.node then

        assert(self.beak, "The beak is nil")

        self.beak:load({bird=self})

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
        self.physicsBody:setAngularFactor(bullet.btVector3(0,0,0))

        self.physicsBody:setName(string.format("%sbird_physicsbody_%05d", self.birdName, self.index))
        self.physicsBody:enableHandleCollideCallback()
        assert(self.physicsBody, "physicsBody is null")

        self.physicsShape = njlic.PhysicsShapeSphere.create()
        self.physicsShape:setRadius(5)

        assert(self.physicsShape, "physicsShape is null")

        self.physicsShape:setMargin(1)
        self.physicsBody:setPhysicsShape(self.physicsShape)
        self.physicsBody:setKinematicPhysics()

        self.sound = njlic.Sound.create()
        self.sound:setName(string.format("%sbird_sound_%05d", self.birdName, self.index))
        local soundName = "sounds/projectile_balloon_water-splash.ogg"
        njlic.World.getInstance():getWorldResourceLoader():load(soundName, self.sound)


        self.steeringBehaviourMachine = njlic.SteeringBehaviorMachineDithered.create()
        self.steeringBehaviourMachine:setMaxSpeed(self.params.Bird[self.birdName].MaxSpeed)
        self.steeringBehaviourMachine:setMaxForce(self.params.Bird[self.birdName].MaxForce)

        self.steeringBehaviorOffsetPursuit = njlic.SteeringBehaviorOffsetPursuit.create()
        self.steeringBehaviorOffsetPursuit:setOffsetPosition(bullet.btVector3(0,20,0))
        self.steeringBehaviorOffsetPursuit:setWeight(1.0)
        self.steeringBehaviorOffsetPursuit:setProbability(0.5)

        self.steeringBehaviorSeparation = njlic.SteeringBehaviorSeparation.create()
        self.steeringBehaviorSeparation:setWeight(60.0)
        self.steeringBehaviorSeparation:setProbability(0.5)

        self.steeringBehaviorEvade = njlic.SteeringBehaviorEvade.create()
        self.steeringBehaviorEvade:setWeight(600.0)
        self.steeringBehaviorEvade:setProbability(1.0)

        self.steeringBehaviorPursuit = njlic.SteeringBehaviorPursuit.create()
        self.steeringBehaviorPursuit:setWeight(1.0)
        self.steeringBehaviorPursuit:setProbability(1.0)


        self.node:setSteeringBehaviorMachine(self.steeringBehaviourMachine)

        self.yapTimer = njlic.Timer.create()


      else
      end

      local stateMachine = StateMachine.new(self)

      -- Bird Fly --------------------------------------------------------------------------

      stateMachine:addState(self.STATEMACHINE_STATES.fly, {
          enter = function()
                self.pursueTimer = njlic.Timer.create()
                self.steeringBehaviourMachine:enable()
              self.currentAnimationState=self.ANIMATION_STATES.idle
                self.steeringBehaviourMachine:addSteeringBehavior(self.steeringBehaviorOffsetPursuit)
                self.steeringBehaviourMachine:addSteeringBehavior(self.steeringBehaviorSeparation)

                self.pursueTimer:start(self.params.Bird[self.birdName].PursueTime)
          end,
          exit = function()
                njlic.Timer.destroy(self.pursueTimer)
                self.steeringBehaviourMachine:removeSteeringBehavior(self.steeringBehaviorOffsetPursuit)
                self.steeringBehaviourMachine:removeSteeringBehavior(self.steeringBehaviorSeparation)
            end,
          update = function(timeStep)

              if self.pursueTimer:isFinished() then
                  if self.game.canPursue then
                      self.stateMachine:switchStates(self.STATEMACHINE_STATES.pursue)
                  else
                      self.pursueTimer:start(self.params.Bird[self.birdName].PursueTime)
                  end
              end

              self.pursueTimer:tick()
          end,
          collide = function(colliderEntity, collisionPoint)
              if(colliderEntity.node:getPhysicsBody():getCollisionGroup() == CollisionGroups.projectile) then
                  self.stateMachine:switchStates(self.STATEMACHINE_STATES.hit)
              end
          end,
        })

      -- Bird Grabbed --------------------------------------------------------------------------
      
      stateMachine:addState(self.STATEMACHINE_STATES.grabbed, {
          enter = function()
              self.currentAnimationState=self.ANIMATION_STATES.grab
              self.beak:hide()
              self.physicsBody:setDynamicPhysics()
              self.steeringBehaviourMachine:enable(false)
                        end,
          exit = function()
              self.beak:show()
              self.steeringBehaviourMachine:enable(true)

          end,
          update = function(timeStep)
              if self.node:getOrigin():y() > 6 then

                  assert(self.dogAttacked ~= nil, "the dog being attacked is nil")

                  self.stateMachine:switchStates(self.STATEMACHINE_STATES.release)
                  self.dogAttacked.stateMachine:switchStates(self.dogAttacked.STATEMACHINE_STATES.released)
                  return

              end

              local y_force = 0

              if self.currentFrame == 1 then
              elseif self.currentFrame == 2 then
              elseif self.currentFrame == 3 then
              elseif self.currentFrame == 4 then
              elseif self.currentFrame == 5 then
              elseif self.currentFrame == 6 then
              elseif self.currentFrame == 7 then
                  y_force = self.params.Bird[self.birdName].StealSpeed
              elseif self.currentFrame == 8 then
              end

            self.physicsBody:applyForce(bullet3.btVector3(0,y_force,0), true)
          end,
          collide = function(colliderEntity, collisionPoint)
              if(colliderEntity.node:getPhysicsBody():getCollisionGroup() == CollisionGroups.projectile) then
                  self.stateMachine:switchStates(self.STATEMACHINE_STATES.release)
                  self.dogAttacked.stateMachine:switchStates(self.dogAttacked.STATEMACHINE_STATES.released)
                  -- self.stateMachine:switchStates(self.STATEMACHINE_STATES.release)
              end
          end,
        })

      -- Bird Grabbing --------------------------------------------------------------------------
      
      stateMachine:addState(self.STATEMACHINE_STATES.grabbing, {
          enter = function()
              self.currentAnimationState=self.ANIMATION_STATES.grab
              self.beak:hide()

              assert(self.dogAttacked ~= nil, "the dog being attacked is nil")

              self.steeringBehaviourMachine:clearSteering()
              self.steeringBehaviourMachine:enable(false)
              self.physicsBody:setKinematicPhysics()

              self.dogAttacked.birdAttacking = self
              self.dogAttacked.stateMachine:switchStates(self.dogAttacked.STATEMACHINE_STATES.caught)
          end,
          exit = function()
              self.beak:show()
          end,
          update = function(timeStep)
              self.stateMachine:switchStates(self.STATEMACHINE_STATES.grabbed)
          end,
          collide = function(colliderEntity, collisionPoint)
              if(colliderEntity.node:getPhysicsBody():getCollisionGroup() == CollisionGroups.projectile) then
                  self.stateMachine:switchStates(self.STATEMACHINE_STATES.hit)
              end
          end,
        })

      -- Bird Hit --------------------------------------------------------------------------
      
      stateMachine:addState(self.STATEMACHINE_STATES.hit, {
          enter = function()
            self.game.canPursue = true
              self.currentAnimationState=self.ANIMATION_STATES.hit
                self.steeringBehaviourMachine:clearSteering()
                self.steeringBehaviourMachine:enable(false)
                self.physicsBody:setDynamicPhysics()
                self.physicsBody:setMass(1000)
                -- self.physicsBody:applyForce(bullet.btVector3(0,1000,0), false)
          end,
          exit = function()
          end,
          update = function(timeStep)
              local origin = self.node:getOrigin()

              local die = self.params.Projectile.WaterBalloon.DieY
              if self.node:getOrigin():y() < die then
                -- self:kill()
                self.spawnMachine:dispose(self)
              end
          end,
          collide = function(colliderEntity, collisionPoint)
              if(colliderEntity.node:getPhysicsBody():getCollisionGroup() == CollisionGroups.projectile) then
              end
          end,
        })

      -- Bird Pursue --------------------------------------------------------------------------
      
        stateMachine:addState(self.STATEMACHINE_STATES.pursue, {
            enter = function()
                self.pursueTimer = njlic.Timer.create()

                self.game.canPursue = false
                self.currentAnimationState=self.ANIMATION_STATES.idle
                self.offsetPosition = self.steeringBehaviorOffsetPursuit:getOffsetPosition()
                self.steeringBehaviorOffsetPursuit:setOffsetPosition(bullet.btVector3(0,6,-2))
                self.steeringBehaviourMachine:addSteeringBehavior(self.steeringBehaviorOffsetPursuit)

                self.collided = false
                self.dogAttacked = nil
          end,
          exit = function()
              njlic.Timer.destroy(self.pursueTimer)

                self.steeringBehaviorOffsetPursuit:setOffsetPosition(self.offsetPosition)
                -- self.steeringBehaviorOffsetPursuit:setOffsetPosition(bullet.btVector3(0,20,0))
                self.steeringBehaviourMachine:removeSteeringBehavior(self.steeringBehaviorOffsetPursuit)
                self.game.canPursue = false
          end,
          update = function(timeStep)

              if self.dogAttacked then
                  self.pursueTimer:tick()

                  if self.pursueTimer:isFinished() then
                      self.stateMachine:switchStates(self.STATEMACHINE_STATES.grabbing)
                      return
                  end

                  -- if not self.collided then
                  --     self.collided = true
                  --     self.pursueTimer:start(self.params.Bird[self.birdName].PursueTime)
                  -- else
                  --     if self.pursueTimer:isFinished() then
                  --         self.stateMachine:switchStates(self.STATEMACHINE_STATES.grabbing)
                  --         return
                  --     end
                  -- end
              else
                  self.pursueTimer:start(self.params.Bird[self.birdName].PursueTime)
                  self.pursueTimer:enablePause()
              end

              self.dogAttacked = nil

          end,
          collide = function(colliderEntity, collisionPoint)
              if(colliderEntity.node:getPhysicsBody():getCollisionGroup() == CollisionGroups.dog) then
                  self.dogAttacked = colliderEntity
                  self.pursueTimer:enablePause(false)
              end
              if(colliderEntity.node:getPhysicsBody():getCollisionGroup() == CollisionGroups.projectile) then
                  self.stateMachine:switchStates(self.STATEMACHINE_STATES.hit)
              end
          end,
        })

      -- Bird Spawn --------------------------------------------------------------------------
      
      stateMachine:addState(self.STATEMACHINE_STATES.spawn, {
          enter = function()
              self.currentAnimationState=self.ANIMATION_STATES.idle
          end,
          exit = function()
        end,
          update = function(timeStep)
              self.stateMachine:switchStates(self.STATEMACHINE_STATES.fly)
            end,
          collide = function(colliderEntity, collisionPoint)
              if(colliderEntity.node:getPhysicsBody():getCollisionGroup() == CollisionGroups.projectile) then
              end
          end,
        })

      -- Bird Release --------------------------------------------------------------------------
      
      stateMachine:addState(self.STATEMACHINE_STATES.release, {
          enter = function()
              self.currentAnimationState=self.ANIMATION_STATES.hit
              self.physicsBody:setKinematicPhysics()
                self.stunTimer = njlic.Timer.create()

                self.stunTimer:start(self.params.Bird[self.birdName].StunTime)
            self.game.canPursue = true
          end,
          exit = function()
            njlic.Timer.destroy(self.stunTimer)
        end,
          update = function(timeStep)
              if self.stunTimer:isFinished() then
                  self.stateMachine:switchStates(self.STATEMACHINE_STATES.fly)
              end

              self.stunTimer:tick()
            end,
          collide = function(colliderEntity, collisionPoint)
              if(colliderEntity.node:getPhysicsBody():getCollisionGroup() == CollisionGroups.projectile) then
              end
          end,
        })

      self.stateMachine = stateMachine

    end

    function bird:unload()

      self.beak:unload()

      self.stateMachine = nil

      njlic.SteeringBehaviorPursuit.destroy(self.steeringBehaviorPursuit)
      njlic.SteeringBehaviorEvade.destroy(self.steeringBehaviorEvade)
      njlic.SteeringBehaviorOffsetPursuit.destroy(self.steeringBehaviorOffsetPursuit)
      njlic.SteeringBehaviorMachineDithered.destroy(self.steeringBehaviourMachine)

      njlic.Sound.destroy(self.sound)

      njlic.PhysicsBodyRigid.destroy(self.physicsBody)
      njlic.PhysicsShapeSphere.destroy(self.physicsShape)

      njlic.Clock.destroy(self.animationClock)
      njlic.Action.destroy(self.action)
      njlic.Node.destroy(self.node)

        njlic.Timer.destroy(self.yapTimer)
    end

    function bird:setup(...)
      local arg=... or {}

      local origin = arg.origin or bullet.btVector3(0.0, 0.0, 0.0)
      local dimensions = arg.dimensions or bullet.btVector2(256.0, 256.0)
      local debug = arg.debug or false
      local spawnMachine = arg.spawnMachine or nil

      self.spawnMachine = spawnMachine

      self.inplay=true

      self.node:setOrigin(origin)
      self.node:getGeometry():setDimensions(self.node, dimensions)

      self.beak:setup(arg)


    end

    function bird:spawn(...)
      local arg=... or {}


      self.inplay=true

      self:show()
      self.node:runAction(self.action)
      self.node:setPhysicsBody(self.physicsBody)
      self.node:enableTagged()

      self.steeringBehaviourMachine:enable()

      self.stateMachine:switchStates(self.STATEMACHINE_STATES.spawn)

    self.physicsBody:setCollisionGroup(CollisionGroups.bird)
    self.physicsBody:setCollisionMask(CollisionMasks.bird)
    self.physicsBody:setKinematicPhysics()
    self.physicsBody:setMass(1)

      self.beak:spawn(arg)
    end

    function bird:kill(...)
      local arg=... or {}

      self.beak:kill(arg)

      if self.inplay then
            self.spawnMachine:decreaseSpawnLeft()
        end
      self.inplay=false

      self.steeringBehaviourMachine:enable(false)

      self.node:removeAction(self.node:getName())

    self.physicsBody:setCollisionGroup(CollisionGroups.none)
    self.physicsBody:setCollisionMask(CollisionMasks.none)
      self.node:removePhysicsBody()
      self.node:enableTagged(false)
      self:hide()



      -- put back to hiding values
    end

    function bird:hide()
      self.node:hide(self.perspectiveCamera)

      self.beak:hide()
    end

    function bird:show()
      self.node:show(self.perspectiveCamera)

      self.beak:show()
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

      self.beak:incrementAnimationFrame()
    end

    function bird:collide(colliderEntity, collisionPoint)
      self.stateMachine:collide(colliderEntity, collisionPoint)
    end

    function bird:update(timeStep)

      for i = 1, #self.dogs do
        local dogEntity = self.dogs[i]

        if dogEntity.inplay then
          self.steeringBehaviorPursuit:addTarget(dogEntity.node)
          self.steeringBehaviorOffsetPursuit:addTarget(dogEntity.node)
        else
          self.steeringBehaviorOffsetPursuit:removeTarget(dogEntity.node)
          self.steeringBehaviorPursuit:removeTarget(dogEntity.node)
        end
      end

      self.stateMachine:update(timeStep)

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
    local game = arg.game or nil

    assert(texturePacker, "The texturePacker is nil")
    assert(perspectiveCamera, "The perspectiveCamera is nil")
    assert(params, "The params is nil")
    assert(game, "The game is nil")

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
      params = params,
      game = game,
      ANIMATION_STATES={spawn="thrown"},
      STATEMACHINE_STATES={hit="hit",lob="lob",spawn="spawn"},
      stateMachine=nil,
      currentAnimationState=nil,
    }

    function balloon:getFrameName()
      local name = string.format("projectile_waterBalloon%s_%s_front/projectile_waterBalloon%s_%s_front_%05d", self.color, self.currentAnimationState, self.color, self.currentAnimationState, self.currentFrame)
      return name
    end

    function balloon:load(...)
      local arg=... or {}


      self.color = arg.color or "?"

      local origin = bullet.btVector3(0.0, 0.0, 0.0)

      self.currentAnimationState=self.ANIMATION_STATES.spawn

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
        self.physicsBody:setCollisionGroup(CollisionGroups.projectile)
        self.physicsBody:setCollisionMask(CollisionMasks.projectile)
        self.physicsBody:setAngularFactor(bullet.btVector3(0,0,0))

      self.physicsBody:setName("balloon_physicsbody_"..self.index)
        self.physicsBody:enableHandleCollideCallback()
      assert(self.physicsBody, "physicsBody is null")

      self.physicsShape = njlic.PhysicsShapeSphere.create()
      self.physicsShape:setRadius(5)
      assert(self.physicsShape, "physicsShape is null")

      self.physicsShape:setMargin(1)
      self.physicsBody:setPhysicsShape(self.physicsShape)
      self.physicsBody:setDynamicPhysics()

      self.sound = njlic.Sound.create()
      self.sound:setName("balloonsound_"..self.index)
      local soundName = "sounds/projectile_balloon_water-splash.ogg"
      njlic.World.getInstance():getWorldResourceLoader():load(soundName, self.sound)

      local stateMachine = StateMachine.new(self)

      -- STATEMACHINE_STATES={hit="hit",lob="lob",spawn="spawn"},
      stateMachine:addState(self.STATEMACHINE_STATES.hit, {
          enter = function()
              self.currentAnimationState=self.ANIMATION_STATES.spawn
          end,
          exit = function()
          end,
          update = function(timeStep)
              self.spawnMachine:dispose(self)
          end,
          collide = function(colliderEntity, collisionPoint)
          end,
        })
      stateMachine:addState(self.STATEMACHINE_STATES.lob, {
          enter = function()
              self.currentAnimationState=self.ANIMATION_STATES.spawn


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
          end,
          exit = function()
          end,
          update = function(timeStep)
          end,
          collide = function(colliderEntity, collisionPoint)
              if(colliderEntity.node:getPhysicsBody():getCollisionGroup() == CollisionGroups.bird) then
                  self.stateMachine:switchStates(self.STATEMACHINE_STATES.hit)
              end
          end,
        })
      stateMachine:addState(self.STATEMACHINE_STATES.spawn, {
          enter = function()
              self.currentAnimationState=self.ANIMATION_STATES.spawn

              local min = self.params.Projectile.WaterBalloon.ScaleMin
              local max = self.params.Projectile.WaterBalloon.ScaleMax
              local function randomFloat(lower, greater)
                  return lower + math.random()  * (greater - lower);
              end
              local scale = randomFloat(min, max)
              self.node:setScale(scale)





          end,
          exit = function()
          end,
          update = function(timeStep)
              self.stateMachine:switchStates(self.STATEMACHINE_STATES.lob)
          end,
          collide = function(colliderEntity, collisionPoint)
          end,
        })
      self.stateMachine = stateMachine

    end

    function balloon:unload()
      njlic.Sound.destroy(self.sound)

      njlic.PhysicsBodyRigid.destroy(self.physicsBody)
      njlic.PhysicsShapeSphere.destroy(self.physicsShape)

      njlic.Clock.destroy(self.animationClock)
      njlic.Action.destroy(self.action)
      njlic.Node.destroy(self.node)

    end

    function balloon:setup(...)
      local arg=... or {}

      local origin = arg.origin or bullet.btVector3(0.0, 0.0, 0.0)
      local dimensions = arg.dimensions or bullet.btVector2(256.0, 256.0)
      local direction = arg.direction or bullet.btVector3(0.0, 1.0, 0.0)
      local debug = arg.debug or false
      local spawnMachine = arg.spawnMachine or nil

      self.spawnMachine = spawnMachine

      self.inplay=true

      self.node:setOrigin(origin)
      self.node:getGeometry():setDimensions(self.node, dimensions)
      self.direction = direction


    end

    function balloon:spawn(...)
      local arg=... or {}


      self.inplay=true

      self:show()
      self.node:enableTagged()
      self.node:runAction(self.action)
      self.node:setPhysicsBody(self.physicsBody)

      self.stateMachine:switchStates(self.STATEMACHINE_STATES.spawn)
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

    function balloon:collide(colliderEntity, collisionPoint)
      self.stateMachine:collide(colliderEntity, collisionPoint)
    end

    function balloon:update(timeStep)
      local origin = self.node:getOrigin()

      local die = self.params.Projectile.WaterBalloon.DieY
      if self.node:getOrigin():y() < die then
        -- self:kill()
        self.spawnMachine:dispose(self)
      end

      self.stateMachine:update(timeStep)
    end

    return balloon
  end
}

local Dog = {
  new = function(...)
    local arg=... or {}

    local texturePacker=arg.texturePacker or {}
    local perspectiveCamera=arg.perspectiveCamera or nil
    local index = arg.index or 0
    local params = arg.params or nil
    local game = arg.game or nil

    assert(texturePacker, "The texturePacker is nil")
    assert(perspectiveCamera, "The perspectiveCamera is nil")
    assert(params, "The params is nil")
    assert(game, "The game is nil")

    local dog = {
      inplay=false,
      texturePacker=texturePacker,
      perspectiveCamera=perspectiveCamera,
      node = nil,
      action = nil,
      index = index,
      currentFrame = 0,
      animationClock = nil,
      fps=1.0,
      params = params,
      game=game,
      ANIMATION_STATES={fall="fall",grabbed="grabbed",idle="idle",run="run"},
      left = false,

      STATEMACHINE_STATES={caught="caught",dazed="dazed",land="land",released="released",run="run",spawn="spawn"},
      stateMachine=nil,
      currentAnimationState=nil,
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


      local origin = bullet.btVector3(0.0, 0.0, 0.0)

      self.currentAnimationState=self.ANIMATION_STATES.idle

      local name = self:getFrameName()
      self.node = njlic.Node.create()

      if self.texturePacker[1]:has({name=name}) then
        self.node = self.texturePacker[1]:draw({name=name, node=self.node, updateDimensions=false})
      elseif self.texturePacker[2]:has({name=name}) then
        self.node = self.texturePacker[2]:draw({name=name, node=self.node, updateDimensions=false})
      end


    aabbMin, aabbMax = game.levelLoader:getDogWayPointsAabb()
    self.wayPointAabbMin = aabbMin
    self.wayPointAabbMax = aabbMax

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
        self.physicsBody:setCollisionGroup(CollisionGroups.dog)
        self.physicsBody:setCollisionMask(CollisionMasks.dog)
        self.physicsBody:setAngularFactor(bullet.btVector3(0,0,0))

        self.physicsBody:setName("dog_physicsbody_"..self.index)
        self.physicsBody:enableHandleCollideCallback()

        assert(self.physicsBody, "physicsBody is null")

        self.physicsShape = njlic.PhysicsShapeSphere.create()
        self.physicsShape:setRadius(5)
        assert(self.physicsShape, "physicsShape is null")

        self.physicsShape:setMargin(1)
        self.physicsBody:setPhysicsShape(self.physicsShape)
        self.physicsBody:setKinematicPhysics()

        self.sound = njlic.Sound.create()
        self.sound:setName("dog_sound_"..self.index)
        local soundName = "sounds/projectile_balloon_water-splash.ogg"
        njlic.World.getInstance():getWorldResourceLoader():load(soundName, self.sound)

        self.steeringBehaviourMachine = njlic.SteeringBehaviorMachineWeighted.create()
        self.steeringBehaviourFollowPath = njlic.SteeringBehaviorFollowPath.create()

        self.steeringBehaviourMachine:setMaxSpeed(self.params.Dog.MaxSpeed)
        self.steeringBehaviourMachine:setMaxForce(self.params.Dog.MaxForce)

        self.steeringBehaviorEvade = njlic.SteeringBehaviorEvade.create()
        self.steeringBehaviorEvade:setWeight(600.0)
        self.steeringBehaviorEvade:setProbability(1.0)

        self.node:setSteeringBehaviorMachine(self.steeringBehaviourMachine)

        self.constraint = njlic.PhysicsConstraintPointToPoint.create()


      else
      end

      local stateMachine = StateMachine.new(self)

      stateMachine:addState(self.STATEMACHINE_STATES.caught, {
          enter = function()
              self.currentAnimationState=self.ANIMATION_STATES.grabbed
              assert(self.birdAttacking ~= nil, "bird attacking is nil")


              local birdNode_min, birdNode_max = self.birdAttacking.node:getAabb()
              local dogNode_min, dogNode_max = self.node:getAabb()


                self.steeringBehaviourMachine:enable(false)
                self.physicsBody:setDynamicPhysics()
                self.physicsBody:setLinearFactor(bullet3.btVector3(1,1,0))

              self.constraint:setNodes(self.birdAttacking.node, self.node, bullet3.btVector3(0,birdNode_min:y() + 3,0), bullet3.btVector3(0,dogNode_max:y() - 3,-1))

          end,
          exit = function()
                self.physicsBody:setLinearFactor(bullet3.btVector3(1,1,1))
                self.steeringBehaviourMachine:enable(true)
          end,
          update = function(timeStep)
          end,
          collide = function(colliderEntity, collisionPoint)
              if(colliderEntity.node:getPhysicsBody():getCollisionGroup() == CollisionGroups.projectile) then
                  self.birdAttacking.stateMachine:switchStates(self.birdAttacking.STATEMACHINE_STATES.release)
              end
          end,
        })
      stateMachine:addState(self.STATEMACHINE_STATES.dazed, {
          enter = function()
              self.currentAnimationState=self.ANIMATION_STATES.idle
              self.runClock = njlic.Clock.create()

                self.steeringBehaviourMachine:clearSteering()
                self.steeringBehaviourMachine:enable(false)

          end,
          exit = function()
              njlic.Clock.destroy(self.runClock)
                self.steeringBehaviourMachine:enable(true)
          end,
          update = function(timeStep)
              local dazedTime = self.params.Dog.DazedTime
              if (self.runClock:getTimeMilliseconds() > dazedTime) then
                  self.runClock:reset()
                  self.stateMachine:switchStates(self.STATEMACHINE_STATES.run)
              end
          end,
          collide = function(colliderEntity, collisionPoint)
          end,
        })
      stateMachine:addState(self.STATEMACHINE_STATES.land, {
          enter = function()
              self.currentAnimationState=self.ANIMATION_STATES.idle
              self.physicsBody:setKinematicPhysics()
          end,
          exit = function()
          end,
          update = function(timeStep)
                self.stateMachine:switchStates(self.STATEMACHINE_STATES.run)
          end,
          collide = function(colliderEntity, collisionPoint)
          end,
        })
      stateMachine:addState(self.STATEMACHINE_STATES.released, {
          enter = function()
              self.currentAnimationState=self.ANIMATION_STATES.fall
              self.physicsBody:setDynamicPhysics()
              self.constraint:removeConstraint()
              self.steeringBehaviourMachine:enable(false)

          end,
          exit = function()
          end,
          update = function(timeStep)
            if self.node:getOrigin():y() < self.wayPointAabbMin:y() then
                self.stateMachine:switchStates(self.STATEMACHINE_STATES.land)
            end
          end,
          collide = function(colliderEntity, collisionPoint)
          end,
        })
      stateMachine:addState(self.STATEMACHINE_STATES.run, {
          enter = function()
              self.currentAnimationState=self.ANIMATION_STATES.run
              self.steeringBehaviourMachine:addSteeringBehavior(self.steeringBehaviourFollowPath)
                self.steeringBehaviourMachine:enable(true)
          end,
          exit = function()
              self.steeringBehaviourMachine:removeSteeringBehavior(self.steeringBehaviourFollowPath)
          end,
          update = function(timeStep)
          end,
          collide = function(colliderEntity, collisionPoint)
              if(colliderEntity.node:getPhysicsBody():getCollisionGroup() == CollisionGroups.projectile) then
                  self.stateMachine:switchStates(self.STATEMACHINE_STATES.dazed)
              elseif(colliderEntity.node:getPhysicsBody():getCollisionGroup() == CollisionGroups.bird) then
                  self.stateMachine:switchStates(self.STATEMACHINE_STATES.dazed)
              end
          end,
        })
      stateMachine:addState(self.STATEMACHINE_STATES.spawn, {
          enter = function()
              self.currentAnimationState=self.ANIMATION_STATES.idle
              self.runClock = njlic.Clock.create()

          end,
          exit = function()
              njlic.Clock.destroy(self.runClock)
          end,
          update = function(timeStep)
              if (self.runClock:getTimeMilliseconds() > 3000) then
                  self.runClock:reset()
                  self.stateMachine:switchStates(self.STATEMACHINE_STATES.run)
              end
          end,
          collide = function(colliderEntity, collisionPoint)
          end,
        })
      self.stateMachine = stateMachine


    end

    function dog:unload()
      njlic.PhysicsConstraintPointToPoint.destroy(self.constraint)
      njlic.Sound.destroy(self.sound)


      njlic.Sound.destroy(self.sound)
      njlic.SteeringBehaviorMachineWeighted.destroy(self.steeringBehaviourMachine)
      njlic.SteeringBehaviorFollowPath.destroy(self.steeringBehaviourFollowPath)
      njlic.SteeringBehaviorEvade.destroy(self.steeringBehaviorEvade)

      njlic.PhysicsBodyRigid.destroy(self.physicsBody)
      njlic.PhysicsShapeSphere.destroy(self.physicsShape)

      njlic.Clock.destroy(self.animationClock)
      njlic.Action.destroy(self.action)
      njlic.Node.destroy(self.node)

    end

    function dog:setup(...)
      local arg=... or {}

      local dimensions = arg.dimensions or bullet.btVector2(256.0, 256.0)
      local path = arg.path or nil
      local debug = arg.debug or false
      local spawnMachine = arg.spawnMachine or nil

      self.spawnMachine = spawnMachine

      self.inplay=true

      self.node:getGeometry():setDimensions(self.node, dimensions)

      assert(path, "The path is nil")

      local origin = path:currentWaypoint()
      self.node:setOrigin(origin)
      self.steeringBehaviourFollowPath:setPath(path)

      self.steeringBehaviourFollowPath:setWaypointSeekDist(1.0)

    end

    function dog:spawn(...)
      local arg=... or {}


      self.inplay=true

      self.stateMachine:switchStates(self.STATEMACHINE_STATES.spawn)

      self:show()
      self.node:runAction(self.action)
      self.node:setPhysicsBody(self.physicsBody)
      self.steeringBehaviourMachine:enable()


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

    function dog:collide(colliderEntity, collisionPoint)
      self.stateMachine:collide(colliderEntity, collisionPoint)
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

      self.stateMachine:update(timeStep)
    end

    function dog:addBirdsToEvade(birds)
      for i = 1, #birds do
        local node = birds[i].node
        if node ~= nil then
          self.steeringBehaviorEvade:addTarget(node)
        end
      end
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
        canPursue = true,
    }

    function game:drawButton(...)
        local arg = ... or {}

        local name = arg.name or "butn_pause_off"
        local x = arg.x or 0
        local y = arg.y or 0
        local node = arg.node or nil
        local tag = arg.tag or "pause button"
        local tp = arg.tp or nil
        local camera = arg.camera or nil
        local scale = arg.scale or 10.0

        assert(tp ~= nil, "The texture packer is nil")
        assert(camera ~= nil, "The camera is nil")

        local node, dimension = tp:draw({name=name, node=node})

        local origin = bullet.btVector3(x, y, -1)
        node:setOrigin(origin)
        node:show(camera)

        if not njlic.World.getInstance():getScene():getRootNode():hasChildNode(node) then
            njlic.World.getInstance():getScene():getRootNode():addChildNode(node)
        end

        local physicsShape = njlic.PhysicsShapeBox.create()

        local physicsBody = njlic.PhysicsBodyRigid.create()
        physicsBody:setStaticPhysics()
        physicsBody:setPhysicsShape(physicsShape)

        node:setPhysicsBody(physicsBody)

        physicsShape:setHalfExtends(bullet.btVector3( dimension:x(), dimension:y(), 1.0 ))

        node:setTag(tag)

        node:setScale(scale)

        return node
    end

    function game:load()

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

      self.orthographicCameraNode = njlic.Node.create()
      self.orthographicCameraNode:setName("perspectiveCamera")

      self.orthographicCamera = njlic.Camera.create()
      self.orthographicCamera:enableOrthographic(true)
      self.orthographicCamera:setRenderCategory(RenderCategories.orthographic)
      self.orthographicCamera:setName("perspectiveCamera")

      self.orthographicCameraNode:setCamera(self.orthographicCamera)

      rootNode:addChildNode(self.orthographicCameraNode)
      njlic.World.getInstance():getScene():setTouchCamera(self.orthographicCamera)

      -- ###################################################################################################

      self.physicsWorld = njlic.PhysicsWorld.create()
      self.physicsWorld:setGravity(self.params.World.Gravity)

      njlic.World.getInstance():getScene():setPhysicsWorld(self.physicsWorld)

      -- ###################################################################################################





      self.YappyBirdFont = BitmapFont(
      {
        names=
        {
        "Ranchers", 
        },
        maxadvance=160
      })

      -- print_r(self.YappyBirdFont)



      self.displayNode, self.displayNodeRect = self.YappyBirdFont:printf({
        mainNode=self.displayNode,
        text="ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789",
        align="Left",
        maxwidth=(njlic.SCREEN():x()),
      })
      local vert_margin = njlic.SCREEN():y() / 30.0
      local horiz_margin = njlic.SCREEN():x() / 60.0
      self.displayNode:setOrigin(bullet.btVector3(horiz_margin * 1, vert_margin * 1, -1))
      self.displayNode:show(self.orthographicCamera)


      self.interfaceTexturePacker = TexturePacker({file="interface0"})

      local pauseNode = self:drawButton({
          name = "butn_pause_off", 
          x = 200, 
          y = 200, 
          node = nil, 
          tag = "pause button", 
          tp = self.interfaceTexturePacker, 
          camera = self.orthographicCamera
      })


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
            params=self.params,
            game = self,
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
            game = self,
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
            game = self,
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
            game = self,
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
            game = self,
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
            game = self,
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
            game = self,
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
            params=self.params,
            game = self,
            })
        balloon:load({color=color})
        table.insert(self.balloonPool, balloon)
      end

      for i = 1, #self.allBirdPool do
        self.allBirdPool[i]:addBalloonsToEvade(self.balloonPool)
      end

      for i = 1, #self.dogPool do
          self.dogPool[i]:addBirdsToEvade(self.allBirdPool)
      end



    end

    function game:unload()

      self.run = false

      njlic.PhysicsWorld.destroy(self.physicsWorld)

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

    end

    function game:collide(node, otherNode, collisionPoint)
      if self.run then
        self.spawnMachine:collide(node, otherNode, collisionPoint)
      end
    end

    function game:update(timeStep)

      local from = self.perspectiveCameraNode:getOrigin()
      local dir = self.perspectiveCamera:getForwardVector()

      local debugDrawer = njlic.World.getInstance():getDebugDrawer()
      debugDrawer:line( bullet.btVector3(-100.0, 0.0, 10.0), bullet.btVector3(100.0, 0.0, 10.0))

      if self.run then

        self.spawnMachine:tick(self, timeStep)

        local number_words = njlic.convertToWords(self.spawnMachine:birdsLeftToSpawn())
      local birdsLeft = string.format("There are %s birds left.", number_words)

      self.displayNode, self.displayNodeRect = self.YappyBirdFont:printf(birdsLeft)
      self.displayNode:show(self.orthographicCamera)

        if self.spawnMachine.done then
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

      if self.run then

        local origin = self.params:originForLayer({x=x, y=y}, 10)
--        origin = self.levelLoader:getDogWayPointParams(1).origin

        local dimensions = self.params:dimensionForLayer()

        local queued = self.spawnMachine:queueBalloon({
            origin = origin,
            dimensions = dimensions,
            direction = self.perspectiveCamera:getForwardVector(),
          })
        if not queued then
        end

      end

    end

    function game:pause()
    end

    function game:unpause()
    end

    function game:start()
      if not self.run then

          self.canPursue = true

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
          else
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
      local spawnMachine = arg.spawnMachine or nil

      assert(origin, "origin is nil")
      assert(dimensions, "dimensions is nil")

      if arg.name == self.CHUBI then
        for i, v in ipairs(self.chubiBirdPool) do
          if not v.inplay then
            v:setup({
              origin=origin,
              dimensions=dimensions,
              debug=debug,
              spawnMachine=spawnMachine
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
              debug=debug,
              spawnMachine=spawnMachine
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
              debug=debug,
              spawnMachine=spawnMachine
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
              debug=debug,
              spawnMachine=spawnMachine
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
              debug=debug,
              spawnMachine=spawnMachine
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
              debug=debug,
              spawnMachine=spawnMachine
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
      local spawnMachine = arg.spawnMachine or nil

      for i, v in ipairs(self.balloonPool) do
        if not v.inplay then
          v:setup({
              origin=origin,
              dimensions=dimensions,
              direction=direction,
              debug=debug,
              spawnMachine=spawnMachine
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
      local spawnMachine = arg.spawnMachine or nil

      for i, v in ipairs(self.dogPool) do
        if not v.inplay then
          v:setup({
              path=path,
--              origin=origin,
              dimensions=dimensions,
              debug=debug,
              spawnMachine=spawnMachine
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

local TestDebugDraw = {
  new = function()
    local test = {
    }

    function test:load()

--      self.shader = njlic.ShaderProgram.create()
--      assert(njlic.World.getInstance():getWorldResourceLoader():load("shaders/PassThrough.vert", "shaders/PassThrough.frag", self.shader))

      local scene = njlic.Scene.create()
      local rootNode = njlic.Node.create()
      rootNode:setOrigin(bullet3.btVector3(0,-0.5,-1))
      scene:setRootNode(rootNode)
      njlic.World.getInstance():setScene(scene)

      self.perspectiveCameraNode = njlic.Node.create()
      self.perspectiveCameraNode:setName("perspectiveCamera")

      self.perspectiveCamera = njlic.Camera.create()
      self.perspectiveCamera:enableOrthographic(false)
--      self.perspectiveCamera:setRenderCategory(RenderCategories.perspective)
      self.perspectiveCamera:setName("perspectiveCamera")

      self.perspectiveCameraNode:setCamera(self.perspectiveCamera)
      -- self.perspectiveCamera:lookAt(btVector3(0,0,0))

      rootNode:addChildNode(self.perspectiveCameraNode)

      njlic.World.getInstance():enableDebugDraw(self.perspectiveCamera)

    end

    function test:unload()

      njlic.Camera.destroy(self.perspectiveCamera)
      njlic.Node.destroy(self.perspectiveCameraNode)

--      njlic.ShaderProgram.destroy(self.shader)
    end

    function test:update(timestep)
      njlic.World.getInstance():setBackgroundColor(1.000, 1.000, 1.000)

      local from = self.perspectiveCameraNode:getOrigin()
      local dir = self.perspectiveCamera:getForwardVector()

      local debugDrawer = njlic.World.getInstance():getDebugDrawer()
      -- debugDrawer:line( from, dir * 1000)

      -- debugDrawer:line( bullet.btVector3(-100.0, 0.0, 0.0), bullet.btVector3(100.0, 0.0, 0.0))
      -- debugDrawer:line( bullet.btVector3(-100.0, 0.0, 1.0), bullet.btVector3(100.0, 0.0, 1.0))
      -- debugDrawer:line( bullet.btVector3(-100.0, 0.0, 2.0), bullet.btVector3(100.0, 0.0, 2.0))
      -- debugDrawer:line( bullet.btVector3(-100.0, 0.0, 3.0), bullet.btVector3(100.0, 0.0, 3.0), bullet.btVector3(0.0, 1.0, 0.0))
      -- debugDrawer:line( bullet.btVector3(0.0, -100.0, 3.0), bullet.btVector3(0.0, 100.0, 3.0), bullet.btVector3(0.0, 0.0, 1.0))
      -- debugDrawer:line( bullet.btVector3(-100.0, 0.0, 4.0), bullet.btVector3(100.0, 0.0, 4.0))
      -- debugDrawer:line( bullet.btVector3(-100.0, 0.0, 5.0), bullet.btVector3(100.0, 0.0, 5.0))
      -- debugDrawer:line( bullet.btVector3(-100.0, 0.0, 6.0), bullet.btVector3(100.0, 0.0, 6.0))
      -- debugDrawer:line( bullet.btVector3(-100.0, 0.0, 7.0), bullet.btVector3(100.0, 0.0, 7.0))
      -- debugDrawer:line( bullet.btVector3(-100.0, 0.0, 8.0), bullet.btVector3(100.0, 0.0, 8.0))
      -- debugDrawer:line( bullet.btVector3(-100.0, 0.0, 9.0), bullet.btVector3(100.0, 0.0, 9.0))
      -- debugDrawer:line( bullet.btVector3(-100.0, 0.0, 10.0), bullet.btVector3(100.0, 0.0, 10.0))
      --
      for i=0,100 do
          debugDrawer:line( bullet.btVector3(i * 0.1, -100.0, 3.0), bullet.btVector3(i * 0.1, 100.0, 3.0), bullet.btVector3(0.0, 0.0, 1.0))
      end
      debugDrawer:point(bullet.btVector3(0.0, 0.0, 3.0), bullet.btVector3(1.0, 0.0, 0.0), 200)
      debugDrawer:projectedText("THIS", bullet.btVector3(0, 0, 3), bullet.btVector3(0,1,0), 10)
      debugDrawer:screenText("THAT", bullet.btVector3(0, 0, 3), bullet.btVector3(0,1,0), 10)


      local scene = njlic.World.getInstance():getScene()
      local rootNode = scene:getRootNode()


    end

      function test:collide(node, otherNode, collisionPoint)
      end

    function test:click(x, y)
    end

      function test:updateAction(action, timeStep)
      end

    return test

  end

}









local TestFont = {
  new = function()
    local test = {
      YappyBirdFont = BitmapFont(
      {
        names=
        {
        "Ranchers", 
        },
        maxadvance=160
      })
    }

    function test:load()

      local scene = njlic.Scene.create()
      local rootNode = njlic.Node.create()
      rootNode:setOrigin(bullet3.btVector3(0,-0.5,-1))
      scene:setRootNode(rootNode)
      njlic.World.getInstance():setScene(scene)

      self.orthographicCameraNode = njlic.Node.create()
      self.orthographicCameraNode:setName("orthographicCameraNode")

      self.orthographicCamera = njlic.Camera.create()
      self.orthographicCamera:enableOrthographic(true)
      self.orthographicCamera:setRenderCategory(RenderCategories.orthographic)
      self.orthographicCamera:setName("orthographicCamera")

      self.orthographicCameraNode:setCamera(self.orthographicCamera)

      rootNode:addChildNode(self.orthographicCameraNode)

      self.displayNode, self.displayNodeRect = self.YappyBirdFont:printf({
        mainNode=self.displayNode,
        text="ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789",
        align="Left",
        maxwidth=(njlic.SCREEN():x()),
      })
      local vert_margin = njlic.SCREEN():y() / 30.0
      self.displayNode:setOrigin(bullet.btVector3(100, njlic.SCREEN():y() - (vert_margin * 10), -1))
      self.displayNode:show(self.orthographicCameraNode:getCamera())

      

      -- print_r(self.YappyBirdFont)

    end

    function test:unload()
      njlic.Camera.destroy(self.orthographicCamera)
      njlic.Node.destroy(self.orthographicCameraNode)
    end

    function test:update(timestep)
      njlic.World.getInstance():setBackgroundColor(1.000, 1.000, 1.000)
    end

  function test:collide(node, otherNode, collisionPoint)
  end

    function test:click(x, y)
    end

      function test:updateAction(action, timeStep)
      end

    return test

  end

}













local Create = function()
    yappyBirds = YappyBirds.new()
    -- yappyBirds = TestDebugDraw.new()
    -- yappyBirds = TestFont.new()
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
end

local Resize = function(width, height, orientation)
end

local TouchesDown = function(touches)
end

local TouchesUp = function(touches)
end

local TouchesMove = function(touches)
end

local TouchesCancelled = function(touches)
end

local TouchDown = function(touch)
  yappyBirds:click(touch:getPosition():x(), touch:getPosition():y())
end

local TouchUp = function(touch)
end

local TouchMove = function(touch)
end

local TouchCancelled = function(touches)
end

local MouseDown = function(mouse)

  yappyBirds:click(mouse:getPosition():x(), mouse:getPosition():y())
end

local MouseUp = function(mouse)
end

local MouseMove = function(mouse)
end

local KeyDown = function(keycodeName, withCapsLock, withControl, withShift, withAlt, withGui)
end

local KeyUp = function(keycodeName, withCapsLock, withControl, withShift, withAlt, withGui)
end

local NodeCollide = function(node, otherNode, collisionPoint)
  yappyBirds:collide(node, otherNode, collisionPoint)
end

local NodeNear = function(node, otherNode)
end

local NodeActionUpdate = function(action, timeStep)

  yappyBirds:updateAction(action, timeStep)


end

local NodeActionComplete = function(action)
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
end

local NodeRayTouchesMissed = function(node)
end

local NodeRayTouchDown = function(rayContact)
    print("NodeRayTouchDown")
end

local NodeRayTouchUp = function(rayContact)
    print("NodeRayTouchUp")
    -- local nodeTag = rayContact:getHitNode():getTag()
    -- print(nodeTag)
end

local NodeRayTouchMove = function(rayContact)
    print("NodeRayTouchMove")
end

local NodeRayTouchCancelled = function(rayContact)
end

local NodeRayMouseDown = function(rayContact)
end

local NodeRayMouseUp = function(rayContact)
    local nodeTag = rayContact:getHitNode():getTag()
    print(nodeTag)
end

local NodeRayMouseMove = function(rayContact)
end

local NodeRayTouchMissed = function(node)
end

local NodeRayMouseMissed = function(node)
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

