require "NJLIC.util"

local BitmapFont = require 'NJLIC.BitmapFont'
local TexturePacker = require "NJLIC.TexturePacker"

local Bird = {
  new = function(...)
    arg=...  

    local bird = {
      inplay=false,
    }
    
    function bird:load(...)
      arg=...
      
--      print("loaded the bird")
    end
  
    function bird:unload()
--      print("unloaded the bird")
    end
  
    function bird:spawn(...)
      local arg=...
      self.inplay=true

--      print("spawned the bird")
    end

    function bird:kill(...)
      local arg=...
      
      self.inplay=false

      -- put back to hiding values
    end
    
    function bird:hide()
    end
    
    function bird:show()
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
    
    function balloon:load(...)
      arg=...
      
--      print("loaded the balloon")
    end
  
    function balloon:unload()
--      print("unloaded the balloon")
    end

    function balloon:spawn(...)
      local arg=...
      
      self.inplay=true

--      print("spawned the balloon")
    end

    function balloon:kill(...)
      local arg=...
      
      self.inplay=false

      -- put back to hiding values
    end
    
    function balloon:hide()
    end
    
    function balloon:show()
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
    
    function dog:load(...)
      arg=...
      
--      print("loaded the dog")
    end
  
    function dog:unload()
--      print("unloaded the dog")
    end

    function dog:spawn(...)
      local arg=...
      
      self.inplay=true

--      print("spawned the dog")
    end

    function dog:kill(...)
      local arg=...
      
      self.inplay=false

      -- put back to hiding values
    end
    
    function dog:hide()
    end
    
    function dog:show()
    end

    return dog
  end
}

local Billboard = {
  new = function(...)
    arg=...
    
    local levelTexturePacker=arg.levelTexturePacker or {}
    local perspectiveCamera=arg.perspectiveCamera or nil

    local billboard = {
      inplay=false,
      node = nil,
      levelTexturePacker=levelTexturePacker,
      perspectiveCamera=perspectiveCamera,
      node = nil,
    }
    
    function billboard:load(...)
      arg=...
      
      print_r(arg)
      
      local name = arg.name or "?"
      local origin = arg.origin or bullet.btVector3(0.0, 0.0, 0.0)
      local dimensions = arg.dimensions or bullet.btVector2(0.0, 0.0)
      
      self.node = njlic.Node.create()
      self.node = levelTexturePacker[1]:draw({name=name, node=self.node})
      
      self.node:getGeometry():setDimensions(self.node, dimensions)
      self.node:setOrigin(origin)
      self.node:hide(self.perspectiveCamera)
      
      njlic.World.getInstance():getScene():getRootNode():addChildNode(self.node)
      
      print("loaded the billboard")
      
--      print_r(self.levelTexturePacker)
      return true
      
--      local tableIndex = arg.tableIndex or 1
      
--      local texturePacker = self.levelTexturePacker[tableIndex] or nil
      
--      if nil ~= texturePacker then
        
----        self.node = njlic.Node.create()
----        self.node:setGeometry(geometry)
----        self.node:hide(self.perspectiveCamera)
        
--        return true
--      end
      
--      return false
    end
  
    function billboard:unload()
      print("unloaded the billboard")
    end

    function billboard:spawn(...)
      local arg=...
      
      print("spawned the billboard")
      
      self.node:show(self.perspectiveCamera)
      
      self.inplay=true
    end

    function billboard:kill(...)
      local arg=...
      
      self.inplay=false

      -- put back to hiding values
    end
    
    function billboard:hide()
    end
    
    function billboard:show()
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
--      levelSpriteAtlas = {},
      gameplayTexturePacker = {},
--      gameplaySpriteAtlas = {},
--      levelGeometry = {},
--      gameplayGeometry = {},
      debugTexturePacker = {},
--      debugSpriteAtlas = {},
--      debugGeometry = {},
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
      
      perspectiveCameraNode = nil,
      perspectiveCamera = nil,
      
      orthographicCameraNode = nil,
      orthographicCamera = nil,
      
      run = false,
      
    }

    function game:load()
      local debug = false
      
      print("game:load()")

      self.levelLoader:loadLevel({debug=debug, loc="country", levelNum=0, mode="arcade"})

      local shader = njlic.ShaderProgram.create()
      assert(njlic.World.getInstance():getWorldResourceLoader():load("shaders/StandardShader.vert", "shaders/StandardShader.frag", shader))
      self.shader = shader
      
      print("shader")
      
      
      -- ###################################################################################################

--      local geometry = njlic.Sprite2D.create()
--      geometry:load(shader, 1000, 1)
--      local material = njlic.Material.create()
--      geometry:setMaterial(material)
--      table.insert(self.levelGeometry, geometry)

      table.insert(self.levelTexturePacker, TexturePacker({file=string.format("%s0", self.levelLoader.location)}))
      print("levelTexturePacker")


