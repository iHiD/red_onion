class CreateRedOnionCachedViewDependencies < ActiveRecord::Migration
  def change
    create_table :red_onion_cached_view_dependencies do |t|
      t.integer :cached_view_id,   null: false
      t.string  :dependency_type, null: false
      t.integer :dependency_id,   null: false
      t.timestamps
    end
  end
end
