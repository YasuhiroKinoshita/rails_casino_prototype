class Member < ActiveRecord::Base
  belongs_to :user
  belongs_to :organization
  has_one :cashier
  has_many :created_games, class_name: 'Game', foreign_key: :owner_id

  validates :organization_id, presence: true
  validates :user_id, presence: true
end
