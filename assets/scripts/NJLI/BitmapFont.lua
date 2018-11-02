local BitmapFont = {}
BitmapFont.__index = BitmapFont

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

local __ctor = function(self, ...)
  local init = ... or {}

  local fonts = init.names
  local maxadvance=init.maxadvance

  self._maxAdvance = {}
  self._fonts = {}
  self._maxLineHeight = 0
  for i=1,#fonts do
    local font = fonts[i]
    local assetPath = njlic.ASSET_PATH("fonts/" .. font .. ".lua")
    local data = loadfile(assetPath)()

    -- self._maxLineHeight = math.max(self._maxLineHeight, data.common.lineHeight)
    self._maxLineHeight = math.max(self._maxLineHeight, data.info.lineHeight)

    local image = njlic.Image.create()
    assert( njlic.World.getInstance():getWorldResourceLoader():load("fonts/" .. font .. ".png", image) )
    local shader = njlic.ShaderProgram.create()
    assert(njlic.World.getInstance():getWorldResourceLoader():load("shaders/StandardShader.vert", "shaders/StandardShader.frag", shader))
    local material = njlic.Material.create()
    local geometry = njlic.Sprite2D.create()

    geometry:setMaterial(material)
    geometry:load(shader, 10000, 1)

    geometry:getMaterial():getDiffuse():loadGPU(image)

    table.insert(self._fonts, {font=font, image=image, data=data, material=material, shader=shader, geometry=geometry})

    local maxXAdvance = 0
    for k, v in pairs(data.frames) do
      local char = data.frames[k]
      maxXAdvance = math.max(maxXAdvance, char.xadvance)
    end
    self._maxAdvance[data.info.fontface] = maxXAdvance

    local kerningTable = {}

    local kernings = data.kernings or {}
    for kerningIdx=1,#kernings do
      local kerningData = kernings[kerningIdx]
      local firstChar = string.char(kerningData.first)
      local secondChar = string.char(kerningData.second)
      local kerningAmt = kerningData.amount
      local key = firstChar .. secondChar
      kerningTable[key] = kerningAmt
    end

    self._fonts[i].kerningTable = kerningTable
  end
  print_r(self._maxAdvance)
end

local __dtor = function(self)
  for i=1,#self._fonts do
    local image = self._fonts[i].image
    njlic.Image.destroy(image)

    local material = self._fonts[i].material
    njlic.Material.destroy(material)

    local shader = self._fonts[i].shader
    njlic.ShaderProgram.destroy(shader)

    local geometry = self._fonts[i].geometry
    njlic.Sprite2D.destroy(geometry)
  end
  self._fonts = nil
end

local __load = function(self)
end

local __unLoad = function(self)
  --TODO: unload this Entity
end

--############################################################################# 

function BitmapFont:maxLineHeight()
  -- print(self._maxLineHeight)
  return self._maxLineHeight
end

function BitmapFont:lineHeight(fontIndex)
  local fi = fontIndex or 1
  if fi  <= #self._fonts then
      return self._fonts[fi].data.info.lineHeight
  end
end

function BitmapFont:_renderLetter(...)

  local arg = ... or {}
  local mainNode = arg.mainNode or nil
  assert(mainNode, "There must me a main node to attach the letter to.")

  local charValue = arg.charValue or "?"
  local fontIndex = arg.fontIndex or 1

  local ascii = string.byte(charValue) or error("This should be impossible", 1)
  local charData = self._fonts[fontIndex].data.frames[ascii - 31]

  local node = nil
  local recycled = false
  if charData then

    local geometry = self._fonts[fontIndex].geometry

    local letterIndex = arg.letterIndex or 1
    if (letterIndex - 1) < mainNode:numberOfChildrenNodes() then
      node = mainNode:getChildNode(letterIndex - 1)
      recycled = true
    else
      node = njlic.Node.create()
    end

    local letter = {xPivot=0,yPivot=0}

    node:setName(charValue)
    node:setGeometry(geometry)
    
    geometry:setSpriteAtlasFrame(node,
      charData.x,
      charData.y,
      charData.width,
      charData.height)

    geometry:setDimensions(node,
      bullet.btVector2( charData.width*2, charData.height*2),
      bullet.btVector2( letter.xPivot, letter.yPivot ))

  end

  return charData, node, recycled

end

function BitmapFont:_renderNewline(...)
  print('render new line')
end

function BitmapFont:hide(camera)
  self._hiddenCamera=camera

  for i=1,#self._fonts do
    local geometry = self._fonts[i].geometry
    if geometry then
      geometry:hide(camera)
    end
  end
end

function BitmapFont:show(camera)
  self._showCamera=camera
print("BitmapFont:show(camera)")
  for i=1,#self._fonts do
    local geometry = self._fonts[i].geometry
    if geometry then
      geometry:show(camera)
    end
  end
end

function BitmapFont:updateFont(...)
  local arg = ... or {}

  local node = arg.node
  local fontIndexTable = arg.fontIndexTable 
  local align = arg.align or "left"

  local arg =
  {
    mainNode=node,
    text=node:getName(),
    align=align or "left"
  }

  print_r(arg)
end

