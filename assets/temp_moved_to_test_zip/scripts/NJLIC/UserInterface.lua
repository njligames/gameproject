local UserInterface = {}
UserInterface.__index = UserInterface

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
    local arg = init or {}

    -- self.backgroundSoundFileName = arg.backgroundSoundFileName or nil
    self.backgroundSound = arg.backgroundSound or nil
    self.playBGSound = true

    self.uiNodes = {}

    self.downUtilityFunctions = {}
    self.upUtilityFunctions = {}
    self.moveUtilityFunctions = {}
    self.cancelledUtilityFunctions = {}
    self.missedUtilityFunctions = {}
end

local __dtor = function(self)
end

local __load = function(self)
    -- if self.backgroundSoundFileName and type(self.backgroundSoundFileName) == "string" then
    --     self.backgroundSound = njlic.Sound.create()
    --     self.backgroundSound:enableLooping()
    --     njlic.World.getInstance():getWorldResourceLoader():load(self.backgroundSoundFileName, self.backgroundSound)
    -- end
end

local __unLoad = function(self)
--TODO: unload this Entity
end

--#############################################################################

function UserInterface:playBackgroundSound()
    self.playBGSound = true
end

function UserInterface:stopBackgroundSound()
    self.playBGSound = false
end

function UserInterface:down(rayContact)
    local id = rayContact:getHitNode():getTag()
    assert(id, "the id is nil")

    if self:isEnabled({id=id}) and self:isVisible({id=id}) then
        local status, err = pcall(self.downUtilityFunctions[id], rayContact)
        if not status then error(err) end

        self.any_ui_touched = true
    end
end

function UserInterface:up(rayContact)
    local id = rayContact:getHitNode():getTag()
    assert(id, "the id is nil")

    if self:isEnabled({id=id}) and self:isVisible({id=id}) then
        local status, err = pcall(self.upUtilityFunctions[id], rayContact)
        if not status then error(err) end

        self.any_ui_touched = false
        for key, value in pairs(self.uiNodes) do
            self.any_ui_touched = self.any_ui_touched or self.uiNodes[key].selected
        end
    end
end

function UserInterface:move(rayContact)
    local id = rayContact:getHitNode():getTag()
    assert(id, "the id is nil")

    if self:isEnabled({id=id}) and self:isVisible({id=id}) then
        local status, err = pcall(self.moveUtilityFunctions[id], rayContact)
        if not status then error(err) end
    end
end

function UserInterface:cancelled(rayContact)
    local id = rayContact:getHitNode():getTag()
    assert(id, "the id is nil")

    if self:isEnabled({id=id}) and self:isVisible({id=id}) then
        local status, err = pcall(self.cancelledUtilityFunctions[id], rayContact)
        if not status then error(err) end
    end
end

function UserInterface:missed(node, deviceTouch)
    local id = node:getTag()
    assert(id, "the id is nil")

    if self:isEnabled({id=id}) and self:isVisible({id=id}) then
        local status, err = pcall(self.missedUtilityFunctions[id], node, deviceTouch)
        if not status then error(err) end
    end
end

function UserInterface:anyTouched()
    return self.any_ui_touched
end

