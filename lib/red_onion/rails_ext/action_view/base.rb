module ActionView
  class Base
    alias_method :original_assign, :assign
    def assign(new_assigns)
      red_onion_assigns = new_assigns.inject({}) do |h, (key, value)|
        h[key] = RedOnion::CachedViewMock.new(value)
        h
      end
      original_assign(red_onion_assigns)
    end
  end
end
