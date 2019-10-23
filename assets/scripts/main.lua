require "NJLIC.util"

local BitmapFont = require 'NJLIC.BitmapFont'
local TexturePacker = require "NJLIC.TexturePacker"
local UserInterface = require "NJLIC.UserInterface"

local YappyBirdFont = BitmapFont({
    names={
        "Ranchers", 
    },
    maxadvance=160
})

-- local function DrawButton(...)
--     local arg = ... or {}
-- 
--     local name = arg.name or "butn_pause_off"
--     local x = arg.x or 0
--     local y = arg.y or 0
--     local node = arg.node or nil
--     local tag = arg.tag or "pause button"
--     local tp = arg.tp or nil
--     local camera = arg.camera or nil
--     local scale = arg.scale or 10.0
-- 
--     assert(tp ~= nil, "The texture packer is nil")
--     assert(camera ~= nil, "The camera is nil")
-- 
--     local node, dimension = tp:draw({name=name, node=node})
-- 
--     if not njlic.World.getInstance():getScene():getRootNode():hasChildNode(node) then
--         njlic.World.getInstance():getScene():getRootNode():addChildNode(node)
--     end
-- 
--     local origin = bullet.btVector3(x, y, -1)
--     node:setOrigin(origin)
--     node:show(camera)
-- 
--     local physicsShape = njlic.PhysicsShapeBox.create()
-- 
--     local physicsBody = njlic.PhysicsBodyRigid.create()
--     physicsBody:setStaticPhysics()
--     physicsBody:setPhysicsShape(physicsShape)
-- 
--     node:setPhysicsBody(physicsBody)
-- 
--     physicsShape:setHalfExtends(bullet.btVector3( dimension:x(), dimension:y(), 1.0 ))
-- 
--     node:setTag(tag)
-- 
--     node:setScale(scale)
-- 
--     return node
-- end
--

        -- self.sound = njlic.Sound.create()
        -- self.sound:setName(string.format("%sbird_beak_sound_%05d", self.birdName, self.index))
        -- local soundName = "sounds/projectile_balloon_water-splash.ogg"
        -- njlic.World.getInstance():getWorldResourceLoader():load(soundName, self.sound)