function UserInterface:update(timeStep)
    if self.backgroundSound ~= nil then

        if self.playBGSound then
            if not self.backgroundSound:isPlaying() then
                self.backgroundSound:play()
            end
        else
            if self.backgroundSound:isPlaying() then
                self.backgroundSound:stop()
            end
        end
    end

    for key, value in pairs(self.uiNodes) do

        -- assert(self.uiNodes[key].enabled_changed ~= nil, "enabled_changed value is nil")
        if self.uiNodes[key].enabled_changed ~= nil and true == self.uiNodes[key].enabled_changed then
            self.uiNodes[key].enabled_changed = false

            assert(self.uiNodes[key].enabled ~= nil, "enabled value is nil")
            if true == self.uiNodes[key].enabled then
                assert(self.uiNodes[key].off ~= nil, "off value is nil")
                local status, retValue = pcall(self.uiNodes[key].tp.draw, self.uiNodes[key].tp, {name=self.uiNodes[key].off, node=self.uiNodes[key].node})
                if not status then error(retValue) else self.uiNodes[key].node = retValue end
            elseif false == self.uiNodes[key].enabled then
                assert(self.uiNodes[key].dis ~= nil, "dis value is nil")
                local status, retValue = pcall(self.uiNodes[key].tp.draw, self.uiNodes[key].tp, {name=self.uiNodes[key].dis, node=self.uiNodes[key].node})
                if not status then error(retValue) else self.uiNodes[key].node = retValue end
            end
        end

        -- assert(self.uiNodes[key].selection_changed ~= nil, "selection_changed value is nil")
        if self.uiNodes[key].selection_changed ~= nil and self.uiNodes[key].selection_changed then
            self.uiNodes[key].selection_changed = false

            if self.uiNodes[key].enabled then
                assert(self.uiNodes[key].node ~= nil, "node value is nil")
                assert(self.uiNodes[key].tp ~= nil, "tp value is nil")
                assert(self.uiNodes[key].selected ~= nil, "selected value is nil")
                if true == self.uiNodes[key].selected then
                    assert(self.uiNodes[key].on ~= nil, "on value is nil")
                    local status, retValue = pcall(self.uiNodes[key].tp.draw, self.uiNodes[key].tp, {name=self.uiNodes[key].on, node=self.uiNodes[key].node})
                    if not status then error(retValue) else self.uiNodes[key].node = retValue end
                elseif false == self.uiNodes[key].selected then
                    assert(self.uiNodes[key].off ~= nil, "off value is nil")
                    local status, retValue = pcall(self.uiNodes[key].tp.draw, self.uiNodes[key].tp, {name=self.uiNodes[key].off, node=self.uiNodes[key].node})
                    if not status then error(retValue) else self.uiNodes[key].node = retValue end
                end

                if true == self.uiNodes[key].execute_touch_up then
                    if nil ~= self.uiNodes[key].up then 
                        if nil ~= self.uiNodes[key].soundTouchUpInside then
                            self.uiNodes[key].soundTouchUpInside:play()
                        end

                        local status, err = pcall(self.uiNodes[key].up)
                        if not status then error(err) end
                    end
                    self.uiNodes[key].execute_touch_up = false
                end

                if true == self.uiNodes[key].execute_touch_down then
                    if nil ~= self.uiNodes[key].down then 
                        local status, err = pcall(self.uiNodes[key].down)
                        if not status then error(err) end
                    end
                    self.uiNodes[key].execute_touch_down = false
                end
            end
        end
    end
end

function UserInterface:createImage(...)
    local arg = ... or {}
    local uuid = require "NJLIC.uuid"

    local id = uuid()

    assert(id, "the id is nil")

    local name = arg.name or "?"
    local x = arg.x or 0
    local y = arg.y or 0
    local node = arg.node or nil
    local tag = id
    local tp = arg.tp or nil
    local camera = arg.camera or nil
    local scale = arg.scale or 1.0

    assert(tp ~= nil, "The texture packer is nil")
    assert(camera ~= nil, "The camera is nil")

    local status, retValue, dimension = pcall(tp.draw, tp, {name=name, node=node})
    if not status then error(retValue) else node = retValue end

    assert(node, "node is nil")

    if not njlic.World.getInstance():getScene():getRootNode():hasChildNode(node) then
        njlic.World.getInstance():getScene():getRootNode():addChildNode(node)
    end

    local origin = bullet.btVector3(x, y, -1)
    node:setOrigin(origin)
    node:show(camera)

    node:setTag(tag)
    node:setName(tag)

    node:setScale(scale)

    self.uiNodes[id] = {
        node=node,
        tp=tp,
        selection_changed=false,
        camera=camera,
    }

    self.any_ui_touched = false

    return node, (dimension * scale), id
end

