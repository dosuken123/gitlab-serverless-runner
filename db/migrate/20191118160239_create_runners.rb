class CreateRunners < ActiveRecord::Migration[6.0]
  def change
    create_table :runners do |t|
      t.string :token, null: false
      t.string :description
      t.string :tags
      t.integer :runtime, limit: 2, null: false
      t.string :url, null: false

      t.timestamps
    end

    create_table :runner_builds do |t|
      t.references :runner, null: true, index: true, foreign_key: { on_delete: :cascade }
      t.bigint :build_id
      t.string :token
      t.jsonb :specification

      t.timestamps
    end
  end
end