local YappyBirdsSound = {
    new = function(...)
        local arg = ... or {}

        local object = {

        }

        function object:load(...)
            local arg = ... or {}

            self.chubibird_death1 = njlic.Sound.create()
            njlic.World.getInstance():getWorldResourceLoader():load("sounds/chubibird_death1.ogg", self.chubibird_death1)

            self.chubibird_death2 = njlic.Sound.create()
            njlic.World.getInstance():getWorldResourceLoader():load("sounds/chubibird_death2.ogg", self.chubibird_death2)

            self.chubibird_taunt1 = njlic.Sound.create()
            njlic.World.getInstance():getWorldResourceLoader():load("sounds/chubibird_taunt1.ogg", self.chubibird_taunt1)

            self.chubibird_taunt2 = njlic.Sound.create()
            njlic.World.getInstance():getWorldResourceLoader():load("sounds/chubibird_taunt2.ogg", self.chubibird_taunt2)

            self.chubibird_taunt3 = njlic.Sound.create()
            njlic.World.getInstance():getWorldResourceLoader():load("sounds/chubibird_taunt3.ogg", self.chubibird_taunt3)

            self.chubibird_taunt4 = njlic.Sound.create()
            njlic.World.getInstance():getWorldResourceLoader():load("sounds/chubibird_taunt4.ogg", self.chubibird_taunt4)

            self.dog_bark1 = njlic.Sound.create()
            njlic.World.getInstance():getWorldResourceLoader():load("sounds/dog_bark1.ogg", self.dog_bark1)

            self.dog_bark2 = njlic.Sound.create()
            njlic.World.getInstance():getWorldResourceLoader():load("sounds/dog_bark2.ogg", self.dog_bark2)

            self.dog_howl1 = njlic.Sound.create()
            njlic.World.getInstance():getWorldResourceLoader():load("sounds/dog_howl1.ogg", self.dog_howl1)

            self.dog_whine1 = njlic.Sound.create()
            njlic.World.getInstance():getWorldResourceLoader():load("sounds/dog_whine1.ogg", self.dog_whine1)

            self.gameplay_powerup_pickup = njlic.Sound.create()
            njlic.World.getInstance():getWorldResourceLoader():load("sounds/gameplay_powerup_pickup.ogg", self.gameplay_powerup_pickup)

            self.garubird_death1 = njlic.Sound.create()
            njlic.World.getInstance():getWorldResourceLoader():load("sounds/garubird_death1.ogg", self.garubird_death1)

            self.garubird_death2 = njlic.Sound.create()
            njlic.World.getInstance():getWorldResourceLoader():load("sounds/garubird_death2.ogg", self.garubird_death2)

            self.garubird_taunt1 = njlic.Sound.create()
            njlic.World.getInstance():getWorldResourceLoader():load("sounds/garubird_taunt1.ogg", self.garubird_taunt1)

            self.garubird_taunt2 = njlic.Sound.create()
            njlic.World.getInstance():getWorldResourceLoader():load("sounds/garubird_taunt2.ogg", self.garubird_taunt2)

            self.garubird_taunt3 = njlic.Sound.create()
            njlic.World.getInstance():getWorldResourceLoader():load("sounds/garubird_taunt3.ogg", self.garubird_taunt3)

            self.garubird_taunt4 = njlic.Sound.create()
            njlic.World.getInstance():getWorldResourceLoader():load("sounds/garubird_taunt4.ogg", self.garubird_taunt4)

            self.garubird_taunt5 = njlic.Sound.create()
            njlic.World.getInstance():getWorldResourceLoader():load("sounds/garubird_taunt5.ogg", self.garubird_taunt5)

            self.garubird_taunt6 = njlic.Sound.create()
            njlic.World.getInstance():getWorldResourceLoader():load("sounds/garubird_taunt6.ogg", self.garubird_taunt6)

            self.interface_gameplay_theme = njlic.Sound.create()
            njlic.World.getInstance():getWorldResourceLoader():load("sounds/interface_gameplay_theme.ogg", self.interface_gameplay_theme)

            self.interface_menu_theme = njlic.Sound.create()
            njlic.World.getInstance():getWorldResourceLoader():load("sounds/interface_menu_theme.ogg", self.interface_menu_theme)
            self.interface_menu_theme:enableLooping()

            self.interface_previous_click = njlic.Sound.create()
            njlic.World.getInstance():getWorldResourceLoader():load("sounds/interface_previous_click.ogg", self.interface_previous_click)

            self.interface_select_whoosh = njlic.Sound.create()
            njlic.World.getInstance():getWorldResourceLoader():load("sounds/interface_select_whoosh.ogg", self.interface_select_whoosh)

            self.interface_title_theme = njlic.Sound.create()
            njlic.World.getInstance():getWorldResourceLoader():load("sounds/interface_title_theme.ogg", self.interface_title_theme)

            self.momibird_death1 = njlic.Sound.create()
            njlic.World.getInstance():getWorldResourceLoader():load("sounds/momibird_death1.ogg", self.momibird_death1)

            self.momibird_taunt1 = njlic.Sound.create()
            njlic.World.getInstance():getWorldResourceLoader():load("sounds/momibird_taunt1.ogg", self.momibird_taunt1)

            self.momibird_taunt2 = njlic.Sound.create()
            njlic.World.getInstance():getWorldResourceLoader():load("sounds/momibird_taunt2.ogg", self.momibird_taunt2)

            self.momibird_taunt3 = njlic.Sound.create()
            njlic.World.getInstance():getWorldResourceLoader():load("sounds/momibird_taunt3.ogg", self.momibird_taunt3)

            self.momibird_taunt4 = njlic.Sound.create()
            njlic.World.getInstance():getWorldResourceLoader():load("sounds/momibird_taunt4.ogg", self.momibird_taunt4)

            self.projectile_balloon_water_splash = njlic.Sound.create()
            njlic.World.getInstance():getWorldResourceLoader():load("sounds/projectile_balloon_water_splash.ogg", self.projectile_balloon_water_splash)

            self.puffybird_death1 = njlic.Sound.create()
            njlic.World.getInstance():getWorldResourceLoader():load("sounds/puffybird_death1.ogg", self.puffybird_death1)

            self.puffybird_death2 = njlic.Sound.create()
            njlic.World.getInstance():getWorldResourceLoader():load("sounds/puffybird_death2.ogg", self.puffybird_death2)

            self.puffybird_taunt1 = njlic.Sound.create()
            njlic.World.getInstance():getWorldResourceLoader():load("sounds/puffybird_taunt1.ogg", self.puffybird_taunt1)

            self.puffybird_taunt2 = njlic.Sound.create()
            njlic.World.getInstance():getWorldResourceLoader():load("sounds/puffybird_taunt2.ogg", self.puffybird_taunt2)

            self.puffybird_taunt3 = njlic.Sound.create()
            njlic.World.getInstance():getWorldResourceLoader():load("sounds/puffybird_taunt3.ogg", self.puffybird_taunt3)

            self.puffybird_taunt4 = njlic.Sound.create()
            njlic.World.getInstance():getWorldResourceLoader():load("sounds/puffybird_taunt4.ogg", self.puffybird_taunt4)

            self.puffybird_taunt5 = njlic.Sound.create()
            njlic.World.getInstance():getWorldResourceLoader():load("sounds/puffybird_taunt5.ogg", self.puffybird_taunt5)

            self.webobird_death1 = njlic.Sound.create()
            njlic.World.getInstance():getWorldResourceLoader():load("sounds/webobird_death1.ogg", self.webobird_death1)

            self.webobird_taunt1 = njlic.Sound.create()
            njlic.World.getInstance():getWorldResourceLoader():load("sounds/webobird_taunt1.ogg", self.webobird_taunt1)

            self.webobird_taunt2 = njlic.Sound.create()
            njlic.World.getInstance():getWorldResourceLoader():load("sounds/webobird_taunt2.ogg", self.webobird_taunt2)

            self.webobird_taunt3 = njlic.Sound.create()
            njlic.World.getInstance():getWorldResourceLoader():load("sounds/webobird_taunt3.ogg", self.webobird_taunt3)

            self.webobird_taunt4 = njlic.Sound.create()
            njlic.World.getInstance():getWorldResourceLoader():load("sounds/webobird_taunt4.ogg", self.webobird_taunt4)

            self.zurubird_death1 = njlic.Sound.create()
            njlic.World.getInstance():getWorldResourceLoader():load("sounds/zurubird_death1.ogg", self.zurubird_death1)

            self.zurubird_death2 = njlic.Sound.create()
            njlic.World.getInstance():getWorldResourceLoader():load("sounds/zurubird_death2.ogg", self.zurubird_death2)

            self.zurubird_taunt1 = njlic.Sound.create()
            njlic.World.getInstance():getWorldResourceLoader():load("sounds/zurubird_taunt1.ogg", self.zurubird_taunt1)

            self.zurubird_taunt2 = njlic.Sound.create()
            njlic.World.getInstance():getWorldResourceLoader():load("sounds/zurubird_taunt2.ogg", self.zurubird_taunt2)

            self.zurubird_taunt3 = njlic.Sound.create()
            njlic.World.getInstance():getWorldResourceLoader():load("sounds/zurubird_taunt3.ogg", self.zurubird_taunt3)

            self.zurubird_taunt4 = njlic.Sound.create()
            njlic.World.getInstance():getWorldResourceLoader():load("sounds/zurubird_taunt4.ogg", self.zurubird_taunt4)

            self.zurubird_taunt5 = njlic.Sound.create()
            njlic.World.getInstance():getWorldResourceLoader():load("sounds/zurubird_taunt5.ogg", self.zurubird_taunt5)
        end

        function object:unload(...)
            local arg = ... or {}

            njlic.Sound.destroy(self.chubibird_death1)
            njlic.Sound.destroy(self.chubibird_death2)
            njlic.Sound.destroy(self.chubibird_taunt1)
            njlic.Sound.destroy(self.chubibird_taunt2)
            njlic.Sound.destroy(self.chubibird_taunt3)
            njlic.Sound.destroy(self.chubibird_taunt4)
            njlic.Sound.destroy(self.dog_bark1)
            njlic.Sound.destroy(self.dog_bark2)
            njlic.Sound.destroy(self.dog_howl1)
            njlic.Sound.destroy(self.dog_whine1)
            njlic.Sound.destroy(self.gameplay_powerup_pickup)
            njlic.Sound.destroy(self.garubird_death1)
            njlic.Sound.destroy(self.garubird_death2)
            njlic.Sound.destroy(self.garubird_taunt1)
            njlic.Sound.destroy(self.garubird_taunt2)
            njlic.Sound.destroy(self.garubird_taunt3)
            njlic.Sound.destroy(self.garubird_taunt4)
            njlic.Sound.destroy(self.garubird_taunt5)
            njlic.Sound.destroy(self.garubird_taunt6)
            njlic.Sound.destroy(self.interface_gameplay_theme)
            njlic.Sound.destroy(self.interface_menu_theme)
            njlic.Sound.destroy(self.interface_previous_click)
            njlic.Sound.destroy(self.interface_select_whoosh)
            njlic.Sound.destroy(self.interface_title_theme)
            njlic.Sound.destroy(self.momibird_death1)
            njlic.Sound.destroy(self.momibird_taunt1)
            njlic.Sound.destroy(self.momibird_taunt2)
            njlic.Sound.destroy(self.momibird_taunt3)
            njlic.Sound.destroy(self.momibird_taunt4)
            njlic.Sound.destroy(self.projectile_balloon_water_splash)
            njlic.Sound.destroy(self.puffybird_death1)
            njlic.Sound.destroy(self.puffybird_death2)
            njlic.Sound.destroy(self.puffybird_taunt1)
            njlic.Sound.destroy(self.puffybird_taunt2)
            njlic.Sound.destroy(self.puffybird_taunt3)
            njlic.Sound.destroy(self.puffybird_taunt4)
            njlic.Sound.destroy(self.puffybird_taunt5)
            njlic.Sound.destroy(self.webobird_death1)
            njlic.Sound.destroy(self.webobird_taunt1)
            njlic.Sound.destroy(self.webobird_taunt2)
            njlic.Sound.destroy(self.webobird_taunt3)
            njlic.Sound.destroy(self.webobird_taunt4)
            njlic.Sound.destroy(self.zurubird_death1)
            njlic.Sound.destroy(self.zurubird_death2)
            njlic.Sound.destroy(self.zurubird_taunt1)
            njlic.Sound.destroy(self.zurubird_taunt2)
            njlic.Sound.destroy(self.zurubird_taunt3)
            njlic.Sound.destroy(self.zurubird_taunt4)
            njlic.Sound.destroy(self.zurubird_taunt5)
        end

        return object
    end
}
local YappyBirdUi = {
    new = function(...)
        local arg=... or {}

        local camera = arg.camera or nil
        local game = arg.game or nil

        assert(camera ~= nil, "camera is nil")
        assert(game ~= nil, "camera is nil")

        local object = {
            orthographicCamera = camera,
            interfaceTexturePacker = TexturePacker({file="interface0"}),
            -- ui = UserInterface({backgroundSoundFileName="sounds/interface_menu-theme.ogg"}),

            ui = UserInterface({backgroundSound=game.ybSound.interface_menu_theme}),
            game = game
        }

        local createUiBackdrop = function(UI, texturePacker, camera)
          local uiImage, uiImageRect, uiImageId = UI:createImage({
              name = "ui_background_tile",
              x = 200, 
              y = 200, 
              node = njlic.Node.create(), 
              tp = texturePacker, 
              camera = camera,
              scale = 7,
          })
          local width = (uiImageRect:x() / 3.0) 
          local height = (uiImageRect:y() / 3.0) 
          uiImage:setOrigin(
          bullet.btVector3(0.0 , njlic.SCREEN():y() * 0.5, 10)
          )

          local uiImage2, uiImageRect2, uiImageId2 = UI:createImage({
              name = "ui_background_tile",
              x = 200, 
              y = 200, 
              node = njlic.Node.create(), 
              tp = texturePacker, 
              camera = camera,
              scale = 7,
          })
          uiImage2:setOrigin(
          bullet.btVector3(width , njlic.SCREEN():y() * 0.5, 10)
          )

          local uiImage3, uiImageRect3, uiImageId3 = UI:createImage({
              name = "ui_background_tile",
              x = 200, 
              y = 200, 
              node = njlic.Node.create(), 
              tp = texturePacker, 
              camera = camera,
              scale = 7,
          })
          uiImage3:setOrigin(
          bullet.btVector3(width * 2, njlic.SCREEN():y() * 0.5, 10)
          )

          return {uiImage, uiImage2, uiImage3}
      end

      local createWin = function(UI, texturePacker, camera, result, object)
          local object = object

          local uiNodes = createUiBackdrop(UI, texturePacker, camera)

          local vert_margin = njlic.SCREEN():y() / 30.0
          local horiz_margin = njlic.SCREEN():x() / 60.0

          local restartButton, restartButtonRect, restartButtonId = UI:createButton({
              off = "butn_RESTART_off", 
              on = "butn_RESTART_on", 
              dis = "butn_RESTART_dis", 
              x = 200, 
              y = 200, 
              node = njlic.Node.create(), 
              tp = texturePacker, 
              camera = camera,
              down = function() 
              end,
              up = function()
                  if object.level <= 15 and object.level >= 1 then
                      object:playGame()
                  end
              end,
              scale = 7,
              enabled = true,
              --upSoundFileName = "sounds/interface_select-whoosh.ogg",
              soundTouchUpInside = object.game.ybSound.interface_select_whoosh,
          })
          local width = (restartButtonRect:x() / 3.0) 
          local height = (restartButtonRect:y() / 3.0) 
          restartButton:setOrigin(
          bullet.btVector3((vert_margin * 1) + width , (vert_margin * 1) + height, -1)
          )
          table.insert(uiNodes, restartButton)

          local quitButton, quitButtonRect, quitButtonId = UI:createButton({
              off = "butn_QUIT_off", 
              on = "butn_QUIT_on", 
              x = 200, 
              y = 200, 
              node = njlic.Node.create(), 
              tp = texturePacker, 
              camera = camera,
              down = function() 
              end,
              up = function()
                  object:showSplash()
              end,
              scale = 7,
              enabled = true,
              --upSoundFileName = "sounds/interface_select-whoosh.ogg",
              soundTouchUpInside = object.game.ybSound.interface_select_whoosh,
          })
          local width = (quitButtonRect:x() / 3.0) 
          local height = (quitButtonRect:y() / 3.0) 
          quitButton:setOrigin(
          bullet.btVector3(njlic.SCREEN():x() * 0.5 , (vert_margin * 1) + height, -1)
          )
          table.insert(uiNodes, quitButton)

          -- if object.level < 19 then
              local nextLevelButton, nextLevelButtonRect, nextLevelButtonId = UI:createButton({
                  off = "butn_NEXT_LEVEL_off", 
                  on = "butn_NEXT_LEVEL_on", 
                  x = 200, 
                  y = 200, 
                  node = njlic.Node.create(), 
                  tp = texturePacker, 
                  camera = camera,
                  down = function() 
                  end,
                  up = function()
                      if object.level < 15 and object.level >= 1 then
                          object.level = object.level + 1
                          object:playGame()
                      end
                  end,
                  scale = 7,
                  enabled = true,
                  --upSoundFileName = "sounds/interface_select-whoosh.ogg",
                  soundTouchUpInside = object.game.ybSound.interface_select_whoosh,
              })
              local width = (nextLevelButtonRect:x() / 3.0) 
              local height = (nextLevelButtonRect:y() / 3.0) 
              nextLevelButton:setOrigin(
              bullet.btVector3(njlic.SCREEN():x() - ((vert_margin * 1) + width) , (vert_margin * 1) + height, -1)
              )
              table.insert(uiNodes, nextLevelButton)
          -- end

          local uiCaption, uiCaptionRect, uiCaptionId = UI:createImage({
              name = "text_YOU_WIN",
              x = 200, 
              y = 200, 
              node = njlic.Node.create(), 
              tp = texturePacker, 
              camera = camera,
              scale = 7,
          })
          local width = (uiCaptionRect:x() / 3.0) 
          local height = (uiCaptionRect:y() / 3.0) 
          uiCaption:setOrigin(
          bullet.btVector3(njlic.SCREEN():x() * 0.5 , njlic.SCREEN():y() * 0.85, -1)
          )
          table.insert(uiNodes, uiCaption)

          return uiNodes
      end

      local createLose = function(UI, texturePacker, camera, result, object)
          local object = object

          local uiNodes = createUiBackdrop(UI, texturePacker, camera)

          local vert_margin = njlic.SCREEN():y() / 30.0
          local horiz_margin = njlic.SCREEN():x() / 60.0

          local restartButton, restartButtonRect, restartButtonId = UI:createButton({
              off = "butn_RESTART_off", 
              on = "butn_RESTART_on", 
              dis = "butn_RESTART_dis", 
              x = 200, 
              y = 200, 
              node = njlic.Node.create(), 
              tp = texturePacker, 
              camera = camera,
              down = function() 
              end,
              up = function()
                  if object.level <= 15 and object.level >= 1 then
                      object:playGame()
                  end
              end,
              scale = 7,
              enabled = true,
              --upSoundFileName = "sounds/interface_select-whoosh.ogg",
              soundTouchUpInside = object.game.ybSound.interface_select_whoosh,
          })
          local width = (restartButtonRect:x() / 3.0) 
          local height = (restartButtonRect:y() / 3.0) 
          restartButton:setOrigin(
          bullet.btVector3((vert_margin * 1) + width , (vert_margin * 1) + height, -1)
          )
          table.insert(uiNodes, restartButton)

          local quitButton, quitButtonRect, quitButtonId = UI:createButton({
              off = "butn_QUIT_off", 
              on = "butn_QUIT_on", 
              x = 200, 
              y = 200, 
              node = njlic.Node.create(), 
              tp = texturePacker, 
              camera = camera,
              down = function() 
              end,
              up = function()
                  object:showSplash()
              end,
              scale = 7,
              enabled = true,
              --upSoundFileName = "sounds/interface_select-whoosh.ogg",
              soundTouchUpInside = object.game.ybSound.interface_select_whoosh,
          })
          local width = (quitButtonRect:x() / 3.0) 
          local height = (quitButtonRect:y() / 3.0) 
          quitButton:setOrigin(
          bullet.btVector3(njlic.SCREEN():x() * 0.5 , (vert_margin * 1) + height, -1)
          )
          table.insert(uiNodes, quitButton)

          local uiCaption, uiCaptionRect, uiCaptionId = UI:createImage({
              name = "text_YOU_LOSE",
              x = 200, 
              y = 200, 
              node = njlic.Node.create(), 
              tp = texturePacker, 
              camera = camera,
              scale = 7,
          })
          local width = (uiCaptionRect:x() / 3.0) 
          local height = (uiCaptionRect:y() / 3.0) 
          uiCaption:setOrigin(
          bullet.btVector3(njlic.SCREEN():x() * 0.5 , njlic.SCREEN():y() * 0.85, -1)
          )
          table.insert(uiNodes, uiCaption)

          return uiNodes

      end

      local createBoardSelect = function(UI, texturePacker, camera, object)
          local object = object

          local uiNodes = createUiBackdrop(UI, texturePacker, camera)

          local vert_margin = njlic.SCREEN():y() / 30.0
          local horiz_margin = njlic.SCREEN():x() / 60.0

          -- local backbutton = createBackButton(UI, texturePacker, camera)
          -- table.insert(uiNodes, backbutton)
          local vert_margin = njlic.SCREEN():y() / 30.0
          local horiz_margin = njlic.SCREEN():x() / 60.0

          local backButton, backButtonRect, backButtonId = UI:createButton({
              off = "butn_BACK_off", 
              on = "butn_BACK_on", 
              x = 200, 
              y = 200, 
              node = njlic.Node.create(), 
              tp = texturePacker, 
              camera = camera,
              down = function() 
              end,
              up = function()
                  object:showLevelSelect()
              end,
              scale = 7,
              enabled = true,
              --upSoundFileName = "sounds/interface_select-whoosh.ogg",
              soundTouchUpInside = object.game.ybSound.interface_previous_click,
          })
          local width = (backButtonRect:x() / 3.0) 
          local height = (backButtonRect:y() / 3.0) 
          backButton:setOrigin(
          bullet.btVector3((vert_margin * 1) + width , (vert_margin * 1) + height, -1)
          )
          table.insert(uiNodes, backButton)

          local num_rows = 3
          local num_columns = 5
          local width_div = (njlic.SCREEN():x() - (horiz_margin * 2.0)) / num_columns
          local height_div = ((njlic.SCREEN():y() * 0.66) - (vert_margin * 2.0)) / num_rows
          local row = 0
          local column = 0
          local total_margin_width = (width_div * num_columns)
          local centered_x = (njlic.SCREEN():x() - total_margin_width) * 2.0

          local boardSelectIds = {}
          for i=1,(num_rows * num_columns) do 
              local enabled = false
              local button, buttonRect, buttonId = UI:createButton({
                  off = "butn_stage_off", 
                  on = "butn_stage_on", 
                  dis = "butn_stage_dis", 
                  x = 200, 
                  y = 200, 
                  node = njlic.Node.create(), 
                  tp = texturePacker, 
                  camera = camera,
                  down = function() 
                      -- print(string.format("stage button %d - down", i))
                  end,
                  up = function()
                      -- print(string.format("stage button %s, %d - up", object.stage, i))
                      object.level = i
                      if object.level <= 15 and object.level >= 1 then
                          object:playGame()
                      end
                  end,
                  scale = 7,
                  enabled = enabled,
                  --upSoundFileName = "sounds/interface_select-whoosh.ogg",
                  soundTouchUpInside = object.game.ybSound.interface_select_whoosh,
              })
              local width = (buttonRect:x() / 3.5) 
              local height = (buttonRect:y() / 3.5) 

              button:setOrigin(
              bullet.btVector3(centered_x + width + (width_div * column), njlic.SCREEN():y() - height - (height_div * row) - vert_margin, -1)
              )
              table.insert(uiNodes, button)
              boardSelectIds[i] = buttonId
              
              if (column + 1) >= num_columns then
                  column = 0
                  row = row + 1
              else
                  column = column + 1
              end
          end

          return uiNodes, boardSelectIds
      end


      local createSplashScreen = function(UI, texturePacker, camera, object)
          local object = object

          local uiNodes = createUiBackdrop(UI, texturePacker, camera)

          local playButton, playButtonRect, playButtonId = UI:createButton({
              off = "butn_PLAY_off", 
              on = "butn_PLAY_on", 
              dis = "butn_PLAY_dis", 
              x = 200, 
              y = 200, 
              node = njlic.Node.create(), 
              tp = texturePacker, 
              camera = camera,
              down = function() 
                  -- print("playdown")
              end,
              up = function()
                  object:showStageSelect()
              end,
              scale = 7,
              enabled = true,
              --upSoundFileName = "sounds/interface_select-whoosh.ogg",
              soundTouchUpInside = object.game.ybSound.interface_select_whoosh,
          })
          local width = (playButtonRect:x() / 3.0) 
          local height = (playButtonRect:y() / 3.0) 
          playButton:setOrigin(
          bullet.btVector3(njlic.SCREEN():x() * 0.5 , njlic.SCREEN():y() * 0.25, -1)
          )
          table.insert(uiNodes, playButton)


          local uiLogo, uiLogoRect, uiLogoId = UI:createImage({
              name = "logo_yb",
              x = 200, 
              y = 200, 
              node = njlic.Node.create(), 
              tp = texturePacker, 
              camera = camera,
              scale = 7,
          })
          local width = (uiLogoRect:x() / 3.0) 
          local height = (uiLogoRect:y() / 3.0) 
          uiLogo:setOrigin(
          bullet.btVector3(njlic.SCREEN():x() * 0.5 , njlic.SCREEN():y() * 0.5, -1)
          )
          table.insert(uiNodes, uiLogo)

          return uiNodes
      end

      local createLevelSelect = function(UI, texturePacker, camera, object)
          local object = object

          local uiNodes = createUiBackdrop(UI, texturePacker, camera)

          local vert_margin = njlic.SCREEN():y() / 30.0
          local horiz_margin = njlic.SCREEN():x() / 60.0

          -- local backbutton = createBackButton(UI, texturePacker, camera)
          -- table.insert(uiNodes, backbutton)
          local vert_margin = njlic.SCREEN():y() / 30.0
          local horiz_margin = njlic.SCREEN():x() / 60.0

          local backButton, backButtonRect, backButtonId = UI:createButton({
              off = "butn_BACK_off", 
              on = "butn_BACK_on", 
              x = 200, 
              y = 200, 
              node = njlic.Node.create(), 
              tp = texturePacker, 
              camera = camera,
              down = function() 
              end,
              up = function()
                  object:showStageSelect()
              end,
              scale = 7,
              enabled = true,
              --upSoundFileName = "sounds/interface_select-whoosh.ogg",
              soundTouchUpInside = object.game.ybSound.interface_previous_click,
          })
          local width = (backButtonRect:x() / 3.0) 
          local height = (backButtonRect:y() / 3.0) 
          backButton:setOrigin(
          bullet.btVector3((vert_margin * 1) + width , (vert_margin * 1) + height, -1)
          )
          table.insert(uiNodes, backButton)

          local uiCaption, uiCaptionRect, uiCaptionId = UI:createImage({
              name = "header_LEVEL_SELECT",
              x = 200, 
              y = 200, 
              node = njlic.Node.create(), 
              tp = texturePacker, 
              camera = camera,
              scale = 7,
          })
          local width = (uiCaptionRect:x() / 3.0) 
          local height = (uiCaptionRect:y() / 3.0) 
          uiCaption:setOrigin(
          bullet.btVector3(njlic.SCREEN():x() * 0.5 , njlic.SCREEN():y() * 0.85, -1)
          )
          table.insert(uiNodes, uiCaption)

          local timeAttackButton, timeAttackButtonRect, timeAttackButtonId = UI:createButton({
              off = "butn_TIME_ATTACK_off", 
              on = "butn_TIME_ATTACK_on", 
              dis = "butn_TIME_ATTACK_dis", 
              x = 200, 
              y = 200, 
              node = njlic.Node.create(), 
              tp = texturePacker, 
              camera = camera,
              down = function() 
              end,
              up = function()
                  object.mode = "timeAttack"
                  object:showBoardSelect()
              end,
              scale = 7,
              enabled = false,
              --upSoundFileName = "sounds/interface_select-whoosh.ogg",
              soundTouchUpInside = object.game.ybSound.interface_select_whoosh,
          })
          local width = (timeAttackButtonRect:x() / 3.0) 
          local height = (timeAttackButtonRect:y() / 3.0) 
          timeAttackButton:setOrigin(
          bullet.btVector3(njlic.SCREEN():x() * 0.25 , njlic.SCREEN():y() * 0.4, -1)
          )
          table.insert(uiNodes, timeAttackButton)

          local arcadeButton, arcadeButtonRect, arcadeButtonId = UI:createButton({
              off = "butn_ARCADE_off", 
              on = "butn_ARCADE_on", 
              dis = "butn_ARCADE_dis", 
              x = 200, 
              y = 200, 
              node = njlic.Node.create(), 
              tp = texturePacker, 
              camera = camera,
              down = function() 
              end,
              up = function()
                  object.mode = "arcade"
                  object:showBoardSelect()
              end,
              scale = 7,
              enabled = true,
              --upSoundFileName = "sounds/interface_select-whoosh.ogg",
              soundTouchUpInside = object.game.ybSound.interface_select_whoosh,
          })
          local width = (arcadeButtonRect:x() / 3.0) 
          local height = (arcadeButtonRect:y() / 3.0) 
          arcadeButton:setOrigin(
          bullet.btVector3(njlic.SCREEN():x() * 0.5 , njlic.SCREEN():y() * 0.4, -1)
          )
          table.insert(uiNodes, arcadeButton)

          local survivalButton, survivalButtonRect, survivalButtonId = UI:createButton({
              off = "butn_SURVIVAL_off", 
              on = "butn_SURVIVAL_on", 
              dis = "butn_SURVIVAL_dis", 
              x = 200, 
              y = 200, 
              node = njlic.Node.create(), 
              tp = texturePacker, 
              camera = camera,
              down = function() 
              end,
              up = function()
                  object.mode = "survival"
                  object:showBoardSelect()
              end,
              scale = 7,
              enabled = false,
              --upSoundFileName = "sounds/interface_select-whoosh.ogg",
              soundTouchUpInside = object.game.ybSound.interface_select_whoosh,
          })
          local width = (survivalButtonRect:x() / 3.0) 
          local height = (survivalButtonRect:y() / 3.0) 
          survivalButton:setOrigin(
          bullet.btVector3(njlic.SCREEN():x() * 0.75 , njlic.SCREEN():y() * 0.4, -1)
          )
          table.insert(uiNodes, survivalButton)

          return uiNodes
      end


      local createStageSelect = function(UI, texturePacker, camera, object)
          local object = object

          local uiNodes = createUiBackdrop(UI, texturePacker, camera)

          local vert_margin = njlic.SCREEN():y() / 30.0
          local horiz_margin = njlic.SCREEN():x() / 60.0

          -- local backbutton = createBackButton(UI, texturePacker, camera)
          -- table.insert(uiNodes, backbutton)
          local vert_margin = njlic.SCREEN():y() / 30.0
          local horiz_margin = njlic.SCREEN():x() / 60.0

          local backButton, backButtonRect, backButtonId = UI:createButton({
              off = "butn_BACK_off", 
              on = "butn_BACK_on", 
              x = 200, 
              y = 200, 
              node = njlic.Node.create(), 
              tp = texturePacker, 
              camera = camera,
              down = function() 
              end,
              up = function()
                  object:showSplash()
              end,
              scale = 7,
              enabled = true,
              --upSoundFileName = "sounds/interface_select-whoosh.ogg",
              soundTouchUpInside = object.game.ybSound.interface_previous_click,
          })
          local width = (backButtonRect:x() / 3.0) 
          local height = (backButtonRect:y() / 3.0) 
          backButton:setOrigin(
          bullet.btVector3((vert_margin * 1) + width , (vert_margin * 1) + height, -1)
          )
          table.insert(uiNodes, backButton)

          local uiCaption, uiCaptionRect, uiCaptionId = UI:createImage({
              name = "header_STAGE_SELECT",
              x = 200, 
              y = 200, 
              node = njlic.Node.create(), 
              tp = texturePacker, 
              camera = camera,
              scale = 7,
          })
          local width = (uiCaptionRect:x() / 3.0) 
          local height = (uiCaptionRect:y() / 3.0) 
          uiCaption:setOrigin(
          bullet.btVector3(njlic.SCREEN():x() * 0.5 , njlic.SCREEN():y() * 0.85, -1)
          )
          table.insert(uiNodes, uiCaption)

          local portraitButton, portraitButtonRect, portraitButtonId = UI:createButton({
              off = "butn_portrait_country_off", 
              on = "butn_portrait_country_on", 
              dis = "butn_portrait_country_dis", 
              x = 200, 
              y = 200, 
              node = njlic.Node.create(), 
              tp = texturePacker, 
              camera = camera,
              down = function() 
              end,
              up = function()
                  object.stage = "country"
                  object:showLevelSelect()
              end,
              scale = 7,
              enabled = true,
              --upSoundFileName = "sounds/interface_select-whoosh.ogg",
              soundTouchUpInside = object.game.ybSound.interface_select_whoosh,
          })
          local width = (portraitButtonRect:x() / 3.0) 
          local height = (portraitButtonRect:y() / 3.0) 
          portraitButton:setOrigin(
          bullet.btVector3(njlic.SCREEN():x() * 0.3 , njlic.SCREEN():y() * 0.4, -1)
          )
          table.insert(uiNodes, portraitButton)

          local cityButton, cityButtonRect, cityButtonId = UI:createButton({
              off = "butn_portrait_city_off", 
              on = "butn_portrait_city_on", 
              dis = "butn_portrait_city_dis", 
              x = 200, 
              y = 200, 
              node = njlic.Node.create(), 
              tp = texturePacker, 
              camera = camera,
              down = function() 
                  -- print("playdown")
              end,
              up = function()
                  object.stage = "city"
                  object:showLevelSelect()
              end,
              scale = 7,
              enabled = false,
              --upSoundFileName = "sounds/interface_select-whoosh.ogg",
              soundTouchUpInside = object.game.ybSound.interface_select_whoosh,
          })
          local width = (cityButtonRect:x() / 3.0) 
          local height = (cityButtonRect:y() / 3.0) 
          cityButton:setOrigin(
          bullet.btVector3(njlic.SCREEN():x() * 0.7 , njlic.SCREEN():y() * 0.4, -1)
          )
          table.insert(uiNodes, cityButton)

          return uiNodes
      end

      local createWinTimeAttack = function(UI, texturePacker, camera, result, object)
          local nodes = createWin(UI, texturePacker, camera, result, object)
          return nodes
      end

      local createWinArcade = function(UI, texturePacker, camera, result, object)

          local nodes = createWin(UI, texturePacker, camera, result, object)


          local text = string.format("It was %s", "just ok")
          -- text = "JAMES FOLK"

          -- print("createWinArcade")
          local displayNode, displayNodeRect = YappyBirdFont:printf({
              mainNode=nil,
              text=text,
              align="center",
              maxwidth=(njlic.SCREEN():x()),
          })
          local vert_margin = njlic.SCREEN():y() / 30.0
          local horiz_margin = njlic.SCREEN():x() / 60.0
          displayNode:setOrigin(bullet.btVector3(horiz_margin * 1, njlic.SCREEN():y() * 0.5, -1))

          table.insert(nodes, displayNode)

          return nodes, displayNode
      end

      local createWinSurvival = function(UI, texturePacker, camera, result, object)
          local nodes = createWin(UI, texturePacker, camera, result, object)
          return nodes
      end

      local createLoseTimeAttack = function(UI, texturePacker, camera, result, object)
          local nodes = createLose(UI, texturePacker, camera, result, object)
          return nodes
      end

      local createLoseArcade = function(UI, texturePacker, camera, result, object)
          local nodes = createLose(UI, texturePacker, camera, result, object)
          return nodes
      end

      local createLoseSurvival = function(UI, texturePacker, camera, result, object)
          local nodes = createLose(UI, texturePacker, camera, result, object)
          return nodes
      end

      object.ui:load()

      -- #4
      object.boardSelectNodes, object.boardSelectIds = createBoardSelect(object.ui, object.interfaceTexturePacker, object.orthographicCamera, object)
      HideNodes({nodes=object.boardSelectNodes, camera=object.orthographicCamera})

      -- #1
      object.splashScreenNodes = createSplashScreen(object.ui, object.interfaceTexturePacker, object.orthographicCamera, object)
      HideNodes({nodes=object.splashScreenNodes, camera=object.orthographicCamera})

      -- #3
      object.levelSelectNodes = createLevelSelect(object.ui, object.interfaceTexturePacker, object.orthographicCamera, object)
      HideNodes({nodes=object.levelSelectNodes, camera=object.orthographicCamera})

      -- #2
      object.stageSelectNodes = createStageSelect(object.ui, object.interfaceTexturePacker, object.orthographicCamera, object)
      HideNodes({nodes=object.stageSelectNodes, camera=object.orthographicCamera})

      object.winTimeAttackNodes = createWinTimeAttack(object.ui, object.interfaceTexturePacker, object.orthographicCamera, result, object)
      HideNodes({nodes=object.winTimeAttackNodes, camera=object.orthographicCamera})

      object.winArcadeNodes, object.bfNode = createWinArcade(object.ui, object.interfaceTexturePacker, object.orthographicCamera, result, object)
      HideNodes({nodes=object.winArcadeNodes, camera=object.orthographicCamera})

      object.winSurvivalNodes = createWinSurvival(object.ui, object.interfaceTexturePacker, object.orthographicCamera, result, object)
      HideNodes({nodes=object.winSurvivalNodes, camera=object.orthographicCamera})

      object.loseTimeAttackNodes = createLoseTimeAttack(object.ui, object.interfaceTexturePacker, object.orthographicCamera, result, object)
      HideNodes({nodes=object.loseTimeAttackNodes, camera=object.orthographicCamera})

      object.loseArcadeNodes = createLoseArcade(object.ui, object.interfaceTexturePacker, object.orthographicCamera, result, object)
      HideNodes({nodes=object.loseArcadeNodes, camera=object.orthographicCamera})

      object.loseSurvivalNodes = createLoseSurvival(object.ui, object.interfaceTexturePacker, object.orthographicCamera, result, object)
      HideNodes({nodes=object.loseSurvivalNodes, camera=object.orthographicCamera})

      function object:hideAll()
          HideNodes({nodes=self.boardSelectNodes, camera=self.orthographicCamera})
          HideNodes({nodes=self.splashScreenNodes, camera=self.orthographicCamera})
          HideNodes({nodes=self.levelSelectNodes, camera=self.orthographicCamera})
          HideNodes({nodes=self.stageSelectNodes, camera=self.orthographicCamera})
          HideNodes({nodes=self.winTimeAttackNodes, camera=self.orthographicCamera})
          HideNodes({nodes=self.winArcadeNodes, camera=self.orthographicCamera})
          HideNodes({nodes=self.winSurvivalNodes, camera=self.orthographicCamera})
          HideNodes({nodes=self.loseTimeAttackNodes, camera=self.orthographicCamera})
          HideNodes({nodes=self.loseArcadeNodes, camera=self.orthographicCamera})
          HideNodes({nodes=self.loseSurvivalNodes, camera=self.orthographicCamera})
      end

      function object:showBoardSelect()
          self:hideAll()

          local YappyBirdsData = require 'YAPPYBIRDS.SaveData'
          local debug = false
          local fp = njlic.DOCUMENT_PATH("yappybirds.lua")
          local d = YappyBirdsData.new({filepath=fp})

          for i = 1, 15 do
              local id = self.boardSelectIds[i]
              local enabled = true
              if d:get(self.stage, i, self.mode) == -1 then
                  enabled = false
              end

              assert(id, "id is nil")

              self.ui:enable({id=id, enabled=enabled})
          end

          ShowNodes({nodes=self.boardSelectNodes, camera=self.orthographicCamera})
      end

      function object:getUi()
          return self.ui
      end

      function object:showSplash()
          self.ui:playBackgroundSound()

          self:hideAll()
          ShowNodes({nodes=self.splashScreenNodes, camera=self.orthographicCamera})
      end

      function object:showLevelSelect()
          self.ui:playBackgroundSound()

          self:hideAll()
          ShowNodes({nodes=self.levelSelectNodes, camera=self.orthographicCamera})
      end

      function object:showStageSelect()
          self.ui:playBackgroundSound()

          self:hideAll()
          ShowNodes({nodes=self.stageSelectNodes, camera=self.orthographicCamera})
      end

      function object:showWinTimeAttack()
          self.ui:playBackgroundSound()

          self:hideAll()
          ShowNodes({nodes=self.winTimeAttackNodes, camera=self.orthographicCamera})
      end

      function object:showWinArcade(balloonsHit, balloonsThrown, percentage)

          self.ui:playBackgroundSound()

          self:hideAll()

          local text = ""

          wordStatusFormat = "You threw %.0f ballons and made contact with %.0f of those ballons. \nYour accuracy is %.0f%%!  \n%s" 

          if percentage == 100.0 then
              wordStatus = "Perfect!"
          elseif percentage >= 60.0 then
              wordStatus = "OK!"
          else
              wordStatus = "You Passed!"
          end

          text = string.format(wordStatusFormat, balloonsThrown, balloonsHit, percentage, wordStatus)

          self.bfNode, self.bfNodeNodeRect = YappyBirdFont:printf({
              mainNode=self.bfNode,
              text=text,
              align="center",
              maxwidth=(njlic.SCREEN():x()),
          })
          self.bfNode:setOrigin(bullet.btVector3((njlic.SCREEN():x() * 0.5) - (self.bfNodeNodeRect.width * 0.5), (njlic.SCREEN():y() * 0.5) - (self.bfNodeNodeRect.height * 0.5), -1))

          ShowNodes({nodes=self.winArcadeNodes, camera=self.orthographicCamera})
      end

      function object:showWinSurvival()
          self.ui:playBackgroundSound()

          self:hideAll()
          ShowNodes({nodes=self.winSurvivalNodes, camera=self.orthographicCamera})
      end

      function object:showLoseTimeAttack()
          self.ui:playBackgroundSound()

          self:hideAll()
          ShowNodes({nodes=self.loseTimeAttackNodes, camera=self.orthographicCamera})
      end

      function object:showLoseArcade()
          self.ui:playBackgroundSound()

          self:hideAll()
          ShowNodes({nodes=self.loseArcadeNodes, camera=self.orthographicCamera})
      end

      function object:showLoseSurvival()
          self.ui:playBackgroundSound()

          self:hideAll()
          ShowNodes({nodes=self.loseSurvivalNodes, camera=self.orthographicCamera})
      end

      function object:playGame()
          self.ui:stopBackgroundSound()

          self:hideAll()

          self.game:start(self)
      end

        function object:update(timestep)
            local status, err = pcall(self.ui.update, self.ui, timeStep)
            if not status then error(err) end
        end

        function object:collide(node, otherNode, collisionPoint)
        end

        function object:click(x, y)
        end

        function object:down(rayContact)
            local status, err = pcall(self.ui.down, self.ui, rayContact)
            if not status then error(err) end
        end

        function object:up(rayContact)
            local status, err = pcall(self.ui.up, self.ui, rayContact)
            if not status then error(err) end
        end

        function object:move(rayContact)
            local status, err = pcall(self.ui.move, self.ui, rayContact)
            if not status then error(err) end
        end

        function object:cancelled(rayContact)
            local status, err = pcall(self.ui.cancelled, self.ui, rayContact)
            if not status then error(err) end
        end

        function object:missed(node, deviceTouch)
            local status, err = pcall(self.ui.missed, self.ui, node, deviceTouch)
            if not status then error(err) end
        end












        return object
    end
}