function UserInterface:createButton(...)
    local arg = ... or {}
    local uuid = require "NJLIC.uuid"

    local id = uuid()

    assert(id, "the id is nil")

    local off = arg.off or "?"
    local on = arg.on or "?"
    local dis = arg.dis or "?"
    local x = arg.x or 0
    local y = arg.y or 0
    local node = arg.node or nil
    local tag = id
    local tp = arg.tp or nil
    local camera = arg.camera or nil
    local scale = arg.scale or 1.0
    local down = arg.down or nil
    local up = arg.up or nil
    -- local upSoundFileName = arg.upSoundFileName or nil
    local soundTouchUpInside = arg.soundTouchUpInside or nil
    local enabled = true
    if nil ~= arg.enabled then
        enabled = arg.enabled
    end

    assert(tp ~= nil, "The texture packer is nil")
    assert(camera ~= nil, "The camera is nil")

    local status, retValue, dimension = pcall(tp.draw, tp, {name=off, node=node})
    if not status then error(retValue) else node = retValue end

    assert(node, "node is nil")

    if not njlic.World.getInstance():getScene():getRootNode():hasChildNode(node) then
        njlic.World.getInstance():getScene():getRootNode():addChildNode(node)
    end

    local origin = bullet.btVector3(x, y, -1)
    node:setOrigin(origin)
    node:show(camera)

    local physicsShape = njlic.PhysicsShapeBox.create()

    local physicsBody = njlic.PhysicsBodyRigid.create()
    physicsBody:setStaticPhysics()
    physicsBody:setPhysicsShape(physicsShape)

    node:setPhysicsBody(physicsBody)

    physicsShape:setHalfExtends(bullet.btVector3( dimension:x(), dimension:y(), 1.0 ))

    node:setTag(tag)
    node:setName(tag)

    node:setScale(scale)

    -- local soundTouchUpInside = nil
    -- if upSoundFileName and type(upSoundFileName) == "string" then
    --     soundTouchUpInside = njlic.Sound.create()
    --     njlic.World.getInstance():getWorldResourceLoader():load(upSoundFileName, soundTouchUpInside)
    -- end

    self.uiNodes[id] = {
        node=node,
        off=off,
        on=on,
        dis=dis,
        selected=false,
        enabled=enabled,
        tp=tp,
        execute_touch_down = false,
        execute_touch_up = false,
        down = down,
        up = up,
        selection_changed=true,
        enabled_changed=true,
        camera=camera,
        soundTouchUpInside=soundTouchUpInside,
        address = -1,
    }

    self.any_ui_touched = false

    self.downUtilityFunctions[id] = function(rayContact)
        assert(id, "the id is nil")

        assert(self.uiNodes[id].selected ~= nil, "selected value is nil")

        if false == self.uiNodes[id].selected then
            self.uiNodes[id].selected = true
            self.uiNodes[id].execute_touch_down = true
            self.uiNodes[id].selection_changed = true

            self.address = rayContact:getDeviceTouch():getAddress()
        end
    end

    self.upUtilityFunctions[id] = function(rayContact)
        assert(id, "the id is nil")

        assert(self.uiNodes[id].selected ~= nil, "selected value is nil")

        local addr = rayContact:getDeviceTouch():getAddress()

        if true == self.uiNodes[id].selected and addr == self.address then
            self.uiNodes[id].selected = false
            self.uiNodes[id].execute_touch_up = true
            self.uiNodes[id].selection_changed = true

            self.address = -1
        end
    end

    self.moveUtilityFunctions[id] = function(rayContact)
        assert(id, "the id is nil")

        assert(self.uiNodes[id].selected ~= nil, "selected value is nil")

        local addr = rayContact:getDeviceTouch():getAddress()

        if true == self.uiNodes[id].selected and addr == self.address then
            self.uiNodes[id].selected = true
            self.uiNodes[id].selection_changed = true
        end
    end

    self.cancelledUtilityFunctions[id] = function(rayContact)
        assert(id, "the id is nil")

        assert(self.uiNodes[id].selected ~= nil, "selected value is nil")

        if false == self.uiNodes[id].selected then
            self.uiNodes[id].selected = true
            self.uiNodes[id].selection_changed = true

            self.address = -1
        end
    end

    self.missedUtilityFunctions[id] = function(node, deviceTouch)
        if self.uiNodes[id].node == node then
            assert(id, "the id is nil")

            assert(self.uiNodes[id].selected ~= nil, "selected value is nil")

            local shouldCall = false
            if deviceTouch then
                local addr = deviceTouch:getAddress()
                shouldCall = (addr == self.address)
            end

            if true == self.uiNodes[id].selected and shouldCall then
                self.uiNodes[id].selected = false
                self.uiNodes[id].selection_changed = true
            end
        end
    end

    return node, (dimension * scale), id
