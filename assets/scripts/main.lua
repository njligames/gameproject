require "NJLIC.util"

local Bird = {
  new = function(...)
    arg=...

    local bird = {
      inplay=false,
    }

    function bird:spawn(...)
      local arg=...
      self.inplay=true

      print("spawned the bird")
    end

    function bird:kill(...)
      local arg=...
      self.inplay=false

      -- put back to hiding values
    end

    return bird
  end
}

local Balloon = {
  new = function(...)
    arg=...

    local balloon = {
      inplay=false,
    }

    function balloon:spawn(...)
      local arg=...
      self.inplay=true

      print("spawned the balloon")
    end

    function balloon:kill(...)
      local arg=...
      self.inplay=false

      -- put back to hiding values
    end

    return balloon
  end
}

local Dog = {
  new = function(...)
    arg=...

    local dog = {
      inplay=false,
    }

    function dog:spawn(...)
      local arg=...
      self.inplay=true

      print("spawned the dog")
    end

    function dog:kill(...)
      local arg=...
      self.inplay=false

      -- put back to hiding values
    end

    return dog
  end
}

local Billboard = {
  new = function(...)
    arg=...

    local billboard = {
      inplay=false,
    }

    function billboard:spawn(...)
      local arg=...
      self.inplay=true
    end

    function billboard:kill(...)
      local arg=...
      self.inplay=false

      -- put back to hiding values
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
      levelSpriteAtlas = {},
      gameplaySpriteAtlas = {},
      levelGeometry = {},
      gameplayGeometry = {},
      debugSpriteAtlas = {},
      debugGeometry = {},
      shader = nil,
      chubiBirdPool = {},
      garuBirdPool = {},
      momiBirdPool = {},
      puffyBirdPool = {},
      weboBirdPool = {},
      zuruBirdPool = {},
      balloonPool = {},
      dogPool = {},
      billboardPool = {},
    }

    function game:load()
      local debug = false

      self.levelLoader:loadLevel({debug=debug, loc="country", levelNum=0, mode="arcade"})

      local shader = njlic.ShaderProgram.create()
      assert(njlic.World.getInstance():getWorldResourceLoader():load("shaders/StandardShader.vert", "shaders/StandardShader.frag", shader))
      self.shader = shader

      -- ###################################################################################################

      local geometry = njlic.Sprite2D.create()
      geometry:load(shader, 1000, 1)
      local material = njlic.Material.create()
      geometry:setMaterial(material)
      table.insert(self.levelGeometry, geometry)

      local path = njlic.ASSET_PATH(string.format("scripts/generated/texturepacker/%s0.lua", self.levelLoader.location))
      local sa = loadfile(path)():getSheet()
      table.insert(self.levelSpriteAtlas, njlic.build(sa, njlic.JLI_OBJECT_TYPE_SpriteFrameAtlas))

      path = string.format("images/generated/%s0.png", self.levelLoader.location)
      local image = njlic.Image.create()
      njlic.World.getInstance():getWorldResourceLoader():load(path, image)
      self.levelGeometry[1]:getMaterial():getDiffuse():loadGPU(image)
      njlic.Image.destroy(image)

      -- ###################################################################################################

      geometry = njlic.Sprite2D.create()
      geometry:load(shader, 4000, 1)
      material = njlic.Material.create()
      geometry:setMaterial(material)
      table.insert(self.gameplayGeometry, geometry)

      path = njlic.ASSET_PATH("scripts/generated/texturepacker/gameplay0.lua")
      sa = loadfile(path)():getSheet()
      table.insert(self.gameplaySpriteAtlas, njlic.build(sa, njlic.JLI_OBJECT_TYPE_SpriteFrameAtlas))

      path = "images/generated/gameplay0.png"
      image = njlic.Image.create()
      njlic.World.getInstance():getWorldResourceLoader():load(path, image)
      self.gameplayGeometry[1]:getMaterial():getDiffuse():loadGPU(image)
      njlic.Image.destroy(image)

      -- ###################################################################################################

      geometry = njlic.Sprite2D.create()
      geometry:load(shader, 4000, 1)
      material = njlic.Material.create()
      geometry:setMaterial(material)
      table.insert(self.gameplayGeometry, geometry)

      path = njlic.ASSET_PATH("scripts/generated/texturepacker/gameplay1.lua")
      sa = loadfile(path)():getSheet()
      table.insert(self.gameplaySpriteAtlas, njlic.build(sa, njlic.JLI_OBJECT_TYPE_SpriteFrameAtlas))

      path = "images/generated/gameplay1.png"
      image = njlic.Image.create()
      njlic.World.getInstance():getWorldResourceLoader():load(path, image)
      self.gameplayGeometry[2]:getMaterial():getDiffuse():loadGPU(image)
      njlic.Image.destroy(image)

      -- ###################################################################################################

      if debug then
        geometry = njlic.Sprite2D.create()
        geometry:load(shader, 100, 1)
        material = njlic.Material.create()
        geometry:setMaterial(material)
        table.insert(self.debugGeometry, geometry)

        path = njlic.ASSET_PATH("scripts/generated/texturepacker/debug0.lua")
        sa = loadfile(path)():getSheet()
        table.insert(self.debugSpriteAtlas, njlic.build(sa, njlic.JLI_OBJECT_TYPE_SpriteFrameAtlas))

        path = "images/generated/debug0.png"
        image = njlic.Image.create()
        njlic.World.getInstance():getWorldResourceLoader():load(path, image)
        self.debugGeometry[1]:getMaterial():getDiffuse():loadGPU(image)
        njlic.Image.destroy(image)
      end

      -- ###################################################################################################

      njlic.World.getInstance():setBackgroundColor(self.levelLoader.backgroundColor)

      for i = 1, self.levelLoader:numTiles() do
        local billboardParams = self.levelLoader:getBillboardParams(i)

        local billboard = Billboard.new()
        billboard:spawn({param=billboardParams})

        table.insert(self.billboardPool, billboard)
      end

      for i = 1, self.levelLoader:numSpawnPoints() do
        local point = self.levelLoader:getSpawnPoint(i)
        self.spawnMachine:addArcadeSpawnPoint(point)
      end

      -- ###################################################################################################

      local numberOfBirdsEach = 10
      local numberOfDogs = 10
      local numberOfBalloons = 100

      for i = 1, numberOfBirdsEach do

        table.insert(self.chubiBirdPool, Bird.new({name=self.CHUBI}))
        table.insert(self.garuBirdPool,  Bird.new({name=self.GARU}))
        table.insert(self.momiBirdPool,  Bird.new({name=self.MOMI}))
        table.insert(self.puffyBirdPool, Bird.new({name=self.PUFFY}))
        table.insert(self.weboBirdPool,  Bird.new({name=self.WEBO}))
        table.insert(self.zuruBirdPool,  Bird.new({name=self.ZURU}))

      end

      for i = 1, numberOfDogs do
        table.insert(self.dogPool, Dog.new())
      end

      for i = 1, numberOfBalloons do
        local color = "red"

        table.insert(self.balloonPool, Balloon.new({color=color}))
      end

    end

    function game:unload()

    end

    function game:update(timeStep)
      self.spawnMachine:tick(self, timeStep)

      if self.spawnMachine.done then
