class CreateRunnerJobsTable < ActiveRecord::Migration[6.0]
  def change
    create_table :runner_jobs do |t|
      t.reference :runner, null: true, index: true, foreign_key: { on_delete: :cascade }
      t.bigint :job_id # or token
      t.integer :status, limit: 2, null: false
      t.jsonb :specification, null: false

      t.timestamps
    end
  end
end