local StateMachine = {
  new = function(...)
    local sm = {
      states = {},
      currentStateName = nil,
    }

    function sm:addState(name, state)
      assert(self.states[name] == nil, "State must be nil")

      self.states[name] = state
    end

    function sm:switchStates(name)
      assert(name, "state name is nil")
      assert(self.states[name] ~= nil, "State is nil")

      if self.currentStateName then
          local status, err = pcall(self.states[self.currentStateName].exit)
          if not status then error(err) end
      end

      self.currentStateName = name

      local status, err = pcall(self.states[self.currentStateName].enter)
      if not status then error(err) end
    end

    function sm:update(timeStep)

      if self.currentStateName then
          local status, err = pcall(self.states[self.currentStateName].update, timeStep)
          if not status then error(err) end
      end

    end

    function sm:collide(colliderEntity, collisionPoint)
      if self.currentStateName then
          local status, err = pcall(self.states[self.currentStateName].collide, colliderEntity, collisionPoint)
          if not status then error(err) end
      end
    end

    return sm
  end
}





local Beak = {
  new = function(...)
    local arg=... or {}

    local texturePacker=arg.texturePacker or {}
    local perspectiveCamera=arg.perspectiveCamera or nil
    local index = arg.index or 0
    local params = arg.params or nil
    local birdName = arg.birdName or nil

    assert(texturePacker, "The texturePacker is nil")
    assert(perspectiveCamera, "The perspectiveCamera is nil")
    assert(params, "The params is nil")
    assert(birdName, "The birdName is nil")

    local beak = {
      inplay=false,
      texturePacker=texturePacker,
      perspectiveCamera=perspectiveCamera,
      node = nil,
      action = nil,
      index = index,
      currentFrame = 0,
      animationClock = nil,
      fps=30,
      params = params,
      ANIMATION_STATES={grab="grab",hit="hit",idle="idle"},
      birdName=birdName,
      STATEMACHINE_STATES={idle="idle",yap="yap"},
      currentAnimationState=nil
    }

    function beak:getFrameName()
      local state = self.currentAnimationState
      local birdName = self.birdName

      local name = string.format("character_%sBird_mouth_%s_front/character_%sBird_mouth_%s_front_%05d", birdName, state, birdName, state, self.currentFrame)
      return name
    end

    function beak:load(...)
      local arg=... or {}


      local bird = arg.bird or nil

      assert(bird, "The bird is nil")

      local origin = bullet.btVector3(0.0, 0.0, 0.0)

      self.currentAnimationState=self.ANIMATION_STATES.idle

      local name = self:getFrameName()
      self.node = njlic.Node.create()
      if self.texturePacker[1]:has({name=name}) then
        self.node = self.texturePacker[1]:draw({name=name, node=self.node, updateDimensions=false})
      elseif self.texturePacker[2]:has({name=name}) then
        self.node = self.texturePacker[2]:draw({name=name, node=self.node, updateDimensions=false})
      end

      if self.node then
        self.node:setName(string.format("%sbird_beak_node_%05d", self.birdName, self.index))

        self.node:setOrigin(origin)
        self.node:enableTagged(false)
        self:hide()

        self.action = njlic.Action.create()
        self.action:setRepeatForever()
        self.action:setName(string.format("%sbird_beak_action_%05d", self.birdName, self.index))

        self.animationClock = njlic.Clock.create()

        bird.node:addChildNode(self.node)
        self.bird = bird
----        njlic.World.getInstance():getScene():getRootNode():addChildNode(self.node)

        -- self.sound = njlic.Sound.create()
        -- self.sound:setName(string.format("%sbird_beak_sound_%05d", self.birdName, self.index))
        -- local soundName = "sounds/projectile_balloon_water-splash.ogg"
        -- njlic.World.getInstance():getWorldResourceLoader():load(soundName, self.sound)

      else
      end


      local stateMachine = StateMachine.new(self)

      stateMachine:addState(self.STATEMACHINE_STATES.yap, {
          enter = function()
              -- print("beak yap enter")
          end,
          exit = function()
          end,
          update = function(timeStep)
              -- print("beak yap update")
              if nil ~= self.birdSFX then
                  if not self.birdSFX:isPlaying() then
                      self.stateMachine:switchStates(self.STATEMACHINE_STATES.idle)
                  end
              end
          end,
          collide = function(colliderEntity, collisionPoint)
          end,
        })

      stateMachine:addState(self.STATEMACHINE_STATES.idle, {
          enter = function()
              -- print("beak idle enter")
          end,
          exit = function()
          end,
          update = function(timeStep)
              -- print("beak idle update")
          end,
          collide = function(colliderEntity, collisionPoint)
          end,
        })

      self.stateMachine = stateMachine

    end

    function beak:unload()

      -- njlic.Sound.destroy(self.sound)

      njlic.Clock.destroy(self.animationClock)
      njlic.Action.destroy(self.action)
      njlic.Node.destroy(self.node)

    end

    function beak:setup(...)
      local arg=... or {}

      local origin = bullet.btVector3(0.0, 0.0, -0.01)
      local dimensions = arg.dimensions or bullet.btVector2(256.0, 256.0)
      local debug = arg.debug or false
      local spawnMachine = arg.spawnMachine or nil

      self.spawnMachine = spawnMachine

      self.inplay=true

      self.node:setOrigin(origin)
      self.node:getGeometry():setDimensions(self.node, dimensions)


    end

    function beak:taunt()
      self.stateMachine:switchStates(self.STATEMACHINE_STATES.yap)
      self.birdSFX = self.bird:playTaunt()
    end

    function beak:spawn(...)
      local arg=... or {}


      self.inplay=true

      self:show()
      self.node:runAction(self.action)
      self.currentAnimationState=self.ANIMATION_STATES.idle

      self.stateMachine:switchStates(self.STATEMACHINE_STATES.idle)
    end

    function beak:kill(...)
      local arg=... or {}


      self.inplay=false

      self.node:removeAction(self.node:getName())

      self:hide()


    end

    function beak:hide()
      self.node:hide(self.perspectiveCamera)
    end

    function beak:show()
      self.node:show(self.perspectiveCamera)
    end

    function beak:incrementAnimationFrame()
        if self.stateMachine.currentStateName ~= "idle" then
            self.currentFrame = self.currentFrame + 1
        end

        if(self.currentFrame > 8) then self.currentFrame = 0 end

        local name = self:getFrameName()
        if self.texturePacker[1]:has({name=name}) then
            self.node = self.texturePacker[1]:draw({name=name, node=self.node, updateDimensions=false})
        elseif self.texturePacker[2]:has({name=name}) then
            self.node = self.texturePacker[2]:draw({name=name, node=self.node, updateDimensions=false})
        end

        -- print(self.stateMachine.currentStateName)
    end

    function beak:collide(colliderEntity, collisionPoint)
      self.stateMachine:collide(colliderEntity, collisionPoint)
    end

    function beak:update(timeStep)
        self.stateMachine:update(timeStep)
    end

    return beak
  end
}

