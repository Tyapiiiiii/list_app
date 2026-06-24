class Item < ApplicationRecord
  belongs_to :template

  # テンプレート毎に position を管理するように設定
  acts_as_list scope: :template

  validates :name, presence: true
end