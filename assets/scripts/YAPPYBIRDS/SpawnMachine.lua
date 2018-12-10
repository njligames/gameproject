
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

function SpawnMachine:tick(gameplay, timeStep)
  
  self.totalTicks = self.totalTicks + timeStep
  self.gameplay = gameplay

  if #self.birdQueue > 0 then
    local bird = table.remove(self.birdQueue, 1)
    bird:spawn()
  end
  
  if #self.balloonQueue > 0 then
    local balloon = table.remove(self.balloonQueue, 1)
    balloon:spawn()
  end
  
  if #self.dogQueue > 0 then
    local dog = table.remove(self.dogQueue, 1)
    balloon:spawn()
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
  point.currentTick = spawnPoint.timeFrequency

  table.insert(self.arcadeSpawnPoints, point)

end

function SpawnMachine:queueBird(spawnPointTable)
  
  local name = spawnPointTable.spawnPoint.birdType or "puffy"
  local origin = spawnPointTable.spawnPoint.origin or bullet.btVector3(0.0, 0.0, 0.0)
  local dimensions = spawnPointTable.spawnPoint.dimensions or bullet.btVector2(256.0, 256.0)
  
  assert(self.gameplay ~= nil)

  local bird = self.gameplay:_availableBird({
    name=name,
    origin=origin,
    dimensions=dimensions,
    visible=false,
    debug=false
  })

  if nil ~= bird then
    table.insert(self.birdQueue, bird)
  end
  
  return (bird ~= nil)

end

function SpawnMachine:queueBalloon(...)
  local arg=... or {}
  
  print("SpawnMachine:queueBalloon")
  local origin = arg.origin or bullet.btVector3(0.0, 0.0, 0.0)
  local dimensions = arg.dimensions or bullet.btVector2(256.0, 256.0)
  
  assert(self.gameplay ~= nil)

  local balloon = self.gameplay:_availableBalloon({
    origin=origin,
    dimensions=dimensions,
    debug=false
  })

  if nil ~= balloon then
    table.insert(self.balloonQueue, balloon)
  end
  
  return (balloon ~= nil)
  
end

function SpawnMachine:queueDog(...)
  local arg=...
  
  local origin = arg.origin or bullet.btVector3(0.0, 0.0, 0.0)
  local dimensions = arg.dimensions or bullet.btVector2(256.0, 256.0)
  
  assert(self.gameplay ~= nil)

  local dog = self.gameplay:_availableDog({
    origin=origin,
    dimensions=dimensions,
    visible=false,
    debug=false
  })

  if nil ~= dog then
    table.insert(self.dogQueue, dog)
  end
  
  return (dog ~= nil)
  
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
