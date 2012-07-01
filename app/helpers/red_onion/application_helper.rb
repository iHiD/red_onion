module RedOnion
  module ApplicationHelper
    
    # This code is a modified verson of ActionView::Helpers::CacheHelper.cache
    def cache(name = {}, options = nil, &block)
      
      if controller.perform_caching

        CachedView.create(name: controller.fragment_cache_key(name))
        safe_concat(fragment_for(name, options, &block))

      else
        yield
      end
      nil
    end
  end
end
