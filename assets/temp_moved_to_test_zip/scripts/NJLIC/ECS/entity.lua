return {
  new = function()
    local entity = {
      components = {},
      tags = {},
      remove = false,
      loaded = false
    }
    
    function entity:add(component)
      assert(component.__id)
      self.components[component.__id] = component
    end
    
    function entity:destroy()
      self.remove = true
    end
    
    function entity:get(id)
      return self.components[id]
    end
    
    return entity
  end
}