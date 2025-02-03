class CreateCacheSchema < ActiveRecord::Migration[8.0]
  def change
    create_table :cache_schemas do |t|
      t.timestamps
    end
  end
end
