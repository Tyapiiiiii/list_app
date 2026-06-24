class Template < ApplicationRecord
  belongs_to :user
  # -> { order(:position) } を追記して、常に並び順通りに取得する
  has_many :items, -> { order(:position) }, dependent: :destroy, inverse_of: :template

  # テンプレ作成時に、一緒に送られてくる複数の items のデータも同時に保存・編集できるようにする
  # allow_destroy: true は、後から持ち物を削除できるようにするための設定です
  # reject_if: :all_blank は、持ち物名が空欄のまま送られてきたら無視する設定です
  accepts_nested_attributes_for :items, allow_destroy: true, reject_if: :all_blank

  # テンプレートが持つ中間テーブルの関係性
  has_many :template_relations, dependent: :destroy

  # テンプレートを共同編集しているユーザー一覧（承認済みのみ）
  has_many :shared_users, -> { where(template_relations: { status: :accepted }) }, 
           through: :template_relations, 
           source: :user
end