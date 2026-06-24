class TemplateRelation < ApplicationRecord
  belongs_to :user
  belongs_to :template

  # status の管理（0: 承認待ち, 1: 承認済み, 2: 拒否）
  enum :status, { pending: 0, accepted: 1, rejected: 2 }
  
  # バリデーション
  validates :status, presence: true
end
