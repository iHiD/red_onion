module RedOnion
  class CachedViewMock
  
    def initialize(wrapped_object)
      @wrapped_object = wrapped_object
      @accessed = false
    end
    
    def _wrapped_object
      @wrapped_object
    end
  
    def method_missing(name, *args)
      _accessed!
      @wrapped_object.send(name, *args)
    end
    
    private
    def _accessed!
      return if @accessed
      @accessed = true
    end
  end
end