class CreateTemplateRelations < ActiveRecord::Migration[7.2]
  def change
    create_table :template_relations do |t|
      t.references :user, null: false, foreign_key: true
      t.references :template, null: false, foreign_key: true
      t.integer :status

      t.timestamps
    end
  end
end
