class CreateTemplates < ActiveRecord::Migration[7.2]
  def change
    create_table :templates do |t|
      t.references :user, null: false, foreign_key: true
      t.string :title
      t.string :icon_class
      t.text :memo

      t.timestamps
    end
  end
end
