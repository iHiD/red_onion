module RedOnion
  class CachedViewDependency < ActiveRecord::Base
    
    self.table_name = "red_onion_cached_view_dependencies"
    
    attr_accessible :object_type, :object_id
    belongs_to :cached_view
    
  end
end
