class Player < ActiveRecord::Base
  belongs_to :member
  belongs_to :game
  has_one :cashier, through: :member
  has_many :statuses, class_name: 'GameStatus'
end
