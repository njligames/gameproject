
local Test = {
  new = function()
    local test = {
    }
    
    function test:load()
      print("create test")
      
      local scene = njlic.Scene.create()
      local rootNode = njlic.Node.create()
      rootNode:setOrigin(bullet3.btVector3(0,-0.5,-1))
      scene:setRootNode(rootNode)
      njlic.World.getInstance():setScene(scene)
      
      self.perspectiveCameraNode = njlic.Node.create()
      self.perspectiveCameraNode:setName("perspectiveCamera")

      self.perspectiveCamera = njlic.Camera.create()
      self.perspectiveCamera:enableOrthographic(false)
      self.perspectiveCamera:setName("perspectiveCamera")

      self.perspectiveCameraNode:setCamera(self.perspectiveCamera)
      
      rootNode:addChildNode(self.perspectiveCameraNode)

      njlic.World.getInstance():enableDebugDraw(self.perspectiveCamera)
      
    end
  
    function test:unload()
      print("destroy test")
      
      njlic.Camera.destroy(self.perspectiveCamera)
      njlic.Node.destroy(self.perspectiveCameraNode)
      
    end
  
    function test:update(timestep)
      njlic.World.getInstance():setBackgroundColor(1.000, 1.000, 1.000)
      
      local from = self.perspectiveCameraNode:getOrigin()
      local dir = self.perspectiveCamera:getForwardVector()

      local debugDrawer = njlic.World.getInstance():getDebugDrawer()

      for i=0,100 do
          debugDrawer:line( bullet.btVector3(i * 0.01, -100.0, 3.0), bullet.btVector3(i * 0.1, 100.0, 3.0), bullet.btVector3(0.0, 0.0, 1.0))
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
      print("click test")
    end

      function test:updateAction(action, timeStep)
      end
    
    return test
    
  end
  
}

local Create = function()
    yappyBirds = Test.new()
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
