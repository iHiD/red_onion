module RedOnion
  class CachedViewMock < BasicObject
  
    attr_reader :_wrapped_object, :_accessed
  
    def initialize(wrapped_object)
      @_wrapped_object = wrapped_object
      @_accessed = false
    end
  
    def method_missing(name, *args)
      @_accessed = true
      @_wrapped_object.send(name, *args)
    end
    
    def _accessed?
      @_accessed
    end
    
    def inspect
      "CachedViewMock: #{super}"
    end
  end
end