# アプリ名

### KYOレシピ（投稿・検索サイト）

# 概要
※文章でかく

- レシピの投稿
- レシピの検索/詳細確認
- 評価機能（いいねボタン）
- ユーザー登録/詳細確認

# 本番環境

https://kyo-recipe.herokuapp.com

ログイン情報（テスト用）

- メールアドレス：test1@test
- パスワード：aaa111

# 制作背景（意図）
※卒業スライドから引用


# DEMO
- ログイン機能/ログアウト機能

- レシピの投稿/編集/削除

- レシピの検索機能

- レシピ詳細確認

- 評価機能（いいねボタン）

- ユーザー詳細機能


# 工夫したポイント

トップ画面でレシピ毎に「いいね」された回数を表記することで良いレシピを見つけやすくしました。
投稿されたレシピは新着順で表記される仕組みとし、投稿意欲をあげることと、内容が変化しやすい状況を作りました。
トップ画面では必要な情報だけを載せるため、レシピの手順１までの表記とし、画像をクリックすることでレシピ詳細へ遷移するようにしました。
レシピ詳細画面では「いいね」ボタンを非同期通信で実装しているため違和感なくクリックが可能です。
ユーザー詳細画面へ遷移し、ユーザーがもらった「いいね」の総合計を出すことで投稿意欲を高めると共に優良な作者を見つけやすくしました。
また、同ページにてレシピの平均材料費を出すことで、重要な要素である価格を意識してもらう仕組みとしました。
投稿画面では文字数制限をして簡単なレシピを意識してもらうことと、簡単で良いというメッセージを伝え、投稿のハードルを下げています。


# 使用技術（開発環境）

## バックエンド
ruby,ruby on Rails

## フロントエンド
javaScript,JQuery,Ajax

## データベース
MySQL,SequelPro

## インフラ
AWS(C3)

## Webサーバー(本番環境)
heroku

## アプリケーションサーバー(本番環境)
heroku

# ソース管理
GitHub,GithubDesktop

# テスト
RSpec

# エディタ
VSCode

# 課題や今後実装したい機能
※詳しく書く
- TOP画面での人気レシピ表記
- 材料検索
- 調味料検索
- インスタント食材検索
- レシピ投稿時のプレビュー表記
- 文字登録時の残文字数の表記
- レシピに対してのコメント機能

# kyo-recipeのER図

## users テーブル

| Column             | Type        | 0ptions                   |
| ------------------ | ----------- | ------------------------- |
| email              | string      | null: false, unique: true |
| encrypted_password | string      | null: false               |
| nickname           | string      | null: false               |


### Association

-has_many :recipes
-has_many :likes


## recipes テーブル

| Column                 | Type        | 0ptions                       |
| ---------------------- | ----------- | ----------------------------- |
| name                   | string      | null: false                   |
| price                  | integer     | null: false                   |
| procedure1             | string      | null: false                   |
| porocedure2            | string      | null: false                   |
| porocedure3            | string      | null: false                   |
| info                   | text        | null: false                   |
| user                   | references  | null: false, foreign_key:true |


### Association

-belongs_to :user
-has_many :likes

## likes テーブル

| Column                 | Type        | 0ptions                       |
| ---------------------- | ----------- | ----------------------------- |
| user                   | references  | null: false, foreign_key:true |
| recipe                 | references  | null: false, foreign_key:true |

### Association

-belongs_to :user
-belongs_to :recipe
