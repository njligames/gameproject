--
-- created with TexturePacker - https://www.codeandweb.com/texturepacker
--
-- TODO: Change this exmaple to make sense for NJLICEngine
-- $TexturePacker:SmartUpdate:9313ef5a79501be90ffdec396d4ff0d4:b9c36eac85f85d82e2ecc25db110f789:18cc0faedb801f0310f07fa32ca9fcf5$
--
-- local sheetInfo = require("mysheet")
-- local myImageSheet = graphics.newImageSheet( "mysheet.png", sheetInfo:getSheet() )
-- local sprite = display.newSprite( myImageSheet , {frames={sheetInfo:getFrameIndex("sprite")}} )
--

local SheetInfo = {}

SheetInfo.sheet =
{
frames = {
  
  {
    x=3004,
    y=1,

    width=128,
    height=105,

    widthFile=128,
    heightFile=105,

    pivotx=0,
    pivoty=105,

    sourceX = 0,
    sourceY = 0,
    sourceWidth = 128,
    sourceHeight = 105,

    trimmedName = "128cloud00",
  },
  
  {
    x=3134,
    y=1,

    width=101,
    height=128,

    widthFile=101,
    heightFile=128,

    pivotx=0,
    pivoty=128,

    sourceX = 0,
    sourceY = 0,
    sourceWidth = 101,
    sourceHeight = 128,

    trimmedName = "128tree00",
  },
  
  {
    x=2507,
    y=1,

    width=256,
    height=209,

    widthFile=256,
    heightFile=209,

    pivotx=0,
    pivoty=209,

    sourceX = 0,
    sourceY = 0,
    sourceWidth = 256,
    sourceHeight = 209,

    trimmedName = "256cloud00",
  },
  
  {
    x=2507,
    y=212,

    width=233,
    height=256,

    widthFile=233,
    heightFile=256,

    pivotx=0,
    pivoty=256,

    sourceX = 0,
    sourceY = 0,
    sourceWidth = 233,
    sourceHeight = 256,

    trimmedName = "256house00",
  },
  
  {
    x=2765,
    y=1,

    width=237,
    height=256,

    widthFile=237,
    heightFile=256,

    pivotx=0,
    pivoty=256,

    sourceX = 0,
    sourceY = 0,
    sourceWidth = 237,
    sourceHeight = 256,

    trimmedName = "256tree00",
  },
  
  {
    x=2051,
    y=1,

    width=454,
    height=512,

    widthFile=454,
    heightFile=512,

    pivotx=0,
    pivoty=512,

    sourceX = 0,
    sourceY = 0,
    sourceWidth = 454,
    sourceHeight = 512,

    trimmedName = "512tree00",
  },
  
  {
    x=1,
    y=1777,

    width=2048,
    height=752,

    widthFile=2048,
    heightFile=752,

    pivotx=0,
    pivoty=752,

    sourceX = 0,
    sourceY = 0,
    sourceWidth = 2048,
    sourceHeight = 752,

    trimmedName = "2048hills00",
  },
  
  {
    x=1,
    y=1,

    width=2048,
    height=926,

    widthFile=2048,
    heightFile=926,

    pivotx=0,
    pivoty=926,

    sourceX = 0,
    sourceY = 0,
    sourceWidth = 2048,
    sourceHeight = 926,

    trimmedName = "2048hills01",
  },
  
  {
    x=1,
    y=929,

    width=2048,
    height=846,

    widthFile=2048,
    heightFile=846,

    pivotx=0,
    pivoty=846,

    sourceX = 0,
    sourceY = 0,
    sourceWidth = 2048,
    sourceHeight = 846,

    trimmedName = "2048hills02",
  },
  
  },
  fileName = "images/country0.png",
  sheetContentWidth = 4096,
  sheetContentHeight = 4096,
  scale = 1,
  shapePadding = 0,
  borderPadding = 0,
  commonDivisorX = 1,
  commonDivisorY = 1,
  extrude = 1,
  baseFactor = 1,
  maxTextureSizeWidth = 4096,
  maxTextureSizeHeight = 4096,
  fixedTextureSizeWidth = -1,
  fixedTextureSizeHeight = -1

  -- _variantParams.scale = 1,
  -- _variantParams.shapePadding = 0,
  -- _variantParams.borderPadding = 0,
  -- _variantParams.commonDivisorX = 1,
  -- _variantParams.commonDivisorY = 1,
  -- _variantParams.extrude = 1,
  -- _variantParams.baseFactor = 1,
  -- _variantParams_maxTextureSize_width = 4096,
  -- _variantParams_maxTextureSize_height = 4096,
  -- _variantParams_fixedTextureSize_width = -1,
  -- _variantParams_fixedTextureSize_height = -1
}

SheetInfo.frameIndex =
{

  ["128cloud00"] = 1,

  ["128tree00"] = 2,

  ["256cloud00"] = 3,

  ["256house00"] = 4,

  ["256tree00"] = 5,

  ["512tree00"] = 6,

  ["2048hills00"] = 7,

  ["2048hills01"] = 8,

  ["2048hills02"] = 9,

}

function SheetInfo:getSheet()
  return self.sheet;
end

function SheetInfo:getFrameIndex(name)
  return self.frameIndex[name];
end

return SheetInfo
