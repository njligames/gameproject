local test = {}

test.create = function()
  test.vars = {}

	local scene = njlic.Scene.create()

	local rootNode = njlic.Node.create()
	rootNode:setOrigin(bullet3.btVector3(0,0,0))
	
	scene:setRootNode(rootNode)

	local cameraNode = njlic.Node.create()
	local camera = njlic.Camera.create()

	cameraNode:setCamera(camera)

	cameraNode:setOrigin(bullet3.btVector3(0,0,0))

	scene:getRootNode():addChildNode(cameraNode)

	shader = njlic.ShaderProgram.create()
	njlic.World.getInstance():getWorldResourceLoader():load("shaders/StandardShader.vert", "shaders/StandardShader.frag", shader)
  
	local geometry = njlic.MeshGeometry.create()
	-- local path = njlic.ASSET_PATH("models/utah-teapot-lowpoly.obj")
	-- local path = njlic.ASSET_PATH("models/cube.obj")
	local path = njlic.ASSET_PATH("models/plane.obj")
	-- local path = njlic.ASSET_PATH("models/uv_sphere.obj")
	-- local path = njlic.ASSET_PATH("models/ico_sphere.obj")
	-- local path = njlic.ASSET_PATH("models/cylinder.obj")
	-- local path = njlic.ASSET_PATH("models/cone.obj")
	-- local path = njlic.ASSET_PATH("models/torus.obj")
  -- local path = njlic.ASSET_PATH("models/grid.obj")
	-- local path = njlic.ASSET_PATH("models/monkey.obj")
	-- local path = njlic.ASSET_PATH("models/capsule.obj")
	-- local path = njlic.ASSET_PATH("models/sphere.obj")
	-- local path = njlic.ASSET_PATH("models/muscular_amazon.obj")
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

  test.vars.node = node
  test.vars.camera = camera

	njlic.World.getInstance():setScene(scene)
  njlic.World.getInstance():enableDebugDraw(camera)

	test.rotation = 0.0

  local p = njlic:getSublimeCompletions()
  print(p)
end

test.destroy = function()
end

test.update = function(timeStep)
  njlic.World.getInstance():setBackgroundColor(1.000, 1.000, 0.000)

  local rotX = bullet3.btQuaternion(bullet3.btVector3(1.0, 0.0, 0.0), test.rotation)
  local rotY = bullet3.btQuaternion(bullet3.btVector3(0.0, 1.0, 0.0), test.rotation)
  local rotZ = bullet3.btQuaternion(bullet3.btVector3(0.0, 0.0, 1.0), test.rotation)
  test.rotation = test.rotation + timeStep

  test.vars.node:setRotation(rotX * rotY)




  








  -- setRimLightColor(const btVector3 &color)
  -- getRimLightColor()const
  -- 
  -- setRimLightStart(const float v)
  -- getRimLightStart()const
  -- 
  -- setRimLightEnd(const float v)
  -- getRimLightEnd()const
  -- 
  -- setRimLightCoefficient(const float v)
  -- getRimLightCoefficient()const
  -- 
  -- setLightSourceAmbientColor(const btVector3 &color)
  -- getLightSourceAmbientColor()const
  -- 
  -- setLightSourceDiffuseColor(const btVector3 &color)
  -- getLightSourceDiffuseColor()const
  -- 
  -- setLightSourceSpecularColor(const btVector3 &color)
  -- getLightSourceSpecularColor()const
  -- 
  -- setLightSourcePosition(const btVector4 &pos)
  -- getLightSourcePosition()const
  -- 
  -- setLightSourceSpotDirection(const btVector3 &dir)
  -- getLightSourceSpotDirection()const
  -- 
  -- setLightSourceSpotExponent(const float v)
  -- getLightSourceSpotExponent()const
  -- 
  -- setLightSourceSpotCutoff(const float v)
  -- getLightSourceSpotCutoff()const
  -- 
  -- setLightSourceSpotCosCutoff(const float v)
  -- getLightSourceSpotCosCutoff()const
  -- 
  -- setLightSourceConstantAttenuation(const float v)
  -- getLightSourceConstantAttenuation()const
  -- 
  -- setLightSourceLinearAttenuation(const float v)
  -- getLightSourceLinearAttenuation()const
  -- 
  -- setLightSourceQuadraticAttenuation(const float v)
  -- getLightSourceQuadraticAttenuation()const
  -- 
  -- setLightAmbientColor(const btVector3 &color)
  -- getLightAmbientColor()const
  -- 
  -- setMaterialShininess(const float v)
  -- getMaterialShininess()const
  -- 
  -- setFogMaxDistance(const float v)
  -- getFogMaxDistance()const
  -- 
  -- setFogMinDistance(const float v)
  -- getFogMinDistance()const
  -- 
  -- setFogColor(const btVector3 &color)
  -- getFogColor()const
  -- 
  -- setFogDensity(const float v)
  -- getFogDensity()const






















end

test.render = function()
  local transform = test.vars.node:getWorldTransform()

  -- print(transform)
  -- njlic.World.getInstance():getDebugDrawer():editTransform(test.vars.camera, transform)

  test.vars.node:setTransform(transform)
end

return test

