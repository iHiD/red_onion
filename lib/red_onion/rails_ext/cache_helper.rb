module ActionView
  module Helpers
    module CacheHelper
      def cache(name = {}, options = nil, &block)
      
        if controller.perform_caching
          cached_view = RedOnion::CachedView.create!(name: controller.fragment_cache_key(name))
          
          # Wrap each assign in a mock
          assigns.dup.each do |assign|
            next if assign[0].starts_with?("_")
            assigns[assign[0]] = RedOnion::CachedViewMock.new(assign[1])
          end
          
          safe_concat(fragment_for(name, options, &block))
          
          # Cycle through the assigns and add a dependency if the mock has been accessed
          assigns.each do |assign|    
            next if assign[0].starts_with?("_")
            wrapped_object = assign[1]._wrapped_object
            cached_view.dependencies.create!(object_type: wrapped_object.class.name, object_id: wrapped_object.id)
          end
          
        else
          yield
        end
        nil
      end
    end
  end
end