local Bird = {
  new = function(...)
    local arg=... or {}

    local texturePacker=arg.texturePacker or {}
    local perspectiveCamera=arg.perspectiveCamera or nil
    local index = arg.index or 0
    local params = arg.params or nil
    local game = arg.game or nil
    local birdName = arg.birdName or nil
    local dogs = arg.dogs or nil

    assert(texturePacker, "The texturePacker is nil")
    assert(perspectiveCamera, "The perspectiveCamera is nil")
    assert(params, "The params is nil")
    assert(game, "The game is nil")
    assert(birdName, "The birdName is nil")
    assert(dogs, "The dogs is nil")

   local beak = Beak.new({
          texturePacker=texturePacker,
          perspectiveCamera=perspectiveCamera,
          birdName=birdName,
          index=index,
          params=params,
          game=game,
          })

    local bird = {
      inplay=false,
      texturePacker=texturePacker,
      perspectiveCamera=perspectiveCamera,
      node = nil,
      action = nil,
      index = index,
      currentFrame = 0,
      animationClock = nil,
      fps=30,
      params = params,
      game = game,
      ANIMATION_STATES={grab="grab",hit="hit",idle="idle"},
      birdName=birdName,
      dogs=dogs,
      STATEMACHINE_STATES={fly="fly",grabbed="grabbed",grabbing="grabbing",hit="hit",pursue="pursue",spawn="spawn", release="release"},
      stateMachine = nil,
      beak = beak,
    }

    function bird:getFrameName()
      local state = self.currentAnimationState
      local birdName = self.birdName

      if state == "fly" then
      elseif state == "grabbed" then
      elseif state == "grabbing" then
      elseif state == "hit" then
      elseif state == "pursue" then
      elseif state == "spawn" then
      end

      local name = string.format("character_%sBird_%s_front/character_%sBird_%s_front_%05d", birdName, state, birdName, state, self.currentFrame)
      return name
    end

    function bird:load(...)
      local arg=... or {}


      local origin = bullet.btVector3(0.0, 0.0, 0.0)

      self.currentAnimationState=self.ANIMATION_STATES.idle

      local name = self:getFrameName()
      self.node = njlic.Node.create()
      if self.texturePacker[1]:has({name=name}) then
        self.node = self.texturePacker[1]:draw({name=name, node=self.node, updateDimensions=false})
      elseif self.texturePacker[2]:has({name=name}) then
        self.node = self.texturePacker[2]:draw({name=name, node=self.node, updateDimensions=false})
      end

      self.sfxClock = njlic.Clock.create()

      if self.node then

        assert(self.beak, "The beak is nil")

        self.beak:load({bird=self})

        self.node:setName(string.format("%sbird_node_%05d", self.birdName, self.index))

        self.node:setOrigin(origin)
        self.node:enableTagged(false)
        self:hide()

        self.action = njlic.Action.create()
        self.action:setRepeatForever()
        self.action:setName(string.format("%sbird_action_%05d", self.birdName, self.index))

        self.animationClock = njlic.Clock.create()

        njlic.World.getInstance():getScene():getRootNode():addChildNode(self.node)

        self.physicsBody = njlic.PhysicsBodyRigid.create()
        self.physicsBody:setAngularFactor(bullet.btVector3(0,0,0))

        self.physicsBody:setName(string.format("%sbird_physicsbody_%05d", self.birdName, self.index))
        self.physicsBody:enableHandleCollideCallback()
        assert(self.physicsBody, "physicsBody is null")

        self.physicsShape = njlic.PhysicsShapeSphere.create()
        self.physicsShape:setRadius(5)

        assert(self.physicsShape, "physicsShape is null")

        self.physicsShape:setMargin(1)
        self.physicsBody:setPhysicsShape(self.physicsShape)
        self.physicsBody:setKinematicPhysics()

        -- self.sound = njlic.Sound.create()
        -- self.sound:setName(string.format("%sbird_sound_%05d", self.birdName, self.index))
        -- local soundName = "sounds/projectile_balloon_water-splash.ogg"
        -- njlic.World.getInstance():getWorldResourceLoader():load(soundName, self.sound)


        self.steeringBehaviourMachine = njlic.SteeringBehaviorMachineDithered.create()
        self.steeringBehaviourMachine:setMaxSpeed(self.params.Bird[self.birdName].MaxSpeed)
        self.steeringBehaviourMachine:setMaxForce(self.params.Bird[self.birdName].MaxForce)

        self.steeringBehaviorOffsetPursuit = njlic.SteeringBehaviorOffsetPursuit.create()
        self.steeringBehaviorOffsetPursuit:setOffsetPosition(bullet.btVector3(0,20,0))
        self.steeringBehaviorOffsetPursuit:setWeight(1.0)
        self.steeringBehaviorOffsetPursuit:setProbability(0.5)

        self.steeringBehaviorSeparation = njlic.SteeringBehaviorSeparation.create()
        self.steeringBehaviorSeparation:setWeight(60.0)
        self.steeringBehaviorSeparation:setProbability(0.5)

        self.steeringBehaviorEvade = njlic.SteeringBehaviorEvade.create()
        self.steeringBehaviorEvade:setWeight(600.0)
        self.steeringBehaviorEvade:setProbability(1.0)

        self.steeringBehaviorPursuit = njlic.SteeringBehaviorPursuit.create()
        self.steeringBehaviorPursuit:setWeight(1.0)
        self.steeringBehaviorPursuit:setProbability(1.0)


        self.steeringBehaviorWallAvoidance = njlic.SteeringBehaviorWallAvoidance.create()
        self.steeringBehaviorWallAvoidance:setFeelerLength(3.0);
        self.steeringBehaviorWallAvoidance:setWeight(60000.0)
        self.steeringBehaviorWallAvoidance:setProbability(1.0)

        -- There is 53 units to the right/left
        -- There is 26 units to the top/right
        --
        -- const btVector3 &planePoint, const btVector3 &planeNormal
        self.topWall    = njlic.Wall(bullet.btVector3(  0.0,  50.0, 0.0), bullet.btVector3( 0.0, -1.0, 0.0))
        self.bottomWall = njlic.Wall(bullet.btVector3(  0.0, -20.0, 0.0), bullet.btVector3( 0.0,  1.0, 0.0))
        self.leftWall   = njlic.Wall(bullet.btVector3(-43.0,  0.0, 0.0), bullet.btVector3( 1.0,  0.0, 0.0))
        self.rightWall  = njlic.Wall(bullet.btVector3( 43.0,  0.0, 0.0), bullet.btVector3(-1.0,  0.0, 0.0))

        self.steeringBehaviorWallAvoidance:addWall(self.topWall)
        self.steeringBehaviorWallAvoidance:addWall(self.bottomWall)
        self.steeringBehaviorWallAvoidance:addWall(self.leftWall)
        self.steeringBehaviorWallAvoidance:addWall(self.rightWall)

        self.node:setSteeringBehaviorMachine(self.steeringBehaviourMachine)

        self.steeringBehaviourMachine:addSteeringBehavior(self.steeringBehaviorWallAvoidance)

        self.yapTimer = njlic.Timer.create()


      else
      end

      local stateMachine = StateMachine.new(self)

      -- Bird Fly --------------------------------------------------------------------------

      stateMachine:addState(self.STATEMACHINE_STATES.fly, {
          enter = function()
                self.pursueTimer = njlic.Timer.create()
                self.steeringBehaviourMachine:enable()
              self.currentAnimationState=self.ANIMATION_STATES.idle
                self.steeringBehaviourMachine:addSteeringBehavior(self.steeringBehaviorOffsetPursuit)
                self.steeringBehaviourMachine:addSteeringBehavior(self.steeringBehaviorSeparation)

                self.pursueTimer:start(self.params.Bird[self.birdName].PursueTime)
          end,
          exit = function()
                njlic.Timer.destroy(self.pursueTimer)
                self.steeringBehaviourMachine:removeSteeringBehavior(self.steeringBehaviorOffsetPursuit)
                self.steeringBehaviourMachine:removeSteeringBehavior(self.steeringBehaviorSeparation)
            end,
          update = function(timeStep)

              if self.pursueTimer:isFinished() then
                  if self.game.canPursue then
                      self.stateMachine:switchStates(self.STATEMACHINE_STATES.pursue)
                  else
                      self.pursueTimer:start(self.params.Bird[self.birdName].PursueTime)
                  end
              end

              self.pursueTimer:tick()
          end,
          collide = function(colliderEntity, collisionPoint)
              if(colliderEntity.node:getPhysicsBody():getCollisionGroup() == CollisionGroups.projectile) then
                  self.stateMachine:switchStates(self.STATEMACHINE_STATES.hit)
              end
          end,
        })

      -- Bird Grabbed --------------------------------------------------------------------------
      
      stateMachine:addState(self.STATEMACHINE_STATES.grabbed, {
          enter = function()
              self.currentAnimationState=self.ANIMATION_STATES.grab
              self.beak:hide()
              self.physicsBody:setDynamicPhysics()
              self.steeringBehaviourMachine:enable(false)
              -- self.beak:taunt()
          end,
          exit = function()
              self.beak:show()
              self.steeringBehaviourMachine:enable(true)

          end,
          update = function(timeStep)

              if self.node:getOrigin():y() >= self.params.World.LoseBirdHeight then

                  self.game.lose = true

                  assert(self.dogAttacked ~= nil, "the dog being attacked is nil")

                  self.stateMachine:switchStates(self.STATEMACHINE_STATES.release)
                  self.dogAttacked.stateMachine:switchStates(self.dogAttacked.STATEMACHINE_STATES.released)
                  return

              end

              local y_force = 0

              if self.currentFrame == 1 then
              elseif self.currentFrame == 2 then
              elseif self.currentFrame == 3 then
              elseif self.currentFrame == 4 then
              elseif self.currentFrame == 5 then
              elseif self.currentFrame == 6 then
              elseif self.currentFrame == 7 then
                  y_force = self.params.Bird[self.birdName].StealSpeed
              elseif self.currentFrame == 8 then
              end

              self.physicsBody:applyForce(bullet3.btVector3(0,y_force,0), true)
          end,
          collide = function(colliderEntity, collisionPoint)
              if(colliderEntity.node:getPhysicsBody():getCollisionGroup() == CollisionGroups.projectile) then
                  self.stateMachine:switchStates(self.STATEMACHINE_STATES.release)
                  self.dogAttacked.stateMachine:switchStates(self.dogAttacked.STATEMACHINE_STATES.released)
                  -- self.stateMachine:switchStates(self.STATEMACHINE_STATES.release)
              end
          end,
        })

      -- Bird Grabbing --------------------------------------------------------------------------
      
      stateMachine:addState(self.STATEMACHINE_STATES.grabbing, {
          enter = function()
              self.currentAnimationState=self.ANIMATION_STATES.grab
              self.beak:hide()

              assert(self.dogAttacked ~= nil, "the dog being attacked is nil")

              self.steeringBehaviourMachine:clearSteering()
              self.steeringBehaviourMachine:enable(false)
              self.physicsBody:setKinematicPhysics()

              self.dogAttacked.birdAttacking = self
              self.dogAttacked.stateMachine:switchStates(self.dogAttacked.STATEMACHINE_STATES.caught)
          end,
          exit = function()
              self.beak:show()
          end,
          update = function(timeStep)
              self.stateMachine:switchStates(self.STATEMACHINE_STATES.grabbed)
          end,
          collide = function(colliderEntity, collisionPoint)
              if(colliderEntity.node:getPhysicsBody():getCollisionGroup() == CollisionGroups.projectile) then
                  self.stateMachine:switchStates(self.STATEMACHINE_STATES.hit)
              end
          end,
        })

      -- Bird Hit --------------------------------------------------------------------------
      
      stateMachine:addState(self.STATEMACHINE_STATES.hit, {
          enter = function()
              self.game.canPursue = true
              self.currentAnimationState=self.ANIMATION_STATES.hit
              self.steeringBehaviourMachine:clearSteering()
              self.steeringBehaviourMachine:enable(false)
              self.physicsBody:setDynamicPhysics()
              self.physicsBody:setMass(1000)
              self.physicsBody:setCollisionGroup(CollisionGroups.none)
              self.physicsBody:setCollisionMask(CollisionMasks.none)
              self:playDeath()

              self.game.balloonsHit = self.game.balloonsHit + 1
          end,
          exit = function()
          end,
          update = function(timeStep)
              local origin = self.node:getOrigin()

              local die = self.params.Projectile.WaterBalloon.DieY
              if self.node:getOrigin():y() < die then
                -- self:kill()
                self.spawnMachine:dispose(self)
              end
          end,
          collide = function(colliderEntity, collisionPoint)
              if(colliderEntity.node:getPhysicsBody():getCollisionGroup() == CollisionGroups.projectile) then
              end
          end,
        })

      -- Bird Pursue --------------------------------------------------------------------------
      
        stateMachine:addState(self.STATEMACHINE_STATES.pursue, {
            enter = function()
                self.pursueTimer = njlic.Timer.create()

                self.game.canPursue = false
                self.currentAnimationState=self.ANIMATION_STATES.idle
                self.offsetPosition = self.steeringBehaviorOffsetPursuit:getOffsetPosition()
                self.steeringBehaviorOffsetPursuit:setOffsetPosition(bullet.btVector3(0,6,-2))
                self.steeringBehaviourMachine:addSteeringBehavior(self.steeringBehaviorOffsetPursuit)

                self.collided = false
                self.dogAttacked = nil

                  self.beak:taunt()
          end,
          exit = function()
              njlic.Timer.destroy(self.pursueTimer)

                self.steeringBehaviorOffsetPursuit:setOffsetPosition(self.offsetPosition)
                -- self.steeringBehaviorOffsetPursuit:setOffsetPosition(bullet.btVector3(0,20,0))
                self.steeringBehaviourMachine:removeSteeringBehavior(self.steeringBehaviorOffsetPursuit)
                self.game.canPursue = false
          end,
          update = function(timeStep)

              if self.dogAttacked then
                  self.pursueTimer:tick()

                  if self.pursueTimer:isFinished() then
                      self.stateMachine:switchStates(self.STATEMACHINE_STATES.grabbing)
                      return
                  end

                  -- if not self.collided then
                  --     self.collided = true
                  --     self.pursueTimer:start(self.params.Bird[self.birdName].PursueTime)
                  -- else
                  --     if self.pursueTimer:isFinished() then
                  --         self.stateMachine:switchStates(self.STATEMACHINE_STATES.grabbing)
                  --         return
                  --     end
                  -- end
              else
                  self.pursueTimer:start(self.params.Bird[self.birdName].PursueTime)
                  self.pursueTimer:enablePause()
              end

              self.dogAttacked = nil

          end,
          collide = function(colliderEntity, collisionPoint)
              if(colliderEntity.node:getPhysicsBody():getCollisionGroup() == CollisionGroups.dog) then
                  self.dogAttacked = colliderEntity
                  self.pursueTimer:enablePause(false)
              end
              if(colliderEntity.node:getPhysicsBody():getCollisionGroup() == CollisionGroups.projectile) then
                  self.stateMachine:switchStates(self.STATEMACHINE_STATES.hit)
              end
          end,
        })

      -- Bird Spawn --------------------------------------------------------------------------
      
      stateMachine:addState(self.STATEMACHINE_STATES.spawn, {
          enter = function()
              self.currentAnimationState=self.ANIMATION_STATES.idle
          end,
          exit = function()
        end,
          update = function(timeStep)
              self.stateMachine:switchStates(self.STATEMACHINE_STATES.fly)
            end,
          collide = function(colliderEntity, collisionPoint)
              if(colliderEntity.node:getPhysicsBody():getCollisionGroup() == CollisionGroups.projectile) then
              end
          end,
        })

      -- Bird Release --------------------------------------------------------------------------
      
      stateMachine:addState(self.STATEMACHINE_STATES.release, {
          enter = function()
              self.currentAnimationState=self.ANIMATION_STATES.hit
              self.physicsBody:setKinematicPhysics()
                self.stunTimer = njlic.Timer.create()

                self.stunTimer:start(self.params.Bird[self.birdName].StunTime)
            self.game.canPursue = true
          end,
          exit = function()
            njlic.Timer.destroy(self.stunTimer)
        end,
          update = function(timeStep)
              if self.stunTimer:isFinished() then
                  self.stateMachine:switchStates(self.STATEMACHINE_STATES.fly)
              end

              self.stunTimer:tick()
            end,
          collide = function(colliderEntity, collisionPoint)
              if(colliderEntity.node:getPhysicsBody():getCollisionGroup() == CollisionGroups.projectile) then
              end
          end,
        })

      self.stateMachine = stateMachine

    end

    function bird:playSfx(sfx)
        local sfxTime = (3.0 * 1000)
        if (self.sfxClock:getTimeMilliseconds() > sfxTime) then
            if sfx ~= nil then
                self.sfxClock:reset()
                sfx:play()
            end
        end
    end

    function bird:isChubi()
        return self.birdName == "chubi"
    end

    function bird:isGaru()
        return self.birdName == "garu" 
    end

    function bird:isMomi()
        return self.birdName == "momi"
    end

    function bird:isPuffy()
        return self.birdName == "puffy"
    end

    function bird:isWebo()
        return self.birdName == "webo"
    end

    function bird:isZuru()
        return self.birdName == "zuru"
    end

    function bird:playDeath()
        if self:isChubi() then
            local idx = math.random(1, 2)

            if idx == 1 then
                self:playSfx(self.game.ybSound.chubibird_death1)
            elseif idx == 2 then
                self:playSfx(self.game.ybSound.chubibird_death2)
            end
        elseif self:isGaru() then
            local idx = math.random(1, 2)

            if idx == 1 then
                self:playSfx(self.game.ybSound.garubird_death1)
            elseif idx == 2 then
                self:playSfx(self.game.ybSound.garubird_death2)
            end
        elseif self:isMomi() then
            self:playSfx(self.game.ybSound.momibird_death1)
        elseif self:isPuffy() then
            local idx = math.random(1, 2)

            if idx == 1 then
                self:playSfx(self.game.ybSound.puffybird_death1)
            elseif idx == 2 then
                self:playSfx(self.game.ybSound.puffybird_death2)
            end
        elseif self:isWebo() then
            self:playSfx(self.game.ybSound.webobird_death1)
        elseif self:isZuru() then
            local idx = math.random(1, 2)

            if idx == 1 then
                self:playSfx(self.game.ybSound.zurubird_death1)
            elseif idx == 2 then
                self:playSfx(self.game.ybSound.zurubird_death2)
            end
        end
    end

    function bird:playTaunt()
        local snd = nil

        if self:isChubi() then
            local idx = math.random(1, 4)

            if idx == 1 then
                snd = self.game.ybSound.chubibird_taunt1
            elseif idx == 2 then
                snd = self.game.ybSound.chubibird_taunt2
            elseif idx == 3 then
                snd = self.game.ybSound.chubibird_taunt3
            elseif idx == 4 then
                snd = self.game.ybSound.chubibird_taunt4
            end
        elseif self:isGaru() then
            local idx = math.random(1, 2)

            if idx == 1 then
                snd = self.game.ybSound.garubird_taunt1
            elseif idx == 2 then
                snd = self.game.ybSound.garubird_taunt2
            elseif idx == 3 then
                snd = self.game.ybSound.garubird_taunt3
            elseif idx == 4 then
                snd = self.game.ybSound.garubird_taunt4
            elseif idx == 5 then
                snd = self.game.ybSound.garubird_taunt5
            elseif idx == 6 then
                snd = self.game.ybSound.garubird_taunt6
            end
        elseif self:isMomi() then
            local idx = math.random(1, 4)

            if idx == 1 then
                snd = self.game.ybSound.momibird_taunt1
            elseif idx == 2 then
                snd = self.game.ybSound.momibird_taunt2
            elseif idx == 3 then
                snd = self.game.ybSound.momibird_taunt3
            elseif idx == 4 then
                snd = self.game.ybSound.momibird_taunt4
            end
        elseif self:isPuffy() then
            local idx = math.random(1, 2)

            if idx == 1 then
                snd = self.game.ybSound.puffybird_taunt1
            elseif idx == 2 then
                snd = self.game.ybSound.puffybird_taunt2
            elseif idx == 3 then
                snd = self.game.ybSound.puffybird_taunt3
            elseif idx == 4 then
                snd = self.game.ybSound.puffybird_taunt4
            elseif idx == 5 then
                snd = self.game.ybSound.puffybird_taunt5
            end
        elseif self:isWebo() then
            local idx = math.random(1, 4)

            if idx == 1 then
                snd = self.game.ybSound.webobird_taunt1
            elseif idx == 2 then
                snd = self.game.ybSound.webobird_taunt2
            elseif idx == 3 then
                snd = self.game.ybSound.webobird_taunt3
            elseif idx == 4 then
                snd = self.game.ybSound.webobird_taunt4
            end
        elseif self:isZuru() then
            local idx = math.random(1, 2)

            if idx == 1 then
                snd = self.game.ybSound.zurubird_taunt1
            elseif idx == 2 then
                snd = self.game.ybSound.zurubird_taunt2
            elseif idx == 3 then
                snd = self.game.ybSound.zurubird_taunt3
            elseif idx == 4 then
                snd = self.game.ybSound.zurubird_taunt4
            elseif idx == 5 then
                snd = self.game.ybSound.zurubird_taunt5
            end
        end

        if nil ~= snd then
            self:playSfx(snd)
        end
        return snd
    end

    function bird:unload()
      njlic.Clock.destroy(self.sfxClock)

      self.beak:unload()

      self.stateMachine = nil

      njlic.SteeringBehaviorPursuit.destroy(self.steeringBehaviorPursuit)
      njlic.SteeringBehaviorEvade.destroy(self.steeringBehaviorEvade)
      njlic.SteeringBehaviorOffsetPursuit.destroy(self.steeringBehaviorOffsetPursuit)
      njlic.SteeringBehaviorMachineDithered.destroy(self.steeringBehaviourMachine)

      -- njlic.Sound.destroy(self.sound)

      njlic.PhysicsBodyRigid.destroy(self.physicsBody)
      njlic.PhysicsShapeSphere.destroy(self.physicsShape)

      njlic.Clock.destroy(self.animationClock)
      njlic.Action.destroy(self.action)
      njlic.Node.destroy(self.node)

        njlic.Timer.destroy(self.yapTimer)
    end

    function bird:setup(...)
      local arg=... or {}

      local origin = arg.origin or bullet.btVector3(0.0, 0.0, 0.0)
      local dimensions = arg.dimensions or bullet.btVector2(256.0, 256.0)
      local debug = arg.debug or false
      local spawnMachine = arg.spawnMachine or nil
      local initialVelocity = arg.initialVelocity or 0

      self.spawnMachine = spawnMachine
      self.initialVelocity = initialVelocity

      self.inplay=true

      self.node:setOrigin(origin)
      self.node:getGeometry():setDimensions(self.node, dimensions)

      self.beak:setup(arg)


    end

    function bird:spawn(...)
      local arg=... or {}


      self.inplay=true

      self:show()
      self.node:runAction(self.action)
      self.node:setPhysicsBody(self.physicsBody)
      self.node:enableTagged()

      self.steeringBehaviourMachine:enable()

      self.stateMachine:switchStates(self.STATEMACHINE_STATES.spawn)

    self.physicsBody:setCollisionGroup(CollisionGroups.bird)
    self.physicsBody:setCollisionMask(CollisionMasks.bird)
    self.physicsBody:setKinematicPhysics()
    self.physicsBody:setMass(1)

      self.beak:spawn(arg)
    end

    function bird:kill(...)
      local arg=... or {}

      self.beak:kill(arg)

      if self.inplay then
            self.spawnMachine:decreaseSpawnLeft()
        end
      self.inplay=false

      self.steeringBehaviourMachine:enable(false)

      self.node:removeAction(self.node:getName())

    self.physicsBody:setCollisionGroup(CollisionGroups.none)
    self.physicsBody:setCollisionMask(CollisionMasks.none)
      self.node:removePhysicsBody()
      self.node:enableTagged(false)
      self:hide()



      -- put back to hiding values
    end

    function bird:hide()
      self.node:hide(self.perspectiveCamera)

      self.beak:hide()
    end

    function bird:show()
      self.node:show(self.perspectiveCamera)

      self.beak:show()
    end

    function bird:incrementAnimationFrame()
      self.currentFrame = self.currentFrame + 1
      if(self.currentFrame > 8) then self.currentFrame = 0 end

      local name = self:getFrameName()

      if self.texturePacker[1]:has({name=name}) then
        self.node = self.texturePacker[1]:draw({name=name, node=self.node, updateDimensions=false})
      elseif self.texturePacker[2]:has({name=name}) then
        self.node = self.texturePacker[2]:draw({name=name, node=self.node, updateDimensions=false})
      end

      self.beak:incrementAnimationFrame()
    end

    function bird:collide(colliderEntity, collisionPoint)
      self.stateMachine:collide(colliderEntity, collisionPoint)
    end

    function bird:update(timeStep)

      for i = 1, #self.dogs do
        local dogEntity = self.dogs[i]

        if dogEntity.inplay then
          self.steeringBehaviorPursuit:addTarget(dogEntity.node)
          self.steeringBehaviorOffsetPursuit:addTarget(dogEntity.node)
        else
          self.steeringBehaviorOffsetPursuit:removeTarget(dogEntity.node)
          self.steeringBehaviorPursuit:removeTarget(dogEntity.node)
        end
      end

      self.stateMachine:update(timeStep)

      self.beak:update(timeStep)

    end

    function bird:addNeighbors(birds)
      for i = 1, #birds do
        local node = birds[i].node
        if node ~= nil then
          self.steeringBehaviorSeparation:addTarget(node)
        end
      end
    end

    function bird:addBalloonsToEvade(balloons)
      for i = 1, #balloons do
        local node = balloons[i].node
        if node ~= nil then
          self.steeringBehaviorEvade:addTarget(node)
        end
      end
    end


    return bird
  end
}

