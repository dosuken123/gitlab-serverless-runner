class CreateRunners < ActiveRecord::Migration[6.0]
  def change
    create_table :runners do |t|
      t.string :token

      t.timestamps
    end
  end
end
