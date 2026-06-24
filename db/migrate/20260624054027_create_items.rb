class CreateItems < ActiveRecord::Migration[7.2]
  def change
    create_table :items do |t|
      t.references :template, null: false, foreign_key: true
      t.string :name
      t.integer :position

      t.timestamps
    end
  end
end
