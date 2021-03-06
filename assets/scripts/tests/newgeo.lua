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

local test = {}

test.create = function()
  test.vars = {}

	local scene = njlic.Scene.create()

	local rootNode = njlic.Node.create()
	rootNode:setOrigin(bullet3.btVector3(0,0,0))
	
	scene:setRootNode(rootNode)

	local cameraNode = njlic.Node.create()
	local camera = njlic.Camera.create()
    camera:setRenderCategory(RenderCategories.perspective)

	cameraNode:setCamera(camera)

	cameraNode:setOrigin(bullet3.btVector3(0,0,0))

	scene:getRootNode():addChildNode(cameraNode)

	shader = njlic.ShaderProgram.create()
	njlic.World.getInstance():getWorldResourceLoader():load("shaders/StandardShader.vert", "shaders/StandardShader.frag", shader)
  
	local geometry = njlic.MeshGeometry.create()
	-- local path = njlic.ASSET_PATH("models/utah-teapot-lowpoly.obj")
	-- local path = njlic.ASSET_PATH("models/cube.obj")
	-- local path = njlic.ASSET_PATH("models/plane.obj")
	-- local path = njlic.ASSET_PATH("models/uv_sphere.obj")
	-- local path = njlic.ASSET_PATH("models/ico_sphere.obj")
	-- local path = njlic.ASSET_PATH("models/cylinder.obj")
	-- local path = njlic.ASSET_PATH("models/cone.obj")
	-- local path = njlic.ASSET_PATH("models/torus.obj")
  -- local path = njlic.ASSET_PATH("models/grid.obj")
	-- local path = njlic.ASSET_PATH("models/monkey.obj")
	-- local path = njlic.ASSET_PATH("models/capsule.obj")
	-- local path = njlic.ASSET_PATH("models/sphere.obj")
	 local path = njlic.ASSET_PATH("models/muscular_amazon.obj")
	-- local path = njlic.ASSET_PATH("models/bunny.obj")
  -- 

	local f = assert(io.open(path, "r"))
	local objFileData = f:read("*all")
	f:close()
	geometry:load(shader, objFileData, 1, 1)


	local node = njlic.Node.create()
	scene:getRootNode():addChildNode(node)

	node:setGeometry(geometry)
	node:setOrigin(bullet3.btVector3(0,0,2))

    node:show(camera)

  test.vars.node = node
  test.vars.camera = camera

	njlic.World.getInstance():setScene(scene)
  njlic.World.getInstance():enableDebugDraw(camera)

	test.rotation = 0.0

  local p = njlic:getSublimeCompletions()
  -- print(p)
end

test.destroy = function()
end

test.update = function(timeStep)

  njlic.World.getInstance():setBackgroundColor(1.000, 0.000, 0.000)

  local rotX = bullet3.btQuaternion(bullet3.btVector3(1.0, 0.0, 0.0), test.rotation)
  local rotY = bullet3.btQuaternion(bullet3.btVector3(0.0, 1.0, 0.0), test.rotation)
  local rotZ = bullet3.btQuaternion(bullet3.btVector3(0.0, 0.0, 1.0), test.rotation)

  -- print("test.rotation", test.rotation)
  -- print("timeStep", timeStep)
  -- print("rotX", rotX)
  -- print("rotY", rotY)
  -- print("rotZ", rotZ)

  test.rotation = test.rotation + timeStep

  local rot = rotX -- * rotY

  -- print(rot)

  test.vars.node:setRotation(rot)

end

test.render = function()
  -- local transform = test.vars.node:getWorldTransform()

  -- print(transform)
  -- njlic.World.getInstance():getDebugDrawer():editTransform(test.vars.camera, transform)

  -- test.vars.node:setTransform(transform)
end

return test

