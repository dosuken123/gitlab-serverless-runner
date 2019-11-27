class AddUrlToRunners < ActiveRecord::Migration[6.0]
  def change
    add_column :runners, :url, :string
  end
end
