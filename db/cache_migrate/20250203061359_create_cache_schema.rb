class CreateCacheSchema < ActiveRecord::Migration[8.0]
  def change
    create_table :solid_cache_entries do |t|
      t.string :key, null: false
      t.text :value
      t.datetime :expires_at

      t.timestamps

      t.index [:key], unique: true
      t.index [:expires_at]
    end
  end
end