local Balloon = {
  new = function(...)
    local arg=... or {}

    local texturePacker=arg.texturePacker or {}
    local perspectiveCamera=arg.perspectiveCamera or nil
    local index = arg.index or 0
    local params = arg.params or nil
    local game = arg.game or nil

    assert(texturePacker, "The texturePacker is nil")
    assert(perspectiveCamera, "The perspectiveCamera is nil")
    assert(params, "The params is nil")
    assert(game, "The game is nil")

    local balloon = {
      inplay=false,
      texturePacker=texturePacker,
      perspectiveCamera=perspectiveCamera,
      color = nil,
      node = nil,
      action = nil,
      index = index,
      currentFrame = 0,
      animationClock = nil,
      fps=30,
      params = params,
      game = game,
      ANIMATION_STATES={spawn="thrown"},
      STATEMACHINE_STATES={hit="hit",lob="lob",spawn="spawn"},
      stateMachine=nil,
      currentAnimationState=nil,
    }

    function balloon:getFrameName()
      local name = string.format("projectile_waterBalloon%s_%s_front/projectile_waterBalloon%s_%s_front_%05d", self.color, self.currentAnimationState, self.color, self.currentAnimationState, self.currentFrame)
      return name
    end

    function balloon:load(...)
      local arg=... or {}


      self.color = arg.color or "?"

      local origin = bullet.btVector3(0.0, 0.0, 0.0)

      self.currentAnimationState=self.ANIMATION_STATES.spawn

      local name = self:getFrameName()

      self.node = njlic.Node.create()
      self.node:enableTagged(false)

      if self.texturePacker[1]:has({name=name}) then
        self.node = self.texturePacker[1]:draw({name=name, node=self.node, updateDimensions=false})
      elseif self.texturePacker[2]:has({name=name}) then
        self.node = self.texturePacker[2]:draw({name=name, node=self.node, updateDimensions=false})
      end
      self.node:setName("balloon_"..self.index)

      self.node:setOrigin(origin)
      self:hide()

      self.action = njlic.Action.create()
      self.action:setRepeatForever()
      self.action:setName("balloon_"..self.index)

      self.animationClock = njlic.Clock.create()

      njlic.World.getInstance():getScene():getRootNode():addChildNode(self.node)

      self.physicsBody = njlic.PhysicsBodyRigid.create()
        self.physicsBody:setCollisionGroup(CollisionGroups.projectile)
        self.physicsBody:setCollisionMask(CollisionMasks.projectile)
        self.physicsBody:setAngularFactor(bullet.btVector3(0,0,0))

      self.physicsBody:setName("balloon_physicsbody_"..self.index)
        self.physicsBody:enableHandleCollideCallback()
      assert(self.physicsBody, "physicsBody is null")

      self.physicsShape = njlic.PhysicsShapeSphere.create()
      self.physicsShape:setRadius(5)
      assert(self.physicsShape, "physicsShape is null")

      self.physicsShape:setMargin(1)
      self.physicsBody:setPhysicsShape(self.physicsShape)
      self.physicsBody:setDynamicPhysics()

      -- self.sound = njlic.Sound.create()
      -- self.sound:setName("balloonsound_"..self.index)
      -- local soundName = "sounds/projectile_balloon_water-splash.ogg"
      -- njlic.World.getInstance():getWorldResourceLoader():load(soundName, self.sound)

      local stateMachine = StateMachine.new(self)

      -- STATEMACHINE_STATES={hit="hit",lob="lob",spawn="spawn"},
      stateMachine:addState(self.STATEMACHINE_STATES.hit, {
          enter = function()
              self.currentAnimationState=self.ANIMATION_STATES.spawn
              self.spawnMachine:dispose(self)
          end,
          exit = function()
          end,
          update = function(timeStep)
          end,
          collide = function(colliderEntity, collisionPoint)
          end,
        })
      stateMachine:addState(self.STATEMACHINE_STATES.lob, {
          enter = function()
              self.currentAnimationState=self.ANIMATION_STATES.spawn


              local azimuth = self.params.Projectile.WaterBalloon.Azimuth
              local magnitude = self.params.Projectile.WaterBalloon.Magnitude
              local mass = self.params.Projectile.WaterBalloon.Mass
              local direction = self.direction

              local x = self.node:getWorldTransform():getOrigin():x()
              local y = self.node:getWorldTransform():getOrigin():y()
              local z = self.node:getWorldTransform():getOrigin():z()
              direction = direction:rotate(bullet.btVector3(-1,0,0), math.atan(azimuth, z))
              direction = direction:rotate(bullet.btVector3(0,1,0), math.atan(x, z))
              direction = direction:rotate(bullet.btVector3(-1,0,0), math.atan(y, z))

              self.node:getPhysicsBody():setMass(mass)
              self.node:getPhysicsBody():applyForce(direction * magnitude, true)
          end,
          exit = function()
          end,
          update = function(timeStep)
          end,
          collide = function(colliderEntity, collisionPoint)
              if(colliderEntity.node:getPhysicsBody():getCollisionGroup() == CollisionGroups.bird) then
                  -- self.sound:play()
                  self.stateMachine:switchStates(self.STATEMACHINE_STATES.hit)
              end
          end,
        })
      stateMachine:addState(self.STATEMACHINE_STATES.spawn, {
          enter = function()
              self.currentAnimationState=self.ANIMATION_STATES.spawn

              local min = self.params.Projectile.WaterBalloon.ScaleMin
              local max = self.params.Projectile.WaterBalloon.ScaleMax
              local function randomFloat(lower, greater)
                  return lower + math.random()  * (greater - lower);
              end
              local scale = randomFloat(min, max)
              self.node:setScale(scale)





          end,
          exit = function()
          end,
          update = function(timeStep)
              self.stateMachine:switchStates(self.STATEMACHINE_STATES.lob)
          end,
          collide = function(colliderEntity, collisionPoint)
          end,
        })
      self.stateMachine = stateMachine

    end

    function balloon:unload()
      -- njlic.Sound.destroy(self.sound)

      njlic.PhysicsBodyRigid.destroy(self.physicsBody)
      njlic.PhysicsShapeSphere.destroy(self.physicsShape)

      njlic.Clock.destroy(self.animationClock)
      njlic.Action.destroy(self.action)
      njlic.Node.destroy(self.node)

    end

    function balloon:setup(...)
      local arg=... or {}

      local origin = arg.origin or bullet.btVector3(0.0, 0.0, 0.0)
      local dimensions = arg.dimensions or bullet.btVector2(256.0, 256.0)
      local direction = arg.direction or bullet.btVector3(0.0, 1.0, 0.0)
      local debug = arg.debug or false
      local spawnMachine = arg.spawnMachine or nil

      self.spawnMachine = spawnMachine

      self.inplay=true

      self.node:setOrigin(origin)
      self.node:getGeometry():setDimensions(self.node, dimensions)
      self.direction = direction


    end

    function balloon:spawn(...)
      -- print("spawn balloon")
      local arg=... or {}


      self.inplay=true

      self:show()
      self.node:enableTagged()
      self.node:runAction(self.action)
      self.node:setPhysicsBody(self.physicsBody)

      self.stateMachine:switchStates(self.STATEMACHINE_STATES.spawn)
      
      self.game.balloonsActive = self.game.balloonsActive + 1
    end

    function balloon:kill(...)
      -- print("kill balloon")

      local arg=... or {}
      self.inplay=false

      self.node:removeAction(self.node:getName())

      self.game.balloonsActive = self.game.balloonsActive - 1

      self.node:removePhysicsBody()
      self.node:enableTagged(false)
      self:hide()
      

      -- put back to hiding values
    end

    function balloon:hide()
      self.node:hide(self.perspectiveCamera)
    end

    function balloon:show()
      self.node:show(self.perspectiveCamera)
    end

    function balloon:incrementAnimationFrame()
      self.currentFrame = self.currentFrame + 1
      if(self.currentFrame > 2) then self.currentFrame = 0 end

      local name = self:getFrameName()

      if self.texturePacker[1]:has({name=name}) then
        self.node = self.texturePacker[1]:draw({name=name, node=self.node, updateDimensions=false})
      elseif self.texturePacker[2]:has({name=name}) then
        self.node = self.texturePacker[2]:draw({name=name, node=self.node, updateDimensions=false})
      end

    end

    function balloon:collide(colliderEntity, collisionPoint)
      self.stateMachine:collide(colliderEntity, collisionPoint)
    end

    function balloon:update(timeStep)
      local origin = self.node:getOrigin()

      local die = self.params.Projectile.WaterBalloon.DieY
      if self.node:getOrigin():y() < die then
        -- self:kill()
        self.spawnMachine:dispose(self)
      end

      self.stateMachine:update(timeStep)
    end

    return balloon
  end
}


