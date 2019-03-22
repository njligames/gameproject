
local SpawnMachine = {}
SpawnMachine.__index = SpawnMachine

--#############################################################################
--DO NOT EDIT ABOVE
--#############################################################################

--#############################################################################
--Begin Custom Code
--Required local functions:
--  __ctor()
--  __dtor()
--  __load()
--  __unLoad()
--#############################################################################

local __ctor = function(self, init)
  --TODO: construct this Entity

  self.totalTicks = 0
  self.arcadeSpawnPoints = {}
  self.birdQueue = {}
  self.balloonQueue = {}
  self.dogQueue = {}

  self.garbageQueue = {}
  
  self.gameEntities = {}
  
  self.done = false
end

local __dtor = function(self)
  --TODO: destruct this Entity
end

local __load = function(self)
  --TODO: load this Entity
end

local __unLoad = function(self)
  --TODO: unload this Entity
end

--############################################################################# 

--TODO: write function here for SpawnMachine

function SpawnMachine:gameEntity(name)
  return self.gameEntities[name]
end

function SpawnMachine:collide(node, otherNode, collisionPoint)
  assert(node, "colidee node is nil")
  assert(otherNode, "colider node is nil")
  
  local collideeEntity = self.gameEntities[node:getName()]
  local colliderEntity = self.gameEntities[otherNode:getName()]
  
  assert(collideeEntity, "The collidee entity is nil")
  assert(colliderEntity, "The collider entity is nil")
  
  -- collideeEntity:collide(colliderEntity, collisionPoint)
  local status, err = pcall(collideeEntity.collide, collideeEntity, colliderEntity, collisionPoint)
  if not status then print(err) end
end

function SpawnMachine:tick(gameplay, timeStep)
  
  local i = 1
  for k,v in pairs(self.gameEntities) do
    local status, err = pcall(v.update, v, timeStep)
      if not status then print(err) end
    
    if not v.inplay then
      self.gameEntities[k]=nil
    end
    i = i + 1
	end
  
  self.totalTicks = self.totalTicks + timeStep
  self.gameplay = gameplay

  if #self.garbageQueue > 0 then
    local entity = table.remove(self.garbageQueue, 1)
    if entity and entity.node then
      assert(entity.node, "entity node is nil")
      self.gameEntities[entity.node:getName()] = entity
      local status, err = pcall(entity.kill, entity)
      if not status then print(err) end
      entity = nil
    end
  end

  if #self.birdQueue > 0 then
    local entity = table.remove(self.birdQueue, 1)
    if entity and entity.node then
      assert(entity.node, "entity node is nil")
      self.gameEntities[entity.node:getName()] = entity
      local status, err = pcall(entity.spawn, entity)
      if not status then print(err) end
    end
  end
  
  if #self.balloonQueue > 0 then
    local entity = table.remove(self.balloonQueue, 1)
    if entity and entity.node then
      assert(entity.node, "entity node is nil")
      self.gameEntities[entity.node:getName()] = entity
      local status, err = pcall(entity.spawn, entity)
      if not status then print(err) end
    end
  end
  
  if #self.dogQueue > 0 then
    local entity = table.remove(self.dogQueue, 1)
    if entity and entity.node then
      assert(entity.node, "entity node is nil")
      self.gameEntities[entity.node:getName()] = entity
      local status, err = pcall(entity.spawn, entity)
      if not status then print(err) end
    end
  end
  
  self.done = true
  for i = 1, #self.arcadeSpawnPoints do
    local spawnPointTable = self.arcadeSpawnPoints[i]
    
--    print(i, spawnPointTable.currentTick, spawnPointTable.spawnPoint.spawnAmount)
    
    if spawnPointTable.spawnPoint.enabled then
      
      if spawnPointTable.spawnPoint.spawnAmount > 0 then
        
        self.done = false
        
        if spawnPointTable.currentTick <= 0 then
          
          if self:queueBird(spawnPointTable) then
            
            spawnPointTable.spawnPoint.spawnAmount = spawnPointTable.spawnPoint.spawnAmount - 1
            spawnPointTable.currentTick = spawnPointTable.spawnPoint.timeFrequency
          end
          
        end
        
        if spawnPointTable.spawnPoint.spawnAmount > 0 then
          spawnPointTable.currentTick = spawnPointTable.currentTick - timeStep
        end
      end
    end
  end
end

