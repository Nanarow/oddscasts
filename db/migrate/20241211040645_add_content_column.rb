class AddContentColumn < ActiveRecord::Migration[8.0]
  def change
    add_column :contents, :state, :integer, default: 0
  end
end