local Dog = {
  new = function(...)
    local arg=... or {}

    local texturePacker=arg.texturePacker or {}
    local perspectiveCamera=arg.perspectiveCamera or nil
    local index = arg.index or 0
    local params = arg.params or nil
    local game = arg.game or nil

    assert(texturePacker, "The texturePacker is nil")
    assert(perspectiveCamera, "The perspectiveCamera is nil")
    assert(params, "The params is nil")
    assert(game, "The game is nil")

    local dog = {
      inplay=false,
      texturePacker=texturePacker,
      perspectiveCamera=perspectiveCamera,
      node = nil,
      action = nil,
      index = index,
      currentFrame = 0,
      animationClock = nil,
      fps=1.0,
      params = params,
      game=game,
      ANIMATION_STATES={fall="fall",grabbed="grabbed",idle="idle",run="run"},
      left = false,

      STATEMACHINE_STATES={caught="caught",dazed="dazed",land="land",released="released",run="run",spawn="spawn"},
      stateMachine=nil,
      currentAnimationState=nil,
    }

    function dog:getFrameName()
      local state = self.currentAnimationState

      local l = ""
      if(self.left)then
        l = "_left"
      end

      local name = string.format("character_dog_%s_side%s/character_dog_%s_side%s_%05d", state, l, state, l, self.currentFrame)

      return name
    end

    function dog:load(...)
      local arg=... or {}


      local origin = bullet.btVector3(0.0, 0.0, 0.0)

      self.currentAnimationState=self.ANIMATION_STATES.idle

      local name = self:getFrameName()
      self.node = njlic.Node.create()

      if self.texturePacker[1]:has({name=name}) then
        self.node = self.texturePacker[1]:draw({name=name, node=self.node, updateDimensions=false})
      elseif self.texturePacker[2]:has({name=name}) then
        self.node = self.texturePacker[2]:draw({name=name, node=self.node, updateDimensions=false})
      end

      aabbMin, aabbMax = game.levelLoader:getDogWayPointsAabb()
      self.wayPointAabbMin = aabbMin
      self.wayPointAabbMax = aabbMax

      self.sfxClock = njlic.Clock.create()

      if self.node then
        self.node:setName("dog_node_"..self.index)

        self.node:setOrigin(origin)
        self:hide()

        self.action = njlic.Action.create()
        self.action:setRepeatForever()
        self.action:setName("dog_action_"..self.index)

        self.animationClock = njlic.Clock.create()

        njlic.World.getInstance():getScene():getRootNode():addChildNode(self.node)

        self.physicsBody = njlic.PhysicsBodyRigid.create()
        self.physicsBody:setCollisionGroup(CollisionGroups.dog)
        self.physicsBody:setCollisionMask(CollisionMasks.dog)
        self.physicsBody:setAngularFactor(bullet.btVector3(0,0,0))

        self.physicsBody:setName("dog_physicsbody_"..self.index)
        self.physicsBody:enableHandleCollideCallback()

        assert(self.physicsBody, "physicsBody is null")

        self.physicsShape = njlic.PhysicsShapeSphere.create()
        self.physicsShape:setRadius(5)
        assert(self.physicsShape, "physicsShape is null")

        self.physicsShape:setMargin(1)
        self.physicsBody:setPhysicsShape(self.physicsShape)
        self.physicsBody:setKinematicPhysics()

        -- self.sound = njlic.Sound.create()
        -- self.sound:setName("dog_sound_"..self.index)
        -- local soundName = "sounds/projectile_balloon_water-splash.ogg"
        -- njlic.World.getInstance():getWorldResourceLoader():load(soundName, self.sound)

        self.steeringBehaviourMachine = njlic.SteeringBehaviorMachineWeighted.create()
        self.steeringBehaviourFollowPath = njlic.SteeringBehaviorFollowPath.create()

        self.steeringBehaviourMachine:setMaxSpeed(self.params.Dog.MaxSpeed)
        self.steeringBehaviourMachine:setMaxForce(self.params.Dog.MaxForce)

        self.steeringBehaviorEvade = njlic.SteeringBehaviorEvade.create()
        self.steeringBehaviorEvade:setWeight(600.0)
        self.steeringBehaviorEvade:setProbability(1.0)

        self.node:setSteeringBehaviorMachine(self.steeringBehaviourMachine)

        self.constraint = njlic.PhysicsConstraintPointToPoint.create()


      else
      end

      local stateMachine = StateMachine.new(self)

      stateMachine:addState(self.STATEMACHINE_STATES.caught, {
          enter = function()
              self.currentAnimationState=self.ANIMATION_STATES.grabbed
              assert(self.birdAttacking ~= nil, "bird attacking is nil")


              local birdNode_min, birdNode_max = self.birdAttacking.node:getAabb()
              local dogNode_min, dogNode_max = self.node:getAabb()


                self.steeringBehaviourMachine:enable(false)
                self.physicsBody:setDynamicPhysics()
                self.physicsBody:setLinearFactor(bullet3.btVector3(1,1,0))

              self.constraint:setNodes(self.birdAttacking.node, self.node, bullet3.btVector3(0,birdNode_min:y() + 3,0), bullet3.btVector3(0,dogNode_max:y() - 3,-1))

          end,
          exit = function()
                self.physicsBody:setLinearFactor(bullet3.btVector3(1,1,1))
                self.steeringBehaviourMachine:enable(true)
          end,
          update = function(timeStep)
          end,
          collide = function(colliderEntity, collisionPoint)
              if(colliderEntity.node:getPhysicsBody():getCollisionGroup() == CollisionGroups.projectile) then
                  self.birdAttacking.stateMachine:switchStates(self.birdAttacking.STATEMACHINE_STATES.release)
              end
          end,
        })
      stateMachine:addState(self.STATEMACHINE_STATES.dazed, {
          enter = function()
              -- self.game.ybSound.dog_bark1
              -- self.game.ybSound.dog_bark2
              -- self.game.ybSound.dog_howl1
              -- self.game.ybSound.dog_whine1
              self:playSfx(self.game.ybSound.dog_whine1)

              self.currentAnimationState=self.ANIMATION_STATES.idle

              self.steeringBehaviourMachine:clearSteering()
              self.steeringBehaviourMachine:enable(false)

              self.runClock = njlic.Clock.create()

          end,
          exit = function()
              njlic.Clock.destroy(self.runClock)

              self.steeringBehaviourMachine:enable(true)
          end,
          update = function(timeStep)
              local dazedTime = self.params.Dog.DazedTime
              if (self.runClock:getTimeMilliseconds() > dazedTime) then
                  self.runClock:reset()
                  self.stateMachine:switchStates(self.STATEMACHINE_STATES.run)
              end
          end,
          collide = function(colliderEntity, collisionPoint)
          end,
        })
      stateMachine:addState(self.STATEMACHINE_STATES.land, {
          enter = function()
              self.currentAnimationState=self.ANIMATION_STATES.idle
              self.physicsBody:setKinematicPhysics()
              -- self.game.ybSound.dog_bark1
              -- self.game.ybSound.dog_bark2
              -- self.game.ybSound.dog_howl1
              -- self.game.ybSound.dog_whine1
              self:playSfx(self.game.ybSound.dog_howl1)
          end,
          exit = function()
          end,
          update = function(timeStep)
                self.stateMachine:switchStates(self.STATEMACHINE_STATES.run)
          end,
          collide = function(colliderEntity, collisionPoint)
          end,
        })
      stateMachine:addState(self.STATEMACHINE_STATES.released, {
          enter = function()
              self.currentAnimationState=self.ANIMATION_STATES.fall
              self.physicsBody:setDynamicPhysics()
              self.constraint:removeConstraint()
              self.steeringBehaviourMachine:enable(false)
              --
              -- self.game.ybSound.dog_bark1
              -- self.game.ybSound.dog_bark2
              -- self.game.ybSound.dog_howl1
              -- self.game.ybSound.dog_whine1
              self:playSfx(self.game.ybSound.dog_bark2)

          end,
          exit = function()
          end,
          update = function(timeStep)
            if self.node:getOrigin():y() < self.wayPointAabbMin:y() then
                self.stateMachine:switchStates(self.STATEMACHINE_STATES.land)
            end
          end,
          collide = function(colliderEntity, collisionPoint)
          end,
        })
      stateMachine:addState(self.STATEMACHINE_STATES.run, {
          enter = function()

              self.currentAnimationState=self.ANIMATION_STATES.run
              self.steeringBehaviourMachine:addSteeringBehavior(self.steeringBehaviourFollowPath)
              self.steeringBehaviourMachine:enable(true)
              self.physicsBody:setKinematicPhysics()
              -- self.game.ybSound.dog_bark1
              -- self.game.ybSound.dog_bark2
              -- self.game.ybSound.dog_howl1
              -- self.game.ybSound.dog_whine1
              self:playSfx(self.game.ybSound.dog_bark1)
          end,
          exit = function()
              self.steeringBehaviourMachine:removeSteeringBehavior(self.steeringBehaviourFollowPath)
          end,
          update = function(timeStep)
          end,
          collide = function(colliderEntity, collisionPoint)
              if(colliderEntity.node:getPhysicsBody():getCollisionGroup() == CollisionGroups.projectile) then
                  self.stateMachine:switchStates(self.STATEMACHINE_STATES.dazed)
              elseif(colliderEntity.node:getPhysicsBody():getCollisionGroup() == CollisionGroups.bird) then
                  self.stateMachine:switchStates(self.STATEMACHINE_STATES.dazed)
              end
          end,
        })
      stateMachine:addState(self.STATEMACHINE_STATES.spawn, {
          enter = function()
              self.steeringBehaviourMachine:clearSteering()

              self.currentAnimationState=self.ANIMATION_STATES.idle
              self.runClock = njlic.Clock.create()

              self.physicsBody:setKinematicPhysics()
          end,
          exit = function()
              njlic.Clock.destroy(self.runClock)
          end,
          update = function(timeStep)
              if (self.runClock:getTimeMilliseconds() > 3000) then
                  self.runClock:reset()
                  self.stateMachine:switchStates(self.STATEMACHINE_STATES.run)
              end
          end,
          collide = function(colliderEntity, collisionPoint)
          end,
        })
      self.stateMachine = stateMachine


    end

    function dog:playSfx(sfx)
        local sfxTime = (3.0 * 1000)
        if (self.sfxClock:getTimeMilliseconds() > sfxTime) then
            if sfx ~= nil then
                self.sfxClock:reset()
                sfx:play()
            end
        end
    end

    function dog:unload()
      njlic.Clock.destroy(self.sfxClock)

      njlic.PhysicsConstraintPointToPoint.destroy(self.constraint)
      -- njlic.Sound.destroy(self.sound)


      -- njlic.Sound.destroy(self.sound)
      njlic.SteeringBehaviorMachineWeighted.destroy(self.steeringBehaviourMachine)
      njlic.SteeringBehaviorFollowPath.destroy(self.steeringBehaviourFollowPath)
      njlic.SteeringBehaviorEvade.destroy(self.steeringBehaviorEvade)

      njlic.PhysicsBodyRigid.destroy(self.physicsBody)
      njlic.PhysicsShapeSphere.destroy(self.physicsShape)

      njlic.Clock.destroy(self.animationClock)
      njlic.Action.destroy(self.action)
      njlic.Node.destroy(self.node)

    end

    function dog:setup(...)
      local arg=... or {}

      local dimensions = arg.dimensions or bullet.btVector2(256.0, 256.0)
      local path = arg.path or nil
      local debug = arg.debug or false
      local spawnMachine = arg.spawnMachine or nil

      self.spawnMachine = spawnMachine

      self.inplay=true

      self.node:getGeometry():setDimensions(self.node, dimensions)

      assert(path, "The path is nil")

      local origin = path:currentWaypoint()
      self.node:setOrigin(origin)
      self.steeringBehaviourFollowPath:setPath(path)

      self.steeringBehaviourFollowPath:setWaypointSeekDist(1.0)

    end

    function dog:spawn(...)
      local arg=... or {}


      self.inplay=true

      self.stateMachine:switchStates(self.STATEMACHINE_STATES.spawn)

      self:show()
      self.node:runAction(self.action)
      self.node:setPhysicsBody(self.physicsBody)
      self.steeringBehaviourMachine:enable()


      self.left = false
    end

    function dog:kill(...)
      local arg=... or {}

      self.inplay=false

      self.steeringBehaviourMachine:enable(false)
      self.node:removeAction(self.node:getName())

      self.node:removePhysicsBody()
      self:hide()
      self.steeringBehaviourMachine:enable(false)

      -- put back to hiding values
    end

    function dog:hide()
      self.node:hide(self.perspectiveCamera)
    end

    function dog:show()
      self.node:show(self.perspectiveCamera)
    end

    function dog:incrementAnimationFrame()
      self.currentFrame = self.currentFrame + 1
      if(self.currentFrame > 8) then self.currentFrame = 0 end

      local name = self:getFrameName()

      if self.texturePacker[1]:has({name=name}) then
        self.node = self.texturePacker[1]:draw({name=name, node=self.node, updateDimensions=false})
      elseif self.texturePacker[2]:has({name=name}) then
        self.node = self.texturePacker[2]:draw({name=name, node=self.node, updateDimensions=false})
      end
    end

    function dog:collide(colliderEntity, collisionPoint)
      self.stateMachine:collide(colliderEntity, collisionPoint)
    end

    function dog:update(timeStep)
      self.left = self.steeringBehaviourMachine:getCurrentVelocity():normalized():x() < 0.0

      local MAXVEL = 62.0
      local MAXFPS = 30.0
      local MINFPS = 5.0

      local vel = math.abs(self.steeringBehaviourMachine:getCurrentVelocity():x())

      -- x/30 == vel/maxvel
      -- vel * 30 = x * maxvel
      -- x = vel * 30 / maxvel
      local x = (vel * MAXFPS) / MAXVEL
      if x < MINFPS then x = MINFPS end
      if x > MAXFPS then x = MAXFPS end

      if self.currentAnimationState==self.ANIMATION_STATES.run then self.fps = x end

      self.stateMachine:update(timeStep)
    end

    function dog:addBirdsToEvade(birds)
      for i = 1, #birds do
        local node = birds[i].node
        if node ~= nil then
          self.steeringBehaviorEvade:addTarget(node)
        end
      end
    end

    return dog
  end
}

