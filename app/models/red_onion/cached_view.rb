module RedOnion
  class CachedView < ActiveRecord::Base
    
    self.table_name = "red_onion_cached_views"
    
    attr_accessible :name
  end
end