--      path = string.format("images/generated/%s0.png", self.levelLoader.location)
--      local image = njlic.Image.create()
--      njlic.World.getInstance():getWorldResourceLoader():load(path, image)
--      self.levelGeometry[1]:getMaterial():getDiffuse():loadGPU(image)
--      njlic.Image.destroy(image)
      -- ###################################################################################################

--      geometry = njlic.Sprite2D.create()
--      geometry:load(shader, 4000, 1)
--      material = njlic.Material.create()
--      geometry:setMaterial(material)
--      table.insert(self.gameplayGeometry, geometry)

--      path = njlic.ASSET_PATH("scripts/generated/texturepacker/gameplay0.lua")
--      sa = njlic.build(loadfile(path)():getSheet(), njlic.JLI_OBJECT_TYPE_SpriteFrameAtlas)
--      table.insert(self.gameplaySpriteAtlas, sa)

      table.insert(self.gameplayTexturePacker, TexturePacker({file="gameplay0"}))

print("gameplayTexturePacker")
--      path = "images/generated/gameplay0.png"
--      image = njlic.Image.create()
--      njlic.World.getInstance():getWorldResourceLoader():load(path, image)
--      self.gameplayGeometry[1]:getMaterial():getDiffuse():loadGPU(image)
--      njlic.Image.destroy(image)
    
      -- ###################################################################################################

--      geometry = njlic.Sprite2D.create()
--      geometry:load(shader, 4000, 1)
--      material = njlic.Material.create()
--      geometry:setMaterial(material)
--      table.insert(self.gameplayGeometry, geometry)

--      path = njlic.ASSET_PATH("scripts/generated/texturepacker/gameplay1.lua")
--      sa = njlic.build(loadfile(path)():getSheet(), njlic.JLI_OBJECT_TYPE_SpriteFrameAtlas)
--      table.insert(self.gameplaySpriteAtlas, sa)
      
      table.insert(self.gameplayTexturePacker, TexturePacker({file="gameplay1"}))
print("gameplayTexturePacker")
--      path = "images/generated/gameplay1.png"
--      image = njlic.Image.create()
--      njlic.World.getInstance():getWorldResourceLoader():load(path, image)
--      self.gameplayGeometry[2]:getMaterial():getDiffuse():loadGPU(image)
--      njlic.Image.destroy(image)

      -- ###################################################################################################

      if debug then
--        geometry = njlic.Sprite2D.create()
--        geometry:load(shader, 100, 1)
--        material = njlic.Material.create()
--        geometry:setMaterial(material)
--        table.insert(self.debugGeometry, geometry)

--        path = njlic.ASSET_PATH("scripts/generated/texturepacker/debug0.lua")
--        sa = njlic.build(loadfile(path)():getSheet(), njlic.JLI_OBJECT_TYPE_SpriteFrameAtlas)
--        table.insert(self.debugSpriteAtlas, sa)
        table.insert(self.debugTexturePacker, TexturePacker({file="debug0"}))
  
--        path = "images/generated/debug0.png"
--        image = njlic.Image.create()
--        njlic.World.getInstance():getWorldResourceLoader():load(path, image)
--        self.debugGeometry[1]:getMaterial():getDiffuse():loadGPU(image)
--        njlic.Image.destroy(image)
      end
      
      -- ###################################################################################################

      njlic.World.getInstance():setBackgroundColor(self.levelLoader.backgroundColor)
      
      print('backgroundcolor')
      for i = 1, self.levelLoader:numSpawnPoints() do
        print(i)
        
        local point = self.levelLoader:getSpawnPoint(i)
        self.spawnMachine:addArcadeSpawnPoint(point)
      end
      
      -- ###################################################################################################
      
      
      
      -- ###################################################################################################
      
      local scene = njlic.Scene.create()

      local rootNode = njlic.Node.create()
      rootNode:setOrigin(bullet3.btVector3(0,0,0))
      
      scene:setRootNode(rootNode)
      
      njlic.World.getInstance():setScene(scene)

print('block1')
      -- ###################################################################################################
      
      self.perspectiveCameraNode = njlic.Node.create()
      self.perspectiveCameraNode:setName("perspectiveCamera")

      self.perspectiveCamera = njlic.Camera.create()
      self.perspectiveCamera:enableOrthographic(false)
      self.perspectiveCamera:setRenderCategory(RenderCategories.perspective)
      self.perspectiveCamera:setName("perspectiveCamera")

      self.perspectiveCameraNode:setCamera(self.perspectiveCamera)
      
      rootNode:addChildNode(self.perspectiveCameraNode)