local Billboard = {
  new = function(...)
    local arg=... or {}

    local levelTexturePacker=arg.levelTexturePacker or {}
    local perspectiveCamera=arg.perspectiveCamera or nil
    local index = arg.index or 0
    local params = arg.params or nil

    local billboard = {
      inplay=false,
      node = nil,
      levelTexturePacker=levelTexturePacker,
      perspectiveCamera=perspectiveCamera,
      node = nil,
      index = index,
      params = params
    }

    function billboard:load(...)
      local arg=... or {}

      local name = arg.name or "?"
      local origin = arg.origin or bullet.btVector3(0.0, 0.0, 0.0)
      local dimensions = arg.dimensions or bullet.btVector2(0.0, 0.0)

      self.node = njlic.Node.create()
      self.node = self.levelTexturePacker[1]:draw({name=name, node=self.node, updateDimensions=false})
      self.node:setName("Billboard_"..name.."_"..self.index)

      self.node:getGeometry():setDimensions(self.node, dimensions)
      self.node:setOrigin(origin)
      self.node:enableTagged(false)
      self:hide()

      njlic.World.getInstance():getScene():getRootNode():addChildNode(self.node)

      return true

    end

    function billboard:unload()
      njlic.Node.destroy(self.node)
    end

    function billboard:spawn(...)
      local arg=... or {}

      self:show()
      self.node:enableTagged()

      self.inplay=true
    end

    function billboard:kill(...)
      local arg=... or {}

      self.inplay=false
      self.node:enableTagged(false)

      self:hide()
    end

    function billboard:hide()
      self.node:hide(self.perspectiveCamera)
    end

    function billboard:show()
      self.node:show(self.perspectiveCamera)
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
      gameplayTexturePacker = {},
      debugTexturePacker = {},
      shader = nil,
      chubiBirdPool = {},
      garuBirdPool = {},
      momiBirdPool = {},
      puffyBirdPool = {},
      weboBirdPool = {},
      zuruBirdPool = {},
      allBirdPool = {},
      balloonPool = {},
      dogPool = {},
      billboardPool = {},

      perspectiveCameraNode = nil,
      perspectiveCamera = nil,

      orthographicCameraNode = nil,
      orthographicCamera = nil,

      run = false,
        canPursue = true,
        lose = false,
        win = false,
        paused = false,
        stageTexturePackerTable = {},
    }

    function game:loadLevel(stage, levelNum, mode)
        local debug = false

        self.levelLoader:loadLevel({debug=debug, loc=stage, levelNum=levelNum, mode=mode})
        -- table.insert(self.levelTexturePacker, TexturePacker({file=string.format("%s0", stage)}))
        table.insert(self.levelTexturePacker, self.stageTexturePackerTable[stage])

        for i = 1, self.levelLoader:numSpawnPoints() do
            local point = self.levelLoader:getSpawnPoint(i)
            self.spawnMachine:addArcadeSpawnPoint(point)
        end

        for i = 1, self.levelLoader:numTiles() do
            local billboardParams = self.levelLoader:getBillboardParams(i)
            local billboard = Billboard.new({
                levelTexturePacker=self.levelTexturePacker,
                perspectiveCamera=self.perspectiveCamera,
                index=i,
                params=self.params,
            })

            if billboard:load(billboardParams) then
                table.insert(self.billboardPool, billboard)
            end
        end

        local numberOfDogs = 1

        for i = 1, numberOfDogs do
            local dog = Dog.new({
                texturePacker=self.gameplayTexturePacker,
                perspectiveCamera=self.perspectiveCamera,
                index=i,
                params=self.params,
                game = self,
            })
            dog:load()
            table.insert(self.dogPool, dog)
        end
    end

    function game:load()
        local debug = false


      local shader = njlic.ShaderProgram.create()
      assert(njlic.World.getInstance():getWorldResourceLoader():load("shaders/StandardShader.vert", "shaders/StandardShader.frag", shader))
      self.shader = shader

      -- ###################################################################################################
      --
      self.stageTexturePackerTable["country"] = TexturePacker({file=string.format("%s0", "country")})

      table.insert(self.gameplayTexturePacker, TexturePacker({file="gameplay0"}))
      table.insert(self.gameplayTexturePacker, TexturePacker({file="gameplay1"}))
      if debug then
        table.insert(self.debugTexturePacker, TexturePacker({file="debug0"}))
      end

      -- ###################################################################################################




      -- ###################################################################################################

      local scene = njlic.Scene.create()

      local rootNode = njlic.Node.create()
      rootNode:setOrigin(bullet3.btVector3(0,0,0))

      scene:setRootNode(rootNode)

      njlic.World.getInstance():setScene(scene)

      -- ###################################################################################################

      self.perspectiveCameraNode = njlic.Node.create()
      self.perspectiveCameraNode:setName("perspectiveCamera")

      self.perspectiveCamera = njlic.Camera.create()
      self.perspectiveCamera:enableOrthographic(false)
      self.perspectiveCamera:setRenderCategory(RenderCategories.perspective)
      self.perspectiveCamera:setName("perspectiveCamera")

      self.perspectiveCameraNode:setCamera(self.perspectiveCamera)

      rootNode:addChildNode(self.perspectiveCameraNode)
      if debug then
          njlic.World.getInstance():enableDebugDraw(self.perspectiveCamera)
      end

      -- ###################################################################################################

      self.orthographicCameraNode = njlic.Node.create()
      self.orthographicCameraNode:setName("orthographicCameraNode")

      self.orthographicCamera = njlic.Camera.create()
      self.orthographicCamera:enableOrthographic(true)
      self.orthographicCamera:setRenderCategory(RenderCategories.orthographic)
      self.orthographicCamera:setName("orthographicCamera")

      self.orthographicCameraNode:setCamera(self.orthographicCamera)

      rootNode:addChildNode(self.orthographicCameraNode)
      njlic.World.getInstance():getScene():setTouchCamera(self.orthographicCamera)

      -- ###################################################################################################

      self.physicsWorld = njlic.PhysicsWorld.create()
      self.physicsWorld:setGravity(self.params.World.Gravity)

      njlic.World.getInstance():getScene():setPhysicsWorld(self.physicsWorld)

      -- ###################################################################################################





      -- YappyBirdFont = BitmapFont(
      -- {
      --   names=
      --   {
      --   "Ranchers", 
      --   },
      --   maxadvance=160
      -- })

      -- print_r(self.YappyBirdFont)



      self.displayNode, self.displayNodeRect = YappyBirdFont:printf({
        mainNode=nil,
        text="ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789",
        align="Left",
        maxwidth=(njlic.SCREEN():x()),
      })
      local vert_margin = njlic.SCREEN():y() / 30.0
      local horiz_margin = njlic.SCREEN():x() / 60.0
      self.displayNode:setOrigin(bullet.btVector3(horiz_margin * 1, vert_margin * 1, -1))
      self.displayNode:show(self.orthographicCamera)
      self.displayNode:hide(self.orthographicCamera)


      self.interfaceTexturePacker = TexturePacker({file="interface0"})

      self.ybSound = YappyBirdsSound.new()

      self.ybSound:load()


      -- self.ui = UserInterface()
      self.ybUi = YappyBirdUi.new({camera=self.orthographicCamera, game=self})

      -- print_r(self.ybUi.ui)

      self.ybUi:showSplash()

      local pauseButton, pauseButtonRect, pauseButtonId = self.ybUi:getUi():createButton({
          off = "butn_pause_off", 
          on = "butn_pause_on", 
          x = 200, 
          y = 200, 
          node = njlic.Node.create(), 
          tp = self.interfaceTexturePacker, 
          camera = self.orthographicCamera,
          down = function() 
              -- print("pausedown")
          end,
          up = function()
              local paused = njlic.World.getInstance():isPausedGame()
              -- print("pause up", paused)
              njlic.World.getInstance():enablePauseGame(not paused)
          end,
          scale = 10,
          enabled = true,
          --upSoundFileName = "sounds/interface_select-whoosh.ogg",
          soundTouchUpInside = self.ybSound.interface_select_whoosh,
      })
      local vert_margin = njlic.SCREEN():y() / 30.0
      local horiz_margin = njlic.SCREEN():x() / 60.0
      local width = (pauseButtonRect:x() / 3.0) 
      local height = (pauseButtonRect:y() / 3.0) 

      pauseButton:setOrigin(
      bullet.btVector3((njlic.SCREEN():x() - (width)) , (height / 2.0) + (vert_margin * 2), -1)
      )
      self.pauseButton = pauseButton
      self.pauseButton:hide(self.orthographicCamera)


      local numberOfBirdsEach = 10
      local numberOfBalloons = 100

      local bird = nil
      for i = 1, numberOfBirdsEach do

        bird = Bird.new({
            texturePacker=self.gameplayTexturePacker,
            perspectiveCamera=self.perspectiveCamera,
            birdName=self.CHUBI,
            index=i,
            params=self.params,
            dogs = self.dogPool,
            game = self,
            })
        bird:load()
        table.insert(self.chubiBirdPool, bird)
        table.insert(self.allBirdPool, bird)


        bird = Bird.new({
            texturePacker=self.gameplayTexturePacker,
            perspectiveCamera=self.perspectiveCamera,
            birdName=self.GARU,
            index=i,
            params=self.params,
            dogs = self.dogPool,
            game = self,
            })
        bird:load()
        table.insert(self.garuBirdPool, bird)
        table.insert(self.allBirdPool, bird)

        bird = Bird.new({
            texturePacker=self.gameplayTexturePacker,
            perspectiveCamera=self.perspectiveCamera,
            birdName=self.MOMI,
            index=i,
            params=self.params,
            dogs = self.dogPool,
            game = self,
            })
        bird:load()
        table.insert(self.momiBirdPool, bird)
        table.insert(self.allBirdPool, bird)

        bird = Bird.new({
            texturePacker=self.gameplayTexturePacker,
            perspectiveCamera=self.perspectiveCamera,
            birdName=self.PUFFY,
            index=i,
            params=self.params,
            dogs = self.dogPool,
            game = self,
            })
        bird:load()
        table.insert(self.puffyBirdPool, bird)
        table.insert(self.allBirdPool, bird)

        bird = Bird.new({
            texturePacker=self.gameplayTexturePacker,
            perspectiveCamera=self.perspectiveCamera,
            birdName=self.WEBO,
            index=i,
            params=self.params,
            dogs = self.dogPool,
            game = self,
            })
        bird:load()
        table.insert(self.weboBirdPool, bird)
        table.insert(self.allBirdPool, bird)

        bird = Bird.new({
            texturePacker=self.gameplayTexturePacker,
            perspectiveCamera=self.perspectiveCamera,
            birdName=self.ZURU,
            index=i,
            params=self.params,
            dogs = self.dogPool,
            game = self,
            })
        bird:load()
        table.insert(self.zuruBirdPool, bird)
        table.insert(self.allBirdPool, bird)
      end

      for i = 1, #self.allBirdPool do
        self.allBirdPool[i]:addNeighbors(self.allBirdPool)
      end


      local balloon = nil
      local colors = {"Blue", "Green", "Purple", "Red", "Yellow"}
      for i = 1, numberOfBalloons do

        local color = colors[math.random(5)]

        balloon = Balloon.new({
            texturePacker=self.gameplayTexturePacker,
            perspectiveCamera=self.perspectiveCamera,
            index=i,
            params=self.params,
            game = self,
            })
        balloon:load({color=color})
        table.insert(self.balloonPool, balloon)
      end

      for i = 1, #self.allBirdPool do
        self.allBirdPool[i]:addBalloonsToEvade(self.balloonPool)
      end

      for i = 1, #self.dogPool do
          self.dogPool[i]:addBirdsToEvade(self.allBirdPool)
      end

    end

    function game:unload()
        print('game:unload()')

      self.stageTexturePackerTable = {}

      self.run = false

      if nil ~= self.physicsWorld then
          njlic.PhysicsWorld.destroy(self.physicsWorld)
      end

      if nil ~= self.orthographicCamera then
          njlic.Camera.destroy(self.orthographicCamera)
      end

      if nil ~= self.orthographicCameraNode then
          njlic.Node.destroy(self.orthographicCameraNode)
      end

      if nil ~= self.perspectiveCamera then
          njlic.Camera.destroy(self.perspectiveCamera)
      end

      if nil ~= self.perspectiveCameraNode then
          njlic.Node.destroy(self.perspectiveCameraNode)
      end

      local scene = njlic.World.getInstance():getScene()
      local rootNode = scene:getRootNode()
      if nil ~= rootNode then
          njlic.Node.destroy(rootNode)
      end

      if nil ~= scene then
          njlic.Scene.destroy(scene)
      end

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

      if nil ~= self.shader then
          njlic.ShaderProgram.destroy(self.shader)
      end

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

      self.allBirdPool = {}

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

    function game:collide(node, otherNode, collisionPoint)
      if self.run then
        self.spawnMachine:collide(node, otherNode, collisionPoint)
      end
    end

    function game:update(timeStep)
      
        local status, err = pcall(self.ybUi:getUi().update, self.ybUi:getUi(), timeStep)
        if not status then error(err) end

      local from = self.perspectiveCameraNode:getOrigin()
      local dir = self.perspectiveCamera:getForwardVector()

      local debugDrawer = njlic.World.getInstance():getDebugDrawer()
      -- debugDrawer:line( bullet.btVector3(-100.0, 0.0, 10.0), bullet.btVector3(100.0, 0.0, 10.0))

      if self.run then


          if self.win then
              self:stop()

              local YappyBirdsData = require 'YAPPYBIRDS.SaveData'
              local fp = njlic.DOCUMENT_PATH("yappybirds.lua")
              local d = YappyBirdsData.new({filepath=fp})

              local level = self.yappyBirdsUi.level
              local stage = self.yappyBirdsUi.stage
              local mode = self.yappyBirdsUi.mode

              -- TODO: Get a score
              local score = 1

              d:set(stage, level, mode, score)
              if level < 15 then
                  d:set(stage, level + 1, mode, 0)
              end

              if self.yappyBirdsUi.mode == "timeattack" then
                  self.yappyBirdsUi:showWinTimeAttack()
              elseif self.yappyBirdsUi.mode == "arcade" then
                  local percentage = 0
                  if self.balloonsThrown > 0 then
                      percentage = ((self.balloonsHit / self.balloonsThrown ) * 100.0)
                  end

                  self.yappyBirdsUi:showWinArcade(self.balloonsHit, self.balloonsThrown, percentage)
              elseif self.yappyBirdsUi.mode == "survival" then
                  self.yappyBirdsUi:showWinSurvival()
              end
          end

          if self.lose then
              self:stop()

              if self.yappyBirdsUi.mode == "timeattack" then
                  self.yappyBirdsUi:showLoseTimeAttack()
              elseif self.yappyBirdsUi.mode == "arcade" then
                  self.yappyBirdsUi:showLoseArcade()
              elseif self.yappyBirdsUi.mode == "survival" then
                  self.yappyBirdsUi:showLoseSurvival()
              end
          end

        if not self.paused then 
            self.spawnMachine:tick(self, timeStep)
        end

        local number_words = njlic.convertToWords(self.spawnMachine:birdsLeftToSpawn())
        local balloonsAvailable = self.balloonsAvailable or 0
        local balloonsActive = self.balloonsActive or 0

        local available = balloonsAvailable - balloonsActive
        local birds_left = njlic.convertToWords(available)
        local bal = "balloon"
        if available > 1 then
            bal = "balloons"
        end
        brd = "bird"
        if self.spawnMachine:birdsLeftToSpawn() > 1 then
            brd = "birds"
        end

      local birdsLeft = string.format("You have %s %s and there are %s %s left.", birds_left, bal, number_words, brd)

      local displayWords = not(self.win == true or self.lose == true)

      if displayWords then

          self.displayNode, self.displayNodeRect = YappyBirdFont:printf({
            mainNode=self.displayNode,
            text=birdsLeft,
            align="Left",
            maxwidth=(njlic.SCREEN():x()),
          })
      end
      -- self.displayNode:show(self.orthographicCamera)

        if self.spawnMachine.done then
            if self.yappyBirdsUi.mode == "timeattack" then
            elseif self.yappyBirdsUi.mode == "arcade" then
                if self.spawnMachine:birdsLeftToSpawn() <= 0 then
                    self.win = true
                end
            elseif self.yappyBirdsUi.mode == "survival" then
            end
        end


      end

      -- if not self.run then
      --   self:start()
      -- end
    end

    function game:updateAction(action, timeStep)
        if not self.paused then 
    
            local node = action:getParent()
            local gameEntity = self.spawnMachine:gameEntity(node:getName())

            if nil ~= gameEntity then
                local animationClock = gameEntity.animationClock
                if (animationClock:getTimeMilliseconds() / 1000) > (1.0 / gameEntity.fps) then
                    animationClock:reset()
                    gameEntity:incrementAnimationFrame()
                end
            end
        end
    end

    function game:worldGamePause()

        self.paused = true
    end

    function game:worldGameUnPause()

        self.paused = false
    end


    function game:click(x, y)
        checkEnableDebugFunctions(x, y)


        local balloonsAvailable = self.balloonsAvailable or 0
        local balloonsActive = self.balloonsActive or 0

        local hasBalloon = false
        local available = balloonsAvailable - balloonsActive

        if available > 0 then
            hasBalloon = true
        end

        -- print("avaialbe ballooons", available)

      -- print(self.balloonsActive)
      -- if not hasBalloon then
      --     print("cannot!")
      -- end

      if hasBalloon and self.run and not self.ybUi:getUi():anyTouched() then

          if not self.paused then
              local origin = self.params:originForLayer({x=x, y=y}, 10)
              local dimensions = self.params:dimensionForLayer()
              local queued = self.spawnMachine:queueBalloon({
                  origin = origin,
                  dimensions = dimensions,
                  direction = self.perspectiveCamera:getForwardVector(),
              })

              if queued then
                  self.balloonsThrown = self.balloonsThrown + 1
              end
          end

      end

    end

    function game:down(rayContact)
        local addr = rayContact:getDeviceTouch():getAddress()
        local status, err = pcall(self.ybUi:getUi().down, self.ybUi:getUi(), rayContact)
        if not status then error(err) end
    end
    
    function game:up(rayContact)
        local addr = rayContact:getDeviceTouch():getAddress()
        local status, err = pcall(self.ybUi:getUi().up, self.ybUi:getUi(), rayContact)
        if not status then error(err) end
    end
    
    function game:move(rayContact)
        local addr = rayContact:getDeviceTouch():getAddress()
        local status, err = pcall(self.ybUi:getUi().move, self.ybUi:getUi(), rayContact)
        if not status then error(err) end
    end

    function game:cancelled(rayContact)
        local status, err = pcall(self.ybUi:getUi().cancelled, self.ybUi:getUi(), rayContact)
        if not status then error(err) end
    end

    function game:missed(node, deviceTouch)
        local status, err = pcall(self.ybUi:getUi().missed, self.ybUi:getUi(), node, deviceTouch)
        if not status then error(err) end
    end

    function game:pause()
    end

    function game:unpause()
    end

    function game:stop()
        if self.run then
            self.run = false

            self.pauseButton:hide(self.orthographicCamera)
            self.displayNode:hide(self.orthographicCamera)

            for i = 1, #self.billboardPool do
              local billboard = self.billboardPool[i]
              billboard:kill()
            end

            self.spawnMachine:reset(self.orthographicCamera)
            self.ybSound.interface_gameplay_theme:stop()
        end
    end

    function game:start(yappyBirdsUi)
        self.balloonsThrown = 0
        self.balloonsHit = 0
        self.balloonsActive = 0
        self.balloonsAvailable = 3

        self.yappyBirdsUi = yappyBirdsUi

      if not self.run then
          self.ybSound.interface_gameplay_theme:play()
          self.ybSound.interface_gameplay_theme:enableLooping()

          self.canPursue = true

        self.spawnMachine.gameplay = self

        self:loadLevel(yappyBirdsUi.stage, yappyBirdsUi.level, yappyBirdsUi.mode)

        for i = 1, #self.billboardPool do
          local billboard = self.billboardPool[i]
          billboard:spawn()
        end

        njlic.World.getInstance():setBackgroundColor(self.levelLoader.backgroundColor)

        local numDogsInLevel = 1

        local numWayPoints = self.levelLoader:numDogWayPoints()
        assert(numWayPoints > 0, "There are no way points")

        for i=1, numDogsInLevel do

          local index = math.random(numWayPoints)
          local wayPoint = self.levelLoader:getDogWayPointParams(1)

          local path = self.levelLoader:createWaypointPath()

          assert(path, "The path is nil")

          local queued = self.spawnMachine:queueDog({
              path=path,
              dimensions = wayPoint.dimensions,
            })
          if not queued then
          else
          end
        end

          self.pauseButton:show(self.orthographicCamera)
          self.displayNode:show(self.orthographicCamera)

        self.run = true
        self.lose = false
        self.win = false
      end
    end

    function game:_availableBird(...)
      local arg=... or {}

      local origin = arg.origin or nil
      local dimensions = arg.dimensions or nil
      local debug = arg.debug or true
      local spawnMachine = arg.spawnMachine or nil
      local initialVelocity = arg.initialVelocity or 0

      assert(origin, "origin is nil")
      assert(dimensions, "dimensions is nil")

      if arg.name == self.CHUBI then
        for i, v in ipairs(self.chubiBirdPool) do
          if not v.inplay then
            v:setup({
              origin=origin,
              dimensions=dimensions,
              debug=debug,
              spawnMachine=spawnMachine,
              initialVelocity=initialVelocity
              })
            return v
          end
        end
      elseif arg.name == self.GARU then
        for i, v in ipairs(self.garuBirdPool) do
          if not v.inplay then
            v:setup({
              origin=origin,
              dimensions=dimensions,
              debug=debug,
              spawnMachine=spawnMachine,
              initialVelocity=initialVelocity
              })
            return v
          end
        end
      elseif arg.name == self.MOMI then
        for i, v in ipairs(self.momiBirdPool) do
          if not v.inplay then
            v:setup({
              origin=origin,
              dimensions=dimensions,
              debug=debug,
              spawnMachine=spawnMachine,
              initialVelocity=initialVelocity
              })
            return v
          end
        end
      elseif arg.name == self.PUFFY then
        for i, v in ipairs(self.puffyBirdPool) do
          if not v.inplay then
            v:setup({
              origin=origin,
              dimensions=dimensions,
              debug=debug,
              spawnMachine=spawnMachine,
              initialVelocity=initialVelocity
              })
            return v
          end
        end
      elseif arg.name == self.WEBO then
        for i, v in ipairs(self.weboBirdPool) do
          if not v.inplay then
            v:setup({
              origin=origin,
              dimensions=dimensions,
              debug=debug,
              spawnMachine=spawnMachine,
              initialVelocity=initialVelocity
              })
            return v
          end
        end
      elseif arg.name == self.ZURU then
        for i, v in ipairs(self.zuruBirdPool) do
          if not v.inplay then
            v:setup({
              origin=origin,
              dimensions=dimensions,
              debug=debug,
              spawnMachine=spawnMachine,
              initialVelocity=initialVelocity
              })
            return v
          end
        end
      end

      return nil
    end

    function game:_availableBalloon(...)
      local arg=... or {}

      local origin = arg.origin or bullet.btVector3(0.0, 0.0, 0.0)
      local dimensions = arg.dimensions or bullet.btVector2(256.0, 256.0)
      local direction = arg.direction or bullet.btVector3(0.0, 1.0, 0.0)
      local debug = arg.debug or true
      local spawnMachine = arg.spawnMachine or nil

      for i, v in ipairs(self.balloonPool) do
        if not v.inplay then
          v:setup({
              origin=origin,
              dimensions=dimensions,
              direction=direction,
              debug=debug,
              spawnMachine=spawnMachine
              })
          return v
        end
      end

      return nil
    end

    function game:_availableDog(...)
      local arg=... or {}

--      local origin = arg.origin or bullet.btVector3(0.0, 0.0, 0.0)
      local dimensions = arg.dimensions or bullet.btVector2(256.0, 256.0)
      local path = arg.path or nil
      local debug = arg.debug or false
      local spawnMachine = arg.spawnMachine or nil

      for i, v in ipairs(self.dogPool) do
        if not v.inplay then
          v:setup({
              path=path,
--              origin=origin,
              dimensions=dimensions,
              debug=debug,
              spawnMachine=spawnMachine
              })
          return v
        end
      end

      return nil
    end

    return game
  end
}

njlic.World.getInstance():setBackgroundColor(1.000, 0.000, 1.000)

