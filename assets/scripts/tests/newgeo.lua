local test = {}

test.create = function()

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
	local path = njlic.ASSET_PATH("models/utah-teapot-lowpoly.obj")
	local f = assert(io.open(path, "r"))
	local objFileData = f:read("*all")
	f:close()
	geometry:load(shader, objFileData, 1, 1)


	local node = njlic.Node.create()
	scene:getRootNode():addChildNode(node)

	node:setGeometry(geometry)
	node:setOrigin(bullet3.btVector3(0,0,2))

	njlic.World.getInstance():setScene(scene)
	
end

test.destroy = function()
end

test.update = function(timeStep)
  njlic.World.getInstance():setBackgroundColor(1.000, 1.000, 0.000)
end

return test

