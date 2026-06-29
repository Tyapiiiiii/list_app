# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

guest = User.find_or_create_by!(email: 'guest@example.com') do |u|
  u.password = SecureRandom.urlsafe_base64
  u.name = 'ゲスト'
end

templates_data = [
  {
    title: '旅行セット',
    icon_class: 'fa-solid fa-plane',
    memo: '旅行に必要な持ち物リストです。',
    items: ['パスポート', 'スーツケース', '充電器', '変換プラグ', '常備薬']
  },
  {
    title: 'キャンプ道具',
    icon_class: 'fa-solid fa-campground',
    memo: 'キャンプに必要な道具リストです。',
    items: ['テント', '寝袋', 'ランタン', '焚き火台', 'クーラーボックス']
  },
  {
    title: '通勤バッグ',
    icon_class: 'fa-solid fa-briefcase',
    memo: '毎日の通勤に必要な持ち物です。',
    items: ['定期券', 'ハンカチ', 'マスク', '財布', 'スマートフォン']
  },
  {
    title: 'ジム用品',
    icon_class: 'fa-solid fa-dumbbell',
    memo: 'ジムに行くときの持ち物リストです。',
    items: ['シューズ', 'タオル', 'ウォーターボトル', 'ウェア', 'ロッカー鍵']
  },
  {
    title: '緊急避難セット',
    icon_class: 'fa-solid fa-triangle-exclamation',
    memo: '緊急時に必要な避難用品リストです。',
    items: ['懐中電灯', '非常食', '救急セット', '飲料水', 'ラジオ']
  },
]

templates_data.each do |t_data|
  template = guest.templates.find_or_create_by!(title: t_data[:title]) do |t|
    t.icon_class = t_data[:icon_class]
    t.memo = t_data[:memo]
  end
  t_data[:items].each_with_index do |item_name, idx|
    template.items.find_or_create_by!(name: item_name) { |i| i.position = idx + 1 }
  end
end