local TestDebugDraw = {
  new = function()
    local test = {
    }

    function test:load()

--      self.shader = njlic.ShaderProgram.create()
--      assert(njlic.World.getInstance():getWorldResourceLoader():load("shaders/PassThrough.vert", "shaders/PassThrough.frag", self.shader))

      local scene = njlic.Scene.create()
      local rootNode = njlic.Node.create()
      rootNode:setOrigin(bullet3.btVector3(0,-0.5,-1))
      scene:setRootNode(rootNode)
      njlic.World.getInstance():setScene(scene)

      self.perspectiveCameraNode = njlic.Node.create()
      self.perspectiveCameraNode:setName("perspectiveCamera")

      self.perspectiveCamera = njlic.Camera.create()
      self.perspectiveCamera:enableOrthographic(false)
--      self.perspectiveCamera:setRenderCategory(RenderCategories.perspective)
      self.perspectiveCamera:setName("perspectiveCamera")

      self.perspectiveCameraNode:setCamera(self.perspectiveCamera)
      -- self.perspectiveCamera:lookAt(btVector3(0,0,0))

      rootNode:addChildNode(self.perspectiveCameraNode)

      njlic.World.getInstance():enableDebugDraw(self.perspectiveCamera)

    end

    function test:unload()

      njlic.Camera.destroy(self.perspectiveCamera)
      njlic.Node.destroy(self.perspectiveCameraNode)

--      njlic.ShaderProgram.destroy(self.shader)
    end

    function test:plane()
        local debugDrawer = njlic.World.getInstance():getDebugDrawer()

        local center = bullet.btVector3(0.0, 0.0, 10.0)
        local planeNormal = bullet.btVector3(0.0, 1.0, -1.0)
        local planeColor = bullet.btVector3(0.0, 0.0, 1.0)
        local normalVecColor = bullet.btVector3(1.0, 0.0, 0.0)
        local planeScale = 1.0
        local normalVecScale = 1.0
        debugDrawer:plane(center, planeNormal, planeColor, normalVecColor, planeScale, normalVecScale)
    end

    function test:arrow()
        local debugDrawer = njlic.World.getInstance():getDebugDrawer()

        local from = bullet.btVector3(1.0, 0.0, 3.0)
        local to = bullet.btVector3(1.0, 1.0, 3.0)
        local color = bullet.btVector3(0.0, 0.0, 1.0)
        local size = 0.1

        debugDrawer:arrow( from, to, color, size)
    end

    function test:axisTriad()
        local debugDrawer = njlic.World.getInstance():getDebugDrawer()

        local transform = bullet.btTransform.getIdentity()

        local origin = bullet.btVector3(-1.0, 0.5, 3.0)
        transform:setOrigin(origin)

        local size = 0.1
        local length = 1.0

        debugDrawer:axisTriad(transform, size, length)
    end

    function test:frustum()
        local debugDrawer = njlic.World.getInstance():getDebugDrawer()

        local camera = self.perspectiveCameraNode:getCamera()
        local proj = camera:getProjection()
        local view = self.perspectiveCameraNode:getTransform()

        local origin = bullet.btVector3(-1.0, 0.5, 3.0)
        view:setOrigin(origin)

        -- local clip = proj * view

        local color = bullet.btVector3(1.0, 0.0, 0.0)

        debugDrawer:frustum(view, proj, color)
    end

    function test:xzSquareGrid()
        local debugDrawer = njlic.World.getInstance():getDebugDrawer()

        local mins = -5000.0
        local maxs = 5000.0
        local step = 1.0
        local color = bullet.btVector3(1.0, 0.0, 0.0)

        debugDrawer:xzSquareGrid(mins, maxs, -1.0, step, color)
        debugDrawer:xzSquareGrid(mins, maxs, 10.0, step, color)
    end

    function test:update(timestep)
      njlic.World.getInstance():setBackgroundColor(1.000, 1.000, 1.000)

      local from = self.perspectiveCameraNode:getOrigin()
      local dir = self.perspectiveCamera:getForwardVector()

      local debugDrawer = njlic.World.getInstance():getDebugDrawer()
      -- debugDrawer:line( from, dir * 1000)

      -- debugDrawer:line( bullet.btVector3(-100.0, 0.0, 0.0), bullet.btVector3(100.0, 0.0, 0.0))
      -- debugDrawer:line( bullet.btVector3(-100.0, 0.0, 1.0), bullet.btVector3(100.0, 0.0, 1.0))
      -- debugDrawer:line( bullet.btVector3(-100.0, 0.0, 2.0), bullet.btVector3(100.0, 0.0, 2.0))
      -- debugDrawer:line( bullet.btVector3(-100.0, 0.0, 3.0), bullet.btVector3(100.0, 0.0, 3.0), bullet.btVector3(0.0, 1.0, 0.0))
      -- debugDrawer:line( bullet.btVector3(0.0, -100.0, 3.0), bullet.btVector3(0.0, 100.0, 3.0), bullet.btVector3(0.0, 0.0, 1.0))
      -- debugDrawer:line( bullet.btVector3(-100.0, 0.0, 4.0), bullet.btVector3(100.0, 0.0, 4.0))
      -- debugDrawer:line( bullet.btVector3(-100.0, 0.0, 5.0), bullet.btVector3(100.0, 0.0, 5.0))
      -- debugDrawer:line( bullet.btVector3(-100.0, 0.0, 6.0), bullet.btVector3(100.0, 0.0, 6.0))
      -- debugDrawer:line( bullet.btVector3(-100.0, 0.0, 7.0), bullet.btVector3(100.0, 0.0, 7.0))
      -- debugDrawer:line( bullet.btVector3(-100.0, 0.0, 8.0), bullet.btVector3(100.0, 0.0, 8.0))
      -- debugDrawer:line( bullet.btVector3(-100.0, 0.0, 9.0), bullet.btVector3(100.0, 0.0, 9.0))
      -- debugDrawer:line( bullet.btVector3(-100.0, 0.0, 10.0), bullet.btVector3(100.0, 0.0, 10.0))
      --
      -- local div = 1.0
      -- for i=0,100 do
      --     local j = i * 0.1
      --     local x = j * (j / div)
      --     debugDrawer:line( bullet.btVector3(x, 0.0, 3.0), bullet.btVector3(x, 1.0, 3.0), bullet.btVector3(0.0, 0.0, 1.0))
      -- end
      -- debugDrawer:point(bullet.btVector3(0.0, 0.0, 3.0), bullet.btVector3(1.0, 0.0, 0.0), 20)
      -- debugDrawer:projectedText("THIS", bullet.btVector3(0, 0, 3), bullet.btVector3(0,1,0), 10)
      -- debugDrawer:screenText("THAT", bullet.btVector3(0, 0, 3), bullet.btVector3(0,1,0), 10)


        -- self:plane()
        -- self:arrow()
        -- self:axisTriad()
        -- self:frustum()
        -- self:xzSquareGrid()

      local scene = njlic.World.getInstance():getScene()
      local rootNode = scene:getRootNode()


    end

      function test:collide(node, otherNode, collisionPoint)
      end

    function test:click(x, y)
    end

      function test:updateAction(action, timeStep)
      end

    return test

  end

}









local TestFont = {
  new = function()
    local test = {
        align = 'left',
        iteration = 1,
    }

    function test:load()

      local scene = njlic.Scene.create()
      local rootNode = njlic.Node.create()
      rootNode:setOrigin(bullet3.btVector3(0,0,0))
      scene:setRootNode(rootNode)
      njlic.World.getInstance():setScene(scene)

      self.orthographicCameraNode = njlic.Node.create()
      self.orthographicCameraNode:setName("orthographicCameraNode")

      self.orthographicCamera = njlic.Camera.create()
      self.orthographicCamera:enableOrthographic(true)
      self.orthographicCamera:setRenderCategory(RenderCategories.orthographic)
      self.orthographicCamera:setName("orthographicCamera")

      self.orthographicCameraNode:setCamera(self.orthographicCamera)

      rootNode:addChildNode(self.orthographicCameraNode)

      -- self.YappyBirdFont = BitmapFont(
      -- {
      --   names=
      --   {
      --   "Ranchers", 
      --   },
      --   maxadvance=160
      -- })





      local percentage = 100.0
      wordStatusFormat = "You threw %.0f ballons and made contact with %.0f of those ballons.\nYour accuracy is %.0f%%!\n%s" 

      if percentage == 100.0 then
          wordStatus = "Perfect!"
      elseif percentage >= 60.0 then
          wordStatus = "OK!"
      else
          wordStatus = "You Passed!"
      end

      text = string.format(wordStatusFormat, 10, 10, percentage, wordStatus)

      self.displayNode, self.displayNodeRect = YappyBirdFont:printf({
        mainNode=self.displayNode,
        text=text,
        align="center",
        maxwidth=(njlic.SCREEN():x()),
      })
      local vert_margin = njlic.SCREEN():y() / 30.0
      local horiz_margin = njlic.SCREEN():x() / 60.0

      local x = 0.0 -- njlic.SCREEN():x() - self.displayNodeRect.width
      local y = 0.0 -- self.displayNodeRect.height --(vert_margin * 10)

      self.displayNode:setOrigin(bullet.btVector3(x, y, -1))
      self.displayNode:show(self.orthographicCamera)
self.totalTimeStep = 0
    end

    function test:unload()
      njlic.Camera.destroy(self.orthographicCamera)
      njlic.Node.destroy(self.orthographicCameraNode)
    end

    function test:update(timestep)
      njlic.World.getInstance():setBackgroundColor(1.000, 1.000, 1.000)
      local message = string.format("The timestep is %f. The total amount accumulated is %f.", timestep, self.totalTimeStep)
      
      -- self.displayNode, self.displayNodeRect = YappyBirdFont:printf(message)

        self.totalTimeStep = self.totalTimeStep + timestep

      local percentage = 100.0
      wordStatusFormat = "You threw %.0f ballons and made contact with %.0f of those ballons.\nYour accuracy is %.0f%%!\n%s" 

      if percentage == 100.0 then
          wordStatus = "Perfect!"
      elseif percentage >= 60.0 then
          wordStatus = "OK!"
      else
          wordStatus = "You Passed!"
      end

      text = string.format(wordStatusFormat, 10, 10, percentage, wordStatus)

      local align = "left"
      if math.modf(self.iteration, 3) == 0 then
          align = "center"
      elseif math.modf(self.iteration, 3) == 1 then
          align = "right"
      end
      self.iteration = self.iteration + 1

      self.displayNode, self.displayNodeRect = YappyBirdFont:printf({
        mainNode=self.displayNode,
        text=text,
        align="center",
        maxwidth=(njlic.SCREEN():x()),
      })

    end

  function test:collide(node, otherNode, collisionPoint)
  end

    function test:click(x, y)
    end

      function test:updateAction(action, timeStep)
      end

    return test

  end

}



local TestTexturePacker = {
  new = function()
    local test = {
    }

    function test:load()

      local scene = njlic.Scene.create()
      local rootNode = njlic.Node.create()
      rootNode:setOrigin(bullet3.btVector3(0,0,0))
      scene:setRootNode(rootNode)
      njlic.World.getInstance():setScene(scene)

      self.orthographicCameraNode = njlic.Node.create()
      self.orthographicCameraNode:setName("orthographicCameraNode")

      self.orthographicCamera = njlic.Camera.create()
      self.orthographicCamera:enableOrthographic(true)
      self.orthographicCamera:setRenderCategory(RenderCategories.orthographic)
      self.orthographicCamera:setName("orthographicCamera")

      self.orthographicCameraNode:setCamera(self.orthographicCamera)

      rootNode:addChildNode(self.orthographicCameraNode)
      njlic.World.getInstance():getScene():setTouchCamera(self.orthographicCamera)

      self.physicsWorld = njlic.PhysicsWorld.create()
      njlic.World.getInstance():getScene():setPhysicsWorld(self.physicsWorld)

      self.ui = YappyBirdUi.new({camera=self.orthographicCamera})

      self.ui:showSplash()

    end

    function test:unload()
      njlic.Camera.destroy(self.orthographicCamera)
      njlic.Node.destroy(self.orthographicCameraNode)
    end

    function test:update(timestep)
      njlic.World.getInstance():setBackgroundColor(1.000, 1.000, 1.000)

        local status, err = pcall(self.ui.update, self.ui, timeStep)
        if not status then error(err) end

    end

  function test:collide(node, otherNode, collisionPoint)
  end

    function test:click(x, y)
    end

    function test:down(rayContact)
        local status, err = pcall(self.ui.down, self.ui, rayContact)
        if not status then error(err) end
    end
    
    function test:up(rayContact)
        local status, err = pcall(self.ui.up, self.ui, rayContact)
        if not status then error(err) end
    end
    
    function test:move(rayContact)
        local status, err = pcall(self.ui.move, self.ui, rayContact)
        if not status then error(err) end
    end

    function test:cancelled(rayContact)
        local status, err = pcall(self.ui.cancelled, self.ui, rayContact)
        if not status then error(err) end
    end

    function test:missed(node, deviceTouch)
        local status, err = pcall(self.ui.missed, self.ui, node, deviceTouch)
        if not status then error(err) end
    end

      function test:updateAction(action, timeStep)
      end

    return test

  end

}


















local TestLevelSaver = {
    new = function()
        local test = {
        }

        function test:load()

            local YappyBirdsData = require 'YAPPYBIRDS.SaveData'

            local fp = njlic.DOCUMENT_PATH("yappybirds.lua")

            local d = YappyBirdsData.new({filepath=fp})

            -- print("READ - $$$$$$$$$$$$$$$$$")
            -- print_r(d.data)
            -- print("READ - $$$$$$$$$$$$$$$$$")

            local stage = YappyBirdsData.COUNTRY
            local mode = YappyBirdsData.TIMEATTACK

            for level=1,15 do 
                d:set(stage, level, mode, 99)
            end

        end

        function test:unload()
        end

        function test:update(timestep)
        end

        function test:collide(node, otherNode, collisionPoint)
        end

        function test:click(x, y)
        end

        function test:down(rayContact)
        end

        function test:up(rayContact)
        end

        function test:move(rayContact)
        end

        function test:cancelled(rayContact)
        end

        function test:missed(node, deviceTouch)
        end

        function test:updateAction(action, timeStep)
        end

        return test

    end

}


















local TestSound = {
    new = function()
        local test = {
        }

        function test:load()
            self.backgroundSoundFileName = "sounds/interface_gameplay_theme.ogg"
            self.backgroundSound = njlic.Sound.create()
            self.backgroundSound:enableLooping()
            njlic.World.getInstance():getWorldResourceLoader():load(self.backgroundSoundFileName, self.backgroundSound)

            self.backgroundSound:play()

        end

        function test:unload()
        end

        function test:update(timestep)
        end

        function test:collide(node, otherNode, collisionPoint)
        end

        function test:click(x, y)
        end

        function test:down(rayContact)
        end

        function test:up(rayContact)
        end

        function test:move(rayContact)
        end

        function test:cancelled(rayContact)
        end

        function test:missed(node, deviceTouch)
        end

        function test:updateAction(action, timeStep)
        end

        return test

    end

}










local TestBullet = {
    new = function()
        local test = {

        }

        function test:load()
            require "NJLIC.thirdparty.luaunit.lunit"

            local stats = lunit.main(argv)
            if stats.errors > 0 or stats.failed > 0 then
                os.exit(1)
            end

            -- local bullet3_test = require 'NJLIC.unittests.bullet3'
            -- local assetPath = njlic.ASSET_PATH("fonts/" .. font .. ".lua")

            local vv1 = bullet3.btVector2()
            local vv2 = bullet3.btVector2()
            print(vv1)
            print(vv1 .. tostring(vv2))

            local vvv1 = bullet3.btVector3()
            local vvv2 = bullet3.btVector3()
            print(vvv1)
            print(vvv1 .. tostring(vvv2))

            local vvvv1 = bullet3.btVector4()
            local vvvv2 = bullet3.btVector4()
            print(vvvv1)
            print(vvvv1 .. tostring(vvvv2))

            local q1 = bullet3.btQuaternion()
            local q2 = bullet3.btQuaternion()
            print(q1)
            print(q1 .. tostring(q2))
            
            local t1 = bullet3.btTransform(bullet3.btTransform.getIdentity())
            local t2 = bullet3.btTransform(bullet3.btTransform.getIdentity())
            print(t1)
            print(t1 .. tostring(t2))

            local m1 = bullet3.btMatrix3x3()
            local m2 = bullet3.btMatrix3x3()
            print(m1)
            print(m1 .. tostring(m2))

        end

    function test:unload()
    end

    function test:update(timestep)
    end

    function test:collide(node, otherNode, collisionPoint)
    end

    function test:click(x, y)
    end

    function test:updateAction(action, timeStep)
    end

    return test

  end

}




















local WorldGamePause = function()
    yappyBirds:worldGamePause()
end

local WorldGameUnPause = function()
    yappyBirds:worldGameUnPause()
end

local Create = function()
    yappyBirds = YappyBirds.new()
    -- yappyBirds = TestDebugDraw.new()
    -- yappyBirds = TestFont.new()
    -- yappyBirds = TestTexturePacker.new()
    -- yappyBirds = TestLevelSaver.new()
    -- yappyBirds = TestSound.new()
    -- yappyBirds = TestBullet.new()
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
  yappyBirds:click(touch:getPosition():x(), touch:getPosition():y())
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

local NodeActionComplete = function(action)
end

local NodeRayTouchesDown = function(rayContact)
    yappyBirds:down(rayContact)
    -- print("* NodeRayTouchesDown")
end

local NodeRayTouchesUp = function(rayContact)
    yappyBirds:up(rayContact)
    -- print("* NodeRayTouchesUp")
end

local NodeRayTouchesMove = function(rayContact)
    yappyBirds:move(rayContact)
    -- print("* NodeRayTouchesMove")
end

local NodeRayTouchesCancelled = function(rayContact)
    yappyBirds:cancelled(rayContact)
    -- print("* NodeRayTouchesCancelled")
end

local NodeRayTouchesMissed = function(node, deviceTouch)
    yappyBirds:missed(node, deviceTouch)
end

local NodeRayTouchDown = function(rayContact)
    yappyBirds:down(rayContact)
    -- print("# NodeRayTouchDown")
end

local NodeRayTouchUp = function(rayContact)
    yappyBirds:up(rayContact)
    -- print("# NodeRayTouchUp")
end

local NodeRayTouchMove = function(rayContact)
    yappyBirds:move(rayContact)
    -- print("# NodeRayTouchMove")
end

local NodeRayTouchCancelled = function(rayContact)
    yappyBirds:cancelled(rayContact)
    -- print("# NodeRayTouchCancelled")
end

local NodeRayMouseDown = function(rayContact)
    yappyBirds:down(rayContact)
    -- print("# NodeRayMouseDown")
end

local NodeRayMouseUp = function(rayContact)
    yappyBirds:up(rayContact)
    -- print("# NodeRayMouseUp")
end

local NodeRayMouseMove = function(rayContact)
    yappyBirds:move(rayContact)
    -- print("# NodeRayMouseMove")
end

local NodeRayTouchMissed = function(node, deviceTouch)
    yappyBirds:missed(node, deviceTouch)
end

local NodeRayMouseMissed = function(node)
    yappyBirds:missed(node, nil)
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
RegisterNodeRayTouchesMissed("NodeRayTouchesMissed",             function(node) pcall(NodeRayTouchesMissed, node, deviceTouch) end )
RegisterNodeRayTouchDown("NodeRayTouchDown",                     function(rayContact) pcall(NodeRayTouchDown, rayContact) end )
RegisterNodeRayTouchUp("NodeRayTouchUp",                         function(rayContact) pcall(NodeRayTouchUp, rayContact) end )
RegisterNodeRayTouchMove("NodeRayTouchMove",                     function(rayContact) pcall(NodeRayTouchMove, rayContact) end )
RegisterNodeRayTouchCancelled("NodeRayTouchCancelled",           function(rayContact) pcall(NodeRayTouchCancelled, rayContact) end )
RegisterNodeRayMouseDown("NodeRayMouseDown",                     function(rayContact) pcall(NodeRayMouseDown, rayContact) end )
RegisterNodeRayMouseUp("NodeRayMouseUp",                         function(rayContact) pcall(NodeRayMouseUp, rayContact) end )
RegisterNodeRayMouseMove("NodeRayMouseMove",                     function(rayContact) pcall(NodeRayMouseMove, rayContact) end )
RegisterNodeRayTouchMissed("NodeRayTouchMissed",                 function(node) pcall(NodeRayTouchMissed, node, deviceTouch) end )
RegisterNodeRayMouseMissed("NodeRayMouseMissed",                 function(node) pcall(NodeRayMouseMissed, node) end )

RegisterWorldGamePause("WorldGamePause", function() pcall(WorldGamePause) end )
RegisterWorldGameUnPause("WorldGameUnPause", function() pcall(WorldGameUnPause) end )

