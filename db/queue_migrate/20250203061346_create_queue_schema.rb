class CreateQueueSchema < ActiveRecord::Migration[8.0]
  def change
    create_table :queue_schemas do |t|
      t.timestamps
    end
  end
end
