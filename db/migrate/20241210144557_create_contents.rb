class CreateContents < ActiveRecord::Migration[8.0]
  def change
    create_table :contents do |t|
      t.string :title
      t.text :description
      t.references :contentable, polymorphic: true, null: false

      t.timestamps
    end
  end
end
