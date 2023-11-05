class Industry < ActiveHash::Base
  self.data = [
    { id: 1, name: '---' },
    { id: 2, name: 'メーカー' },
    { id: 3, name: '小売' },
    { id: 4, name: '商社' },
    { id: 5, name: '金融' },
    { id: 6, name: 'サービス・インフラ' },
    { id: 7, name: 'IT・ソフトウェア' },
    { id: 8, name: '広告・出版・マスコミ' },
    { id: 9, name: '官公庁・公社・団体' },
    { id: 10, name: 'その他' }
  ]

  include ActiveHash::Associations
  has_many :posts
  end