print('block2')
      -- ###################################################################################################
      
      local orthographicCameraNode = njlic.Node.create()
      orthographicCameraNode:setName("perspectiveCamera")

      self.orthographicCamera = njlic.Camera.create()
      self.orthographicCamera:enableOrthographic(true)
      self.orthographicCamera:setRenderCategory(RenderCategories.orthographic)
      self.orthographicCamera:setName("perspectiveCamera")

      orthographicCameraNode:setCamera(self.orthographicCamera)
      
      rootNode:addChildNode(orthographicCameraNode)
      print('block3')
      -- ###################################################################################################
      
      self.physicsWorld = njlic.PhysicsWorld.create()
      njlic.World.getInstance():getScene():setPhysicsWorld(self.physicsWorld)
print('block4')

      -- ###################################################################################################
      
      
      for i = 1, self.levelLoader:numTiles() do
        local billboardParams = self.levelLoader:getBillboardParams(i)

        local billboard = Billboard.new({
--            levelSpriteAtlasTable=self.levelSpriteAtlas,
--            levelGeometryTable=self.levelGeometry,
            levelTexturePacker=self.levelTexturePacker,
            perspectiveCamera=self.perspectiveCamera
          })
        
        print(i)
        if billboard:load(billboardParams) then
          table.insert(self.billboardPool, billboard)
          print("loaded")
        else
          print("not loaded")
        end
        
      end

      local numberOfBirdsEach = 10
      local numberOfDogs = 10
      local numberOfBalloons = 100

      local bird = nil
      for i = 1, numberOfBirdsEach do

        bird = Bird.new({name=self.CHUBI})
        bird:load()
        table.insert(self.chubiBirdPool, bird)

        
        bird = Bird.new({name=self.GARU})
        bird:load()
        table.insert(self.garuBirdPool, bird)
        
        bird = Bird.new({name=self.MOMI})
        bird:load()
        table.insert(self.momiBirdPool, bird)
        
        bird = Bird.new({name=self.PUFFY})
        bird:load()
        table.insert(self.puffyBirdPool, bird)
        
        bird = Bird.new({name=self.WEBO})
        bird:load()
        table.insert(self.weboBirdPool, bird)
        
        bird = Bird.new({name=self.ZURU})
        bird:load()
        table.insert(self.zuruBirdPool, bird)
        
      end

      local dog = nil
      for i = 1, numberOfDogs do
        dog = Dog.new()
        dog:load()
        table.insert(self.dogPool, dog)
      end
      
      local balloon = nil
      for i = 1, numberOfBalloons do
        local color = "red"

        balloon = Balloon.new({color=color})
        balloon:load()
        table.insert(self.balloonPool, balloon)
      end

      
    end

    function game:unload()
      print("game:unload")
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
      
--      for i = 1, #self.debugGeometry do
--        local geometry = self.debugGeometry[i]
        
--        geometry:getMaterial():getDiffuse():unLoadGPU()
        
--        njlic.Sprite2D.destroy(geometry)
--      end
--      self.debugGeometry = {}
      
--      for i = 1, #self.gameplayGeometry do
--        local geometry = self.gameplayGeometry[i]
        
--        geometry:getMaterial():getDiffuse():unLoadGPU()
        
--        njlic.Sprite2D.destroy(geometry)
--      end
--      self.gameplayGeometry = {}
      
--      for i = 1, #self.levelGeometry do
--        local geometry = self.levelGeometry[i]
        
--        geometry:getMaterial():getDiffuse():unLoadGPU()
        
--        njlic.Sprite2D.destroy(geometry)
--      end
--      self.levelGeometry = {}
      
--      for i = 1, #self.debugSpriteAtlas do
--        self.debugSpriteAtlas[i] = nil
--      end
--      self.debugSpriteAtlas = {}
      
--      for i = 1, #self.gameplaySpriteAtlas do
--        self.gameplaySpriteAtlas[i] = nil
--      end
--      self.gameplaySpriteAtlas = {}
      
--      for i = 1, #self.levelSpriteAtlas do
--        self.levelSpriteAtlas[i] = nil
--      end
--      self.levelSpriteAtlas = {}



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

    function game:click(x, y)

      if self.run then
        
        local origin = self.params:originForLayer({x=x, y=y})

        local queued = self.spawnMachine:queueBalloon({
            origin = origin,
            dimensions = bullet.btVector2(256.0, 256.0)})
      end
      
    end

    function game:pause()
    end
  
    function game:unpause()
    end
  
    function game:start()
      print ("start game")
      print(self.run)
      if not self.run then
        for i = 1, #self.billboardPool do
          print(i)
          local billboard = self.billboardPool[i]
          billboard:spawn()
        end
        
        self.run = true
      end
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
  print("newed yappybird")
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
  print("NodeActionUpdate")
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
