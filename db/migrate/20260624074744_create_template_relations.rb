class CreateTemplateRelations < ActiveRecord::Migration[7.2]
  def change
    create_table :template_relations do |t|
      t.references :user, null: false, foreign_key: true
      t.references :template, null: false, foreign_key: true
      # statusに 初期値default: 0 (pending) と null: false を追加します
      t.integer :status, null: false, default: 0

      t.timestamps
    end
    # 同じユーザーが同じテンプレートに2回以上招待されないようにユニーク制約をつけておく
    add_index :template_relations, [:user_id, :template_id], unique: true
  end
end
