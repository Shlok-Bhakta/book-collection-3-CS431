class CreateCableSchema < ActiveRecord::Migration[8.0]
  def change
    create_table :cable_schemas do |t|
      t.timestamps
    end
  end
end
