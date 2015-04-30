class Game < ActiveRecord::Base
  has_many :players
  has_many :users, through: :players
  belongs_to :organization

  validates :title, length: { maximum: 100 }, presence: true
  validates :buy_in, numericality: { greater_than_or_equal_to: 0 }
end