function SpawnMachine:addArcadeSpawnPoint(spawnPoint)

  local point = {}
  point.spawnPoint = spawnPoint
  point.currentTick = 0 --spawnPoint.timeFrequency

  table.insert(self.arcadeSpawnPoints, point)

end

function SpawnMachine:queueBird(spawnPointTable)
  
  local name = spawnPointTable.spawnPoint.birdType or "puffy"
  local origin = spawnPointTable.spawnPoint.origin or bullet.btVector3(0.0, 0.0, 0.0)
  local dimensions = spawnPointTable.spawnPoint.dimensions or bullet.btVector2(256.0, 256.0)
  
  assert(self.gameplay ~= nil, "Gameplay is nil")

  local bird = self.gameplay:_availableBird({
    name=name,
    origin=origin,
    dimensions=dimensions,
    visible=false,
    debug=false,
    spawnMachine=self,
  })

  if nil ~= bird then
    table.insert(self.birdQueue, bird)
  end
  
  return (bird ~= nil)

end

function SpawnMachine:queueBalloon(...)
  local arg=... or {}
  
--  print("SpawnMachine:queueBalloon")
  local origin = arg.origin or bullet.btVector3(0.0, 0.0, 0.0)
  local dimensions = arg.dimensions or bullet.btVector2(256.0, 256.0)
  local direction = arg.direction or bullet.btVector3(0.0, 1.0, 0.0)
  
  assert(self.gameplay ~= nil)

  local balloon = self.gameplay:_availableBalloon({
    origin=origin,
    dimensions=dimensions,
    direction=direction,
    debug=false,
    spawnMachine=self,
  })

  if nil ~= balloon then
    table.insert(self.balloonQueue, balloon)
  end
  
  return (balloon ~= nil)
  
end


function SpawnMachine:queueDog(...)
  local arg=... or {}
  
--  local origin = arg.origin or bullet.btVector3(0.0, 0.0, 0.0)
  local dimensions = arg.dimensions or bullet.btVector2(256.0, 256.0)
  local path = arg.path or nil
  
  assert(self.gameplay ~= nil, "Gameplay is nil")
  assert(path ~= nil, "The path is nil")

  local dog = self.gameplay:_availableDog({
      path=path,
--    origin=origin,
    dimensions=dimensions,
    debug=false,
    spawnMachine=self,
  })

  if nil ~= dog then
    table.insert(self.dogQueue, dog)
  end
  
  return (dog ~= nil)
  
end

function SpawnMachine:dispose(entity)
    if nil ~= entity then
        table.insert(self.garbageQueue, entity)
    end

    return (entity ~= nil)
end

--############################################################################# 
--End Custom Code
--#############################################################################


--#############################################################################
--DO NOT EDIT BELOW
--#############################################################################

setmetatable(SpawnMachine, {
    __call = function (cls, ...)
      local self = setmetatable({}, cls)
      self:_create(...)
      return self
    end,
  })

function SpawnMachine:className()
  return "SpawnMachine"
end

function SpawnMachine:class()
  return self
end

function SpawnMachine:superClass()
  return nil
end

function SpawnMachine:isa(theClass)
  local b_isa = false
  local cur_class = theClass:class()
  while ( nil ~= cur_class ) and ( false == b_isa ) do
    if cur_class == theClass then
      b_isa = true
    else
      cur_class = cur_class:superClass()
    end
  end

  return b_isa
end

function SpawnMachine:__gc()
  SpawnMachine._destroy(self)
end

function SpawnMachine:__tostring()
  local ret = self:className() .. " =\n{\n"
  
  for pos,val in pairs(self) do 
    ret = ret .. "\t" .. "["..pos.."]" .. " => " .. type(val) .. " = " .. tostring(val) .. "\n"
  end

  return ret .. "\n\t" .. tostring_r(getmetatable(self)) .. "\n}"
end

function SpawnMachine:_destroy()
  assert(not self.__SpawnMachineCalledLoad, "Must unload before you destroy")
  
  __dtor(self)
end

function SpawnMachine:_create(init)
  self.__SpawnMachineCalledLoad = false
  
  __ctor(self, init)
end

function SpawnMachine:load()
  __load(self)
  
  self.__SpawnMachineCalledLoad = true
end

function SpawnMachine:unLoad()
  assert(self.__SpawnMachineCalledLoad, "Must load before unloading")
  
  __unLoad(self)
  self.__SpawnMachineCalledLoad = false
end

return SpawnMachine
