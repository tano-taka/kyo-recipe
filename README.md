# kyo-recipeのER図

## users テーブル

| Column             | Type        | 0ptions                   |
| ------------------ | ----------- | ------------------------- |
| email              | string      | null: false, unique: true |
| encrypted_password | string      | null: false               |
| nickname           | string      | null: false               |


### Association

-has_many :recipe


## recipe テーブル

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