
local SaveData = {
  TIMEATTACK = "timeattack",
  ARCADE = "arcade",
  SURVIVAL = "survival",
  COUNTRY = "country",
  CITY = "city",

  new = function(...)
    local arg = ... or {}

    local fp = arg.filepath or njlic.DOCUMENT_PATH("yappybirds.lua")

    local json = require 'NJLIC.thirdparty.json'

    local object = {
      filepath = fp,
      TIMEATTACK = "timeattack",
      ARCADE = "arcade",
      SURVIVAL = "survival",
      COUNTRY = "country",
      CITY = "city"
    }


    local raw_data = [===[
{
    "country": {
        "timeattack": [
            0,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1
        ],
        "arcade": [
            0,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1
        ],
        "survival": [
            0,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1
        ],
    },
    "city": {
        "timeattack": [
            0,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1
        ],
        "arcade": [
            0,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1
        ],
        "survival": [
            0,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1
        ],
    }
}
]===]

    local hard_init = function(filepath, d)
      local file = io.open(filepath, "wb")
      assert(file ~= nil, "The file is nil")

      io.output(file)
      io.write(d)
      io.close(file)
    end

    local init = function(filepath, d)
      local data = ""
      local file = io.open(filepath, "rb")
      if nil == file then

        data = d

        file = io.open(filepath, "wb")
        file:write(data)
        file:close()
      else
        data = file:read("*all")
        file:close()
      end

      return data
    end

    local _raw_data = init(object.filepath, raw_data)

    object.data = json.decode(_raw_data)

    function object:_validate(stage, level, mode)
      assert(stage ~= nil, "Must have a stage")
      assert(level ~= nil, "Must have a level")
      assert(mode ~= nil, "Must have a mode")

      local correctMode = (mode == self.TIMEATTACK) or (mode == self.ARCADE) or (mode == self.SURVIVAL)
      local correctStage = (stage == self.COUNTRY) or (stage == self.CITY)
      local correctLevel = (level >= 1) and (level <= 20)

      assert(correctMode == true, "The mode is incorrect `" .. mode .. "`")
      assert(correctStage == true, "The stage is incorrect `" .. stage .. "`")
      assert(correctLevel == true, "The level is incorrect `" .. level .. "`")

      assert(self.data[stage] ~= nil, "stage table is nil for stage " .. stage)
      assert(self.data[stage][mode] ~= nil, "mode table is nil for mode " .. mode)
      assert(self.data[stage][mode][level] ~= nil, "level is nil for level " .. level)

    end

    function object:set(stage, level, mode, value)
      self:_validate(stage, level, mode)
      assert(value ~= nil, "Must have a value")

      self.data[stage][mode][level] = value
      local d = json.encode(self.data)
      hard_init(self.filepath, d)
    end

    function object:get(stage, level, mode)
      self:_validate(stage, level, mode)
      return self.data[stage][mode][level]
    end

    function object:reset(stage, level, mode)
      self:set(stage, level, mode, 0)
    end

    function object:clear()
      hard_init(self.filepath, raw_data)
    end

    return object
  end
}
return SaveData
