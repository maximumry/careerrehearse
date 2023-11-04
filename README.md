## users テーブル

|     Column         |   Type  |    Options                |
|--------------------|---------|---------------------------|
| email              | string  | null: false, unique: true |
| encrypted_password | string  | null: false               |
| last_name          | string  | null: false               |
| first_name         | string  | null: false               |

### Association

- has_many :opinions
- has_many :comments
- has_many :likes