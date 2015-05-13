class Game < ActiveRecord::Base
  has_many :players
  has_many :members, through: :players
  has_many :users, through: :players
  has_many :statuses, class_name: 'GameStatus', through: :players
  belongs_to :organization
  belongs_to :owner, class_name: 'Member', foreign_key: :owner_id

  validates :title, length: { maximum: 100 }, presence: true
  validates :buy_in, numericality: { greater_than_or_equal_to: 0 }
end
