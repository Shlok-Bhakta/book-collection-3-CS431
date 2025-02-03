class CreateCableSchema < ActiveRecord::Migration[8.0]
  def change
    create_table :solid_cable_subscriptions do |t|
      t.string :channel_id, null: false
      t.string :connection_id, null: false
      t.string :subscription_id, null: false
      t.jsonb :params
      t.datetime :created_at, null: false

      t.index %i[channel_id connection_id subscription_id], unique: true,
                                                            name: 'index_solid_cable_subscriptions_uniqueness'
      t.index :connection_id
    end

    create_table :solid_cable_connections do |t|
      t.string :connection_id, null: false
      t.jsonb :params
      t.datetime :created_at, null: false

      t.index :connection_id, unique: true
    end
  end
end