end

function UserInterface:destroyButton(...)
    local arg = ... or {}

    local id = self:unRegisterUI(arg)

    if id then
        local node = self.uiNodes[id].node

        local sound = self.uiNodes[id].soundTouchUpInside
        if sound ~= nil then
            njlic.Sound.destroy(sound)
        end
        -- TODO
    end

    self.uiNodes[id] = nil
    self.downUtilityFunctions[id] = nil
    self.upUtilityFunctions[id] = nil
    self.moveUtilityFunctions[id] = nil
    self.cancelledUtilityFunctions[id] = nil
    self.missedUtilityFunctions[id] = nil
end

function UserInterface:enable(...)
    local arg = ... or {}

    assert(arg.id, "no id")
    assert(arg.enabled ~= nil, "no value")

    if nil ~= arg.id and nil ~= self.uiNodes[arg.id] then
        self.uiNodes[arg.id].enabled = arg.enabled
        self.uiNodes[arg.id].enabled_changed = true
    end
end

function UserInterface:isEnabled(...)
    local arg = ... or {}

    local id = arg.id

    if nil ~= id and nil ~= self.uiNodes[id] then
        return self.uiNodes[id].enabled
    end
    return false
end

function UserInterface:isVisible(...)
    local arg = ... or {}

    local id = arg.id

    if nil ~= id and nil ~= self.uiNodes[id] and nil ~= self.uiNodes[id].node and nil ~= self.uiNodes[id].camera then
        return not self.uiNodes[id].node:isHidden(self.uiNodes[id].camera)
    end
    return false
end

function UserInterface:hide(camera)
end

function UserInterface:show(camera)
end

--#############################################################################
--End Custom Code
--#############################################################################


--#############################################################################
--DO NOT EDIT BELOW
--#############################################################################

setmetatable(UserInterface, {
    __call = function (cls, ...)
        local self = setmetatable({}, cls)
        self:_create(...)
        return self
    end,
})

function UserInterface:className()
    return "UserInterface"
end

function UserInterface:class()
    return self
end

function UserInterface:superClass()
    return nil
end

function UserInterface:isa(theClass)
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

function UserInterface:__gc()
    UserInterface._destroy(self)
end

function UserInterface:__tostring()
    local ret = self:className() .. " =\n{\n"

    for pos,val in pairs(self) do
        ret = ret .. "\t" .. "["..pos.."]" .. " => " .. type(val) .. " = " .. tostring(val) .. "\n"
    end

    return ret .. "\n\t" .. tostring_r(getmetatable(self)) .. "\n}"
end

function UserInterface:_destroy()
    assert(not self.__UserInterfaceCalledLoad, "Must unload before you destroy")

    __dtor(self)
end

function UserInterface:_create(init)
    self.__UserInterfaceCalledLoad = false

    __ctor(self, init)
end

function UserInterface:load()
    __load(self)

    self.__UserInterfaceCalledLoad = true
end

function UserInterface:unLoad()
    assert(self.__UserInterfaceCalledLoad, "Must load before unloading")

    __unLoad(self)
    self.__UserInterfaceCalledLoad = false
end

return UserInterface
