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

function envIsAlphaNum(sIn)
    return (string.match(sIn,"[^%w]") == nil)
end

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
        local geometry = self._fonts[i].geometry

        geometry:getMaterial():getDiffuse():unLoadGPU()

        local image = self._fonts[i].image
        njlic.Image.destroy(image)

        local material = self._fonts[i].material
        njlic.Material.destroy(material)

        local shader = self._fonts[i].shader
        njlic.ShaderProgram.destroy(shader)

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
    return self._maxLineHeight
end

function BitmapFont:lineHeight(fontIndex)
    local fi = fontIndex or 1
    if fi  <= #self._fonts then
        return self._fonts[fi].data.info.lineHeight
    end
end

function BitmapFont:getLetterNode(...)
    local arg = ... or {}

    local mainNode = arg.mainNode or nil
    local letterIndex = arg.letterIndex or 1

    if mainNode then
        return mainNode:getChildNode(letterIndex)
    end
    return nil
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

    local spacesInTab = self.spacesInTab or arg.spacesInTab or 2
    local maxwidth = self.maxwidth or arg.maxwidth
    local text = arg.text or tostring(arg)
    local align = self.align or arg.align or "left"

    -- print("the text is", text)

    if arg.align and (arg.align == "left" or arg.align == "center" or arg.align == "right") then
        align = arg.align
    end
    self.align = align
    self.spacesInTab = spacesInTab

    -- local mainNode = self.mainNode or arg.mainNode or njlic.Node.create()
    local mainNode = arg.mainNode or njlic.Node.create()
    mainNode:setName(text)
    -- self.mainNode = mainNode

    local fontIndexTable = {}
    if arg.fontIndexTable then
        for i=1, #arg.fontIndexTable do
            fontIndexTable[i] = arg.fontIndexTable[i] or 1
        end
    else
        if nil == self._fontIndexTable then
            for i=1,string.len(text) do
                fontIndexTable[i] = 1
            end
            self._fontIndexTable = fontIndexTable
        end
    end


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

    local lineWidths = {}
    local currentLine = 1

    local nodeLines = {}
    nodeLines[currentLine] = {}














    local _nodes = {}

    local previous_c = nil
    for c in string.gmatch( text .. '\n', '(.)' ) do
        --
        -- Check for line breaks for maxwidth
        if maxwidth and previous_c then

            local _letterIndex = letterIndex
            local _c = string.sub(text, _letterIndex, _letterIndex)

            if nil ~= fontIndexTable[_letterIndex] and not envIsAlphaNum(previous_c) and envIsAlphaNum(c) then

                local _xCurrent = xCurrent

                repeat
                    local _ascii = string.byte(_c)
                    assert(_letterIndex)
                    assert(fontIndexTable[_letterIndex])
                    assert(self._fonts[fontIndexTable[_letterIndex]])
                    assert(_ascii - 31)
                    assert(self._fonts[fontIndexTable[_letterIndex]].data)
                    assert(self._fonts[fontIndexTable[_letterIndex]].data.frames[_ascii - 31])

                    local _charData = self._fonts[fontIndexTable[_letterIndex]].data.frames[_ascii - 31]
                    local _advance = maxadvance or _charData.xadvance
                    _xCurrent = _xCurrent + _advance

                    _letterIndex = _letterIndex + 1
                    _c = string.sub(text, _letterIndex, _letterIndex)
                until not envIsAlphaNum(_c)

                if _xCurrent >= maxwidth then
                    xCurrent = 0
                    yCurrent = yCurrent + self._fonts[fontIndexTable[_letterIndex]].data.info.base
                end
            end

        end

        local ascii = string.byte(c)
        -- print(ascii, c)

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
            local ypos = (lineHeight - charData.yoffset) - (lineHeight - base) - yCurrent

            local advance = maxadvance or charData.xadvance
            xCurrent = xCurrent + advance
            xMax = math.max(xMax, xCurrent)

            if node then
                -- node:setOrigin(bullet.btVector3(xpos, ypos, 0))

                local _p = {}
                _p["node"] = node
                _p["x"] = xpos
                _p["y"] = ypos
                table.insert(_nodes, _p)

                if not recycleNode then
                    mainNode:addChildNode(node)
                end
            end

            table.insert(nodeLines[currentLine], node)

        else
            -- if LINEFEED
            if ascii == 10 then
                local fontIndex = paramTable.fontIndex or 1
                local lineHeight = self._fonts[fontIndex].data.info.lineHeight
                local base = self._fonts[fontIndex].data.info.base

                lineWidths[currentLine] = xCurrent
                currentLine = currentLine + 1
                nodeLines[currentLine] = {}

                xMax = math.max(xMax, xCurrent)
                xCurrent = 0

                yCurrent = yCurrent + (base)
                yMax = math.max(yMax, yCurrent)

            -- if TAB
            elseif  ascii == 9 then
                paramTable.charValue = " "
                for i=1, self.spacesInTab do
                    charData, node, recycleNode = self:_renderLetter(paramTable)

                    local fontIndex = paramTable.fontIndex or 1
                    local lineHeight = self._fonts[fontIndex].data.info.lineHeight
                    local base = self._fonts[fontIndex].data.info.base

                    local xpos = xCurrent + charData.xoffset
                    local ypos = (lineHeight - charData.yoffset) - (lineHeight - base) - yCurrent

                    local advance = maxadvance or charData.xadvance
                    xCurrent = xCurrent + advance
                    lastXAdvance = advance

                    xMax = math.max(xMax, xCurrent)

                    if node then
                        -- node:setOrigin(bullet.btVector3(xpos, ypos, 0))

                        local _p = {}
                        _p["node"] = node
                        _p["x"] = xpos
                        _p["y"] = ypos
                        table.insert(_nodes, _p)

                        if not recycleNode then
                            mainNode:addChildNode(node)
                        end
                    end
                end
            end
        end

        previous_c = c
        letterIndex = letterIndex + 1
    end
    lineWidths[currentLine] = xCurrent

    local rect =
        {
            x=xStart, y=yStart, width=(xMax - lastXAdvance), height=yMax
        }


    -- print("-- BEGIN --------------------")
    -- if self.align == "center" or self.align == "right" then


        local idx = 1

        local rectCenterX = (rect.width / 2.0)

        for i=1, currentLine do
            local lineCenter = (lineWidths[i] / 2.0)
            local offsetX = 0
            if self.align == "center" then
                offsetX = (rectCenterX - lineCenter)
            elseif self.align == "right" then
                offsetX = (rect.width - lineWidths[i])
            end

            for key,node in pairs(nodeLines[i]) do
                assert(node == _nodes[idx]["node"])

                local xpos = _nodes[idx]["x"]
                local ypos = _nodes[idx]["y"]
                idx = idx + 1

                local newX = xpos + offsetX
                local newY = ypos + rect.height
                node:setOrigin(bullet.btVector3(newX, newY, 0))

            end
            -- print("end of line")
        end

    -- end
    -- print("-- END ----------------------")

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
