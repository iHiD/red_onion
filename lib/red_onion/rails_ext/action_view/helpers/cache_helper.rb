module ActionView
  module Helpers
    module CacheHelper
      def cache(name = {}, options = nil, &block)
      
        unless controller.perform_caching
          yield
          nil
        end

        # Create a record of this cached view
        cached_view = RedOnion::CachedView.create!(name: controller.fragment_cache_key(name))
        
        # Get the cache context and add the view onto the stack
        assigns['_cached_views'] ||= []
        if context = assigns['_cached_views'].last
          context.dependencies.create!(dependency_type: context.class.name, dependency_id: context.id)
        end
        assigns['_cached_views'].push(cached_view)
        
        # Render the block
        safe_concat(fragment_for(name, options, &block))
        assigns['_cached_views'].delete(cached_view)
        
        # Cycle through the assigns and add a dependency if the object has been accessed
        assigns.each do |assign|    
          next if assign[0].starts_with?("_")
          next unless assign[1]._accessed
          
          wrapped_object = assign[1]._wrapped_object
          cached_view.dependencies.create!(dependency_type: wrapped_object.class.name, dependency_id: wrapped_object.id)
        end
      end
    end
  end
end