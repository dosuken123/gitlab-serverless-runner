class CreateRunners < ActiveRecord::Migration[6.0]
  def change
    create_table :runners do |t|
      t.string :token, null: false
      t.string :description
      t.string :tags
      t.integer :runtime, limit: 2, null: false

      t.timestamps
    end
  end
end
