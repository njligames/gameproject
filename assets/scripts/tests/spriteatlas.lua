local test = {}

OrthographicCameraNode = nil
PerspectiveCameraNode = nil

RenderCategories =
{
  none = bit.tobit(0x00000),
  orthographic = bit.tobit(0x00002),
  perspective = bit.tobit(0x00004),
  anotherType1 = bit.tobit(0x00008),
  anotherType2 = bit.tobit(0x00010),
  anotherType2 = bit.tobit(0x00020),
  anotherType3 = bit.tobit(0x00040),
  anotherType4 = bit.tobit(0x00080),
  anotherType5 = bit.tobit(0x00100),
  anotherType6 = bit.tobit(0x00200),
  anotherType7 = bit.tobit(0x00400),
  anotherType8 = bit.tobit(0x00800),
  anotherType9 = bit.tobit(0x01000),
  anotherType10 = bit.tobit(0x02000),
  anotherType11 = bit.tobit(0x04000),
  anotherType12 = bit.tobit(0x08000),
  anotherType13 = bit.tobit(0x10000),
}


test.create = function()
  local scene = njlic.Scene.create()
  local rootNode = njlic.Node.create()
  
  local physicsWorld = njlic.PhysicsWorld.create()
  scene:setPhysicsWorld(physicsWorld)
  scene:setRootNode(rootNode)
  
  njlic.World.getInstance():setScene(scene)

  if nil == OrthographicCameraNode then
    OrthographicCameraNode = njlic.Node.create()
    OrthographicCameraNode:setName("orthoCamera")

    local cam = njlic.Camera.create()
    cam:enableOrthographic()
    cam:setRenderCategory(RenderCategories.orthographic)
    cam:setName("orthoCamera")

    OrthographicCameraNode:setCamera(cam)
    
    njlic.World.getInstance():enableDebugDraw(OrthographicCameraNode:getCamera())
    
    OrthographicCameraNode:setOrigin(bullet3.btVector3(0,0,0))
	  scene:getRootNode():addChildNode(OrthographicCameraNode)

    scene:setTouchCamera(OrthographicCameraNode:getCamera())
  end

  
  if nil == PerspectiveCameraNode then
    PerspectiveCameraNode = njlic.Node.create()
    PerspectiveCameraNode:setName("perspectiveCamera")

    local cam = njlic.Camera.create()
    cam:enableOrthographic(false)
    cam:setRenderCategory(RenderCategories.perspective)
    cam:setName("perspectiveCamera")

    PerspectiveCameraNode:setCamera(cam)
    
	  -- scene:getRootNode():addChildNode(PerspectiveCameraNode)
  end

  test.vars = {}

  -- local camera = OrthographicCameraNode:getCamera()
  -- local camera = PerspectiveCameraNode:getCamera()
	-- scene:getRootNode():addChildNode(PerspectiveCameraNode)










  local function benchmark()
    shader = njlic.ShaderProgram.create()
    njlic.World.getInstance():getWorldResourceLoader():load("shaders/StandardShader.vert", "shaders/StandardShader.frag", shader)
    
    local geometry = njlic.Sprite2D.create()
    geometry:load(shader, 1, 1)

    local image = njlic.Image.create()
    njlic.World.getInstance():getWorldResourceLoader():load("images/generated/elia_gameplay0.png", image)

    local material = njlic.Material.create()
    geometry:setMaterial(material)
    geometry:getMaterial():getDiffuse():loadGPU(image)
    njlic.Image.destroy(image)

    local node = njlic.Node.create()
    node:setGeometry(geometry)

    node:setOrigin(bullet3.btVector3(0,0,2))

    return node
  end



  local function spriteatlas()
    local TexturePacker = require "NJLIC.TexturePacker"
    local EliaTexturePacker = TexturePacker({file="elia_gameplay0"})

    local node = njlic.Node.create()
    node, dimension = EliaTexturePacker:draw({name="gfg_4th", node=node})
    node:setOrigin(bullet3.btVector3(75.0 / 2.0, 75.0 / 2.0, 0))
    print("spriteatlas dimension", dimension)
    return node
  end





  -- local node = benchmark()
  local node = spriteatlas()

	-- scene:getRootNode():addChildNode(node)
  -- PerspectiveCameraNode:addChildNode(node)
  OrthographicCameraNode:addChildNode(node)


  test.vars.node = node
  test.vars.camera = camera

	njlic.World.getInstance():setScene(scene)

	test.rotation = 0.0

  local p = njlic:getSublimeCompletions()
  -- print(p)
end

test.destroy = function()
end

test.update = function(timeStep)

  -- njlic.World.getInstance():setBackgroundColor(1.000, 1.000, 0.000)

  local rotX = bullet3.btQuaternion(bullet3.btVector3(1.0, 0.0, 0.0), test.rotation)
  local rotY = bullet3.btQuaternion(bullet3.btVector3(0.0, 1.0, 0.0), test.rotation)
  local rotZ = bullet3.btQuaternion(bullet3.btVector3(0.0, 0.0, 1.0), test.rotation)

  -- print("test.rotation", test.rotation)
  -- print("timeStep", timeStep)
  -- print("rotX", rotX)
  -- print("rotY", rotY)
  -- print("rotZ", rotZ)

  test.rotation = test.rotation + timeStep

  local rot = rotX * rotY

  -- print(rot)

  -- test.vars.node:setRotation(rotX * rotY)
  -- test.vars.node:setRotation(rotZ)

end

test.render = function()
  -- local transform = test.vars.node:getWorldTransform()

  -- print(transform)
  -- njlic.World.getInstance():getDebugDrawer():editTransform(test.vars.camera, transform)

  -- test.vars.node:setTransform(transform)
end

return test

