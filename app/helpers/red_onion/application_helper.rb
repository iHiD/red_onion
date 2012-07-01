module RedOnion
  module ApplicationHelper
    def cache
      CachedView.create(name: "test")
      super
    end
  end
end
