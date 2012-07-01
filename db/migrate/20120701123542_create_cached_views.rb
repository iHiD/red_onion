class CreateCachedViews < ActiveRecord::Migration
  def change
    create_table :red_onion_cached_views do |t|
      t.string :name, null: false
      t.timestamps
    end
  end
end
