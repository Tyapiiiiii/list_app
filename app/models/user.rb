class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

    has_many :templates, dependent: :destroy
    # 自分が招待されている・共同編集している関係性
    has_many :template_relations, dependent: :destroy

    # 中間テーブルを経由して、「承認済み」の共同編集テンプレート一覧を取得できるようにする
    has_many :shared_templates, -> { where(template_relations: { status: :accepted }) }, 
           through: :template_relations, 
           source: :template

    def self.guest
    user = find_or_create_by!(email: 'guest@example.com') do |u|
      u.password = SecureRandom.urlsafe_base64
      u.name = 'ゲスト'
    end
    user.update_columns(name: 'ゲスト') if user.name != 'ゲスト'
    user
  end
end
