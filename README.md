# 持ち物リストアプリ

テンプレートを使って持ち物リストを管理・共有できる Web アプリです。

## 機能一覧

- **テンプレート管理** — 持ち物リストのテンプレートを作成・編集・削除
- **チェックリスト** — アイテムのチェック ON/OFF をリアルタイムで切り替え（Turbo Stream）
- **並び替え** — ドラッグ＆ドロップでアイテムの順序を変更
- **チェックリセット** — テンプレート内の全チェックを一括リセット
- **テンプレート共有** — 他のユーザーを招待して共同編集（承認 / 拒否）
- **通知** — 共有招待の通知一覧
- **ゲストログイン**

## 技術スタック

| カテゴリ | 技術 |
|---|---|
| 言語 | Ruby 3.3.0 |
| フレームワーク | Rails 7.2.3 |
| DB | SQLite3 |
| 認証 | Devise |
| フロントエンド | Hotwire（Turbo + Stimulus）、importmap |
| 並び替え | acts_as_list |
| インフラ | Docker |

## データモデル

```
User
 └─ has_many :templates
 └─ has_many :template_relations
 └─ has_many :shared_templates（承認済みのみ、through: template_relations）

Template
 └─ belongs_to :user
 └─ has_many :items（position 順）
 └─ has_many :template_relations
 └─ has_many :shared_users（承認済みのみ）

Item
 └─ belongs_to :template
 └─ position（acts_as_list）
 └─ is_checked（boolean）

TemplateRelation（中間テーブル）
 └─ belongs_to :user
 └─ belongs_to :template
 └─ status: pending / accepted / rejected
```

## セットアップ

### 前提条件

- Ruby 3.3.0
- Bundler
- SQLite3

## 主なルーティング

| メソッド | パス | 説明 |
|---|---|---|
| GET | `/` | テンプレート一覧（トップページ） |
| GET/POST | `/templates/new` | テンプレート作成 |
| GET | `/templates/:id` | テンプレート詳細（チェックリスト） |
| PATCH | `/templates/:id` | テンプレート更新 |
| POST | `/templates/:id/reset` | チェック一括リセット |
| POST | `/templates/:id/template_relations` | 共有招待の送信 |
| PATCH | `/template_relations/:id` | 招待の承認 / 拒否 |
| PATCH | `/items/:id/toggle_check` | アイテムのチェック切り替え |
| PATCH | `/items/:id/move` | アイテムの並び替え |
| GET | `/notifications` | 通知一覧 |
| POST | `/guest_login` | ゲストログイン |
