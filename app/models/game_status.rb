class GameStatus < ActiveRecord::Base
  belongs_to :player
  # enum is not support in 4.0.x
  # enum status: {join_the_game: 0, lose: 1, rebuy: 2}

  validates :player_id, presence: true
  validates :status, presence: true, numericality: true
end