function BitmapFont:printf(...)
	local arg = ... or {}

	local text = arg.text or "???"
	local align = arg.align or "left"

	if arg.align and (arg.align == "left" or arg.align == "center" or arg.align == "right") then
		align = arg.align
	end

  local mainNode = arg.mainNode or njlic.Node.create()
  mainNode:setName(text)

  local fontIndexTable = {}
  if arg.fontIndexTable then
    for i=1, #arg.fontIndexTable do
      fontIndexTable[i] = arg.fontIndexTable[i] or 1
    end
  else
    for i=1,string.len(text) do
      fontIndexTable[i] = 1
    end
  end
  self._fontIndexTable = fontIndexTable

  local spacesInTab = arg.spacesInTab or 2

  local xStart, yStart = 0, 0
  --TODO: Calculate the starting position based on the justification
  local letterIndex = 1

  local xCurrent, yCurrent = xStart, yStart

  local node = nil
  local charData = nil
  local recycleNode = false
  local xMax, yMax = 0, self._maxLineHeight
  local lastXAdvance=0

  for i=0,mainNode:numberOfChildrenNodes() do 
    local letterIndex=i+1
    local paramTable =
    {
      mainNode = mainNode,
      letterIndex = letterIndex,
      charValue = " ",
      fontIndex = fontIndexTable[letterIndex]
    }
    charData, node, recycleNode = self:_renderLetter(paramTable)
  end

	for c in string.gmatch( text .. '\n', '(.)' ) do
    local ascii = string.byte(c)

    local paramTable =
    {
      mainNode = mainNode,
      letterIndex = letterIndex,
      charValue = c,
      fontIndex = fontIndexTable[letterIndex]
    }

    if (ascii >= 32 and ascii <= 126) then
      charData, node, recycleNode = self:_renderLetter(paramTable)

      local fontIndex = paramTable.fontIndex or 1
      local lineHeight = self._fonts[fontIndex].data.info.lineHeight
      local base = self._fonts[fontIndex].data.info.base

      local xpos = xCurrent + charData.xoffset
      -- local ypos = (lineHeight - charData.yoffset) - charData.height - (lineHeight - base) - yCurrent
      local ypos = (lineHeight - charData.yoffset) - (lineHeight - base) - yCurrent

      local advance = maxadvance or charData.xadvance
      xCurrent = xCurrent + advance
      xMax = math.max(xMax, xCurrent)

      if node then
        node:setOrigin(bullet.btVector3(xpos, ypos, 0))
        if not recycleNode then
          mainNode:addChildNode(node)
        end
      end
    else
      -- if LINEFEED
      if ascii == 10 then
        -- xOffset, yOffset, xAdvance = self:_renderNewline(paramTable)
      -- if TAB
      elseif  ascii == 9 then
        paramTable.charValue = " "
        for i=1, spacesInTab do
          charData, node, recycleNode = self:_renderLetter(paramTable)

          local fontIndex = paramTable.fontIndex or 1
          local lineHeight = self._fonts[fontIndex].data.info.lineHeight
          local base = self._fonts[fontIndex].data.info.base

          local xpos = xCurrent + charData.xoffset
          -- local ypos = (lineHeight - charData.yoffset) - charData.height - (lineHeight - base) - yCurrent
          local ypos = (lineHeight - charData.yoffset) - (lineHeight - base) - yCurrent

          local advance = maxadvance or charData.xadvance
          xCurrent = xCurrent + advance
          lastXAdvance = advance

          xMax = math.max(xMax, xCurrent)

          if node then
            node:setOrigin(bullet.btVector3(xpos, ypos, 0))
            if not recycleNode then
              mainNode:addChildNode(node)
            end
          end
        end
      end
    end

    letterIndex = letterIndex + 1
	end

  local rect =
  {
    x=xStart, y=yStart, width=(xMax - lastXAdvance), height=yMax
  }

  return mainNode, rect
end

--############################################################################# 
--End Custom Code
--#############################################################################


--#############################################################################
--DO NOT EDIT BELOW
--#############################################################################

setmetatable(BitmapFont, {
    __call = function (cls, ...)
      local self = setmetatable({}, cls)
      self:_create(...)
      return self
    end,
  })

function BitmapFont:className()
  return "BitmapFont"
end

function BitmapFont:class()
  return self
end

function BitmapFont:superClass()
  return nil
end

function BitmapFont:isa(theClass)
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

function BitmapFont:__gc()
  BitmapFont._destroy(self)
end

function BitmapFont:__tostring()
  local ret = self:className() .. " =\n{\n"
  
  for pos,val in pairs(self) do 
    ret = ret .. "\t" .. "["..pos.."]" .. " => " .. type(val) .. " = " .. tostring(val) .. "\n"
  end

  return ret .. "\n\t" .. tostring_r(getmetatable(self)) .. "\n}"
end

function BitmapFont:_destroy()
  assert(not self.__BitmapFontCalledLoad, "Must unload before you destroy")
  
  __dtor(self)
end

function BitmapFont:_create(init)
  self.__BitmapFontCalledLoad = false
  
  __ctor(self, init)
end

function BitmapFont:load()
  __load(self)
  
  self.__BitmapFontCalledLoad = true
end

function BitmapFont:unLoad()
  assert(self.__BitmapFontCalledLoad, "Must load before unloading")
  
  __unLoad(self)
  self.__BitmapFontCalledLoad = false
end

return BitmapFont
