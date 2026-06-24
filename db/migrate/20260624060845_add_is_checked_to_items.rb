class AddIsCheckedToItems < ActiveRecord::Migration[7.2]
  def change
    # default: false を追記します
    add_column :items, :is_checked, :boolean, default: false
  end
end