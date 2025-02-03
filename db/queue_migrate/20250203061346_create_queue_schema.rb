class CreateQueueSchema < ActiveRecord::Migration[8.0]
  def change
    create_table :solid_queue_jobs do |t|
      t.string :queue_name, null: false
      t.string :class_name, null: false
      t.text :arguments
      t.integer :priority, default: 0, null: false
      t.string :active_job_id
      t.datetime :scheduled_at
      t.datetime :finished_at
      t.string :error_message
      t.text :error_stack_trace
      t.integer :error_count, default: 0, null: false
      t.string :status, default: 'pending', null: false

      t.timestamps

      t.index %i[queue_name status priority scheduled_at], name: 'index_solid_queue_jobs_for_polling'
      t.index :active_job_id, unique: true
      t.index :finished_at
    end

    create_table :solid_queue_scheduled_executions do |t|
      t.references :job, null: false, index: false
      t.string :queue_name, null: false
      t.integer :priority, default: 0, null: false
      t.datetime :scheduled_at, null: false

      t.timestamps

      t.index %i[scheduled_at priority], name: 'index_solid_queue_scheduled_executions_for_polling'
    end

    create_table :solid_queue_ready_executions do |t|
      t.references :job, null: false, index: false
      t.string :queue_name, null: false
      t.integer :priority, default: 0, null: false

      t.timestamps

      t.index %i[priority created_at], name: 'index_solid_queue_ready_executions_for_polling'
    end

    create_table :solid_queue_claimed_executions do |t|
      t.references :job, null: false, index: { unique: true }
      t.bigint :process_id
      t.datetime :created_at, null: false

      t.index %i[process_id created_at]
    end

    create_table :solid_queue_blocked_executions do |t|
      t.references :job, null: false, index: { unique: true }
      t.string :queue_name, null: false
      t.integer :priority, default: 0, null: false
      t.string :concurrency_key, null: false
      t.datetime :expires_at, null: false

      t.timestamps

      t.index %i[expires_at concurrency_key], name: 'index_solid_queue_blocked_executions_for_maintenance'
    end

    create_table :solid_queue_processes do |t|
      t.string :kind, null: false
      t.datetime :last_heartbeat_at, null: false
      t.bigint :supervisor_id

      t.integer :pid, null: false
      t.string :hostname, null: false
      t.text :metadata

      t.timestamps

      t.index [:last_heartbeat_at]
    end

    create_table :solid_queue_pauses do |t|
      t.string :queue_name, null: false
      t.datetime :created_at, null: false

      t.index [:queue_name], unique: true
    end
  end
end