--        print("spawn machine is finished")
      end

    end

    function game:click(x, y)

      local origin = self.params:originForLayer({x=x, y=y})

      local queued = self.spawnMachine:queueBalloon({
          origin = origin,
          dimensions = bullet.btVector2(256.0, 256.0)})
    end

    function game:pause()
    end

    function game:_availableBird(...)
      arg=...

      assert(arg.name)

      if arg.name == self.CHUBI then
        for i, v in ipairs(self.chubiBirdPool) do
          if not v.inplay then
            return v 
          end
        end
      elseif arg.name == self.GARU then
        for i, v in ipairs(self.garuBirdPool) do
          if not v.inplay then
            return v 
          end
        end
      elseif arg.name == self.MOMI then
        for i, v in ipairs(self.momiBirdPool) do
          if not v.inplay then
            return v 
          end
        end
      elseif arg.name == self.PUFFY then
        for i, v in ipairs(self.puffyBirdPool) do
          if not v.inplay then
            return v 
          end
        end
      elseif arg.name == self.WEBO then
        for i, v in ipairs(self.weboBirdPool) do
          if not v.inplay then
            return v 
          end
        end
      elseif arg.name == self.ZURU then
        for i, v in ipairs(self.zuruBirdPool) do
          if not v.inplay then
            return v 
          end
        end
      end

      return nil
    end

    function game:_availableBalloon(...)
      arg=...

      for i, v in ipairs(self.balloonPool) do
        if not v.inplay then
          return v 
        end
      end

      return nil
    end

    function game:_availableDog(...)
      arg=...

      for i, v in ipairs(self.dogPool) do
        if not v.inplay then
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
  print("MouseDown")
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

RegisterCreate("Create",                                         function() pcall(Create) end)
RegisterDestroy("Destroy",                                       function() pcall(Destroy) end )
done = nil
RegisterUpdate("Update",
  function(timeStep)
    if done == nil then done = false return end
    if not done then

      require("mobdebug").on()
      require("mobdebug").start()

      pcall(Destroy)
      pcall(Create)

      done = true
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


